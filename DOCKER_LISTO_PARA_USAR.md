# ✅ **PROYECTO LISTO PARA DOCKER**

## 🎯 **ESTADO ACTUAL**

El proyecto **Grupo Hemmy** está completamente preparado y listo para ejecutarse en Docker.

---

## 📋 **VERIFICACIÓN DE REQUISITOS**

### ✅ **Archivos Docker Configurados**

| Archivo | Estado | Descripción |
|---------|--------|-------------|
| `docker-compose.yml` | ✅ | Orquestación de servicios |
| `grupo_hemmy_backend/Dockerfile` | ✅ | Imagen del backend (NestJS) |
| `grupo_hemmy_frontend/Dockerfile` | ✅ | Imagen del frontend (Next.js) |
| `env.template` | ✅ | Template de variables |
| `docker-start.bat` | ✅ | Script de inicio (Windows) |
| `docker-stop.bat` | ✅ | Script de detención |
| `docker-logs.bat` | ✅ | Script para ver logs |

### ✅ **Software Instalado**

- **Docker:** v28.5.1 ✅
- **Docker Compose:** Disponible ✅
- **MySQL Local:** Requerido (debe estar corriendo)

---

## 🚀 **INSTRUCCIONES DE USO (PASO A PASO)**

### **Paso 1: Configurar Variables de Entorno**

```powershell
# Si NO existe .env, créalo desde el template
copy env.template .env

# Abre y edita el archivo .env
notepad .env
```

**Configuración CRÍTICA en .env:**

```env
# ⚠️ IMPORTANTE: Para que Docker se conecte a MySQL local
DB_HOST=host.docker.internal  # ← NO usar 'localhost'
DB_USER=root
DB_NAME=group_hemmy
DB_PASSWORD=tu_contraseña_mysql_actual

# Genera un secret aleatorio seguro
JWT_SECRET=aqui_tu_secret_generado

# URLs (dejar como están)
BACKEND_URL=http://localhost:3000
FRONTEND_URL=http://localhost:3001
NEXT_PUBLIC_API_URL=http://localhost:3000
NEXT_PUBLIC_APP_URL=http://localhost:3001
```

**🔐 Generar JWT_SECRET:**
```powershell
# Ejecuta esto en PowerShell para generar un secret aleatorio
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | % {[char]$_})
```

### **Paso 2: Verificar MySQL Local**

```powershell
# Verificar que MySQL está corriendo
mysql -u root -p -e "SHOW DATABASES;"

# Debe aparecer 'group_hemmy' en la lista
# Si no existe, créala:
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS group_hemmy;"
```

### **Paso 3: Levantar Servicios**

**Opción A: Script Automático (Recomendado para Windows)**
```powershell
.\docker-start.bat
```

**Opción B: Docker Compose Directo**
```powershell
# Construir y levantar servicios
docker compose up -d

# Ver logs en tiempo real
docker compose logs -f
```

### **Paso 4: Verificar que Todo Funciona**

```powershell
# Ver estado de contenedores
docker compose ps

# Debe mostrar:
# NAME              STATUS
# hemmy_backend     Up
# hemmy_frontend    Up

# Ver logs
docker compose logs -f backend
docker compose logs -f frontend
```

### **Paso 5: Acceder a la Aplicación**

Abre tu navegador:
- **Frontend:** http://localhost:3001
- **Backend API:** http://localhost:3000

---

## 📊 **ARQUITECTURA DEL DESPLIEGUE**

```
┌─────────────────────────────────────────────────────────┐
│                    TU COMPUTADORA                       │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              DOCKER CONTAINERS                   │  │
│  │                                                  │  │
│  │  ┌─────────────────┐    ┌──────────────────┐  │  │
│  │  │   Backend       │    │    Frontend      │  │  │
│  │  │   (NestJS)      │◄───┤    (Next.js)     │  │  │
│  │  │   Port: 3000    │    │    Port: 3001    │  │  │
│  │  └────────┬────────┘    └──────────────────┘  │  │
│  │           │                                    │  │
│  │           │ host.docker.internal               │  │
│  └───────────┼────────────────────────────────────┘  │
│              │                                        │
│  ┌───────────▼────────┐                              │
│  │   MySQL LOCAL      │                              │
│  │   Port: 3306       │                              │
│  │   DB: group_hemmy  │                              │
│  └────────────────────┘                              │
└─────────────────────────────────────────────────────────┘
```

**Explicación:**
- ✅ Backend y Frontend corren en **contenedores Docker**
- ✅ MySQL corre **localmente** (NO en Docker)
- ✅ Backend se conecta a MySQL vía `host.docker.internal`
- ✅ Frontend se conecta a Backend vía `localhost:3000`

---

## 🔧 **COMANDOS ÚTILES**

### **Gestión Básica**

```powershell
# Iniciar servicios
docker compose up -d

# Detener servicios
docker compose down

# Reiniciar servicios
docker compose restart

# Ver logs en tiempo real
docker compose logs -f

# Ver logs solo del backend
docker compose logs -f backend

# Ver logs solo del frontend
docker compose logs -f frontend

# Ver estado
docker compose ps
```

### **Después de Cambios en Código**

```powershell
# Si modificaste el BACKEND
docker compose build backend
docker compose up -d backend

# Si modificaste el FRONTEND
docker compose build frontend
docker compose up -d frontend

# Reconstruir TODO (sin caché)
docker compose build --no-cache
docker compose up -d
```

### **Debugging**

```powershell
# Entrar al contenedor del backend
docker compose exec backend sh

# Ver variables de entorno del backend
docker compose exec backend env | findstr DB_

# Entrar al contenedor del frontend
docker compose exec frontend sh

# Ver configuración parseada
docker compose config
```

