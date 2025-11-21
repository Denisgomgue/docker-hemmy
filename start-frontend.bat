@echo off
echo ========================================
echo    INICIANDO FRONTEND (PUERTO 3001)
echo ========================================
echo.
cd grupo_hemmy_frontend
if not exist node_modules (
    echo Instalando dependencias del frontend...
    call npm install
    echo.
)
echo Iniciando servidor frontend...
call npm run dev
pause

