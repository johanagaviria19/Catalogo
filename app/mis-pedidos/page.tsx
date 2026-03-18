import { redirect } from 'next/navigation'
import { Header } from '@/components/header'
import { Footer } from '@/components/footer'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { getProfile } from '@/lib/actions/auth'
import { getClientOrders } from '@/lib/actions/orders'
import { ShoppingCart, Package } from 'lucide-react'

const statusColors: Record<string, 'default' | 'secondary' | 'destructive' | 'outline'> = {
  pending: 'secondary',
  confirmed: 'default',
  preparing: 'default',
  ready: 'default',
  delivered: 'default',
  cancelled: 'destructive',
}

const statusLabels: Record<string, string> = {
  pending: 'Pendiente',
  confirmed: 'Confirmado',
  preparing: 'Preparando',
  ready: 'Listo para recoger',
  delivered: 'Entregado',
  cancelled: 'Cancelado',
}

export default async function MisPedidosPage() {
  const profile = await getProfile()

  if (!profile) {
    redirect('/auth/login?redirect=/mis-pedidos')
  }

  const orders = await getClientOrders()
  const user = { email: profile.email, role: profile.role }

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP',
      minimumFractionDigits: 0,
    }).format(price)
  }

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString('es-CO', {
      day: '2-digit',
      month: 'long',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    })
  }

  return (
    <div className="min-h-screen flex flex-col">
      <Header user={user} />
      <main className="flex-1">
        <section className="py-8 bg-muted/30 border-b">
          <div className="container">
            <h1 className="text-3xl font-bold text-foreground">Mis Pedidos</h1>
            <p className="text-muted-foreground mt-2">
              Historial y seguimiento de tus pedidos
            </p>
          </div>
        </section>

        <section className="py-8">
          <div className="container">
            {orders.length === 0 ? (
              <div className="text-center py-16 border-2 border-dashed rounded-xl max-w-lg mx-auto">
                <ShoppingCart className="h-16 w-16 mx-auto text-muted-foreground/50 mb-4" />
                <h3 className="text-lg font-medium text-foreground mb-2">No tienes pedidos</h3>
                <p className="text-muted-foreground">
                  Cuando realices un pedido, aparecerá aquí
                </p>
              </div>
            ) : (
              <div className="space-y-4">
                {orders.map((order) => (
                  <Card key={order.id}>
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div>
                          <CardTitle className="text-lg">Pedido #{order.id.slice(0, 8)}</CardTitle>
                          <CardDescription>{formatDate(order.created_at)}</CardDescription>
                        </div>
                        <Badge variant={statusColors[order.status]}>
                          {statusLabels[order.status]}
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        {order.items?.map((item) => (
                          <div key={item.id} className="flex items-center gap-4">
                            <div className="w-12 h-12 rounded bg-muted flex items-center justify-center shrink-0">
                              <Package className="h-6 w-6 text-muted-foreground/50" />
                            </div>
                            <div className="flex-1 min-w-0">
                              <p className="font-medium truncate">{item.product?.name}</p>
                              <p className="text-sm text-muted-foreground">
                                {item.quantity} x {formatPrice(item.unit_price)}
                              </p>
                            </div>
                            <p className="font-medium">{formatPrice(item.subtotal)}</p>
                          </div>
                        ))}
                        <div className="border-t pt-4 flex justify-between items-center">
                          <span className="text-muted-foreground">Total</span>
                          <span className="text-lg font-bold text-primary">{formatPrice(order.total)}</span>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            )}
          </div>
        </section>
      </main>
      <Footer />
    </div>
  )
}
