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

# nushellは動的にスクリプトを読み込めないので、最初に見つかったファイルがロードされることを利用して擬似的に条件付きロードを行う
# つまり、`/local`→`/override`→`/lib`の順にロードされる
$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'local'),
  ($nu.config-path | path dirname | path join 'override'),
  ($nu.config-path | path dirname | path join 'lib'),
]

$env.NU_PLUGIN_DIRS = [
  ($nu.default-config-dir | path join 'plugins')
]

let external_dir = ($nu.config-path | path dirname | path join 'lib/external')
mkdir $external_dir

if "name" in (sys).host and (sys).host.name == "Windows" {
  # windowsではシェルじゃなくて普通に設定画面でPATHを設定する
} else {
  # linux
  $env.PATH = ($env.PATH | append "~/.local/bin")
  $env.PATH = ($env.PATH | append "~/go/bin")
  $env.PATH = ($env.PATH | append "~/.cargo/bin")
  $env.PATH = ($env.PATH | append "~/.rye/shims")
  $env.PATH = ($env.PATH | append "~/.deno/bin")
  $env.PATH = ($env.PATH | append "~/.local/share/bob/nvim-bin")
  $env.PATH = ($env.PATH | append "~/.rbenv/shims")
  $env.PATH = ($env.PATH | append "~/.local/share/mise/shims")
  $env.PATH = ($env.PATH | append "~/.dotnet/tools")
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
