# Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Paradox
$omp_config = Join-Path $PSScriptRoot ".\xifost.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

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
  Number             = 'Gray'
  Member             = 'Gray'
  Operator           = 'Gray'
  Type               = 'Gray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
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
function hikari-bot { set-location "C:\Users\Blank\Documents\Programming\Python\Codes\Git\hikari-bot" }
function nvim-dir { set-location "C:\Users\Blank\AppData\Local\nvim" }
function posh-dir { set-location "C:\Users\Blank\.config\powershell" }
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
Set-Alias vi nvim
Set-Alias grep findstr
Set-Alias hibot hikari-bot
Set-Alias vidir nvim-dir
Set-Alias pdir posh-dir
Set-Alias touch touch-file

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
