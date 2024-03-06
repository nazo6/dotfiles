use nu-config

$env.config = (nu-config)

source scripts/alias.nu
source scripts/commands.nu
source local.nu

source scripts/completions/git.nu
source scripts/completions/scoop.nu

source external/starship.nu
source external/zoxide.nu