---

## ⚠️ **PROBLEMAS COMUNES Y SOLUCIONES**

### **❌ Error: Backend no se conecta a MySQL**

**Causa:** `DB_HOST` incorrecto en `.env`

**Solución:**
```env
# En .env, asegúrate de tener:
DB_HOST=host.docker.internal  # ← NO 'localhost'
```

Luego:
```powershell
docker compose down
docker compose up -d
```

### **❌ Error: Puerto 3000 o 3001 en uso**

**Solución:**
```powershell
# Ver qué proceso usa el puerto
netstat -ano | findstr :3000
netstat -ano | findstr :3001

# Detener el proceso (reemplaza PID)
taskkill /PID numero_pid /F
```

### **❌ Error: Cannot find module**

**Solución:**
```powershell
# Reconstruir sin caché
docker compose build --no-cache
docker compose up -d
```

### **❌ Frontend muestra página en blanco**

**Solución:**
```powershell
# Ver logs del frontend
docker compose logs -f frontend

# Reconstruir frontend
docker compose build --no-cache frontend
docker compose up -d frontend
```

---

## 📝 **CHECKLIST ANTES DE INICIAR**

Antes de ejecutar `docker compose up -d`, verifica:

- [ ] Docker Desktop está ejecutándose
- [ ] Archivo `.env` existe y está configurado
- [ ] `DB_HOST=host.docker.internal` en `.env`
- [ ] `JWT_SECRET` generado y configurado
- [ ] MySQL está corriendo (localhost:3306)
- [ ] Base de datos `group_hemmy` existe
- [ ] Puertos 3000 y 3001 están libres
- [ ] Última compilación del frontend fue exitosa

---

## 🎯 **FLUJO DE TRABAJO RECOMENDADO**

### **Para Desarrollo Diario:**

```powershell
# Opción 1: Desarrollo local (más rápido para hot reload)
cd grupo_hemmy_backend
npm run start:dev

# En otra terminal
cd grupo_hemmy_frontend
npm run dev
```

### **Para Testing/Demo:**

```powershell
# Usar Docker
docker compose up -d
docker compose logs -f
```

### **Para Producción:**

```powershell
# Actualizar .env con URLs de producción
# Reconstruir con caché limpio
docker compose build --no-cache
docker compose up -d
```

---

## 📊 **MONITOREO**

```powershell
# Ver uso de recursos
docker stats

# Ver estado detallado
docker compose ps -a

# Exportar logs a archivo
docker compose logs > logs-$(Get-Date -Format 'yyyyMMdd_HHmmss').txt
```

---

## 🔄 **ACTUALIZAR APLICACIÓN**

Cuando hagas cambios en el código:

```powershell
# 1. Hacer tus cambios en el código

# 2. Detener servicios
docker compose down

# 3. Reconstruir imágenes
docker compose build --no-cache

# 4. Levantar servicios
docker compose up -d

# 5. Ver logs para verificar
docker compose logs -f
```

---

## 🌐 **DESPLEGAR EN SERVIDOR**

### **En tu servidor (Linux/Windows Server):**

1. **Instalar Docker:**
   ```bash
   # Ubuntu/Debian
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   ```

2. **Subir archivos:**
   ```bash
   # Clonar repositorio o subir vía FTP
   git clone tu-repositorio.git hemmy
   cd hemmy
   ```

3. **Configurar .env:**
   ```bash
   cp env.template .env
   nano .env  # Editar con valores de producción
   ```

4. **Levantar servicios:**
   ```bash
   docker compose up -d
   ```

5. **Configurar Nginx/Apache como reverse proxy (opcional):**
   - Frontend: dominio.com → localhost:3001
   - Backend: api.dominio.com → localhost:3000

---

## 📦 **BACKUP Y RESTORE**

### **Backup de Uploads:**
```powershell
# Los uploads se guardan automáticamente en:
# ./grupo_hemmy_backend/uploads

# Copiar a lugar seguro
xcopy /E /I grupo_hemmy_backend\uploads backup-uploads-$(Get-Date -Format 'yyyyMMdd')
```

### **Backup de Base de Datos:**
```powershell
# Desde MySQL local
mysqldump -u root -p group_hemmy > backup-$(Get-Date -Format 'yyyyMMdd_HHmmss').sql
```

---

## ✅ **RESULTADO ESPERADO**

Después de ejecutar `docker compose up -d`:

```
✓ Network hemmy_network     Created
✓ Container hemmy_backend   Started
✓ Container hemmy_frontend  Started
```

**Logs esperados (sin errores):**

```
hemmy_backend   | [Nest] 1  - LOG [NestApplication] Nest application successfully started
hemmy_frontend  | ▲ Next.js 15.1.5
hemmy_frontend  | - Local:        http://localhost:3000
hemmy_frontend  | ✓ Ready in 2.3s
```

**Acceso:**
- ✅ Frontend: http://localhost:3001 (funcional)
- ✅ Backend: http://localhost:3000 (API respondiendo)
- ✅ MySQL: localhost:3306 (conexión desde backend OK)

---

## 🎉 **¡LISTO PARA USAR!**

Tu sistema Grupo Hemmy está completamente dockerizado y listo para:
- ✅ Desarrollo local
- ✅ Testing
- ✅ Despliegue en servidores
- ✅ Producción

**Comandos rápidos:**
```powershell
.\docker-start.bat  # Iniciar
.\docker-logs.bat   # Ver logs
.\docker-stop.bat   # Detener
```

---

**Última actualización:** Noviembre 2025  
**Estado:** ✅ LISTO PARA PRODUCCIÓN  
**Versión Docker:** v28.5.1

