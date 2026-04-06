import { redirect } from 'next/navigation'
import { getSession } from '@/lib/application/services/auth-service'
import type { Role } from '@/lib/domain/entities'

// Server-side role guard for pages
export async function guardPage(allowedRoles: Role[], redirectTo: string = '/') {
  const session = await getSession()
  
  if (!session.isAuthenticated) {
    redirect('/auth/login')
  }

  if (!session.user || !allowedRoles.includes(session.user.role)) {
    redirect(redirectTo)
  }

  return session
}

// Guard for admin-only pages
export async function guardAdminPage() {
  return guardPage(['admin'], '/')
}

// Guard for staff pages (admin + bodeguero)
export async function guardStaffPage() {
  return guardPage(['admin', 'bodeguero'], '/')
}

// Guard for client pages (any authenticated user)
export async function guardAuthenticatedPage() {
  return guardPage(['admin', 'bodeguero', 'cliente'], '/auth/login')
}

// Get role-based redirect path after login
export function getRedirectPathForRole(role: Role): string {
  switch (role) {
    case 'admin':
    case 'bodeguero':
      return '/dashboard'
    case 'cliente':
    default:
      return '/'
  }
}
