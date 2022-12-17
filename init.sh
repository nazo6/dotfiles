echo "Copying default configuration files"
dot_root=$(dirname ${0})
cp $dot_root/.dotter/local-templates/local.linux.toml $dot_root/.dotter/local.toml
dotter
