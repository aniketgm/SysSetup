# System Setup

## Windows (WSL2)

### Initial setup

1. Manually, install git. Why manually ? Because the setup script will be in the gh repo which will contain the __*installation*__ script.
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
	& '<setup_filename>.ps1'
	```
5. The *setup* file will be responsible for:
	- Installing necessary softwares,
	- Setting up config files, and
	- (Optional) Downloading notes and documents from the cloud storages (GDrive/Dropbox/OneDrive/Github/Gitlab/etc..)
