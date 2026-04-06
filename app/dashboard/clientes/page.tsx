'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Badge } from '@/components/ui/badge'
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { getAllUsers, updateUserRole } from '@/lib/application/services/auth-service'
import { Users, Loader2, Shield } from 'lucide-react'
import { toast } from 'sonner'
import type { User, Role } from '@/lib/domain/entities'

export default function ClientesPage() {
  const router = useRouter()
  const [users, setUsers] = useState<User[]>([])
  const [loading, setLoading] = useState(true)
  const [updating, setUpdating] = useState(false)
  const [selectedUser, setSelectedUser] = useState<User | null>(null)
  const [roleDialogOpen, setRoleDialogOpen] = useState(false)

  useEffect(() => {
    getAllUsers().then((data) => {
      setUsers(data)
      setLoading(false)
    })
  }, [])

  const handleUpdateRole = async (newRole: Role) => {
    if (!selectedUser) return

    setUpdating(true)
    const result = await updateUserRole(selectedUser.id, newRole)

    if (result.error) {
      toast.error(result.error)
      setUpdating(false)
      return
    }

    toast.success('Rol actualizado correctamente')
    setRoleDialogOpen(false)
    setUpdating(false)
    const updated = await getAllUsers()
    setUsers(updated)
    router.refresh()
  }

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Gestión de Usuarios</h1>
        <p className="text-muted-foreground">Administra los roles y permisos de los usuarios</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Lista de Usuarios</CardTitle>
          <CardDescription>{users.length} usuarios registrados</CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="text-center py-12">
              <Loader2 className="h-8 w-8 mx-auto animate-spin text-muted-foreground" />
            </div>
          ) : users.length === 0 ? (
            <div className="text-center py-12">
              <Users className="h-12 w-12 mx-auto text-muted-foreground/50 mb-4" />
              <h3 className="text-lg font-medium mb-2">No hay usuarios</h3>
              <p className="text-muted-foreground">Los usuarios registrados aparecerán aquí</p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Nombre</TableHead>
                  <TableHead>Email</TableHead>
                  <TableHead>Rol</TableHead>
                  <TableHead>Registro</TableHead>
                  <TableHead className="text-right">Acciones</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {users.map((user) => (
                  <TableRow key={user.id}>
                    <TableCell className="font-medium">{user.fullName || 'Sin nombre'}</TableCell>
                    <TableCell>{user.email}</TableCell>
                    <TableCell>
                      <Badge variant={user.role === 'admin' ? 'default' : user.role === 'bodeguero' ? 'secondary' : 'outline'}>
                        {user.role}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {new Date(user.createdAt).toLocaleDateString('es-CO')}
                    </TableCell>
                    <TableCell className="text-right">
                      <Button 
                        variant="ghost" 
                        size="sm" 
                        onClick={() => {
                          setSelectedUser(user)
                          setRoleDialogOpen(true)
                        }}
                      >
                        <Shield className="mr-2 h-4 w-4" />
                        Cambiar Rol
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Role Dialog */}
      <Dialog open={roleDialogOpen} onOpenChange={setRoleDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Cambiar Rol de Usuario</DialogTitle>
            <DialogDescription>
              Selecciona el nuevo rol para {selectedUser?.fullName || selectedUser?.email}
            </DialogDescription>
          </DialogHeader>
          <div className="py-4 space-y-4">
            <div className="space-y-2">
              <p className="text-sm font-medium">Rol actual: <span className="capitalize font-bold">{selectedUser?.role}</span></p>
              <Select 
                defaultValue={selectedUser?.role} 
                onValueChange={(v) => handleUpdateRole(v as Role)}
                disabled={updating}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona un rol" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="cliente">Cliente (Usuario normal)</SelectItem>
                  <SelectItem value="bodeguero">Bodeguero (Gestión de stock y pedidos)</SelectItem>
                  <SelectItem value="admin">Administrador (Control total)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            {updating && (
              <div className="flex items-center justify-center gap-2 text-sm text-muted-foreground">
                <Loader2 className="h-4 w-4 animate-spin" />
                Actualizando rol...
              </div>
            )}
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setRoleDialogOpen(false)}>Cancelar</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}
