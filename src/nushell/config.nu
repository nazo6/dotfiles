use config
$env.config = (config)

source scripts/alias.nu
source scripts/commands.nu
source local.nu

source scripts/completions/git.nu
source scripts/completions/scoop.nu

if (sys).host.name == "Windows" {
  source scripts/os/os_windows.nu
} else {
  source scripts/os/os_linux.nu
  source external/rtx.nu
}

source external/starship.nu
source external/zoxide.nu
