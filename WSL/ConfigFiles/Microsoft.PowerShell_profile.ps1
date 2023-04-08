#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : This is a powershell configuration file
#        /    \  \       _____   /    \/    \                       similar to .bashrc for bash, which run before
#       /  /\  \  \     /    /  /            \                      the powershell prompt appears. It contains
#      /        \  \        /  /      \/      \                     configurations such as Aliases, Functions, etc...
#     /          \  \      /  /                \
#    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/Dotfiles
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

# Set Theme
# ---------
If ( (Get-Module -ListAvailable -Name 'posh-git') -And
     (Get-Module -ListAvailable -Name 'oh-my-posh'))
{
  Import-Module 'posh-git'
  Import-Module 'oh-my-posh'
  Set-PoshPrompt bubblesline
  # Set-PoshPrompt marcduiker
} Else
{
  Write-Output "Modules 'posh-git' and 'oh-my-posh' not found. Attempting installation of these modules..."
  Write-Output "If problem occurs, run powershell as Admin."
  Install-Module 'posh-git'
  Install-Module 'oh-my-posh'
  Write-Output "Done. Restart powershell."
}

# Variables
# ---------
$Env:HOME = $Env:USERPROFILE

# Functions
# ---------
function ..
{
  Set-Location .. 
}
function ~
{
  Set-Location $Env:USERPROFILE 
}
function assoc
{
  CMD /C "assoc $args" 
}
function ftype
{
  CMD /C "ftype $args" 
}
function gca($CmdName)
{
  (Get-Command $CmdName).Parameters.Values | Select-Object Name, Aliases 
}
function hist
{
  Get-Content (Get-PSReadLineOption).HistorySavePath 
}
function phead([Int]$Lines=10)
{
  $Input | Select-Object -First $Lines 
}
function ptail([Int]$Lines=10)
{
  $Input | Select-Object -Last $Lines 
}
function q
{
  exit 
}
function rmr
{
  Remove-Item -Recurse -Verbose -Force $Args 
}
function lv
{
  If(Test-Path -Path "$HOME\.local\bin\lvim.ps1" -PathType Leaf)
  { 
    Invoke-Expression "& $HOME\.local\bin\lvim.ps1 $Args"
  } Else
  {
    nvim $Args 
  }
}
function lvc
{
  lv $Env:LOCALAPPDATA\lvim\config.lua
}
function vipro
{
  lv $PROFILE
}

# Activate Virtual Env of a Python Project
function activate([String]$ProjFolder=(Get-Location))
{
  If (Test-Path $ProjFolder\"$((Get-Item *env*).Name)")
  { & $ProjFolder\"$((Get-Item *env*).Name)\Scripts\Activate.ps1" 
  } Else
  { Write-Output "Goto the python project root folder and then run this command ..." 
  }
}

# Edit Module Code
function modloc ([String]$ModuleName)
{
  If (-Not $ModuleName)
  {
    Write-Output "Pass a module name. Pressing tab after the command will cycle through the installed modules"
    Return 
  }
  Return (Get-Module $ModuleName).ModuleBase
}

# Auto-complete powershell modules for modloc command
Register-ArgumentCompleter -CommandName modloc -ScriptBlock { (Get-Module).Name }

# Open pdf file in Acrobat Reader
function pdf([String]$PDFFile)
{
  If ($PDFFile -contains ' ')
  { $PDFFile = $PDFFile -replace ' ', '`` ' 
  }
  Start-Process $Env:LOCALAPPDATA\SumatraPDF\SumatraPDF.exe `"$PDFFile`"
}

# Auto-complete pdf files in the directory for 'pdf' command
Register-ArgumentCompleter -CommandName pdf -ScriptBlock {
  Param($WrdToCmp)
  Get-ChildItem $WrdToCmp*.pdf
}

# Google search
function gglSrchStr([String]$SrchFor)
{
  $SrchFor = $SrchFor.Trim()
  $SrchFor = $SrchFor -Replace "\s+", " "
  $SrchFor = $SrchFor -Replace " ", "+"
  Return "https://www.google.com/search?q=$SrchFor"
}

