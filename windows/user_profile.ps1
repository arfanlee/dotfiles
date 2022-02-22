# Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Paradox
$omp_config = Join-Path $PSScriptRoot ".\poshell.json"
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
Set-Alias vi nvim
Set-Alias grep findstr
Set-Alias hibot hikari-bot

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
