# 🏢 Grupo Hemmy - Sistema de Gestión ISP

Sistema completo de gestión para proveedores de servicios de Internet (ISP) con backend en NestJS y frontend en Next.js.

## 📦 Estructura del Proyecto

```
hemmy/
├── grupo_hemmy_backend/    # API REST - NestJS + PostgreSQL
├── grupo_hemmy_frontend/   # Aplicación Web - Next.js + React
├── docker-compose.yml      # Orquestación de servicios
├── env.template            # Template de variables de entorno
└── README-DOCKER.md        # Documentación completa de Docker
```

## 🚀 Inicio Rápido con Docker

### 1. Configurar variables de entorno

```bash
# Copiar el template
copy env.template .env

# Editar con tus valores
notepad .env
```

### 2. Iniciar todos los servicios

**Opción A - Script de Windows:**
```bash
docker-start.bat
```

**Opción B - Comando manual:**
```bash
docker compose up -d
```

### 3. Acceder al sistema

- **Frontend (Aplicación):** http://localhost:3001
- **Backend (API):** http://localhost:3000
- **Base de Datos:** localhost:3306 (MySQL)

## 📚 Documentación

- **[Guía completa de Docker](README-DOCKER.md)** - Setup, comandos, troubleshooting
- **[Backend](grupo_hemmy_backend/README.md)** - Documentación de la API
- **[Frontend](grupo_hemmy_frontend/README.md)** - Documentación de la aplicación

## 🛠️ Comandos Rápidos

```bash
# Ver logs en tiempo real
docker-logs.bat
# o
docker compose logs -f

# Detener servicios
docker-stop.bat
# o
docker compose down

# Reiniciar un servicio
docker compose restart backend
docker compose restart frontend
```

## 🏗️ Arquitectura

### Backend (Puerto 3000)
- **Framework:** NestJS
- **Base de Datos:** MySQL
- **Características:**
  - API REST
  - Autenticación JWT
  - Gestión de clientes
  - Sistema de pagos
  - Gestión de equipos e instalaciones
  - Sistema de tickets
  - Notificaciones

### Frontend (Puerto 3001)
- **Framework:** Next.js 14+
- **UI:** React + TailwindCSS + shadcn/ui
- **Características:**
  - Dashboard administrativo
  - Gestión de clientes
  - Control de pagos
  - Sistema de tickets
  - Gestión de dispositivos
  - Reportes y estadísticas

## 🔧 Desarrollo Local (Sin Docker)

### Backend
```bash
cd grupo_hemmy_backend
npm install
npm run start:dev
```

### Frontend
```bash
cd grupo_hemmy_frontend
npm install
npm run dev
```

## 📊 Stack Tecnológico

**Backend:**
- NestJS
- TypeScript
- PostgreSQL
- TypeORM
- JWT

**Frontend:**
- Next.js
- React
- TypeScript
- TailwindCSS
- shadcn/ui
- Zustand (State Management)

**DevOps:**
- Docker
- Docker Compose

## 🤝 Contribución

Para contribuir al proyecto:

1. Sigue las convenciones de código existentes
2. Mantén los módulos simples y funcionales
3. Usa rutas relativas en lugar de URLs hardcodeadas
4. Documenta cambios significativos

## 📝 Notas Importantes

- **Backend siempre en puerto 3000** [[memory:4982754]]
- **Frontend siempre en puerto 3001** [[memory:4982754]]
- Los backups se almacenan en `grupo_hemmy_backend/backups/`
- Los uploads se guardan en `grupo_hemmy_backend/uploads/`

## 🐛 Troubleshooting

Consulta la [Guía completa de Docker](README-DOCKER.md) para solución de problemas comunes.

## 📞 Soporte

Para problemas o preguntas, consulta la documentación específica de cada módulo o revisa los logs:

```bash
docker compose logs -f backend
docker compose logs -f frontend
```

