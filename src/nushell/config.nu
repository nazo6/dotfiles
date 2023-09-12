use config
$env.config = (config)

source external/starship.nu
source external/zoxide.nu


source scripts/alias.nu
source local.nu

source scripts/completions/git.nu
source scripts/completions/scoop.nu

mut cl = {|| print a}
if (sys).host.name == "Windows" {
  source scripts/os/os_windows.nu
} else {
  source scripts/os/os_linux.nu
}

do $cl
