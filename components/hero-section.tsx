import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'
import { ArrowRight, Truck, CreditCard, Shield } from 'lucide-react'

export function HeroSection() {
  return (
    <section className="relative overflow-hidden bg-gradient-to-br from-secondary via-secondary to-secondary/90">
      <div className="container py-16 md:py-24">
        <div className="grid gap-8 md:grid-cols-2 md:gap-12 items-center">
          <div className="space-y-6">
            <div className="inline-block rounded-full bg-primary/10 px-4 py-1.5 text-sm font-medium text-primary">
              Tu aliado comercial en Nariño
            </div>
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight text-secondary-foreground text-balance">
              Productos de calidad al mejor precio
            </h1>
            <p className="text-lg text-secondary-foreground/80 max-w-lg text-pretty">
              Somos tu comercializadora de confianza. Encuentra todo lo que necesitas para tu negocio con precios competitivos y entrega rápida.
            </p>
            <div className="flex flex-wrap gap-4">
              <Link href="/catalogo">
                <Button size="lg" className="font-semibold">
                  Ver Catálogo
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </Link>
              <Link href="/auth/registro">
                <Button size="lg" variant="outline" className="font-semibold bg-secondary-foreground/10 border-secondary-foreground/20 text-secondary-foreground hover:bg-secondary-foreground/20">
                  Registrarse
                </Button>
              </Link>
            </div>
          </div>
          <div className="relative flex justify-center">
            <div className="relative w-64 h-64 md:w-80 md:h-80">
              <Image
                src="/images/logo.jpeg"
                alt="AS DE NARIÑO"
                fill
                className="object-contain drop-shadow-2xl"
                priority
              />
            </div>
          </div>
        </div>

        {/* Features */}
        <div className="mt-16 grid gap-6 md:grid-cols-3">
          <div className="flex items-start gap-4 p-6 rounded-xl bg-secondary-foreground/5">
            <div className="p-3 rounded-lg bg-primary/10">
              <Truck className="h-6 w-6 text-primary" />
            </div>
            <div>
              <h3 className="font-semibold text-secondary-foreground">Entrega Rápida</h3>
              <p className="text-sm text-secondary-foreground/70">Recibe tus pedidos en tiempo récord</p>
            </div>
          </div>
          <div className="flex items-start gap-4 p-6 rounded-xl bg-secondary-foreground/5">
            <div className="p-3 rounded-lg bg-primary/10">
              <CreditCard className="h-6 w-6 text-primary" />
            </div>
            <div>
              <h3 className="font-semibold text-secondary-foreground">Crédito Disponible</h3>
              <p className="text-sm text-secondary-foreground/70">Opciones de pago flexibles para tu negocio</p>
            </div>
          </div>
          <div className="flex items-start gap-4 p-6 rounded-xl bg-secondary-foreground/5">
            <div className="p-3 rounded-lg bg-primary/10">
              <Shield className="h-6 w-6 text-primary" />
            </div>
            <div>
              <h3 className="font-semibold text-secondary-foreground">Productos Garantizados</h3>
              <p className="text-sm text-secondary-foreground/70">Calidad asegurada en cada compra</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
