import Link from 'next/link'
import Image from 'next/image'
import { Card, CardContent } from '@/components/ui/card'
import { Layers } from 'lucide-react'
import type { Category } from '@/lib/types/database'

interface CategoriesSectionProps {
  categories: Category[]
}

export function CategoriesSection({ categories }: CategoriesSectionProps) {
  if (categories.length === 0) {
    return (
      <section className="py-16 bg-muted/30">
        <div className="container">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground">Categorías</h2>
            <p className="text-muted-foreground mt-2">Explora nuestras categorías de productos</p>
          </div>
          <div className="text-center py-12">
            <Layers className="h-16 w-16 mx-auto text-muted-foreground/50 mb-4" />
            <p className="text-muted-foreground">Próximamente agregaremos categorías</p>
          </div>
        </div>
      </section>
    )
  }

  return (
    <section className="py-16 bg-muted/30">
      <div className="container">
        <div className="text-center mb-10">
          <h2 className="text-3xl font-bold text-foreground">Categorías</h2>
          <p className="text-muted-foreground mt-2">Explora nuestras categorías de productos</p>
        </div>
        <div className="grid gap-4 grid-cols-2 md:grid-cols-4 lg:grid-cols-6">
          {categories.map((category) => (
            <Link key={category.id} href={`/catalogo?categoria=${category.id}`}>
              <Card className="group cursor-pointer transition-all hover:shadow-md hover:border-primary/50">
                <CardContent className="p-4 text-center">
                  <div className="relative aspect-square mb-3 rounded-lg overflow-hidden bg-muted">
                    {category.image_url ? (
                      <Image
                        src={category.image_url}
                        alt={category.name}
                        fill
                        className="object-cover transition-transform group-hover:scale-105"
                      />
                    ) : (
                      <div className="flex h-full items-center justify-center">
                        <Layers className="h-10 w-10 text-muted-foreground/50" />
                      </div>
                    )}
                  </div>
                  <h3 className="font-medium text-foreground text-sm">{category.name}</h3>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </section>
  )
}
