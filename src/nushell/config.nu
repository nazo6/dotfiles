use config
$env.config = (config)

source external/starship.nu
source external/zoxide.nu

if (sys).host.name == "Windows" {
  source scripts/os/os_windows.nu
} else {
  source scripts/os/os_linux.nu
}

source scripts/alias.nu
source local.nu
