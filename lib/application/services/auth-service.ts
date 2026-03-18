'use server'

import { createClient } from '@/lib/supabase/server'
import { cookies } from 'next/headers'
import type { Role, User } from '@/lib/domain/entities'

export interface AuthUser {
  id: string
  email: string
  role: Role
  fullName: string | null
  emailConfirmed: boolean
}

export interface SessionData {
  user: AuthUser | null
  isAuthenticated: boolean
  isAdmin: boolean
  isWarehouse: boolean
  isClient: boolean
}

// Get current session from server
export async function getSession(): Promise<SessionData> {
  const supabase = await createClient()
  
  const { data: { user }, error } = await supabase.auth.getUser()
  
  if (error || !user) {
    return {
      user: null,
      isAuthenticated: false,
      isAdmin: false,
      isWarehouse: false,
      isClient: false,
    }
  }

  // Get role from user metadata (set during signup or by admin)
  const role = (user.user_metadata?.role as Role) || 'client'
  
  const authUser: AuthUser = {
    id: user.id,
    email: user.email!,
    role,
    fullName: user.user_metadata?.full_name || null,
    emailConfirmed: !!user.email_confirmed_at,
  }

  return {
    user: authUser,
    isAuthenticated: true,
    isAdmin: role === 'admin',
    isWarehouse: role === 'warehouse',
    isClient: role === 'client',
  }
}

// Get user profile from database
export async function getUserProfile(userId: string): Promise<User | null> {
  const supabase = await createClient()
  
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single()

  if (error || !data) return null

  return {
    id: data.id,
    email: data.email,
    role: data.role,
    fullName: data.full_name,
    phone: data.phone,
    address: data.address,
    creditLimit: data.credit_limit,
    creditUsed: data.credit_used,
    isActive: data.is_active,
    createdAt: new Date(data.created_at),
  }
}

// Check if user has required role
export async function requireRole(allowedRoles: Role[]): Promise<SessionData> {
  const session = await getSession()
  
  if (!session.isAuthenticated) {
    throw new Error('UNAUTHORIZED')
  }

  if (!session.user || !allowedRoles.includes(session.user.role)) {
    throw new Error('FORBIDDEN')
  }

  return session
}

// Check if user is admin
export async function requireAdmin(): Promise<SessionData> {
  return requireRole(['admin'])
}

// Check if user is admin or warehouse
export async function requireStaff(): Promise<SessionData> {
  return requireRole(['admin', 'warehouse'])
}

// Sign out user
export async function signOut(): Promise<void> {
  const supabase = await createClient()
  await supabase.auth.signOut()
}

// Update user role (admin only)
export async function updateUserRole(userId: string, newRole: Role): Promise<{ success: boolean; error?: string }> {
  try {
    await requireAdmin()
    
    const supabase = await createClient()
    
    // Update in profiles table
    const { error: profileError } = await supabase
      .from('profiles')
      .update({ role: newRole })
      .eq('id', userId)

    if (profileError) {
      return { success: false, error: profileError.message }
    }

    // Note: To update user_metadata, you need admin API access
    // The role in profiles table is the source of truth for RLS

    return { success: true }
  } catch (error) {
    if (error instanceof Error) {
      return { success: false, error: error.message }
    }
    return { success: false, error: 'Error desconocido' }
  }
}

// Create warehouse user (admin only)
export async function createWarehouseUser(
  email: string,
  password: string,
  fullName: string
): Promise<{ success: boolean; error?: string; userId?: string }> {
  try {
    await requireAdmin()
    
    const supabase = await createClient()
    
    // Create user with warehouse role in metadata
    const { data, error } = await supabase.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: {
        full_name: fullName,
        role: 'warehouse',
      },
    })

    if (error) {
      // If admin API not available, return error with instructions
      return { 
        success: false, 
        error: 'No se puede crear usuario. Contacta al administrador del sistema.' 
      }
    }

    return { success: true, userId: data.user?.id }
  } catch (error) {
    if (error instanceof Error) {
      return { success: false, error: error.message }
    }
    return { success: false, error: 'Error desconocido' }
  }
}
