# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'local'),
  ($nu.config-path | path dirname | path join 'lib'),
]

$env.NU_PLUGIN_DIRS = [
  ($nu.default-config-dir | path join 'plugins')
]

let external_dir = ($nu.config-path | path dirname | path join 'lib/external')
mkdir $external_dir

if "name" in (sys).host and (sys).host.name == "Windows" {
  # windows
} else {
  # linux
  $env.PNPM_HOME = ($env.HOME | path join ".local/share/pnpm")
  $env.PATH = ($env.PATH | append $env.PNPM_HOME)
  $env.PATH = ($env.PATH | append "~/.local/bin")
  $env.PATH = ($env.PATH | append "~/go/bin")
  $env.PATH = ($env.PATH | append "~/.cargo/bin")
  $env.PATH = ($env.PATH | append "~/.deno/bin")
  $env.PATH = ($env.PATH | append "~/.local/share/bob/nvim-bin")
}


if (which starship | length) != 0 {
  starship init nu | save -f ($external_dir | path join 'starship.nu')
} else {
  "" | save -f ($external_dir | path join 'starship.nu')
}

if (which zoxide | length) != 0 {
  zoxide init nushell | save -f ($external_dir | path join 'zoxide.nu')
} else {
  "" | save -f ($external_dir | path join 'zoxide.nu')
}

if ("name" in (sys).host and (sys).host.name == "Windows") or (which rtx | length) == 0 {
  "" | save -f ($external_dir | path join 'rtx.nu')
} else {
  rtx activate nu | save -f ($external_dir | path join 'rtx.nu')
}

