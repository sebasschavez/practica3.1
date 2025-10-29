# ⚡ INICIO RÁPIDO - 5 Pasos

## 🎯 Lo que necesitas hacer (15-20 minutos)

### ✅ Paso 1: Crear cuenta en Supabase (3 min)
1. Ve a: https://supabase.com
2. Crea una cuenta (con GitHub es más rápido)
3. Crea un nuevo proyecto
4. **ESPERA** 2-3 minutos a que se inicialice

---

### ✅ Paso 2: Configurar base de datos (2 min)
1. En Supabase, ve a **SQL Editor** (menú lateral)
2. Click en **"New query"**
3. Abre el archivo **`setup-database.sql`**
4. Copia TODO su contenido
5. Pégalo en el SQL Editor
6. Click en **"Run"** (o Ctrl+Enter)
7. ✅ Verifica en **Table Editor** que se crearon las tablas "users" e "information"

---

### ✅ Paso 3: Obtener credenciales (2 min)
1. En Supabase, ve a **Settings** ⚙️ → **API**
2. Copia 2 valores:
   - **Project URL** (ejemplo: https://xxxxx.supabase.co)
   - **anon public key** (la clave larga)

---

### ✅ Paso 4: Configurar config.js (1 min)
1. Abre el archivo **`config.js`** en tu proyecto
2. Reemplaza:
   ```javascript
   const SUPABASE_URL = 'TU_URL_AQUI';
   const SUPABASE_ANON_KEY = 'TU_KEY_AQUI';
   ```
   Con tus valores copiados.
3. **GUARDA** el archivo

---

### ✅ Paso 5: Probar (5 min)

#### 5.1 Iniciar servidor local

**Opción A - Python:**
```bash
python -m http.server 8000
```

**Opción B - Node.js:**
```bash
npx http-server -p 8000
```

**Opción C - VS Code:**
- Instala extensión "Live Server"
- Click derecho en index.html → "Open with Live Server"

#### 5.2 Verificar configuración
1. Abre: **http://localhost:8000/test-connection.html**
2. Debe mostrar todos ✅
3. Si algo falla, sigue las instrucciones que muestra

#### 5.3 Crear cuenta y probar
1. Ve a: **http://localhost:8000**
2. Click en **"Registrarse"**
3. Crea una cuenta como **Administrador**
4. Inicia sesión
5. Ve al **Panel de Administración**
6. Crea una publicación de prueba
7. ¡Listo! ✅

---

## 🚀 Opcional: Deshabilitar confirmación de email

Para pruebas rápidas sin verificar emails:

1. Supabase → **Authentication** → **Settings**
2. Desactiva **"Enable email confirmations"**
3. Guarda

---

## 🌐 Desplegar en Internet

Cuando esté listo:

### Vercel (Más fácil)
1. https://vercel.com
2. Importa tu proyecto
3. Deploy automático
4. Obtienes: `tu-app.vercel.app`

### Netlify
1. https://netlify.com
2. Arrastra tu carpeta
3. Deploy automático
4. Obtienes: `tu-app.netlify.app`

### GitHub Pages
1. Sube a GitHub
2. Settings → Pages
3. Activa Pages
4. Obtienes: `tu-usuario.github.io/tu-repo`

---

## 📚 Archivos Importantes

```
📁 Tu Proyecto
├── 📄 index.html          → Página principal
├── 📄 config.js           → ⚙️ CONFIGURA ESTO PRIMERO
├── 📄 setup-database.sql  → 🗄️ Ejecuta esto en Supabase
├── 📄 test-connection.html → 🧪 Verifica configuración
├── 📄 GUIA-COMPLETA.md    → 📖 Guía detallada
└── 📄 INICIO-RAPIDO.md    → ⚡ Esta guía
```

---

## 🆘 Problemas?

1. **Abre:** `test-connection.html` → Te dirá qué está mal
2. **Lee:** `GUIA-COMPLETA.md` → Soluciones detalladas
3. **Consola:** Presiona F12 → Pestaña Console → Ve los errores

---

## ✅ Checklist

- [ ] Cuenta en Supabase creada
- [ ] Proyecto creado y listo
- [ ] Script SQL ejecutado
- [ ] Tablas creadas (users, information)
- [ ] Credenciales copiadas
- [ ] config.js configurado
- [ ] test-connection.html muestra todo ✅
- [ ] Cuenta de admin creada
- [ ] Publicación de prueba creada
- [ ] Todo funciona ✅

---

## 🎉 ¿Listo?

Si completaste todos los checkboxes, ¡ya tienes tu app funcionando!

**Próximos pasos:**
- Personaliza los colores en `style.css`
- Despliega en Vercel/Netlify
- Comparte tu app con el mundo 🚀

---

**¿Necesitas la guía completa?**
👉 Lee `GUIA-COMPLETA.md`
