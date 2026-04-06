import { redirect } from 'next/navigation'
import { Header } from '@/components/header'
import { Footer } from '@/components/footer'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { getProfile, signOut } from '@/lib/actions/auth'
import { getClientOrders } from '@/lib/actions/orders'
import { CreditCard, Package, LogOut, ChevronRight } from 'lucide-react'
import { ProfileForm } from '@/components/profile-form'
import Link from 'next/link'

export default async function PerfilPage() {
  const [profile, orders] = await Promise.all([
    getProfile(),
    getClientOrders()
  ])

  if (!profile) {
    redirect('/auth/login')
  }

  const user = { email: profile.email, role: profile.role }

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP',
      minimumFractionDigits: 0,
    }).format(price)
  }

  const statusColors: Record<string, 'default' | 'secondary' | 'destructive' | 'outline'> = {
    pendiente: 'secondary',
    preparando: 'default',
    despachado: 'default',
    entregado: 'default',
    cancelado: 'destructive',
  }

  return (
    <div className="min-h-screen flex flex-col bg-muted/20">
      <Header user={user} />
      <main className="flex-1 pb-12">
        <section className="py-10 bg-background border-b">
          <div className="container px-4 sm:px-6">
            <h1 className="text-3xl font-bold text-foreground">Mi Perfil</h1>
            <p className="text-muted-foreground mt-1">
              Gestiona tu cuenta y revisa tus pedidos
            </p>
          </div>
        </section>

        <div className="container px-4 sm:px-6 py-8">
          <div className="grid gap-8 md:grid-cols-12">
            {/* Columna Izquierda: Datos y Crédito */}
            <div className="md:col-span-5 space-y-6">
              <ProfileForm profile={profile} />

              {profile.credit_limit > 0 && (
                <Card className="bg-primary/5 border-primary/20">
                  <CardHeader>
                    <CardTitle className="text-lg flex items-center gap-2">
                      <CreditCard className="h-5 w-5 text-primary" />
                      Cupo de Crédito
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex justify-between items-end">
                      <div>
                        <p className="text-xs text-muted-foreground uppercase font-semibold">Disponible</p>
                        <p className="text-2xl font-bold text-primary">
                          {formatPrice(profile.credit_limit - profile.credit_used)}
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="text-xs text-muted-foreground uppercase font-semibold">Total</p>
                        <p className="text-sm font-medium">{formatPrice(profile.credit_limit)}</p>
                      </div>
                    </div>
                    <div className="w-full bg-primary/10 rounded-full h-2">
                      <div 
                        className="bg-primary h-2 rounded-full transition-all" 
                        style={{ width: `${Math.min(100, (profile.credit_used / profile.credit_limit) * 100)}%` }}
                      />
                    </div>
                    <p className="text-[10px] text-muted-foreground text-center italic">
                      Has utilizado el {Math.round((profile.credit_used / profile.credit_limit) * 100)}% de tu cupo
                    </p>
                  </CardContent>
                </Card>
              )}

              <form action={signOut}>
                <Button type="submit" variant="outline" className="w-full text-destructive hover:bg-destructive/5 hover:text-destructive border-destructive/20">
                  <LogOut className="mr-2 h-4 w-4" />
                  Cerrar Sesión
                </Button>
              </form>
            </div>

            {/* Columna Derecha: Pedidos Recientes */}
            <div className="md:col-span-7 space-y-6">
              <Card>
                <CardHeader className="flex flex-row items-center justify-between">
                  <div>
                    <CardTitle>Pedidos Recientes</CardTitle>
                    <CardDescription>Historial de tus últimas compras</CardDescription>
                  </div>
                  <Link href="/mis-pedidos">
                    <Button variant="link" className="text-primary pr-0">
                      Ver todos <ChevronRight className="ml-1 h-4 w-4" />
                    </Button>
                  </Link>
                </CardHeader>
                <CardContent>
                  {orders.length === 0 ? (
                    <div className="text-center py-10 border-2 border-dashed rounded-lg">
                      <Package className="h-10 w-10 mx-auto text-muted-foreground/40 mb-3" />
                      <p className="text-sm text-muted-foreground">Aún no has realizado pedidos</p>
                      <Link href="/catalogo" className="mt-4 inline-block">
                        <Button variant="outline" size="sm">Ir al catálogo</Button>
                      </Link>
                    </div>
                  ) : (
                    <div className="space-y-4">
                      {orders.slice(0, 5).map((order) => (
                        <div key={order.id} className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted/50 transition-colors">
                          <div className="space-y-1 min-w-0">
                            <p className="font-medium text-sm">Pedido #{order.id.slice(0, 8)}</p>
                            <p className="text-xs text-muted-foreground">
                              {new Date(order.created_at).toLocaleDateString('es-CO')} • {formatPrice(order.total)}
                            </p>
                          </div>
                          <Badge variant={statusColors[order.status] || 'outline'} className="capitalize text-[10px]">
                            {order.status}
                          </Badge>
                        </div>
                      ))}
                    </div>
                  )}
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  )
}
