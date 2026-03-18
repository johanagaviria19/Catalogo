'use client'

import Link from 'next/link'
import { useSearchParams } from 'next/navigation'
import { cn } from '@/lib/utils'
import type { Category } from '@/lib/types/database'

interface CategoryFilterProps {
  categories: Category[]
  selectedCategory?: string
}

export function CategoryFilter({ categories, selectedCategory }: CategoryFilterProps) {
  const searchParams = useSearchParams()

  return (
    <div className="space-y-4">
      <h3 className="font-semibold text-foreground">Categorías</h3>
      <nav className="space-y-1">
        <Link
          href="/catalogo"
          className={cn(
            "block px-3 py-2 rounded-md text-sm transition-colors",
            !selectedCategory
              ? "bg-primary text-primary-foreground font-medium"
              : "text-muted-foreground hover:bg-muted hover:text-foreground"
          )}
        >
          Todas las categorías
        </Link>
        {categories.map((category) => (
          <Link
            key={category.id}
            href={`/catalogo?categoria=${category.id}`}
            className={cn(
              "block px-3 py-2 rounded-md text-sm transition-colors",
              selectedCategory === category.id
                ? "bg-primary text-primary-foreground font-medium"
                : "text-muted-foreground hover:bg-muted hover:text-foreground"
            )}
          >
            {category.name}
          </Link>
        ))}
      </nav>
    </div>
  )
}