# Search the web Or Goto a given URL
function web([String]$SiteURL, [Switch]$Firefox, [Switch]$Brave, [Switch]$Opera, [Switch]$InCog, [Switch]$GoogleSrch)
{
  Filter IsFirefox
  {
    If ($Firefox.IsPresent)
    { Return $True 
    } Else
    { Return $False 
    } 
  }
  Filter IsBrave
  {
    If ($Brave.IsPresent)
    { Return $True 
    } Else
    { Return $False 
    } 
  }
  Filter BrowserArg
  {
    If (IsFirefox)
    { Return "-private-window" 
    } Else
    { Return "-incognito" 
    } 
  }
  Filter IsOpera
  {
    If ($Opera.IsPresent)
    { Return $True 
    } Else
    { Return $False 
    } 
  }

  # Default is Chrome Browser
  $BrowserExePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
  If (IsFirefox)
  { $BrowserExePath = 'C:\Program Files\Mozilla Firefox\firefox.exe' 
  }
  If (IsBrave)
  { $BrowserExePath = 'C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe' 
  }
  If (IsOpera)
  { $BrowserExePath = $Env:LOCALAPPDATA + '\Programs\Opera\launcher.exe' 
  }
  If ($GoogleSrch.IsPresent)
  { $SiteURL = (gglSrchStr $SiteURL) 
  }
  If ($InCog.IsPresent)
  {
    Start-Process -FilePath $BrowserExePath -ArgumentList (BrowserArg), $(
      If (Test-Path $SiteURL)
      { 'file:///' + (Get-ChildItem $SiteURL).FullName 
      } Else
      { $SiteURL 
      }
    )
  } Else
  { Start-Process -FilePath $BrowserExePath -ArgumentList $SiteURL 
  }
}

# UTF conversion
function U
{
  Param([Int]$Code)
  If ((0 -le $Code) -and ($Code -le 0xFFFF)) { return [char] $Code }
  If ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) { return [char]::ConvertFromUtf32($Code) }
  throw "Invalid character code $Code"
}

## Git related stuff ##
If (Get-Command git -ErrorAction Ignore)
{
  function g { git $Args }
  function gs { git status }
  function ga { git add $Args }
  function gb { git branch $Args }
  function gup
  {
    Param(
      [Parameter(Position=0)][String]$file,
      [Parameter(Mandatory=$True, Position=1)][String]$msg,
      [Parameter(Position=2)][String]$branch="main"
    )
    Write-Output "Adding to source control ...`n"
    If ([String]::IsNullOrEmpty($file)) { git add . }
    Else { git add $file }
    Write-Output "Commiting changes with msg: $msg ...`n"
    git commit -m $msg
    Write-Output "Pushing to remote Github branch: $branch ..."
    git push origin $branch
  }
}

# Powershell Disk Usage
function pdu([String]$FoldName=".", [Switch]$TotalOnly)
{
  Write-Output ""
  $DUScriptBlk = {
    Param ($FoldNameIn)
    $AllOutput = $DirOutput = $FilOutput = @()
    $TotalSize = 0

    # Recurse through the folders and get size for each
    Get-ChildItem $FoldNameIn -Directory | ForEach-Object {
      $Output = [PSCustomObject]@{
        ContentName = "$($_.Name)/"
        SizeOnDisk  = $(
          $Tmp = (Get-ChildItem -LiteralPath $_.FullName -Recurse -EA SilentlyContinue | Measure-Object -Property Length -Sum -EA SilentlyContinue).Sum
          If ([String]::IsNullOrEmpty($Tmp)) { 0 }
          Else { $Tmp }
        )
      }
      $DirOutput += $Output
      $TotalSize += $Output.SizeOnDisk
    }
    $AllOutput += ($DirOutput | Sort-Object -Property SizeOnDisk -Descending)

    # Files in the current directory are ingnored. Get sizes of this as well.
    Get-ChildItem $FoldNameIn -File | ForEach-Object {
      $Output = [PSCustomObject]@{
        ContentName = $_.Name
        SizeOnDisk  = (Get-ChildItem $_.FullName -EA SilentlyContinue | Measure-Object -Property Length -Sum -EA SilentlyContinue).Sum
      }
      $FilOutput += $Output
      $TotalSize += $Output.SizeOnDisk
    }
    $AllOutput += ($FilOutput | Sort-Object -Property SizeOnDisk -Descending)

    Write-Output ""
    Write-Output "`n## Total Size : $( Format-FileSize $TotalSize )"
    If ($TotalOnly.IsPresent)
    { Exit; 
    }
    $AllOutput |
      Format-Table @{Label="Size";     Expression={ Format-FileSize $_.SizeOnDisk }},
      @{Label="Contents"; Expression={ $_.ContentName }}
  }
  spinner -ScriptToExec $DUScriptBlk -Label "Calculating size ..." -OtherArgs (Get-Item $FoldName).FullName
}

# Spinner. Cyles through -- [ '|',  '/', '-', '\' ]
function spinner([Scriptblock]$ScriptToExec, [String]$Label, [String]$OtherArgs)
{
  $job = Start-Job -ScriptBlock $ScriptToExec -ArgumentList $OtherArgs
  $symbols = @("[|]", "[/]", "[-]", "[\]")
  $TimerWatch = [System.Diagnostics.Stopwatch]::StartNew()
  $WaitMessage = "[may take some time ...]"
  $i = 0
  while ($job.State -eq "Running")
  {
    $symbol =  $symbols[$i]
    Write-Host -NoNewLine "`r$symbol $Label $(If ($TimerWatch.Elapsed.Seconds -gt 30) { $WaitMessage } )" -ForegroundColor Green
    Start-Sleep -Milliseconds 100
    $i += 1
    if ($i -eq $symbols.Count)
    { $i = 0 
    }
  }
  Write-Host -NoNewLine "`r"
  If ($job.State -eq 'Failed')
  { Write-Output ($job.ChildJobs[0].JobStateInfo.Reason.Message) 
  } Else
  {
    $JobOutput = Receive-Job -Job $job 6>&1
    Write-Output $JobOutput
  }
}

