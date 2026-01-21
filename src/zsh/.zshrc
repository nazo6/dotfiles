export PATH="$PATH:$HOME/.local/bin"
export PATH=~/.local/share/bob/nvim-bin:$PATH
export PATH=~/.cargo/bin:$PATH

# WSL specific settings
if [[ $(grep -i Microsoft /proc/version) ]]; then
  if command -v wsl2-ssh-agent &> /dev/null; then
    eval $(wsl2-ssh-agent -log /tmp/wsl2-ssh-agent.log)
  fi

  # Fix cuda
  export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH
fi

if type eza &> /dev/null; then
  alias ls='eza'
  alias ll='eza -la'
else
  alias ll='ls -la'
fi

alias n='nvim'
alias lg='lazygit'
alias reload='source ~/.zshrc'

if type ghq &> /dev/null && type fzf &> /dev/null; then
  gs() {
    if [ $# -eq 0 ]; then
      local repo_path
      repo_path=$(ghq list | fzf --height 40% --reverse)
      if [ -n "$repo_path" ]; then
        cd "$(ghq root)/$repo_path"
      fi
    else
      command ghq "$@"
    fi
  }
fi

# External tools
if type starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if type zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if type mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if type sheldon &> /dev/null; then
  eval "$(sheldon source)"
fi

