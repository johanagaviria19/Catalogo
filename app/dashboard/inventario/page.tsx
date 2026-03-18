'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Textarea } from '@/components/ui/textarea'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Badge } from '@/components/ui/badge'
import { getAllProducts } from '@/lib/actions/products'
import { createClient } from '@/lib/supabase/client'
import { Plus, Warehouse, Loader2, ArrowUp, ArrowDown, RefreshCw } from 'lucide-react'
import type { Product, MovementType } from '@/lib/types/database'

export default function InventarioPage() {
  const router = useRouter()
  const [products, setProducts] = useState<Product[]>([])
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [selectedProduct, setSelectedProduct] = useState<string>('')
  const [movementType, setMovementType] = useState<MovementType>('in')
  const [quantity, setQuantity] = useState('')
  const [reason, setReason] = useState('')
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    getAllProducts().then((prods) => {
      setProducts(prods)
      setLoading(false)
    })
  }, [])

  const handleMovement = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!selectedProduct || !quantity) return

    setSubmitting(true)
    setError(null)

    const supabase = createClient()
    const { data: { user } } = await supabase.auth.getUser()
    
    if (!user) {
      setError('No autenticado')
      setSubmitting(false)
      return
    }

    const product = products.find(p => p.id === selectedProduct)
    if (!product) {
      setError('Producto no encontrado')
      setSubmitting(false)
      return
    }

    const qty = parseInt(quantity)
    let newStock = product.stock

    if (movementType === 'in') {
      newStock += qty
    } else if (movementType === 'out') {
      if (qty > product.stock) {
        setError('No hay suficiente stock')
        setSubmitting(false)
        return
      }
      newStock -= qty
    } else {
      newStock = qty
    }

    // Update product stock
    const { error: updateError } = await supabase
      .from('products')
      .update({ stock: newStock })
      .eq('id', selectedProduct)

    if (updateError) {
      setError(updateError.message)
      setSubmitting(false)
      return
    }

    // Record movement
    const { error: movementError } = await supabase
      .from('inventory_movements')
      .insert({
        product_id: selectedProduct,
        user_id: user.id,
        type: movementType,
        quantity: movementType === 'adjustment' ? newStock : qty,
        reason: reason || null,
      })

    if (movementError) {
      setError(movementError.message)
      setSubmitting(false)
      return
    }

    setDialogOpen(false)
    setSelectedProduct('')
    setQuantity('')
    setReason('')
    setSubmitting(false)
    
    const updated = await getAllProducts()
    setProducts(updated)
    router.refresh()
  }

  const getStockStatus = (product: Product) => {
    if (product.stock === 0) return { label: 'Agotado', variant: 'destructive' as const }
    if (product.stock <= product.min_stock) return { label: 'Bajo', variant: 'secondary' as const }
    return { label: 'Normal', variant: 'default' as const }
  }

  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">Inventario</h1>
          <p className="text-muted-foreground">Gestiona el stock de tus productos</p>
        </div>
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogTrigger asChild>
            <Button>
              <Plus className="mr-2 h-4 w-4" />
              Movimiento
            </Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>Registrar Movimiento</DialogTitle>
              <DialogDescription>Registra entrada, salida o ajuste de inventario</DialogDescription>
            </DialogHeader>
            <form onSubmit={handleMovement}>
              <div className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label>Producto *</Label>
                  <Select value={selectedProduct} onValueChange={setSelectedProduct}>
                    <SelectTrigger>
                      <SelectValue placeholder="Selecciona un producto" />
                    </SelectTrigger>
                    <SelectContent>
                      {products.filter(p => p.is_active).map((product) => (
                        <SelectItem key={product.id} value={product.id}>
                          {product.name} (Stock: {product.stock})
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>Tipo de Movimiento *</Label>
                  <Select value={movementType} onValueChange={(v) => setMovementType(v as MovementType)}>
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="in">
                        <span className="flex items-center gap-2">
                          <ArrowUp className="h-4 w-4 text-green-500" />
                          Entrada
                        </span>
                      </SelectItem>
                      <SelectItem value="out">
                        <span className="flex items-center gap-2">
                          <ArrowDown className="h-4 w-4 text-red-500" />
                          Salida
                        </span>
                      </SelectItem>
                      <SelectItem value="adjustment">
                        <span className="flex items-center gap-2">
                          <RefreshCw className="h-4 w-4 text-blue-500" />
                          Ajuste
                        </span>
                      </SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="quantity">
                    {movementType === 'adjustment' ? 'Nuevo Stock *' : 'Cantidad *'}
                  </Label>
                  <Input
                    id="quantity"
                    type="number"
                    min="0"
                    value={quantity}
                    onChange={(e) => setQuantity(e.target.value)}
                    required
                    placeholder="0"
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="reason">Razón</Label>
                  <Textarea
                    id="reason"
                    value={reason}
                    onChange={(e) => setReason(e.target.value)}
                    placeholder="Motivo del movimiento..."
                    rows={2}
                  />
                </div>
                {error && <p className="text-sm text-destructive">{error}</p>}
              </div>
              <DialogFooter>
                <Button type="button" variant="outline" onClick={() => setDialogOpen(false)}>
                  Cancelar
                </Button>
                <Button type="submit" disabled={submitting || !selectedProduct || !quantity}>
                  {submitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                  Registrar
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Estado del Inventario</CardTitle>
          <CardDescription>Stock actual de todos los productos</CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="text-center py-12">
              <Loader2 className="h-8 w-8 mx-auto animate-spin text-muted-foreground" />
            </div>
          ) : products.length === 0 ? (
            <div className="text-center py-12">
              <Warehouse className="h-12 w-12 mx-auto text-muted-foreground/50 mb-4" />
              <h3 className="text-lg font-medium mb-2">No hay productos</h3>
              <p className="text-muted-foreground">Agrega productos primero para gestionar inventario</p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Producto</TableHead>
                  <TableHead>SKU</TableHead>
                  <TableHead className="text-right">Stock Actual</TableHead>
                  <TableHead className="text-right">Stock Mínimo</TableHead>
                  <TableHead>Estado</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {products.filter(p => p.is_active).map((product) => {
                  const status = getStockStatus(product)
                  return (
                    <TableRow key={product.id}>
                      <TableCell className="font-medium">{product.name}</TableCell>
                      <TableCell className="text-muted-foreground">{product.sku}</TableCell>
                      <TableCell className="text-right font-medium">{product.stock}</TableCell>
                      <TableCell className="text-right text-muted-foreground">{product.min_stock}</TableCell>
                      <TableCell>
                        <Badge variant={status.variant}>{status.label}</Badge>
                      </TableCell>
                    </TableRow>
                  )
                })}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>
    </div>
  )
}
