@echo off
echo ========================================
echo    COMPILANDO BACKEND Y FRONTEND
echo ========================================
echo.

echo Compilando Backend...
cd grupo_hemmy_backend
if not exist node_modules (
    echo Instalando dependencias del backend...
    call npm install
)
call npm run build
if errorlevel 1 (
    echo ERROR: Fallo la compilacion del backend
    pause
    exit /b 1
)
cd ..
echo Backend compilado correctamente.
echo.

echo Compilando Frontend...
cd grupo_hemmy_frontend
if not exist node_modules (
    echo Instalando dependencias del frontend...
    call npm install
)
call npm run build
if errorlevel 1 (
    echo ERROR: Fallo la compilacion del frontend
    pause
    exit /b 1
)
cd ..
echo Frontend compilado correctamente.
echo.

echo ========================================
echo    COMPILACION COMPLETADA
echo ========================================
echo.
echo Para ejecutar en modo produccion:
echo - Backend:  cd grupo_hemmy_backend && npm run start:prod
echo - Frontend: cd grupo_hemmy_frontend && npm start
echo.
pause

