'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { getAllUsers, updateUserCredit } from '@/lib/application/services/auth-service'
import { CreditCard, Loader2, DollarSign } from 'lucide-react'
import { toast } from 'sonner'
import type { User } from '@/lib/domain/entities'

export default function CreditosPage() {
  const router = useRouter()
  const [users, setUsers] = useState<User[]>([])
  const [loading, setLoading] = useState(true)
  const [updating, setUpdating] = useState(false)
  const [selectedUser, setSelectedUser] = useState<User | null>(null)
  const [creditDialogOpen, setCreditDialogOpen] = useState(false)
  const [newLimit, setNewLimit] = useState<string>('0')

  useEffect(() => {
    getAllUsers().then((data) => {
      setUsers(data.filter(u => u.role === 'cliente'))
      setLoading(false)
    })
  }, [])

  const handleUpdateCredit = async () => {
    if (!selectedUser) return

    setUpdating(true)
    const limit = parseFloat(newLimit)
    const result = await updateUserCredit(selectedUser.id, limit)

    if (result.error) {
      toast.error(result.error)
      setUpdating(false)
      return
    }

    toast.success('Cupo de crédito actualizado correctamente')
    setCreditDialogOpen(false)
    setUpdating(false)
    const updated = await getAllUsers()
    setUsers(updated.filter(u => u.role === 'cliente'))
    router.refresh()
  }

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP',
      minimumFractionDigits: 0,
    }).format(price)
  }

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Gestión de Créditos</h1>
        <p className="text-muted-foreground">Administra los cupos de crédito de tus clientes</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Créditos por Cliente</CardTitle>
          <CardDescription>{users.length} clientes con posibilidad de crédito</CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="text-center py-12">
              <Loader2 className="h-8 w-8 mx-auto animate-spin text-muted-foreground" />
            </div>
          ) : users.length === 0 ? (
            <div className="text-center py-12">
              <CreditCard className="h-12 w-12 mx-auto text-muted-foreground/50 mb-4" />
              <h3 className="text-lg font-medium mb-2">No hay clientes</h3>
              <p className="text-muted-foreground">Los clientes registrados aparecerán aquí</p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Cliente</TableHead>
                  <TableHead>Email</TableHead>
                  <TableHead className="text-right">Cupo Asignado</TableHead>
                  <TableHead className="text-right">Crédito Utilizado</TableHead>
                  <TableHead className="text-right">Crédito Disponible</TableHead>
                  <TableHead className="text-right">Acciones</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {users.map((user) => (
                  <TableRow key={user.id}>
                    <TableCell className="font-medium">{user.fullName || 'Sin nombre'}</TableCell>
                    <TableCell>{user.email}</TableCell>
                    <TableCell className="text-right">{formatPrice(user.creditLimit)}</TableCell>
                    <TableCell className="text-right text-destructive">{formatPrice(user.creditUsed)}</TableCell>
                    <TableCell className="text-right text-green-600 font-bold">
                      {formatPrice(user.creditLimit - user.creditUsed)}
                    </TableCell>
                    <TableCell className="text-right">
                      <Button 
                        variant="ghost" 
                        size="sm" 
                        onClick={() => {
                          setSelectedUser(user)
                          setNewLimit(user.creditLimit.toString())
                          setCreditDialogOpen(true)
                        }}
                      >
                        <DollarSign className="mr-2 h-4 w-4" />
                        Asignar Cupo
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Credit Dialog */}
      <Dialog open={creditDialogOpen} onOpenChange={setCreditDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Asignar Cupo de Crédito</DialogTitle>
            <DialogDescription>
              Establece el límite de crédito para {selectedUser?.fullName || selectedUser?.email}
            </DialogDescription>
          </DialogHeader>
          <div className="py-4 space-y-4">
            <div className="space-y-2">
              <Label htmlFor="creditLimit">Nuevo Cupo de Crédito (COP)</Label>
              <Input 
                id="creditLimit" 
                type="number" 
                min="0" 
                step="10000" 
                value={newLimit} 
                onChange={(e) => setNewLimit(e.target.value)}
                disabled={updating}
              />
              <p className="text-xs text-muted-foreground">
                El cliente podrá realizar pedidos hasta este monto total acumulado.
              </p>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setCreditDialogOpen(false)}>Cancelar</Button>
            <Button onClick={handleUpdateCredit} disabled={updating || !newLimit}>
              {updating && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Actualizar Cupo
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}
