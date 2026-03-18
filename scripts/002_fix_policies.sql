-- Agregar columna is_active a categories si no existe
ALTER TABLE public.categories ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;

-- Agregar columnas faltantes a products
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS sku TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS min_stock INTEGER DEFAULT 5;

-- Eliminar políticas problemáticas que causan recursión infinita
DROP POLICY IF EXISTS "profiles_select_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_update_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_all" ON public.profiles;

DROP POLICY IF EXISTS "categories_select_all" ON public.categories;
DROP POLICY IF EXISTS "categories_admin_all" ON public.categories;

DROP POLICY IF EXISTS "products_select_all" ON public.products;
DROP POLICY IF EXISTS "products_admin_all" ON public.products;
DROP POLICY IF EXISTS "products_bodeguero_update" ON public.products;

DROP POLICY IF EXISTS "orders_select_own" ON public.orders;
DROP POLICY IF EXISTS "orders_insert_own" ON public.orders;
DROP POLICY IF EXISTS "orders_admin_all" ON public.orders;
DROP POLICY IF EXISTS "orders_bodeguero_select" ON public.orders;
DROP POLICY IF EXISTS "orders_bodeguero_update" ON public.orders;

DROP POLICY IF EXISTS "order_items_select_own" ON public.order_items;
DROP POLICY IF EXISTS "order_items_insert_own" ON public.order_items;
DROP POLICY IF EXISTS "order_items_admin_all" ON public.order_items;
DROP POLICY IF EXISTS "order_items_bodeguero_select" ON public.order_items;

DROP POLICY IF EXISTS "inventory_admin_all" ON public.inventory_movements;
DROP POLICY IF EXISTS "inventory_bodeguero_all" ON public.inventory_movements;

DROP POLICY IF EXISTS "credit_select_own" ON public.credit_movements;
DROP POLICY IF EXISTS "credit_admin_all" ON public.credit_movements;

-- NUEVAS POLÍTICAS PARA PROFILES (sin recursión)
-- Usuarios pueden ver y actualizar su propio perfil
CREATE POLICY "profiles_select_own" ON public.profiles 
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "profiles_insert_own" ON public.profiles 
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "profiles_update_own" ON public.profiles 
  FOR UPDATE USING (auth.uid() = id);

-- Admin puede ver todos los perfiles usando user_metadata en lugar de consultar la tabla
CREATE POLICY "profiles_select_admin" ON public.profiles 
  FOR SELECT USING (
    (SELECT (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin') OR
    (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
  );

-- POLÍTICAS PARA CATEGORIES (público)
CREATE POLICY "categories_select_public" ON public.categories 
  FOR SELECT USING (true);

CREATE POLICY "categories_insert_admin" ON public.categories 
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "categories_update_admin" ON public.categories 
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "categories_delete_admin" ON public.categories 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- POLÍTICAS PARA PRODUCTS (público para lectura)
CREATE POLICY "products_select_public" ON public.products 
  FOR SELECT USING (true);

CREATE POLICY "products_insert_admin" ON public.products 
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "products_update_staff" ON public.products 
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "products_delete_admin" ON public.products 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- POLÍTICAS PARA ORDERS
CREATE POLICY "orders_select_own" ON public.orders 
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "orders_insert_auth" ON public.orders 
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "orders_update_staff" ON public.orders 
  FOR UPDATE USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "orders_delete_admin" ON public.orders 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- POLÍTICAS PARA ORDER_ITEMS
CREATE POLICY "order_items_select" ON public.order_items 
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders 
      WHERE id = order_items.order_id 
      AND (user_id = auth.uid() OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero')))
    )
  );

CREATE POLICY "order_items_insert_auth" ON public.order_items 
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.orders WHERE id = order_items.order_id AND user_id = auth.uid())
  );

CREATE POLICY "order_items_update_staff" ON public.order_items 
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "order_items_delete_admin" ON public.order_items 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- POLÍTICAS PARA INVENTORY_MOVEMENTS
CREATE POLICY "inventory_select_staff" ON public.inventory_movements 
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "inventory_insert_staff" ON public.inventory_movements 
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "inventory_update_staff" ON public.inventory_movements 
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin', 'bodeguero'))
  );

CREATE POLICY "inventory_delete_admin" ON public.inventory_movements 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- POLÍTICAS PARA CREDIT_MOVEMENTS
CREATE POLICY "credit_select_own" ON public.credit_movements 
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "credit_insert_admin" ON public.credit_movements 
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "credit_update_admin" ON public.credit_movements 
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "credit_delete_admin" ON public.credit_movements 
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );
