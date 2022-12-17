echo "Copying default configuration files"
$dot_root = Split-Path $MyInvocation.MyCommand.Path
Copy-Item "$dot_root\.dotter\local-templates\local.windows.toml" "$dot_root\.dotter\local.toml" 
dotter
