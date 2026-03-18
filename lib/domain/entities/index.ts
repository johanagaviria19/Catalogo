// Domain Entities - Core business objects

export type Role = 'admin' | 'warehouse' | 'client'

export interface User {
  id: string
  email: string
  role: Role
  fullName: string | null
  phone: string | null
  address: string | null
  creditLimit: number
  creditUsed: number
  isActive: boolean
  createdAt: Date
}

export interface Category {
  id: string
  name: string
  slug: string
  description: string | null
  imageUrl: string | null
  isActive: boolean
  createdAt: Date
}

export interface Product {
  id: string
  name: string
  slug: string
  description: string | null
  sku: string
  price: number
  stock: number
  minStock: number
  categoryId: string | null
  imageUrl: string | null
  isActive: boolean
  createdAt: Date
  category?: Category
}

export type OrderStatus = 'pending' | 'confirmed' | 'preparing' | 'ready' | 'dispatched' | 'delivered' | 'cancelled'
export type PaymentMethod = 'cash' | 'transfer' | 'credit'
export type PaymentStatus = 'pending' | 'paid' | 'partial'

export interface Order {
  id: string
  userId: string
  status: OrderStatus
  paymentMethod: PaymentMethod
  paymentStatus: PaymentStatus
  subtotal: number
  tax: number
  total: number
  notes: string | null
  deliveryAddress: string | null
  createdAt: Date
  updatedAt: Date
  user?: User
  items?: OrderItem[]
}

export interface OrderItem {
  id: string
  orderId: string
  productId: string
  quantity: number
  unitPrice: number
  total: number
  product?: Product
}

export interface InventoryMovement {
  id: string
  productId: string
  type: 'in' | 'out' | 'adjustment'
  quantity: number
  reason: string | null
  orderId: string | null
  userId: string
  createdAt: Date
  product?: Product
  user?: User
}

export interface CreditMovement {
  id: string
  userId: string
  type: 'charge' | 'payment'
  amount: number
  orderId: string | null
  description: string | null
  createdAt: Date
}

// Cart types (client-side only)
export interface CartItem {
  product: Product
  quantity: number
}

export interface Cart {
  items: CartItem[]
  subtotal: number
  tax: number
  total: number
}
