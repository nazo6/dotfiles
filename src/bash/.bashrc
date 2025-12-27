# zshrc config to chain-load fish shell (for Linux)

export PATH="$PATH:$HOME/.local/bin"
export PATH=~/.local/share/bob/nvim-bin:$PATH
export PATH=~/.cargo/bin:$PATH

if [[ $(grep -i Microsoft /proc/version) ]]; then
  if command -v wsl2-ssh-agent &> /dev/null; then
    eval $(wsl2-ssh-agent -log /tmp/wsl2-ssh-agent.log)
  fi

  # Fix cuda
  export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH
fi

# If not running interactively
[[ $- != *i* ]] && return

if ! command -v fish &> /dev/null; then
  echo "Nushell is not installed."
else
  exec nu
fi