# Convert file from DOS to Unix format
function ps_dos2unx([String]$FileToConvert)
{
  If (Test-Path -Type Leaf $FileToConvert)
  {
    $FilePath = (Get-ChildItem $FileToConvert).FullName
    $AllTxt = Get-Content -Raw $FilePath | ForEach-Object{ $_ -replace "`r`n", "`n" }
    [IO.File]::WriteAllText('.\wntx64\log\libmfg_all_err', $AllTxt)
  }
}

# Timed Out Choice, returns default choice if no choice is entered with 10 secs
function timedOutChoice
{
  Param (
    [Parameter( Mandatory = $True )][Alias('m')][String]$PromptMsg,
    [Parameter( Mandatory = $True )][Alias('d')][String]$DefChoice,
    [Alias('t')][Int]$TimeoutSec = 10
  )

  $TimeOut = New-TimeSpan -Seconds $TimeoutSec
  $StopWatch = [System.Diagnostics.StopWatch]::StartNew()

  If (-Not [String]::IsNullOrEmpty($PromptMsg))
  { Write-Output -NoNewline ($PromptMsg + "[y/n]: ") 
  }
  While ($StopWatch.Elapsed.Seconds -lt $TimeOut.Seconds)
  {
    If ($Host.UI.RawUI.KeyAvailable)
    {
      $KeyPressed = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
      If ($KeyPressed.KeyDown -eq "True")
      {
        Return [System.Char]::ToUpper($KeyPressed.Character)
      }
    }
  }
  Return $DefChoice
}

If (Get-Command winget -ErrorAction Ignore)
{
  function wl { winget list $Args }
  function ws { winget search $Args }
  function wi { winget install $Args }
  function wun { winget uninstall --purge $Args }
}

# Search files/folders and perform appropriate actions
If (Get-Command fzf -ErrorAction Ignore)
{
  $Env:FZF_DEFAULT_OPTS = "--height=20 --reverse"
  If (Get-Command rg -ErrorAction Ignore)
  {
    # Functions ffe and ffo are almost identical. Reason for two separate function is that
    # one is for editing text-based files using vim and other is for opening files like PDF, DOCX, etc.
    function ffe($SearchFolder)
    {
      $FZF_OUTPUT = (rg --files --hidden --ignore-case --no-messages $SearchFolder `
        | fzf --preview="bat --color=always --style=numbers {}" `
              --bind shift-up:preview-page-up,shift-down:preview-page-down `
              --header="Text-based file to open")
      If ($FZF_OUTPUT) { lv $FZF_OUTPUT }
    }
    function ffo($SearchFolder)
    {
      $FZF_OUTPUT = (rg --files --ignore-case --no-messages $SearchFolder `
        | fzf --header="Search the file to open")
      If ($FZF_OUTPUT) { & "$FZF_OUTPUT" }
    }
  }
  If (Get-Command fd -ErrorAction Ignore)
  {
    # Search and jump to a folder
    function fdd($FolderScope)
    {
      $FZF_OUTPUT = (fd . "$FolderScope" --type d `
        | fzf --preview="dir {}" `
              --header="Jump to directory" `
              --bind shift-up:preview-page-up,shift-down:preview-page-down)
      If ($FZF_OUTPUT)
      {
        If (Get-Command zoxide -ErrorAction Ignore)
        { z $FZF_OUTPUT
        } Else
        { Set-Location $FZF_OUTPUT 
        }
      }
    }
    # Copy file to destination
    function fcp($SearchFolder, $DestScope)
    {
      $FZF_COPYFILES = (rg --files --ignore-case --no-messages $SearchFolder `
        | fzf --header="Search file(s) to copy" --multi)
      If ($FZF_COPYFILES)
      {
        $FZF_DESTFOLD = (fd --full-path "$DestScope" --type d | fzf --header="Select destination folder")
        If ($FZF_DESTFOLD) {
          $FZF_COPYFILES | ForEach-Object { Copy-Item -Verbose "$_" "$FZF_DESTFOLD" }
        }
      }
    }
  }
}

