@echo off
echo ========================================
echo    INICIANDO BACKEND (PUERTO 3000)
echo ========================================
echo.
cd grupo_hemmy_backend
if not exist node_modules (
    echo Instalando dependencias del backend...
    call npm install
    echo.
)
echo Iniciando servidor backend...
call npm run start:dev
pause

