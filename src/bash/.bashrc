# zshrc config to chain-load fish shell (for Linux)

export PATH="$PATH:$HOME/.local/bin"
export PATH=~/.local/share/bob/nvim-bin:$PATH
export PATH=~/.cargo/bin:$PATH

if [[ $(grep -i Microsoft /proc/version) ]]; then
  if command -v wsl2-ssh-agent &> /dev/null; then
    eval $(wsl2-ssh-agent -log /tmp/wsl2-ssh-agent.log)
  fi
fi

# pnpm
export PNPM_HOME="/home/wada/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# If not running interactively
[[ $- != *i* ]] && return

if ! command -v fish &> /dev/null; then
  echo "Nushell is not installed."
else
  exec nu
fi