# Colored ls
If (Get-Command Get-ChildItemColor -ErrorAction SilentlyContinue)
{
  Set-Alias -Name lsw Get-ChildItemColorFormatWide

  function lsd
  {
    Get-ChildItemColor -Directory $Args | Sort-Object LastWriteTime -Descending
  }
  function lse
  {
    Get-ChildItemColor $Args | Sort-Object Extension,LastWriteTime -Descending
  }
  function lsn
  {
    Get-ChildItemColor $Args | Select-Object Length,Name | Format-Table @{n="Size";e={Format-FileSize $_.Length};a="right"},Name
  }
  function la
  {
    Get-ChildItemColor -Hidden $Args | Sort-Object LastWriteTime -Descending
  }
  function ll
  {
    Get-ChildItemColor $Args | Sort-Object LastWriteTime -Descending
  }

  # Add colors to MSoffice files and pdf
  $GetChildItemColorTable.File.Add(".doc",  "DarkCyan")
  $GetChildItemColorTable.File.Add(".docx", "DarkCyan")
  $GetChildItemColorTable.File.Add(".ppt",  "Magenta")
  $GetChildItemColorTable.File.Add(".pptx", "Magenta")
  $GetChildItemColorTable.File.Add(".xls",  "Green")
  $GetChildItemColorTable.File.Add(".xlsx", "Green")
  $GetChildItemColorTable.File.Add(".pdf",  "Red")
} Else
{
  Import-Module Get-ChildItemColor
}

# Btop4win alias
If (Test-Path "$Env:LOCALAPPDATA\Programs\btop4win")
{
  Set-Alias -Name btop -Value "$Env:LOCALAPPDATA\Programs\btop4win\btop4win.exe"
}

# Notepad++ alias
If (Test-Path "${Env:ProgramFiles(x86)}\Notepad++")
{
  Set-Alias -Name np -Value "${Env:ProgramFiles(x86)}\Notepad++\notepad++.exe"
} ElseIf (Test-Path "$Env:ProgramFiles\Notepad++")
{
  Set-Alias -Name np -Value "$Env:ProgramFiles\Notepad++\notepad++.exe"
}

# Alias to reboot system
Set-Alias -Name 'reboot' -Value Restart-Computer
Set-Alias -Name 'poff' -Value Stop-Computer

# Emacs aliases with DoomEmacs
# If (Get-Command "runemacs" -EA Ignore)
# {
#   $Env:LANG = "en_US.UTF-8"
#   $EmacsServ = (Get-Command "runemacs").Source
#   $EmacsClnt = (Get-Command "emacsclientw").Source
#   function ems
#   {
#     Start-Process -FilePath $EmacsServ -ArgumentList "--daemon" -NoNewWindow
#   }
#   function emc
#   {
#     Start-Process -FilePath $EmacsClnt -ArgumentList "-cn"
#   }
#   function em
#   {
#     Start-Process -FilePath $EmacsServ -NoNewWindow
#   }
#   If (Get-Command "doom" -EA Ignore)
#   {
#     function ds
#     {
#       Write-Output "Sync doom config changes..."
#       Invoke-Command { doom sync -ev }
#     }
#   }
# }

# Zoxide Config :: Jump directories faster
If (Get-Command zoxide -EA Ignore)
{
  Invoke-Expression (& {
      $hook = if ($PSVersionTable.PSVersion.Major -lt 6)
      { 'prompt' 
      } else
      { 'pwd' 
      }
        (zoxide init --hook $hook powershell | Out-String)
    })
  Set-Alias -Name 'c' -Value z
}

# Batcat 'bat' on Windows, 'batcat' on *nix Systems
If (Get-Command bat -EA Ignore)
{
  function b
  {
    bat --style="numbers,changes,header-filename,header-filesize" $Args
  }
}

# Scoop functions and aliases
If (Get-Command scoop -EA Ignore)
{
  function scs
  {
    scoop search $Args
  }
  function scl
  {
    scoop list $Args
  }
}

# Hyper terminal settings (optional, just in case)
If (Get-Command hyper -EA Ignore)
{
  Set-Alias -Name 'hy' -Value 'hyper'
  function vh([Alias("f")][Switch]$ConfFile)
  {
    $HyperConfFile = "$Env:USERPROFILE\AppData\Local\Hyper\.hyper.js"
    If ($ConfFile.IsPresent)
    { Return $HyperConfFile 
    } Else
    { lv $HyperConfFile 
    }
  }
}

# Wezterm terminal emulator/multiplexer (better than hyper)
If (Get-Command wezterm -EA Ignore)
{
  function wtmconf([Alias("f")][Switch]$ConfFile)
  {
    $WeztermConfFile = "$Env:USERPROFILE\.config\wezterm\wezterm.lua"
    If ($ConfFile.IsPresent)
    { Return $WeztermConfFile 
    } Else
    { lv $WeztermConfFile 
    }
  }
}

# WSL shutdown
If (Get-Command wsl -EA Ignore)
{
  function wsld
  {
    wsl --shutdown
  }
}
