import { redirect } from 'next/navigation'
import { getProfile } from '@/lib/actions/auth'
import { DashboardSidebar } from '@/components/dashboard-sidebar'

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const profile = await getProfile()

  if (!profile) {
    redirect('/auth/login')
  }

  if (profile.role === 'client') {
    redirect('/mis-pedidos')
  }

  return (
    <div className="min-h-screen flex">
      <DashboardSidebar profile={profile} />
      <main className="flex-1 overflow-auto">
        {children}
      </main>
    </div>
  )
}
