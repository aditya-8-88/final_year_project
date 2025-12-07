# Run Women Safety App on Android Phone

Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Women Safety App - Phone Testing    " -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Set Flutter path
$env:PATH = "C:\flutter\bin;$env:PATH"

Write-Host "Checking connected devices..." -ForegroundColor Yellow
flutter devices

Write-Host ""
Write-Host "If your phone is listed above, press ENTER to continue..." -ForegroundColor Green
Write-Host "If NOT listed, check USB Debugging is enabled!" -ForegroundColor Red
$null = Read-Host

Write-Host ""
Write-Host "Installing and running app on your phone..." -ForegroundColor Green
Write-Host "The app will open automatically on your device." -ForegroundColor Green
Write-Host ""
Write-Host "Hot Reload Tips:" -ForegroundColor Yellow
Write-Host "  - Press 'r' = Quick reload" -ForegroundColor Yellow
Write-Host "  - Press 'R' = Full restart" -ForegroundColor Yellow
Write-Host "  - Press 'q' = Quit app" -ForegroundColor Yellow
Write-Host ""

# Run on phone
flutter run

Write-Host ""
Write-Host "App closed. Thanks for testing!" -ForegroundColor Cyan
