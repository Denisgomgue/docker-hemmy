@echo off
echo ========================================
echo    INICIANDO BACKEND Y FRONTEND
echo ========================================
echo.

echo Verificando dependencias...

REM Verificar dependencias del backend
cd grupo_hemmy_backend
if not exist node_modules (
    echo Instalando dependencias del backend...
    call npm install
    echo.
)
cd ..

REM Verificar dependencias del frontend
cd grupo_hemmy_frontend
if not exist node_modules (
    echo Instalando dependencias del frontend...
    call npm install
    echo.
)
cd ..

echo.
echo Iniciando Backend en nueva ventana...
start "Backend - Grupo Hemmy (Puerto 3000)" cmd /k "cd /d %~dp0grupo_hemmy_backend && npm run start:dev"

echo Esperando 3 segundos...
timeout /t 3 /nobreak >nul

echo Iniciando Frontend en nueva ventana...
start "Frontend - Grupo Hemmy (Puerto 3001)" cmd /k "cd /d %~dp0grupo_hemmy_frontend && npm run dev"

echo.
echo ========================================
echo    AMBOS SERVICIOS INICIADOS
echo ========================================
echo.
echo Backend:  http://localhost:3000
echo Frontend: http://localhost:3001
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul

