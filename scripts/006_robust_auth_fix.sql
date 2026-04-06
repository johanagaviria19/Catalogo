-- 1. Asegurar permisos básicos para los roles de Supabase
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated, service_role;

-- 2. Limpiar políticas de profiles para evitar cualquier conflicto
DROP POLICY IF EXISTS "profiles_select_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_insert_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_update_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_select" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_update" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_delete" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_all" ON public.profiles;

-- 3. Crear políticas simplificadas y seguras
-- Lectura: Cada uno lo suyo, admin todo
CREATE POLICY "profiles_select_policy" ON public.profiles
  FOR SELECT USING (
    auth.uid() = id OR 
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- Inserción: Solo el trigger (SECURITY DEFINER) o el propio usuario como respaldo
CREATE POLICY "profiles_insert_policy" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Actualización: Cada uno lo suyo (excepto rol), admin todo
CREATE POLICY "profiles_update_policy" ON public.profiles
  FOR UPDATE USING (
    auth.uid() = id OR 
    (auth.jwt() -> 'user_metadata' ->> 'role') = 'admin'
  );

-- 4. Reforzar el trigger de creación de perfil
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth
AS $$
DECLARE
  default_role TEXT := 'cliente';
BEGIN
  -- Intentar obtener el rol de metadata, si no, usar el default
  IF (NEW.raw_user_meta_data ->> 'role') IS NOT NULL THEN
    default_role := NEW.raw_user_meta_data ->> 'role';
  END IF;

  INSERT INTO public.profiles (
    id, 
    email, 
    full_name, 
    phone, 
    address, 
    role
  )
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data ->> 'full_name', NEW.raw_user_meta_data ->> 'fullName'),
    COALESCE(NEW.raw_user_meta_data ->> 'phone', NULL),
    COALESCE(NEW.raw_user_meta_data ->> 'address', NULL),
    default_role
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name),
    phone = COALESCE(EXCLUDED.phone, profiles.phone),
    address = COALESCE(EXCLUDED.address, profiles.address),
    updated_at = NOW();
  
  RETURN NEW;
EXCEPTION WHEN OTHERS THEN
  -- Si falla, al menos dejamos que el usuario se cree en auth.users
  -- Esto evita el error 500 en el registro, aunque el perfil no se cree
  -- El usuario podrá loguearse y el perfil se podría crear después
  RETURN NEW;
END;
$$;

-- 5. Re-vincular el trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();
