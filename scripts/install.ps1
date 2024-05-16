# Do not modify this file. You will lose the ability to install and auto-update!

$ErrorActionPreference = "Stop" # Exit immediately if a command exits with a non-zero status

$VERSION="0.0.1"
$CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"

Write-Host "-------------"
Write-Host "Welcome to DealHub installer!"
Write-Host "This script will install everything for you."
Write-Host "-------------"

Write-Host "Creating directories..."

New-Item -ItemType Directory -Force -Path DealHub

Write-Host "Downloading required files from CDN..."
Invoke-WebRequest -Uri "$CDN/docker-compose.prod.yml" -OutFile "DealHub/docker-compose.yml"
Invoke-WebRequest -Uri "$CDN/.env.example" -OutFile "DealHub/.env.example"
Invoke-WebRequest -Uri "$CDN/nginx/default.conf" -OutFile "DealHub/default.conf"
Invoke-WebRequest -Uri "$CDN/scripts/upgrade.sh" -OutFile "DealHub/upgrade.sh"

# Copy .env.example if .env does not exist
if (!(Test-Path -Path DealHub/.env)) {
    Copy-Item -Path DealHub/.env.example -Destination DealHub/.env
}

# Generate DJANGO_SECRET_KEY and update DEBUG value in .env file
$envContent = Get-Content -Path DealHub/.env
$DJANGO_SECRET_KEY = -join ((65..90) + (97..122) | Get-Random -Count 50 | % {[char]$_})
$envContent = $envContent -replace 'SECRET_KEY=.*', "SECRET_KEY=$DJANGO_SECRET_KEY"
$envContent = $envContent -replace 'DEBUG=.*', 'DEBUG=False'
$envContent | Set-Content -Path DealHub/.env

# Merge .env and .env.example, remove duplicates and empty lines
$env = Get-Content -Path DealHub/.env
$envExample = Get-Content -Path DealHub/.env.example
$mergedEnv = $env + $envExample | Sort-Object -Unique
$mergedEnv = $mergedEnv | Where-Object { $_.Trim() -ne "" }
$mergedEnv | Set-Content -Path DealHub/.env

Write-Host ""
Write-Host "Congratulations! Your DealHub instance is ready to use."
Write-Host ""