# 🚀 **GUÍA PARA COMPILAR Y EJECUTAR SIN DOCKER**

Esta guía explica cómo compilar y ejecutar el proyecto **Grupo Hemmy** (backend y frontend) de forma local sin usar Docker.

---

## 📋 **REQUISITOS PREVIOS**

Antes de comenzar, asegúrate de tener instalado:

- **Node.js** (versión 18 o superior)
- **npm** o **yarn** (incluido con Node.js)
- **MySQL** (debe estar corriendo en tu sistema local)
- **Git** (para clonar el repositorio si es necesario)

Verifica tus versiones:
```bash
node --version
npm --version
mysql --version
```

---

## ⚙️ **PASO 1: CONFIGURACIÓN DE VARIABLES DE ENTORNO**

### **Backend** (`grupo_hemmy_backend`)

Crea un archivo `.env` en la raíz de `grupo_hemmy_backend` con las siguientes variables:

```env
# Configuración de Base de Datos
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=tu_contraseña_mysql
DB_NAME=group_hemmy

# URLs
BACKEND_URL=http://localhost:3000
FRONTEND_URL=http://localhost:3001

# JWT
JWT_SECRET=tu_secret_jwt_aqui_cambialo_por_uno_seguro

# Ambiente
NODE_ENV=development
```

### **Frontend** (`grupo_hemmy_frontend`)

Crea un archivo `.env.local` en la raíz de `grupo_hemmy_frontend` con:

```env
NEXT_PUBLIC_API_URL=http://localhost:3000
NEXT_PUBLIC_APP_URL=http://localhost:3001
```

> **Nota:** Las variables `NEXT_PUBLIC_*` son públicas y están disponibles en el navegador.

---

## 📦 **PASO 2: INSTALACIÓN DE DEPENDENCIAS**

### **Instalar dependencias del Backend**

```bash
cd grupo_hemmy_backend
npm install
```

### **Instalar dependencias del Frontend**

```bash
cd grupo_hemmy_frontend
npm install
```

---

## 🔧 **PASO 3: CONFIGURACIÓN DE BASE DE DATOS**

1. **Asegúrate de que MySQL esté corriendo:**
   ```bash
   # Windows (si MySQL está en el PATH)
   mysql -u root -p
   
   # O verifica el servicio en Windows Services
   ```

2. **Crea la base de datos si no existe:**
   ```sql
   CREATE DATABASE IF NOT EXISTS group_hemmy;
   ```

3. **Las migraciones se ejecutarán automáticamente al iniciar el backend** (si están configuradas).

---

## 🚀 **PASO 4: EJECUTAR EN MODO DESARROLLO**

### **Opción A: Ejecutar en Terminales Separadas (Recomendado)**

#### **Terminal 1 - Backend:**
```bash
cd grupo_hemmy_backend
npm run start:dev
```

El backend estará disponible en: `http://localhost:3000`

#### **Terminal 2 - Frontend:**
```bash
cd grupo_hemmy_frontend
npm run dev
```

El frontend estará disponible en: `http://localhost:3001`

### **Opción B: Usar Scripts de Inicio Automático**

Ver sección de **Scripts Útiles** más abajo.

---

## 🏗️ **PASO 5: COMPILAR Y EJECUTAR EN MODO PRODUCCIÓN**

### **Backend - Compilar y Ejecutar:**

```bash
cd grupo_hemmy_backend

# 1. Compilar el proyecto
npm run build

# 2. Ejecutar en modo producción
npm run start:prod
```

El código compilado se guardará en la carpeta `dist/`.

### **Frontend - Compilar y Ejecutar:**

```bash
cd grupo_hemmy_frontend

# 1. Compilar el proyecto (optimizado para producción)
npm run build

# 2. Ejecutar el servidor de producción
npm start
```

> **Nota:** El frontend también estará disponible en `http://localhost:3001` en modo producción, pero optimizado.

---

## 📝 **SCRIPTS DISPONIBLES**

### **Backend (`grupo_hemmy_backend/package.json`):**

| Script | Descripción |
|--------|-------------|
| `npm run start` | Inicia el servidor (sin watch) |
| `npm run start:dev` | Inicia en modo desarrollo con hot-reload |
| `npm run start:debug` | Inicia en modo debug con watch |
| `npm run start:prod` | Ejecuta la versión compilada en producción |
| `npm run build` | Compila el proyecto TypeScript |
| `npm run lint` | Ejecuta el linter |

