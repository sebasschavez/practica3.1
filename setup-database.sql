-- ================================================
-- SCRIPT DE CONFIGURACIÓN DE BASE DE DATOS
-- Sistema de Gestión de Información con Supabase
-- ================================================
-- INSTRUCCIONES:
-- 1. Ve a tu proyecto en Supabase
-- 2. Click en "SQL Editor" en el menú lateral
-- 3. Copia y pega TODO este archivo
-- 4. Click en "Run" o presiona Ctrl+Enter
-- ================================================

-- Paso 1: Crear tabla de usuarios con información adicional
CREATE TABLE IF NOT EXISTS users (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Paso 2: Crear tabla de información/posts
CREATE TABLE IF NOT EXISTS information (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Paso 3: Habilitar Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE information ENABLE ROW LEVEL SECURITY;

-- Paso 4: ELIMINAR políticas existentes si las hay (para evitar errores)
DROP POLICY IF EXISTS "Users can view own profile" ON users;
DROP POLICY IF EXISTS "Users can update own profile" ON users;
DROP POLICY IF EXISTS "Enable insert for authenticated users only" ON users;
DROP POLICY IF EXISTS "Anyone authenticated can view information" ON information;
DROP POLICY IF EXISTS "Only admins can insert information" ON information;
DROP POLICY IF EXISTS "Only admins can delete information" ON information;
DROP POLICY IF EXISTS "Only admins can update information" ON information;

-- Paso 5: Políticas para la tabla USERS
-- Los usuarios pueden leer su propia información
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT 
  USING (auth.uid() = id);

-- Los usuarios pueden actualizar su propia información
CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE 
  USING (auth.uid() = id);

-- Permitir inserciones al registrarse
CREATE POLICY "Enable insert for authenticated users only" ON users
  FOR INSERT 
  WITH CHECK (auth.uid() = id);

-- Paso 6: Políticas para la tabla INFORMATION
-- Todos los usuarios autenticados pueden LEER la información
CREATE POLICY "Anyone authenticated can view information" ON information
  FOR SELECT 
  USING (auth.role() = 'authenticated');

-- Solo los ADMINS pueden INSERTAR información
CREATE POLICY "Only admins can insert information" ON information
  FOR INSERT 
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );

-- Solo los ADMINS pueden ELIMINAR información
CREATE POLICY "Only admins can delete information" ON information
  FOR DELETE 
  USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );

-- Solo los ADMINS pueden ACTUALIZAR información
CREATE POLICY "Only admins can update information" ON information
  FOR UPDATE 
  USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );

-- Paso 7: Crear índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_information_user_id ON information(user_id);
CREATE INDEX IF NOT EXISTS idx_information_created_at ON information(created_at DESC);

-- Paso 8: Función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc', NOW());
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Paso 9: Trigger para actualizar updated_at en information
DROP TRIGGER IF EXISTS update_information_updated_at ON information;
CREATE TRIGGER update_information_updated_at 
  BEFORE UPDATE ON information
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- ================================================
-- ¡CONFIGURACIÓN COMPLETADA!
-- ================================================
-- Ahora puedes:
-- 1. Verificar que las tablas se crearon: Ve a "Table Editor"
-- 2. Deberías ver las tablas "users" e "information"
-- 3. Continúa con la configuración de tu aplicación
-- ================================================
