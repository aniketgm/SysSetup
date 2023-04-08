# System Setup

## Windows (WSL2)

1. First, manually install git. So as to clone this repo and run the *installation* script.
	- Git can be installed using the *GitForWindows* installer Or through the commandline tool winget. Winget is now available in almost all latest windows installations, (Windows 10 and above)
	- So preferable way: `winget install Git.Git`
2. Once Git is installed, then clone the repo
	```powershell
	mkdir $USERPROFILE\GHRepos
	git clone https://github.com/aniketgm/system-setup
	```
3. Now run the powershell script from an elevated terminal (Open As Administrator), inorder to avoid any permission issues.
4. In a powershell terminal, this can be achieved as follows:
	```powershell
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	& software-install.ps1
	```
5. This *setup* file will be responsible for installing necessary softwares and then it will automatically restart the system for the changes to take effect.
6. Once the system restarts, the again launch Powershell and set the default profile of the terminal to Powershell 7.
7. Relaunching the terminal as Admin again and run the next script:
  - This script is responsible for setting up config files and other softwares. The script will again *Restart* the system.
  __*NOTE*__: We are yet to setup the WSL. This is for Windows.
  ```powershell
  & post-install-setup.ps1
  ```
8. Now after restart, launch Alacritty, which should launch WSL prompt.
  - If WSL is not launched, you might want to check a few things:
    1. If alacritty is launched through shortcut, check the properties and the target config file set in the properties.
    2. Else, check the config file $Env:APPDATA\alacritty\alacritty.yml, for any issue in the configuration.

## Linux

* The setup for Linux is similar to that of WSL, with a few more for the actual NonWSL2 setup

### Common Setup

* Assuming the OS is Ubuntu (WSL), 'apt' package manager is considered below.
* WSL now can be launched from Alacritty.

1. Install git.
  ```bash
  sudo apt install git
  ```
2. Clone the repo 'aniketgm/system-setup' (OR in WSL2, one can cd into the already cloned repo on Windows FileSystem)
  ```bash
  mkdir ~/Repos && cd $_
  git clone https://github.com/aniketgm/system-setup
  cd system-setup
  ```

### WSL2 Config

* Run the following script that is inside the `Linux` folder:
  ```bash
  sudo wsl-setup.sh
  ```

### NonWSL2 Config

* Run the following script that is inside the `Linux` folder:
  ```bash
  sudo nonwsl-setup.sh
  ```
