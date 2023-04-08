#Requires -RunAsAdministrator
#Requires -Version 7.1

# Install other tools that are not in winget and Setup other configurations
Write-Output "-> Running Post-Install script.."
Write-Output ""


function Install-Btop4Win {
  Write-Output "-> Setting up btop4win.."

  # Check if VCRedist is installed, if not then install it using winget
  if ((winget list "Microsoft.VCRedist.2015+.x64")[2] -like "No installed*") {
    winget install "Microsoft.VCRedist.2015+.x64"
  } Elseif ((winget list "Microsoft.VCRedist.2015+.x86")[2] -like "No installed*") {
    winget install "Microsoft.VCRedist.2015+.x86"
  }

  # If Downloads folder not present create it
  $DwnldsFolder = "$Env:USERPROFILE\Downloads"
  If (!(Test-Path $DwnldsFolder)) { New-Item -Path "$DwnldsFolder" -ItemType Directory }

  # Download zip file from website in Downloads
  Write-Output "-> # Downloading btop4win (latest release).."
  Push-Location $DwnldsFolder
  Invoke-WebRequest -Uri "https://github.com/aristocratos/btop4win/releases/latest/download/btop4win-x64.zip" -OutFile btop4win.zip

  # Extract and setup btop4win in AppData\Local\Programs. Create respective folder if required.
  Write-Output "-> # Extracting to $Env:LOCALAPPDATA\Programs.."
  $LocalPrograms = "$Env:LOCALAPPDATA\Programs"
  If (!(Test-Path $LocalPrograms)) { New-Item -Path $LocalPrograms -ItemType Directory }
  Expand-Archive btop4win.zip -DestinationPath $LocalPrograms
  Remove-Item btop4win.zip
  Pop-Location ## Pop out from 'Downloads' folder
  Write-Output "-> # Done.."
  Write-Output ""

# NOTE: In Powershell Profile file, if the respective 'btop4win' folder exist, then an alias (btop) is created.
# Else if there is any issue, then check and create the respective alias manually to that executable (btop4win.exe).
}

function Install-Fonts {
  Write-Output "-> Setting up fonts.."
  mkdir $Env:TEMP\FontSetup
  Push-Location $Env:TEMP\FontSetup
  Write-Output "-> # Cloning nerd-fonts repo.."
  git clone "https://github.com/ryanoasis/nerd-fonts"
  Set-Location nerd-fonts
  Write-Output "-> # Installing fonts [JetBrainsMono,FiraCode].."
  ./install.ps1 JetBrainsMono, FiraCode -WindowsCompatibleOnly
  Pop-Location
  Write-Output "-> # Cleaning up temp files.."
  Remove-Item $Env:TEMP\FontSetup -Recurse
  Write-Output "-> # Done.."
  Write-Output ""
}

function Install-LunarVim {
  Write-Output "-> Setting up LunarVim.."
  Invoke-WebRequest https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.ps1 -UseBasicParsing | Invoke-Expression
  Write-Output "-> # Done.."
  Write-Output ""
}

function Set-Confifigurations {
  Write-Output "-> Setting up configurations.."
  $RepoRoot = (git rev-parse --show-toplevel)
  Push-Location "$RepoRoot\WSL\ConfigFiles"
  
  # Copy PowerShell config
  Write-Output "-> # Copying Microsoft.PowerShell_profile.ps1.."
  $PSProfilePath = (Split-Path $PROFILE)
  If (!(Test-Path $PSProfilePath)) { New-Item -Path $PSProfilePath -ItemType Directory }
  Copy-Item -Path "Microsoft.PowerShell_profile.ps1" -Destination $PSProfilePath -Force

  # Copy Alacritty config
  Write-Output "-> # Copying Alacritty config.."
  $AlacrittyConfPath = "$Env:APPDATA\alacritty"
  If (!(Test-Path $AlacrittyConfPath)) { New-Item -Path $AlacrittyConfPath -ItemType Directory }
  Copy-Item -Path "alacritty.yml" -Destination $AlacrittyConfPath -Force

  # Copy LunarVim config
  Write-Output "-> # Copying LunarVim config.."
  Copy-Item -Path "lvim" -Destination $Env:LOCALAPPDATA\ -Recurse -Force

  Pop-Location
  Write-Output "-> # Done.."
  Write-Output ""
}

Install-Btop4Win
Install-LunarVim
Install-Fonts
Set-Confifigurations
Write-Output "-> Restarting.."
shutdown /r /t 60 /c "Post-install setup done. Close everything quickly. Restarting in 1 min...."
