export PATH="$PATH:$HOME/.local/bin"

if [[ $(grep -i Microsoft /proc/version) ]]; then
  eval $(wsl2-ssh-agent -log /tmp/wsl2-ssh-agent.log)
fi

[ -z "$PS1" ]  || exec nu

# fnm
export PATH="/home/nazo/.local/share/fnm:$PATH"
eval "`fnm env`"
