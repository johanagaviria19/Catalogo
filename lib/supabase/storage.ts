import { createClient } from '@/lib/supabase/client'

export async function uploadImage(file: File, bucket: string = 'products'): Promise<string | null> {
  try {
    const supabase = createClient()
    
    // Create bucket if not exists (this might fail if not admin, but usually handled in dashboard)
    // For now we assume bucket 'products' exists and is public.
    
    const fileExt = file.name.split('.').pop()
    const fileName = `${Math.random().toString(36).substring(2)}-${Date.now()}.${fileExt}`
    const filePath = `${fileName}`

    const { data, error } = await supabase.storage
      .from(bucket)
      .upload(filePath, file)

    if (error) {
      console.error('Error uploading image:', error)
      return null
    }

    const { data: { publicUrl } } = supabase.storage
      .from(bucket)
      .getPublicUrl(filePath)

    return publicUrl
  } catch (error) {
    console.error('Error in uploadImage:', error)
    return null
  }
}
