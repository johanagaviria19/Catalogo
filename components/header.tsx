'use client'

import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'
import { ShoppingCart, User, Menu, X } from 'lucide-react'
import { useState } from 'react'
import { useCart } from '@/lib/hooks/use-cart'

interface HeaderProps {
  user?: {
    email: string
    role?: string
  } | null
}

export function Header({ user }: HeaderProps) {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)
  const { items } = useCart()
  const itemCount = items.reduce((sum, item) => sum + item.quantity, 0)

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container px-4 sm:px-6 flex h-16 items-center justify-between mx-auto">
        <Link href="/" className="flex items-center gap-2 sm:gap-3 shrink-0">
          <Image
            src="/images/logo.jpeg"
            alt="AS DE NARIÑO"
            width={40}
            height={40}
            className="rounded w-8 h-8 sm:w-10 sm:h-10 md:w-12 md:h-12"
          />
          <div className="hidden xs:block">
            <p className="font-bold text-foreground leading-none text-xs sm:text-sm md:text-base">AS DE NARIÑO</p>
            <p className="text-[10px] sm:text-xs text-muted-foreground">Comercializadora</p>
          </div>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden md:flex items-center gap-4 lg:gap-6">
          <Link href="/catalogo" className="text-sm font-medium text-muted-foreground hover:text-primary transition-colors">
            Catálogo
          </Link>
          {user ? (
            <>
              <Link href="/mis-pedidos" className="text-sm font-medium text-muted-foreground hover:text-primary transition-colors">
                Mis Pedidos
              </Link>
              {(user.role === 'admin' || user.role === 'bodeguero') && (
                <Link href="/dashboard" className="text-sm font-medium text-muted-foreground hover:text-primary transition-colors">
                  Panel
                </Link>
              )}
            </>
          ) : null}
        </nav>

        <div className="flex items-center gap-1 sm:gap-2">
          <Link href="/carrito">
            <Button variant="ghost" size="icon" className="relative h-9 w-9 sm:h-10 sm:w-10">
              <ShoppingCart className="h-4 w-4 sm:h-5 sm:w-5" />
              {itemCount > 0 && (
                <span className="absolute -top-1 -right-1 h-4 w-4 sm:h-5 sm:w-5 rounded-full bg-primary text-primary-foreground text-[10px] sm:text-xs flex items-center justify-center">
                  {itemCount}
                </span>
              )}
            </Button>
          </Link>

          {user ? (
            <Link href="/perfil">
              <Button variant="ghost" size="icon" className="h-9 w-9 sm:h-10 sm:w-10">
                <User className="h-4 w-4 sm:h-5 sm:w-5" />
              </Button>
            </Link>
          ) : (
            <Link href="/auth/login">
              <Button variant="default" size="sm" className="text-xs sm:text-sm px-2 sm:px-4">
                Iniciar Sesión
              </Button>
            </Link>
          )}

          {/* Mobile menu button */}
          <Button
            variant="ghost"
            size="icon"
            className="md:hidden h-9 w-9"
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          >
            {mobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
          </Button>
        </div>
      </div>

      {/* Mobile Navigation */}
      {mobileMenuOpen && (
        <div className="md:hidden border-t bg-background animate-in slide-in-from-top-2 duration-200">
          <nav className="container px-4 py-4 flex flex-col gap-1">
            <Link 
              href="/catalogo" 
              className="px-4 py-3 text-sm font-medium hover:bg-muted rounded-md transition-colors"
              onClick={() => setMobileMenuOpen(false)}
            >
              Catálogo
            </Link>
            {user && (
              <>
                <Link 
                  href="/mis-pedidos" 
                  className="px-4 py-3 text-sm font-medium hover:bg-muted rounded-md transition-colors"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  Mis Pedidos
                </Link>
                {(user.role === 'admin' || user.role === 'bodeguero') && (
                  <Link 
                    href="/dashboard" 
                    className="px-4 py-3 text-sm font-medium hover:bg-muted rounded-md transition-colors"
                    onClick={() => setMobileMenuOpen(false)}
                  >
                    Panel de Administración
                  </Link>
                )}
              </>
            )}
          </nav>
        </div>
      )}
    </header>
  )
}