### **Frontend (`grupo_hemmy_frontend/package.json`):**

| Script | Descripción |
|--------|-------------|
| `npm run dev` | Inicia el servidor de desarrollo (puerto 3001) |
| `npm run build` | Compila para producción |
| `npm start` | Ejecuta la versión compilada |
| `npm run lint` | Ejecuta el linter |

---

## 🛠️ **SCRIPTS ÚTILES PARA WINDOWS**

Puedes crear estos scripts `.bat` en la raíz del proyecto para facilitar el inicio:

### **`start-backend.bat`**
```batch
@echo off
echo Iniciando Backend...
cd grupo_hemmy_backend
call npm run start:dev
pause
```

### **`start-frontend.bat`**
```batch
@echo off
echo Iniciando Frontend...
cd grupo_hemmy_frontend
call npm run dev
pause
```

### **`start-all.bat`** (Inicia ambos en ventanas separadas)
```batch
@echo off
echo Iniciando Backend y Frontend...
start "Backend" cmd /k "cd /d grupo_hemmy_backend && npm run start:dev"
timeout /t 3 /nobreak >nul
start "Frontend" cmd /k "cd /d grupo_hemmy_frontend && npm run dev"
echo Ambos servicios iniciados en ventanas separadas.
pause
```

---

## 🐛 **SOLUCIÓN DE PROBLEMAS COMUNES**

### **Error: Puerto ya en uso**

Si el puerto 3000 o 3001 está ocupado:

**Backend:**
- Cambia el puerto en `grupo_hemmy_backend/src/main.ts` (línea 35)
- O termina el proceso que está usando el puerto:
  ```bash
  # Windows
  netstat -ano | findstr :3000
  taskkill /PID <PID> /F
  ```

**Frontend:**
- Cambia el puerto en `grupo_hemmy_frontend/package.json`:
  ```json
  "dev": "next dev -p 3002"
  ```

### **Error de conexión a la base de datos**

- Verifica que MySQL esté corriendo
- Revisa las credenciales en `.env` del backend
- Asegúrate de que la base de datos exista

### **Error: Módulos no encontrados**

Ejecuta nuevamente:
```bash
npm install
```

### **Error de CORS**

Asegúrate de que `FRONTEND_URL` en el backend `.env` coincida con la URL del frontend:
```env
FRONTEND_URL=http://localhost:3001
```

---

## 📊 **VERIFICACIÓN**

Una vez que ambos servicios estén corriendo:

1. **Backend:** Abre `http://localhost:3000` en tu navegador (deberías ver algún mensaje o error de ruta)
2. **Frontend:** Abre `http://localhost:3001` - deberías ver la aplicación

---

## 🔄 **FLUJO DE TRABAJO RECOMENDADO**

1. **Desarrollo:**
   - Usa `npm run start:dev` para el backend (hot-reload automático)
   - Usa `npm run dev` para el frontend (hot-reload automático)

2. **Antes de commitear:**
   - Ejecuta `npm run lint` en ambos proyectos
   - Asegúrate de que todo compile: `npm run build`

3. **Producción:**
   - Compila ambos: `npm run build`
   - Ejecuta: `npm run start:prod` (backend) y `npm start` (frontend)

---

## 💡 **NOTAS IMPORTANTES**

- El **backend** corre en el **puerto 3000** (nunca cambia según la configuración)
- El **frontend** corre en el **puerto 3001** (nunca cambia según la configuración)
- En modo desarrollo, los cambios se recargan automáticamente gracias al watch mode
- El backend necesita MySQL corriendo localmente
- Los archivos subidos se guardan en `grupo_hemmy_backend/uploads/`

---

## 📚 **RESUMEN RÁPIDO**

```bash
# 1. Configurar variables de entorno (.env y .env.local)

# 2. Instalar dependencias
cd grupo_hemmy_backend && npm install
cd ../grupo_hemmy_frontend && npm install

# 3. Iniciar en desarrollo
# Terminal 1:
cd grupo_hemmy_backend && npm run start:dev

# Terminal 2:
cd grupo_hemmy_frontend && npm run dev

# 4. Acceder
# Backend: http://localhost:3000
# Frontend: http://localhost:3001
```

¡Listo! Tu proyecto está corriendo sin Docker. 🎉

