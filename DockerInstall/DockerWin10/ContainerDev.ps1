############################################################
# Powershell provision container development environment
# Installs container utilities, 
# Author: Joshua Haupt josh@hauptj.com Date: 31.12.2017
############################################################

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install git -y

choco install vagrant -y

choco install docker-for-windows -y

choco install minikube -y

# Install the entire Hyper-V stack (hypervisor, services, and tools)
# Source: https://www.altaro.com/hyper-v/install-hyper-v-powershell-module/
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

##### Enable Developer Mode #####

Write-Host "Enabling Developer Mode"

# Source: https://stackoverflow.com/questions/40033608/enable-windows-10-developer-mode-programmatically
# Create AppModelUnlock if it doesn't exist, required for enabling Developer Mode
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}

# Add registry value to enable Developer Mode
New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1


##### Install Windows Subsystem for Linux #####

Write-Host "Enabling Windows Subsystem for Linux"

Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -LimitAccess