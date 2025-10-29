# 🚀 GUÍA COMPLETA - Configuración y Ejecución

## 📑 Índice
1. [Crear Cuenta en Supabase](#paso-1-crear-cuenta-en-supabase)
2. [Configurar Base de Datos](#paso-2-configurar-base-de-datos)
3. [Obtener Credenciales](#paso-3-obtener-credenciales)
4. [Configurar la Aplicación](#paso-4-configurar-la-aplicación)
5. [Probar la Aplicación](#paso-5-probar-la-aplicación)
6. [Desplegar en Internet](#paso-6-desplegar-en-internet)

---

## 🎯 Paso 1: Crear Cuenta en Supabase

### 1.1 Registrarse

1. Abre tu navegador y ve a: **https://supabase.com**
2. Click en el botón **"Start your project"** o **"Sign Up"**
3. Puedes registrarte con:
   - GitHub (recomendado, más rápido)
   - Email y contraseña

### 1.2 Crear un Nuevo Proyecto

1. Una vez dentro, click en **"New Project"**
2. Completa los campos:
   ```
   Nombre del proyecto: mi-sistema-gestion (o el que prefieras)
   Database Password: [Crea una contraseña segura y GUÁRDALA]
   Region: Selecciona la más cercana a ti (ej: South America (São Paulo))
   Pricing Plan: Free (gratis, suficiente para desarrollo)
   ```
3. Click en **"Create new project"**
4. **ESPERA** 2-3 minutos mientras se crea el proyecto
   - Verás un mensaje "Setting up project..."
   - ☕ Es buen momento para un café

---

## 🗄️ Paso 2: Configurar Base de Datos

### 2.1 Acceder al SQL Editor

1. En el menú lateral izquierdo, busca y click en **"SQL Editor"**
   - Tiene un ícono de terminal/consola
2. Se abrirá el editor SQL

### 2.2 Ejecutar el Script de Configuración

1. Abre el archivo **`setup-database.sql`** que está en tu proyecto
2. **COPIA TODO** el contenido del archivo (Ctrl+A, luego Ctrl+C)
3. Vuelve a Supabase SQL Editor
4. Click en **"New query"** (arriba a la derecha)
5. **PEGA** todo el contenido en el editor
6. Click en el botón **"Run"** (o presiona Ctrl+Enter)

### 2.3 Verificar que Funcionó

Deberías ver en la parte inferior:
```
Success. No rows returned
```

Si ves esto, ¡perfecto! La base de datos está configurada.

### 2.4 Verificar las Tablas

1. En el menú lateral, click en **"Table Editor"**
2. Deberías ver 2 tablas:
   - **users** - Para almacenar usuarios y sus roles
   - **information** - Para almacenar los posts/información

---

## 🔑 Paso 3: Obtener Credenciales

### 3.1 Ir a la Configuración de API

1. En el menú lateral, busca el ícono de engranaje ⚙️ **"Settings"**
2. Click en **"API"** (en el submenú)

### 3.2 Copiar las Credenciales

Vas a necesitar 2 valores:

**A) Project URL:**
```
Busca la sección "Project URL"
Ejemplo: https://abcdefghijklm.supabase.co
```
👉 Click en el botón "Copy" para copiar

**B) API Key (anon/public):**
```
Busca la sección "Project API keys"
Encuentra la key que dice "anon" "public"
Ejemplo: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```
👉 Click en el botón "Copy" para copiar

**⚠️ IMPORTANTE:**
- NO copies la "service_role" key (es secreta)
- Copia la "anon" o "public" key

---

## ⚙️ Paso 4: Configurar la Aplicación

### 4.1 Abrir config.js

1. En tu proyecto, abre el archivo **`config.js`**
2. Verás algo así:

```javascript
const SUPABASE_URL = 'TU_SUPABASE_URL_AQUI';
const SUPABASE_ANON_KEY = 'TU_SUPABASE_ANON_KEY_AQUI';
```

### 4.2 Reemplazar las Credenciales

1. Reemplaza `'TU_SUPABASE_URL_AQUI'` con tu Project URL
2. Reemplaza `'TU_SUPABASE_ANON_KEY_AQUI'` con tu anon key

**Ejemplo final:**

```javascript
const SUPABASE_URL = 'https://abcdefghijklm.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG0iLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYxNjI0MDAwMCwiZXhwIjoxOTMxODE2MDAwfQ.abcdefghijklmnopqrstuvwxyz123456789';
```

3. **GUARDA** el archivo (Ctrl+S)

### 4.3 Deshabilitar Confirmación de Email (Opcional, solo para pruebas)

Para poder probar rápidamente sin verificar emails:

1. Vuelve a Supabase
2. Ve a **"Authentication"** en el menú lateral
3. Click en **"Settings"** (dentro de Authentication)
4. Busca **"Enable email confirmations"**
5. **Desactiva** el toggle (ponlo en OFF)
6. Scroll hacia abajo y click en **"Save"**

**Nota:** Para producción, déjalo activado y configura SMTP.

---

## 🧪 Paso 5: Probar la Aplicación

### 5.1 Abrir la Aplicación

Tienes varias opciones para ejecutar la aplicación:

#### Opción A: Servidor Local Simple (Recomendado para Windows/Mac/Linux)

**Si tienes Python instalado:**

```bash
# Python 3
python -m http.server 8000

# O Python 2
python -m SimpleHTTPServer 8000
```

**Si tienes Node.js instalado:**

```bash
npx http-server -p 8000
```

**Si tienes Visual Studio Code:**
1. Instala la extensión "Live Server"
2. Click derecho en `index.html`
3. Selecciona "Open with Live Server"

Luego abre tu navegador en: **http://localhost:8000**

#### Opción B: Abrir Directamente (Solo para pruebas rápidas)

Simplemente abre el archivo `index.html` en tu navegador.

**⚠️ Nota:** Algunos navegadores tienen restricciones de seguridad con `file://`, por lo que es mejor usar un servidor local.

### 5.2 Verificar Configuración

1. Abre: **http://localhost:8000/test-connection.html**
2. La página ejecutará automáticamente todas las verificaciones
3. Deberías ver:
   - ✅ Credenciales configuradas
   - ✅ Conexión exitosa a Supabase
   - ✅ Tablas verificadas
   - ✅ Políticas de seguridad activas

**Si algo falla:**
- Lee el mensaje de error
- Sigue las instrucciones de solución
- Vuelve a ejecutar la verificación

### 5.3 Crear tu Primera Cuenta

1. Ve a: **http://localhost:8000**
2. Click en **"Registrarse"**
3. Completa el formulario:
   ```
   Nombre: Tu Nombre
   Email: tu@email.com
   Contraseña: minimo6caracteres
   Confirmar Contraseña: minimo6caracteres
   Tipo de Usuario: Administrador (para tu primera cuenta)
   ```
4. Click en **"Registrarse"**

**Si la confirmación de email está ACTIVADA:**
- Ve a tu correo
- Busca el email de Supabase
- Click en "Confirm your email"

**Si la confirmación de email está DESACTIVADA:**
- Serás redirigido al login
- Inicia sesión inmediatamente

### 5.4 Probar como Administrador

1. Inicia sesión con tu cuenta
2. Deberías ver el Dashboard
3. Click en **"Panel de Administración"**
4. Prueba crear información:
   ```
   Título: Mi primera publicación
   Contenido: Este es un contenido de prueba para verificar que todo funciona correctamente.
   ```
5. Click en **"Publicar Información"**
6. Deberías ver tu publicación en la lista
7. Prueba el botón **"Eliminar"**

### 5.5 Probar como Usuario Normal

1. Cierra sesión (botón "Cerrar Sesión")
2. Crea otra cuenta con **Tipo de Usuario: Usuario Normal**
3. Inicia sesión con esta nueva cuenta
4. Verifica que:
   - ✅ Puedes VER la información publicada
   - ❌ NO ves el botón "Panel de Administración"
   - ❌ NO puedes crear ni eliminar información

---

## 🌐 Paso 6: Desplegar en Internet

Una vez que todo funciona localmente, despliega tu aplicación:

### Opción A: Vercel (Recomendado)

1. Crea una cuenta en **https://vercel.com**
2. Click en **"Add New"** → **"Project"**
3. Importa tu repositorio de Git (o sube los archivos)
4. Vercel detectará automáticamente que es HTML estático
5. Click en **"Deploy"**
6. En 1-2 minutos tendrás un dominio: `tu-app.vercel.app`

**Para dominio personalizado:**
- Ve a "Settings" → "Domains"
- Agrega tu dominio
- Sigue las instrucciones de configuración DNS

### Opción B: Netlify

1. Crea una cuenta en **https://netlify.com**
2. Arrastra y suelta la carpeta de tu proyecto
3. O conecta tu repositorio de Git
4. Automáticamente se despliega
5. Dominio: `tu-app.netlify.app`

### Opción C: GitHub Pages

1. Sube tu código a GitHub
2. Ve a **Settings** → **Pages**
3. Selecciona la rama `main`
4. Guarda
5. Tu sitio estará en: `tu-usuario.github.io/tu-repo`

---

## ✅ Checklist Final

Antes de considerar que todo está listo:

- [ ] ✅ Proyecto creado en Supabase
- [ ] ✅ Base de datos configurada (script SQL ejecutado)
- [ ] ✅ Tablas "users" e "information" creadas
- [ ] ✅ Credenciales copiadas y configuradas en `config.js`
- [ ] ✅ Aplicación funciona localmente
- [ ] ✅ Test de conexión pasa todas las verificaciones
- [ ] ✅ Cuenta de administrador creada y probada
- [ ] ✅ Cuenta de usuario normal creada y probada
- [ ] ✅ Se puede crear información como admin
- [ ] ✅ Se puede eliminar información como admin
- [ ] ✅ Usuario normal solo puede ver información
- [ ] ✅ (Opcional) Aplicación desplegada en internet

---

## 🆘 Solución de Problemas Comunes

### Problema: "Failed to fetch" o "Network Error"

**Causas posibles:**
- Credenciales incorrectas
- URL mal copiada
- Proyecto de Supabase pausado

**Solución:**
1. Verifica que copiaste correctamente la URL y la key
2. Asegúrate de que no haya espacios extra
3. Ve a Supabase y verifica que el proyecto esté activo

---

### Problema: "relation does not exist"

**Causa:** Las tablas no se han creado

**Solución:**
1. Ve al SQL Editor en Supabase
2. Ejecuta nuevamente el archivo `setup-database.sql`
3. Verifica en Table Editor que las tablas existan

---

### Problema: "JWT expired" o "Invalid JWT"

**Causa:** La sesión expiró

**Solución:**
- Simplemente cierra sesión y vuelve a iniciar sesión

---

### Problema: No puedo crear información como admin

**Causas posibles:**
- El usuario no tiene role='admin' en la base de datos
- Las políticas RLS no están correctas

**Solución:**
1. Ve a Supabase → Table Editor → users
2. Busca tu usuario
3. Verifica que la columna "role" tenga el valor "admin"
4. Si no, edita y cámbialo a "admin"

---

### Problema: La página está en blanco

**Causas posibles:**
- Error en config.js
- Archivos JS no se cargan

**Solución:**
1. Abre la consola del navegador (F12)
2. Ve a la pestaña "Console"
3. Lee el error y busca la línea que lo causa
4. Verifica que todos los archivos existan y estén en la ubicación correcta

---

## 📞 ¿Necesitas más ayuda?

Si sigues teniendo problemas:

1. **Verifica la consola del navegador** (F12 → Console)
   - Los errores ahí son muy descriptivos

2. **Usa la página de verificación**
   - Abre `test-connection.html`
   - Te dirá exactamente qué está mal

3. **Revisa la documentación de Supabase**
   - https://supabase.com/docs

---

## 🎉 ¡Felicidades!

Si llegaste hasta aquí y todo funciona, ¡ya tienes tu aplicación completa funcionando!

**Tienes:**
- ✅ Una aplicación web moderna y segura
- ✅ Autenticación completa
- ✅ Sistema de roles (admin/usuario)
- ✅ Base de datos PostgreSQL en la nube
- ✅ UI responsive y atractiva
- ✅ Listo para producción

**¡Ahora puedes:**
- Personalizarla a tu gusto
- Agregar más funcionalidades
- Compartirla con otros
- Usarla para tu proyecto

---

**¿Próximos pasos sugeridos?**
1. Personaliza los colores en `style.css`
2. Agrega más campos a la información (imágenes, categorías, etc.)
3. Implementa búsqueda y filtros
4. Agrega paginación para muchos registros
5. Implementa edición de información
6. Agrega perfil de usuario editable

¡Mucha suerte con tu proyecto! 🚀
