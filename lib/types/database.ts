export type UserRole = 'admin' | 'warehouse' | 'client'

export interface Profile {
  id: string
  email: string
  full_name: string | null
  phone: string | null
  address: string | null
  role: UserRole
  credit_limit: number
  current_credit: number
  created_at: string
  updated_at: string
}

export interface Category {
  id: string
  name: string
  description: string | null
  image_url: string | null
  is_active: boolean
  created_at: string
}

export interface Product {
  id: string
  category_id: string | null
  name: string
  description: string | null
  sku: string
  price: number
  stock: number
  min_stock: number
  image_url: string | null
  is_active: boolean
  created_at: string
  updated_at: string
  category?: Category
}

export type OrderStatus = 'pending' | 'confirmed' | 'preparing' | 'ready' | 'delivered' | 'cancelled'
export type PaymentMethod = 'cash' | 'credit' | 'transfer'

export interface Order {
  id: string
  client_id: string
  status: OrderStatus
  payment_method: PaymentMethod
  subtotal: number
  discount: number
  total: number
  notes: string | null
  created_at: string
  updated_at: string
  client?: Profile
  items?: OrderItem[]
}

export interface OrderItem {
  id: string
  order_id: string
  product_id: string
  quantity: number
  unit_price: number
  subtotal: number
  product?: Product
}

export type MovementType = 'in' | 'out' | 'adjustment'

export interface InventoryMovement {
  id: string
  product_id: string
  user_id: string
  type: MovementType
  quantity: number
  reason: string | null
  reference_id: string | null
  created_at: string
  product?: Product
  user?: Profile
}

export type CreditMovementType = 'charge' | 'payment' | 'adjustment'

export interface CreditMovement {
  id: string
  client_id: string
  order_id: string | null
  type: CreditMovementType
  amount: number
  balance_after: number
  notes: string | null
  created_at: string
  order?: Order
}

export interface CartItem {
  product: Product
  quantity: number
}
