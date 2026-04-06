import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Badge } from '@/components/ui/badge'
import { getAllOrders } from '@/lib/actions/orders'
import { OrderStatusSelect } from '@/components/order-status-select'
import { ShoppingCart } from 'lucide-react'

const statusColors: Record<string, 'default' | 'secondary' | 'destructive' | 'outline'> = {
  pendiente: 'secondary',
  preparando: 'default',
  despachado: 'default',
  entregado: 'default',
  cancelado: 'destructive',
}

const statusLabels: Record<string, string> = {
  pendiente: 'Pendiente',
  preparando: 'Preparando',
  despachado: 'Despachado',
  entregado: 'Entregado',
  cancelado: 'Cancelado',
}

const paymentLabels: Record<string, string> = {
  efectivo: 'Efectivo',
  credito: 'Crédito',
}

export default async function PedidosPage() {
  const orders = await getAllOrders()

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
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    })
  }

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Pedidos</h1>
        <p className="text-muted-foreground">Gestiona los pedidos de tus clientes</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Lista de Pedidos</CardTitle>
          <CardDescription>{orders.length} pedidos en total</CardDescription>
        </CardHeader>
        <CardContent>
          {orders.length === 0 ? (
            <div className="text-center py-12">
              <ShoppingCart className="h-12 w-12 mx-auto text-muted-foreground/50 mb-4" />
              <h3 className="text-lg font-medium mb-2">No hay pedidos</h3>
              <p className="text-muted-foreground">Los pedidos de tus clientes aparecerán aquí</p>
            </div>
          ) : (
            <div className="overflow-x-auto -mx-6 px-6">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="min-w-[100px]">ID Pedido</TableHead>
                    <TableHead className="min-w-[150px]">Cliente</TableHead>
                    <TableHead className="min-w-[150px]">Fecha</TableHead>
                    <TableHead className="min-w-[100px]">Pago</TableHead>
                    <TableHead className="text-right min-w-[100px]">Total</TableHead>
                    <TableHead className="min-w-[120px]">Estado</TableHead>
                    <TableHead className="text-right min-w-[150px]">Acciones</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {orders.map((order) => (
                    <TableRow key={order.id}>
                      <TableCell className="font-mono text-sm">#{order.id.slice(0, 8)}</TableCell>
                      <TableCell>
                        <div className="max-w-[200px]">
                          <p className="font-medium truncate">{order.client?.full_name || 'Cliente'}</p>
                          <p className="text-xs text-muted-foreground truncate">{order.client?.email}</p>
                        </div>
                      </TableCell>
                      <TableCell className="text-sm whitespace-nowrap">{formatDate(order.created_at)}</TableCell>
                      <TableCell>
                        <Badge variant="outline">{paymentLabels[order.payment_method]}</Badge>
                      </TableCell>
                      <TableCell className="text-right font-medium whitespace-nowrap">{formatPrice(order.total)}</TableCell>
                      <TableCell>
                        <Badge variant={statusColors[order.status]}>
                          {statusLabels[order.status]}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-right">
                        <OrderStatusSelect orderId={order.id} currentStatus={order.status} />
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
