# Script de Inicialización Git
# Este script inicializa el repositorio y hace el primer commit

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Inicializando Repositorio Git" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si ya existe un repositorio
if (Test-Path ".git") {
    Write-Host "⚠️  Ya existe un repositorio Git en este directorio" -ForegroundColor Yellow
    $response = Read-Host "¿Deseas reinicializarlo? (s/n)"
    if ($response -ne "s") {
        Write-Host "Operación cancelada" -ForegroundColor Red
        exit 0
    }
    Remove-Item -Recurse -Force ".git"
}

# Inicializar Git
Write-Host "Inicializando Git..." -ForegroundColor Yellow
git init

# Configurar rama principal como 'main'
git branch -M main

# Agregar todos los archivos
Write-Host "Agregando archivos..." -ForegroundColor Yellow
git add .

# Hacer el primer commit
Write-Host "Creando commit inicial..." -ForegroundColor Yellow
git commit -m "Initial commit: Java 25 Docker for Pterodactyl - Ready for Hytale"

Write-Host ""
Write-Host "✅ Repositorio Git inicializado correctamente!" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Próximos Pasos" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Crea un repositorio en GitHub:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Conecta este repositorio con GitHub:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/TU_USUARIO/java-25-pterodactyl.git" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Sube el código:" -ForegroundColor White
Write-Host "   git push -u origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Publica en Docker Hub:" -ForegroundColor White
Write-Host "   docker login" -ForegroundColor Gray
Write-Host "   docker tag turbomc/java25-pterodactyl:latest TU_USUARIO/java25-pterodactyl:latest" -ForegroundColor Gray
Write-Host "   docker push TU_USUARIO/java25-pterodactyl:latest" -ForegroundColor Gray
Write-Host ""
Write-Host "📖 Para más detalles, lee: PUBLICACION.md" -ForegroundColor Cyan
Write-Host ""
