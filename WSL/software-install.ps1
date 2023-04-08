#Requires -RunAsAdministrator

function Install-Tools {
  Write-Output "Installing necessary tools.."
  winget import -i apps-to-install.json
  Write-Output "Done.."
}

function Install-WSLUbuntu {
  If (wsl --status) {
    Write-Output "WSL already Installed.."
  } Else {
    Write-Output "Installing WSL2 (Ubuntu). This may take a while. Have some tea/coffee.."
    wsl --install -d "Ubuntu-22.04"
    Write-Output "Done.."
  }
}

Install-Tools
Install-WSLUbuntu
shutdown /r /t 20 /c "Installation done. Close everything. Restarting in 1 min...."
