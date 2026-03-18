-- Drop ALL existing policies on profiles to fix recursion
DROP POLICY IF EXISTS profiles_select_own ON profiles;
DROP POLICY IF EXISTS profiles_select_admin ON profiles;
DROP POLICY IF EXISTS profiles_insert_own ON profiles;
DROP POLICY IF EXISTS profiles_update_own ON profiles;
DROP POLICY IF EXISTS profiles_delete_own ON profiles;
DROP POLICY IF EXISTS profiles_admin_all ON profiles;

-- Simple policies without recursion
-- Users can read their own profile
CREATE POLICY "profiles_select_own" ON profiles
  FOR SELECT USING (auth.uid() = id);

-- Users can insert their own profile
CREATE POLICY "profiles_insert_own" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Users can update their own profile (but not role)
CREATE POLICY "profiles_update_own" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- Admin can see all profiles using user metadata (no table lookup = no recursion)
CREATE POLICY "profiles_admin_select" ON profiles
  FOR SELECT USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Admin can update any profile
CREATE POLICY "profiles_admin_update" ON profiles
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Fix trigger to also set role in user metadata
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, phone, role)
  VALUES (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'full_name', null),
    coalesce(new.raw_user_meta_data ->> 'phone', null),
    coalesce(new.raw_user_meta_data ->> 'role', 'client')
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name),
    phone = COALESCE(EXCLUDED.phone, profiles.phone);
  
  RETURN new;
END;
$$;

-- Recreate trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Fix other tables that reference profiles for admin check
-- Products
DROP POLICY IF EXISTS products_insert_admin ON products;
DROP POLICY IF EXISTS products_delete_admin ON products;
DROP POLICY IF EXISTS products_update_staff ON products;

CREATE POLICY "products_insert_admin" ON products
  FOR INSERT WITH CHECK (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "products_delete_admin" ON products
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "products_update_staff" ON products
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

-- Categories
DROP POLICY IF EXISTS categories_insert_admin ON categories;
DROP POLICY IF EXISTS categories_update_admin ON categories;
DROP POLICY IF EXISTS categories_delete_admin ON categories;

CREATE POLICY "categories_insert_admin" ON categories
  FOR INSERT WITH CHECK (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "categories_update_admin" ON categories
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "categories_delete_admin" ON categories
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Orders
DROP POLICY IF EXISTS orders_update_staff ON orders;
DROP POLICY IF EXISTS orders_delete_admin ON orders;

CREATE POLICY "orders_update_staff" ON orders
  FOR UPDATE USING (
    auth.uid() = user_id OR
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

CREATE POLICY "orders_delete_admin" ON orders
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Order Items
DROP POLICY IF EXISTS order_items_update_staff ON order_items;
DROP POLICY IF EXISTS order_items_delete_admin ON order_items;

CREATE POLICY "order_items_update_staff" ON order_items
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

CREATE POLICY "order_items_delete_admin" ON order_items
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Inventory Movements
DROP POLICY IF EXISTS inventory_select_staff ON inventory_movements;
DROP POLICY IF EXISTS inventory_insert_staff ON inventory_movements;
DROP POLICY IF EXISTS inventory_update_staff ON inventory_movements;
DROP POLICY IF EXISTS inventory_delete_admin ON inventory_movements;

CREATE POLICY "inventory_select_staff" ON inventory_movements
  FOR SELECT USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

CREATE POLICY "inventory_insert_staff" ON inventory_movements
  FOR INSERT WITH CHECK (
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

CREATE POLICY "inventory_update_staff" ON inventory_movements
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') IN ('admin', 'warehouse')
  );

CREATE POLICY "inventory_delete_admin" ON inventory_movements
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Credit Movements
DROP POLICY IF EXISTS credit_select_own ON credit_movements;
DROP POLICY IF EXISTS credit_insert_admin ON credit_movements;
DROP POLICY IF EXISTS credit_update_admin ON credit_movements;
DROP POLICY IF EXISTS credit_delete_admin ON credit_movements;

CREATE POLICY "credit_select_own" ON credit_movements
  FOR SELECT USING (
    auth.uid() = user_id OR
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "credit_insert_admin" ON credit_movements
  FOR INSERT WITH CHECK (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "credit_update_admin" ON credit_movements
  FOR UPDATE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

CREATE POLICY "credit_delete_admin" ON credit_movements
  FOR DELETE USING (
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );
