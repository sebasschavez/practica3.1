// Configuración de Supabase
// IMPORTANTE: Reemplaza estos valores con los de tu proyecto de Supabase
// Los puedes encontrar en: https://app.supabase.com/project/_/settings/api

const SUPABASE_URL = 'TU_SUPABASE_URL_AQUI'; // Ejemplo: https://xxxxxxxxxxxx.supabase.co
const SUPABASE_ANON_KEY = 'TU_SUPABASE_ANON_KEY_AQUI'; // Tu clave pública anon/public

// Inicializar cliente de Supabase
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Exportar para uso en otros archivos
window.supabaseClient = supabase;
