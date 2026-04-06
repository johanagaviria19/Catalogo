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

    // 2. Update auth.users metadata
    // Fetch current metadata first to avoid breaking it
    const userResult = await sql`
      SELECT raw_user_meta_data FROM auth.users WHERE id = ${userId}
    `
    
    if (userResult.length > 0) {
      let currentMetadata = userResult[0].raw_user_meta_data || {}
      
      // Handle potential array issue (safety)
      if (Array.isArray(currentMetadata)) {
        currentMetadata = typeof currentMetadata[0] === 'object' ? currentMetadata[0] : {}
      }
      
      const newMetadata = { ...currentMetadata, role: role }

      await sql`
        UPDATE auth.users 
        SET raw_user_meta_data = ${newMetadata}
        WHERE id = ${userId}
      `
      console.log(`✅ Metadata actualizado en auth.users para el usuario ${userId}`)
    }

    console.log(`🚀 ¡Listo! ${email} ahora es ${role}. Reinicia sesión en la app para aplicar cambios.`)

  } catch (error) {
    console.error('❌ Error ejecutando el script:', error)
  } finally {
    await sql.end()
  }
}

setupRoles()
