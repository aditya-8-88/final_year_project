# Women Safety App - Quick Launch Script
# This script sets up Flutter path and runs the app

Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Women Safety & Legal Awareness App  " -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Set Flutter path
$env:PATH = "C:\flutter\bin;$env:PATH"

# Check if Flutter is available
Write-Host "Checking Flutter installation..." -ForegroundColor Yellow
flutter --version

Write-Host ""
Write-Host "Starting the app in Chrome..." -ForegroundColor Green
Write-Host "The app will open in your browser shortly." -ForegroundColor Green
Write-Host ""
Write-Host "Press 'q' in the terminal to quit the app." -ForegroundColor Yellow
Write-Host ""

# Run the app
flutter run -d chrome
