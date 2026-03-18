import Link from 'next/link'
import { Header } from '@/components/header'
import { Footer } from '@/components/footer'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { getProfile } from '@/lib/actions/auth'
import { CheckCircle } from 'lucide-react'

interface PedidoExitosoPageProps {
  searchParams: Promise<{ id?: string }>
}

export default async function PedidoExitosoPage({ searchParams }: PedidoExitosoPageProps) {
  const params = await searchParams
  const profile = await getProfile()
  const user = profile ? { email: profile.email, role: profile.role } : null

  return (
    <div className="min-h-screen flex flex-col">
      <Header user={user} />
      <main className="flex-1 flex items-center justify-center p-4">
        <Card className="w-full max-w-md text-center">
          <CardHeader>
            <div className="mx-auto w-16 h-16 rounded-full bg-green-100 flex items-center justify-center mb-4">
              <CheckCircle className="h-10 w-10 text-green-600" />
            </div>
            <CardTitle className="text-2xl">Pedido Realizado</CardTitle>
            <CardDescription>
              Tu pedido ha sido registrado exitosamente
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {params.id && (
              <p className="text-sm text-muted-foreground">
                Número de pedido: <span className="font-mono font-medium">#{params.id.slice(0, 8)}</span>
              </p>
            )}
            <p className="text-sm text-muted-foreground">
              Te notificaremos cuando tu pedido esté listo. Puedes seguir el estado en la sección de Mis Pedidos.
            </p>
            <div className="flex flex-col gap-2 pt-4">
              <Link href="/mis-pedidos">
                <Button className="w-full">Ver Mis Pedidos</Button>
              </Link>
              <Link href="/catalogo">
                <Button variant="outline" className="w-full">Seguir Comprando</Button>
              </Link>
            </div>
          </CardContent>
        </Card>
      </main>
      <Footer />
    </div>
  )
}
