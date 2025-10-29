# 📚 Sistema de Gestión de Información con Supabase

Una aplicación web moderna con autenticación, roles de usuario (admin y usuario normal), y gestión de información usando Supabase como backend.

## ✨ Características

- 🔐 **Autenticación segura** con Supabase Auth
- 👥 **Sistema de roles**: Administradores y Usuarios normales
- 📝 **CRUD de información**: Los admins pueden crear y eliminar información
- 👀 **Consulta de información**: Los usuarios normales pueden ver toda la información
- 🎨 **UI moderna y responsive**: Diseño atractivo que funciona en todos los dispositivos
- ⚡ **Tiempo real**: Base de datos PostgreSQL con Supabase

## 🚀 Configuración

### 1. Crear cuenta en Supabase

1. Ve a [https://supabase.com](https://supabase.com) y crea una cuenta gratuita
2. Crea un nuevo proyecto
3. Espera a que el proyecto se inicialice (puede tomar unos minutos)

### 2. Configurar la Base de Datos

Una vez que tu proyecto esté listo, ve al **SQL Editor** en Supabase y ejecuta el siguiente script para crear las tablas necesarias:

```sql
-- Crear tabla de usuarios con información adicional
CREATE TABLE users (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Crear tabla de información
CREATE TABLE information (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Habilitar Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE information ENABLE ROW LEVEL SECURITY;

-- Políticas para la tabla users
-- Los usuarios pueden leer su propia información
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

-- Los usuarios pueden actualizar su propia información
CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

-- Permitir inserciones al registrarse (necesario para el registro)
CREATE POLICY "Enable insert for authenticated users only" ON users
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Políticas para la tabla information
-- Todos los usuarios autenticados pueden leer la información
CREATE POLICY "Anyone authenticated can view information" ON information
  FOR SELECT USING (auth.role() = 'authenticated');

-- Solo los admins pueden insertar información
CREATE POLICY "Only admins can insert information" ON information
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );

-- Solo los admins pueden eliminar información
CREATE POLICY "Only admins can delete information" ON information
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );

-- Crear índices para mejor rendimiento
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_information_user_id ON information(user_id);
CREATE INDEX idx_information_created_at ON information(created_at DESC);

-- Función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = TIMEZONE('utc', NOW());
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger para actualizar updated_at en information
CREATE TRIGGER update_information_updated_at BEFORE UPDATE ON information
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 3. Obtener las credenciales de Supabase

1. En tu proyecto de Supabase, ve a **Settings** > **API**
2. Copia los siguientes valores:
   - **Project URL** (ejemplo: `https://xxxxxxxxxxxx.supabase.co`)
   - **anon/public key** (la clave pública)

### 4. Configurar la aplicación

Abre el archivo `config.js` y reemplaza los valores con tus credenciales:

```javascript
const SUPABASE_URL = 'TU_SUPABASE_URL_AQUI'; // Tu Project URL
const SUPABASE_ANON_KEY = 'TU_SUPABASE_ANON_KEY_AQUI'; // Tu anon key
```

### 5. Configurar la autenticación por email (Opcional pero recomendado)

Por defecto, Supabase requiere verificación de email. Para desarrollo, puedes deshabilitarlo:

1. Ve a **Authentication** > **Settings** en Supabase
2. Desactiva **"Enable email confirmations"** (solo para desarrollo)
3. Para producción, configura el proveedor de email en **SMTP Settings**

## 🌐 Deployment

### Opción 1: Vercel (Recomendado)

1. Sube tu código a GitHub
2. Ve a [vercel.com](https://vercel.com) y crea una cuenta
3. Importa tu repositorio de GitHub
4. Vercel detectará automáticamente que es un sitio estático
5. ¡Despliega!

Tu aplicación estará disponible en un dominio `.vercel.app` gratuito.

### Opción 2: Netlify

1. Sube tu código a GitHub
2. Ve a [netlify.com](https://netlify.com) y crea una cuenta
3. Conecta tu repositorio
4. Click en "Deploy site"

Tu aplicación estará disponible en un dominio `.netlify.app` gratuito.

### Opción 3: GitHub Pages

1. Sube tu código a un repositorio de GitHub
2. Ve a **Settings** > **Pages**
3. Selecciona la rama `main` y la carpeta `/ (root)`
4. Guarda y espera unos minutos

Tu aplicación estará disponible en `https://tu-usuario.github.io/tu-repositorio`

### Opción 4: Servidor propio

Si tienes un servidor con Apache o Nginx:

1. Sube todos los archivos HTML, CSS y JS a tu servidor
2. Configura tu servidor web para servir archivos estáticos
3. Asegúrate de que HTTPS esté habilitado (requerido por Supabase)

## 📁 Estructura del Proyecto

```
/
├── index.html          # Landing page
├── login.html          # Página de login
├── register.html       # Página de registro
├── dashboard.html      # Dashboard para usuarios
├── admin.html          # Panel de administración
├── style.css          # Estilos
├── app.js             # Lógica de la aplicación
├── config.js          # Configuración de Supabase
├── README.md          # Este archivo
├── db.php             # (Legacy - no se usa)
├── login.php          # (Legacy - no se usa)
└── register.php       # (Legacy - no se usa)
```

## 👥 Roles de Usuario

### Usuario Normal
- ✅ Puede ver toda la información publicada
- ❌ No puede crear ni eliminar información

### Administrador
- ✅ Puede ver toda la información publicada
- ✅ Puede crear nueva información
- ✅ Puede eliminar información existente

## 🔧 Uso

### Registrar un nuevo usuario

1. Ve a la página de registro
2. Completa el formulario con:
   - Nombre completo
   - Email
   - Contraseña
   - Tipo de usuario (Usuario Normal o Administrador)
3. Click en "Registrarse"
4. Si la verificación de email está habilitada, verifica tu correo

### Iniciar sesión

1. Ve a la página de login
2. Ingresa tu email y contraseña
3. Click en "Iniciar Sesión"

### Como Usuario Normal

- Verás todas las publicaciones en el dashboard
- Puedes navegar y leer toda la información

### Como Administrador

- Puedes ir al "Panel de Administración"
- Crear nueva información con título y contenido
- Eliminar información existente

## 🎨 Personalización

### Cambiar colores

Edita `style.css` y modifica las siguientes variables:

```css
/* Color primario (morado actual) */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Para cambiar a otro color, por ejemplo azul: */
background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
```

### Personalizar el título

Edita `index.html` y cambia:

```html
<h1>📚 Sistema de Gestión de Información</h1>
```

## 🔒 Seguridad

- ✅ Las contraseñas se encriptan automáticamente con Supabase Auth
- ✅ Row Level Security (RLS) protege la base de datos
- ✅ Solo los admins pueden crear/eliminar información
- ✅ Las sesiones se manejan de forma segura
- ✅ Protección contra inyección SQL

## 🐛 Solución de Problemas

### Error: "Invalid API key"
- Verifica que hayas copiado correctamente la URL y la clave anon de Supabase en `config.js`

### Error: "Failed to fetch"
- Asegúrate de que tu proyecto de Supabase esté activo
- Verifica que las tablas se hayan creado correctamente

### No puedo registrarme
- Verifica que las políticas RLS estén configuradas correctamente
- Asegúrate de que la tabla `users` exista

### Los admins no pueden crear información
- Verifica que el usuario tenga role='admin' en la tabla users
- Revisa las políticas RLS de la tabla information

### La página no carga
- Abre la consola del navegador (F12) para ver errores
- Verifica que todos los archivos JS se carguen correctamente

## 📚 Recursos

- [Documentación de Supabase](https://supabase.com/docs)
- [Supabase Auth](https://supabase.com/docs/guides/auth)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)

## 🆘 Soporte

Si tienes problemas:
1. Revisa la consola del navegador para errores
2. Verifica que las tablas estén creadas en Supabase
3. Asegúrate de que las políticas RLS estén correctas
4. Verifica que config.js tenga las credenciales correctas

## 📝 Licencia

Este proyecto es de código abierto y está disponible para uso personal y comercial.

---

¡Disfruta tu aplicación! 🎉
