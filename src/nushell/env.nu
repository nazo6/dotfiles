# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
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
let-env NU_LIB_DIRS = [
  # splitted configs
  ($nu.config-path | path dirname | path join 'config'),
  ($nu.config-path | path dirname | path join 'config/theme'),
  # scripts to run after config
  ($nu.config-path | path dirname | path join 'script/local'),
  ($nu.config-path | path dirname | path join 'script')
  ($nu.config-path | path dirname | path join 'script/os'),
  # temporary folder for external scripts
  ($nu.config-path | path dirname | path join 'external'),
]

let-env NU_PLUGIN_DIRS = [
  ($nu.default-config-dir | path join 'plugins')
]

let external_dir = ($nu.config-path | path dirname | path join 'external')
mkdir $external_dir
starship init nu | save -f ($external_dir | path join 'external_starship.nu')
zoxide init nushell | save -f ($external_dir | path join 'external_zoxide.nu')
