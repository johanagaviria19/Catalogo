import postgres from 'postgres'
import * as dotenv from 'dotenv'

dotenv.config({ path: '.env.local' })

const databaseUrl = process.env.DATABASE_URL

if (!databaseUrl) {
  console.error('Error: DATABASE_URL no encontrada en .env.local')
  process.exit(1)
}

const sql = postgres(databaseUrl)

async function setupRoles() {
  const email = process.argv[2]
  const role = process.argv[3] || 'admin'

  if (!email) {
    console.error('Uso: npx tsx scripts/setup-roles.ts <email> [role]')
    process.exit(1)
  }

  console.log(`Promoviendo a ${email} al rol: ${role}...`)

  try {
    // 1. Update profiles table
    const result = await sql`
      UPDATE public.profiles 
      SET role = ${role} 
      WHERE email = ${email}
      RETURNING id
    `

    if (result.length === 0) {
      console.error(`❌ No se encontró el usuario con email ${email} en la tabla profiles.`)
      console.log('Asegúrate de que el usuario ya se haya registrado en la aplicación.')
      process.exit(1)
    }

    const userId = result[0].id

    console.log(`✅ Rol actualizado en la tabla profiles para el usuario ${userId}`)

    // Nota: El rol en auth.users (user_metadata) es difícil de actualizar vía SQL directo 
    // porque está en un campo JSONB y es parte del esquema auth.
    // Pero nuestras políticas RLS usan la tabla profiles o el JWT metadata.
    
    // Intentar actualizar también el metadata en auth.users si es posible
    await sql`
      UPDATE auth.users 
      SET raw_user_meta_data = raw_user_meta_data || ${JSON.stringify({ role: role })}::jsonb
      WHERE id = ${userId}
    `
    
    console.log(`✅ Metadata actualizado en auth.users para el usuario ${userId}`)
    console.log(`🚀 ¡Listo! ${email} ahora es ${role}. Reinicia sesión en la app para aplicar cambios.`)

  } catch (error) {
    console.error('❌ Error ejecutando el script:', error)
  } finally {
    await sql.end()
  }
}

setupRoles()
