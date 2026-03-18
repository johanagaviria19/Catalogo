'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidateTag } from 'next/cache'
import type { Order, OrderStatus, PaymentMethod, CartItem } from '@/lib/types/database'

export async function createOrder(
  items: CartItem[],
  paymentMethod: PaymentMethod,
  notes?: string
) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) {
    return { error: 'No autenticado' }
  }

  const subtotal = items.reduce((sum, item) => sum + (item.product.price * item.quantity), 0)
  const total = subtotal

  // Create order
  const { data: order, error: orderError } = await supabase
    .from('orders')
    .insert({
      client_id: user.id,
      status: 'pending' as OrderStatus,
      payment_method: paymentMethod,
      subtotal,
      discount: 0,
      total,
      notes,
    })
    .select()
    .single()

  if (orderError) {
    return { error: orderError.message }
  }

  // Create order items
  const orderItems = items.map(item => ({
    order_id: order.id,
    product_id: item.product.id,
    quantity: item.quantity,
    unit_price: item.product.price,
    subtotal: item.product.price * item.quantity,
  }))

  const { error: itemsError } = await supabase
    .from('order_items')
    .insert(orderItems)

  if (itemsError) {
    // Rollback order
    await supabase.from('orders').delete().eq('id', order.id)
    return { error: itemsError.message }
  }

  // If credit payment, update client credit
  if (paymentMethod === 'credit') {
    const { data: profile } = await supabase
      .from('profiles')
      .select('current_credit')
      .eq('id', user.id)
      .single()

    if (profile) {
      const newCredit = profile.current_credit + total

      await supabase
        .from('profiles')
        .update({ current_credit: newCredit })
        .eq('id', user.id)

      await supabase.from('credit_movements').insert({
        client_id: user.id,
        order_id: order.id,
        type: 'charge',
        amount: total,
        balance_after: newCredit,
        notes: `Pedido #${order.id.slice(0, 8)}`,
      })
    }
  }

  revalidateTag('orders', 'max')
  return { success: true, orderId: order.id }
}

export async function getClientOrders(): Promise<Order[]> {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) return []

  const { data, error } = await supabase
    .from('orders')
    .select('*, items:order_items(*, product:products(*))')
    .eq('client_id', user.id)
    .order('created_at', { ascending: false })

  if (error) {
    console.error('Error fetching orders:', error)
    return []
  }

  return data || []
}

export async function getAllOrders(): Promise<Order[]> {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('orders')
    .select('*, client:profiles(*), items:order_items(*, product:products(*))')
    .order('created_at', { ascending: false })

  if (error) {
    console.error('Error fetching all orders:', error)
    return []
  }

  return data || []
}

export async function updateOrderStatus(orderId: string, status: OrderStatus) {
  const supabase = await createClient()

  const { error } = await supabase
    .from('orders')
    .update({ status })
    .eq('id', orderId)

  if (error) {
    return { error: error.message }
  }

  // If order is delivered, update inventory
  if (status === 'delivered') {
    const { data: order } = await supabase
      .from('orders')
      .select('*, items:order_items(*)')
      .eq('id', orderId)
      .single()

    if (order?.items) {
      const { data: { user } } = await supabase.auth.getUser()
      
      for (const item of order.items) {
        // Update stock
        await supabase.rpc('update_product_stock', {
          p_product_id: item.product_id,
          p_quantity: -item.quantity
        })

        // Record inventory movement
        await supabase.from('inventory_movements').insert({
          product_id: item.product_id,
          user_id: user?.id,
          type: 'out',
          quantity: item.quantity,
          reason: 'Venta',
          reference_id: orderId,
        })
      }
    }
  }

  revalidateTag('orders', 'max')
  return { success: true }
}

export async function getOrderById(orderId: string): Promise<Order | null> {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('orders')
    .select('*, client:profiles(*), items:order_items(*, product:products(*))')
    .eq('id', orderId)
    .single()

  if (error) {
    console.error('Error fetching order:', error)
    return null
  }

  return data
}
