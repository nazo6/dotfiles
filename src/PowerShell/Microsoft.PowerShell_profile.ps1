Invoke-Expression (&starship init powershell)

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

Set-Alias n nvim
Set-Alias lg lazygit

if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ll { eza -la @Args }
    Set-Alias ls eza
}
