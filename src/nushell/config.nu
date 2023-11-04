use nu-config
$env.config = (nu-config)

source scripts/alias.nu
source scripts/commands.nu
source local.nu

source scripts/completions/git.nu
source scripts/completions/scoop.nu

if "name" in (sys).host and (sys).host.name == "Windows" {
  source scripts/os/os_windows.nu
} else {
  source scripts/os/os_linux.nu
}

source external/starship.nu
source external/zoxide.nu
source external/rtx.nu
