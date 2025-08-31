# zshrc config to chain-load fish shell (for Linux)

export PATH="$PATH:$HOME/.local/bin"
export PATH=~/.local/share/bob/nvim-bin:$PATH
export PATH=~/.cargo/bin:$PATH

if [[ $(grep -i Microsoft /proc/version) ]]; then
  if command -v wsl2-ssh-agent &> /dev/null; then
    eval $(wsl2-ssh-agent -log /tmp/wsl2-ssh-agent.log)
  fi
fi

# If not running interactively
[[ $- != *i* ]] && return

# If fish is not installed, show warning message
if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed."
else
  exec fish
fi
