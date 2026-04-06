'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { createProduct, getAllCategories } from '@/lib/actions/products'
import { uploadImage } from '@/lib/supabase/storage'
import { ArrowLeft, Loader2, Upload, ImageIcon } from 'lucide-react'
import Image from 'next/image'
import type { Category } from '@/lib/types/database'

export default function NuevoProductoPage() {
  const router = useRouter()
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [categories, setCategories] = useState<Category[]>([])
  const [imageFile, setImageFile] = useState<File | null>(null)
  const [imagePreview, setImagePreview] = useState<string | null>(null)

  useEffect(() => {
    getAllCategories().then(setCategories)
  }, [])

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      setImageFile(file)
      const reader = new FileReader()
      reader.onloadend = () => {
        setImagePreview(reader.result as string)
      }
      reader.readAsDataURL(file)
    }
  }

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setLoading(true)
    setError(null)

    const formData = new FormData(e.currentTarget)
    
    // Upload image if selected
    if (imageFile) {
      const imageUrl = await uploadImage(imageFile)
      if (imageUrl) {
        formData.set('image_url', imageUrl)
      }
    }

    const result = await createProduct(formData)

    if (result.error) {
      setError(result.error)
      setLoading(false)
      return
    }

    router.push('/dashboard/productos')
  }

  return (
    <div className="p-4 sm:p-6 space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/dashboard/productos">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl sm:text-3xl font-bold text-foreground">Nuevo Producto</h1>
          <p className="text-sm text-muted-foreground">Agrega un nuevo producto al catálogo</p>
        </div>
      </div>

      <Card className="max-w-2xl mx-auto">
        <CardHeader>
          <CardTitle>Información del Producto</CardTitle>
          <CardDescription>Completa los datos del nuevo producto</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="grid gap-4 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="name">Nombre *</Label>
                <Input id="name" name="name" required placeholder="Nombre del producto" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="sku">SKU *</Label>
                <Input id="sku" name="sku" required placeholder="Código único" />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="description">Descripción</Label>
              <Textarea id="description" name="description" placeholder="Descripción del producto" rows={3} />
            </div>

            <div className="space-y-2">
              <Label htmlFor="category_id">Categoría</Label>
              <Select name="category_id">
                <SelectTrigger>
                  <SelectValue placeholder="Selecciona una categoría" />
                </SelectTrigger>
                <SelectContent>
                  {categories.map((cat) => (
                    <SelectItem key={cat.id} value={cat.id}>{cat.name}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid gap-4 grid-cols-1 sm:grid-cols-3">
              <div className="space-y-2">
                <Label htmlFor="price">Precio *</Label>
                <Input id="price" name="price" type="number" min="0" step="100" required placeholder="0" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="stock">Stock Inicial *</Label>
                <Input id="stock" name="stock" type="number" min="0" required placeholder="0" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="min_stock">Stock Mínimo</Label>
                <Input id="min_stock" name="min_stock" type="number" min="0" defaultValue="5" />
              </div>
            </div>

            <div className="space-y-4 border-t pt-4">
              <Label>Imagen del Producto</Label>
              <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center">
                <div className="relative w-32 h-32 rounded-lg border-2 border-dashed flex items-center justify-center bg-muted overflow-hidden">
                  {imagePreview ? (
                    <Image src={imagePreview} alt="Preview" fill className="object-cover" />
                  ) : (
                    <ImageIcon className="h-8 w-8 text-muted-foreground" />
                  )}
                </div>
                <div className="flex-1 space-y-2 w-full">
                  <Input 
                    id="image_file" 
                    type="file" 
                    accept="image/*" 
                    onChange={handleImageChange}
                    className="hidden" 
                  />
                  <Button 
                    type="button" 
                    variant="outline" 
                    className="w-full sm:w-auto"
                    onClick={() => document.getElementById('image_file')?.click()}
                  >
                    <Upload className="mr-2 h-4 w-4" />
                    Seleccionar Imagen
                  </Button>
                  <p className="text-[10px] sm:text-xs text-muted-foreground">
                    Formatos recomendados: JPG, PNG, WEBP. Tamaño máx: 2MB.
                  </p>
                </div>
              </div>
            </div>

            {error && <p className="text-sm text-destructive">{error}</p>}

            <div className="flex flex-col sm:flex-row gap-3 pt-4">
              <Button type="submit" disabled={loading} className="w-full sm:w-auto order-1 sm:order-2">
                {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                Crear Producto
              </Button>
              <Link href="/dashboard/productos" className="w-full sm:w-auto order-2 sm:order-1">
                <Button type="button" variant="outline" className="w-full">Cancelar</Button>
              </Link>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}

