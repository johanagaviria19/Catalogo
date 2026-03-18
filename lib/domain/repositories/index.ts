// Domain Repository Interfaces - Ports for data access

import type { 
  User, 
  Product, 
  Category, 
  Order, 
  OrderItem,
  InventoryMovement,
  CreditMovement,
  Role,
  OrderStatus
} from '../entities'

export interface IUserRepository {
  findById(id: string): Promise<User | null>
  findByEmail(email: string): Promise<User | null>
  findAll(): Promise<User[]>
  findByRole(role: Role): Promise<User[]>
  create(user: Omit<User, 'id' | 'createdAt'>): Promise<User>
  update(id: string, data: Partial<User>): Promise<User>
  updateRole(id: string, role: Role): Promise<void>
  delete(id: string): Promise<void>
}

export interface IProductRepository {
  findById(id: string): Promise<Product | null>
  findBySlug(slug: string): Promise<Product | null>
  findAll(options?: { categoryId?: string; isActive?: boolean }): Promise<Product[]>
  findFeatured(limit?: number): Promise<Product[]>
  findLowStock(): Promise<Product[]>
  create(product: Omit<Product, 'id' | 'createdAt'>): Promise<Product>
  update(id: string, data: Partial<Product>): Promise<Product>
  updateStock(id: string, quantity: number): Promise<void>
  delete(id: string): Promise<void>
}

export interface ICategoryRepository {
  findById(id: string): Promise<Category | null>
  findBySlug(slug: string): Promise<Category | null>
  findAll(options?: { isActive?: boolean }): Promise<Category[]>
  create(category: Omit<Category, 'id' | 'createdAt'>): Promise<Category>
  update(id: string, data: Partial<Category>): Promise<Category>
  delete(id: string): Promise<void>
}

export interface IOrderRepository {
  findById(id: string): Promise<Order | null>
  findByUserId(userId: string): Promise<Order[]>
  findAll(options?: { status?: OrderStatus }): Promise<Order[]>
  findPending(): Promise<Order[]>
  create(order: Omit<Order, 'id' | 'createdAt' | 'updatedAt'>): Promise<Order>
  update(id: string, data: Partial<Order>): Promise<Order>
  updateStatus(id: string, status: OrderStatus): Promise<void>
  delete(id: string): Promise<void>
}

export interface IOrderItemRepository {
  findByOrderId(orderId: string): Promise<OrderItem[]>
  create(item: Omit<OrderItem, 'id'>): Promise<OrderItem>
  createMany(items: Omit<OrderItem, 'id'>[]): Promise<OrderItem[]>
  delete(id: string): Promise<void>
}

export interface IInventoryRepository {
  findByProductId(productId: string): Promise<InventoryMovement[]>
  findAll(options?: { type?: 'in' | 'out' | 'adjustment' }): Promise<InventoryMovement[]>
  create(movement: Omit<InventoryMovement, 'id' | 'createdAt'>): Promise<InventoryMovement>
}

export interface ICreditRepository {
  findByUserId(userId: string): Promise<CreditMovement[]>
  create(movement: Omit<CreditMovement, 'id' | 'createdAt'>): Promise<CreditMovement>
  getUserBalance(userId: string): Promise<{ limit: number; used: number; available: number }>
}
