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
starship init nu | save -f ($external_dir | path join 'starship.nu')
# temporary fix (https://github.com/ajeetdsouza/zoxide/issues/599#issuecomment-1659120147)
zoxide init nushell | str replace --all 'let-env ' '$env.' | save -f ($external_dir | path join 'zoxide.nu')

if (sys).host.name == "Windows" {
} else {
  rtx activate nu | save -f ($external_dir | path join 'rtx.nu')
}
