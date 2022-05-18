# Prompt
Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\xifost.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Remove virtual environment default prompt
$Env:VIRTUAL_ENV_DISABLE_PROMPT=1

# Icons
Import-Module Terminal-Icons

# PSReadLine
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -Colors @{
  Command            = 'DarkGreen'
  Error				 = 'DarkRed'
  Number             = 'Yellow'
  Member             = 'Gray'
  Operator           = 'Gray'
  Type               = 'Gray'
  Variable           = 'Gray'
  Parameter          = 'Gray'
  ContinuationPrompt = 'Gray'
  Default            = 'Gray'
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Chord 'UpArrow' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord 'DownArrow' -Function HistorySearchForward
Set-PSReadLineKeyhandler -Chord 'Ctrl+Backspace' -Function BackwardDeleteWord

# Alias
function posh-dir { set-location "C:\Users\Blank\.config\powershell" }
function nvim-dir { set-location "C:\Users\Blank\AppData\Local\nvim" }
function touch-file {
  Param(
    [Parameter(Mandatory=$true)]
    [string]$Path
  )

  if (Test-Path -LiteralPath $Path) {
    (Get-Item -Path $Path).LastWriteTime = Get-Date
  } else {
    New-Item -Type File -Path $Path
  }
}
Set-Alias pdir posh-dir
Set-Alias vi nvim
Set-Alias grep findstr
Set-Alias vidir nvim-dir
Set-Alias touch touch-file

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
