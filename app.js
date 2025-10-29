// Funciones de autenticación y lógica de la aplicación

// Verificar si el usuario está logueado
async function checkAuth() {
    const { data: { user } } = await supabaseClient.auth.getUser();
    return user;
}

// Registro de nuevo usuario
async function register(email, password, fullName, isAdmin = false) {
    try {
        // Registrar usuario en Supabase Auth
        const { data, error } = await supabaseClient.auth.signUp({
            email: email,
            password: password,
            options: {
                data: {
                    full_name: fullName,
                    role: isAdmin ? 'admin' : 'user'
                }
            }
        });

        if (error) throw error;

        // Insertar información adicional en la tabla users
        if (data.user) {
            const { error: profileError } = await supabaseClient
                .from('users')
                .insert([
                    { 
                        id: data.user.id,
                        email: email,
                        full_name: fullName,
                        role: isAdmin ? 'admin' : 'user'
                    }
                ]);

            if (profileError) console.error('Error al crear perfil:', profileError);
        }

        return { success: true, data };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

// Login de usuario
async function login(email, password) {
    try {
        const { data, error } = await supabaseClient.auth.signInWithPassword({
            email: email,
            password: password
        });

        if (error) throw error;
        return { success: true, data };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

// Logout de usuario
async function logout() {
    try {
        const { error } = await supabaseClient.auth.signOut();
        if (error) throw error;
        window.location.href = 'index.html';
    } catch (error) {
        console.error('Error al cerrar sesión:', error);
    }
}

// Obtener rol del usuario actual
async function getUserRole() {
    try {
        const user = await checkAuth();
        if (!user) return null;

        const { data, error } = await supabaseClient
            .from('users')
            .select('role')
            .eq('id', user.id)
            .single();

        if (error) throw error;
        return data?.role || 'user';
    } catch (error) {
        console.error('Error al obtener rol:', error);
        return 'user';
    }
}

// Verificar si el usuario es admin
async function isAdmin() {
    const role = await getUserRole();
    return role === 'admin';
}

// Obtener información/posts
async function getInformation() {
    try {
        const { data, error } = await supabaseClient
            .from('information')
            .select('*')
            .order('created_at', { ascending: false });

        if (error) throw error;
        return data;
    } catch (error) {
        console.error('Error al obtener información:', error);
        return [];
    }
}

// Crear información (solo admin)
async function createInformation(title, content) {
    try {
        const user = await checkAuth();
        if (!user) throw new Error('Usuario no autenticado');

        const userIsAdmin = await isAdmin();
        if (!userIsAdmin) throw new Error('No tienes permisos para crear información');

        const { data, error } = await supabaseClient
            .from('information')
            .insert([
                { 
                    title: title,
                    content: content,
                    user_id: user.id
                }
            ])
            .select();

        if (error) throw error;
        return { success: true, data };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

// Eliminar información (solo admin)
async function deleteInformation(id) {
    try {
        const userIsAdmin = await isAdmin();
        if (!userIsAdmin) throw new Error('No tienes permisos para eliminar información');

        const { error } = await supabaseClient
            .from('information')
            .delete()
            .eq('id', id);

        if (error) throw error;
        return { success: true };
    } catch (error) {
        return { success: false, error: error.message };
    }
}

// Proteger páginas (redirigir si no está logueado)
async function protectPage(requireAdmin = false) {
    const user = await checkAuth();
    
    if (!user) {
        window.location.href = 'login.html';
        return false;
    }

    if (requireAdmin) {
        const userIsAdmin = await isAdmin();
        if (!userIsAdmin) {
            alert('No tienes permisos para acceder a esta página');
            window.location.href = 'dashboard.html';
            return false;
        }
    }

    return true;
}

// Mostrar información del usuario en la UI
async function displayUserInfo() {
    const user = await checkAuth();
    if (user) {
        const role = await getUserRole();
        const userInfoElement = document.getElementById('userInfo');
        if (userInfoElement) {
            userInfoElement.innerHTML = `
                <span>${user.email} (${role})</span>
                <button onclick="logout()" class="btn btn-logout">Cerrar Sesión</button>
            `;
        }
    }
}

// Formatear fecha
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('es-ES', { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}
