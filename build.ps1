# PowerShell Build Script for Java 25 Docker Image
# Usage: .\build.ps1 [-Push] [-Version "1.0.0"] [-Username "yourusername"]

param(
    [switch]$Push,
    [string]$Version = "latest",
    [string]$Username = "turbomc"
)

$ImageName = "java25-pterodactyl"
$FullImageName = "$Username/$ImageName"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building Java 25 Docker Image" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Build the image
Write-Host "Building image: $FullImageName`:$Version" -ForegroundColor Yellow
docker build -t "$FullImageName`:$Version" -t "$FullImageName`:latest" .

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅ Build successful!" -ForegroundColor Green
Write-Host ""

# Verify Java version
Write-Host "Verifying Java version..." -ForegroundColor Yellow
docker run --rm "$FullImageName`:$Version" java -version

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Build Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Image: $FullImageName`:$Version" -ForegroundColor White
Write-Host "Tags: $Version, latest" -ForegroundColor White
Write-Host ""

# Push to Docker Hub if requested
if ($Push) {
    Write-Host "Pushing to Docker Hub..." -ForegroundColor Yellow
    Write-Host ""
    
    docker push "$FullImageName`:$Version"
    docker push "$FullImageName`:latest"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "❌ Push failed! Make sure you're logged in with 'docker login'" -ForegroundColor Red
        exit 1
    }
    
    Write-Host ""
    Write-Host "✅ Successfully pushed to Docker Hub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your image is now available at:" -ForegroundColor Cyan
    Write-Host "  docker pull $FullImageName`:$Version" -ForegroundColor White
    Write-Host "  docker pull $FullImageName`:latest" -ForegroundColor White
} else {
    Write-Host "To push to Docker Hub, run:" -ForegroundColor Cyan
    Write-Host "  .\build.ps1 -Push -Version `"$Version`" -Username `"$Username`"" -ForegroundColor White
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. Test the image locally" -ForegroundColor White
Write-Host "2. Update egg-java-25.json with your image name" -ForegroundColor White
Write-Host "3. Import the egg into Pterodactyl" -ForegroundColor White
Write-Host "4. Create a test server" -ForegroundColor White
Write-Host ""
