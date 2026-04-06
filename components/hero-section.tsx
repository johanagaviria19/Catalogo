import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { ArrowRight, Truck, CreditCard, Shield } from 'lucide-react'

export function HeroSection() {
  return (
    <section className="relative h-[400px] sm:h-[500px] md:h-[600px] w-full overflow-hidden bg-slate-900">
      <div className="absolute inset-0">
        <Image
          src="/images/hero-bg.jpg"
          alt="Comercializadora AS DE NARIÑO"
          fill
          className="object-cover opacity-60"
          priority
        />
        <div className="absolute inset-0 bg-gradient-to-r from-slate-900 via-slate-900/40 to-transparent" />
      </div>
      
      <div className="container relative h-full flex items-center px-4 sm:px-6 mx-auto">
        <div className="max-w-2xl space-y-4 sm:space-y-6">
          <Badge variant="secondary" className="bg-primary/20 text-primary border-primary/20 text-xs sm:text-sm">
            Distribuidor Mayorista
          </Badge>
          <h1 className="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold text-white tracking-tight leading-tight">
            Calidad y Confianza en <br className="hidden sm:block" />
            <span className="text-primary">Cada Entrega</span>
          </h1>
          <p className="text-base sm:text-lg md:text-xl text-slate-300 max-w-lg leading-relaxed">
            Suministramos los mejores productos para tu negocio con los precios más competitivos del mercado.
          </p>
          <div className="flex flex-col sm:flex-row gap-3 sm:gap-4 pt-2 sm:pt-4">
            <Link href="/catalogo" className="w-full sm:w-auto">
              <Button size="lg" className="w-full sm:w-auto text-base px-8 h-12">
                Ver Catálogo
              </Button>
            </Link>
            <Link href="/auth/registro" className="w-full sm:w-auto">
              <Button size="lg" variant="outline" className="w-full sm:w-auto text-base px-8 h-12 bg-white/10 text-white hover:bg-white/20 border-white/20">
                Registrarse
              </Button>
            </Link>
          </div>
        </div>
      </div>
    </section>
  )
}
