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
  if [[ "$OSTYPE" == "cygwin" ]]; then
    # Very hacky way to make mise work on msys2
    
    local mise_path_win=$(where.exe mise | head -n 1 | tr -d '\r')

    _mise_wrapper() {
        command mise "$@" | sed -E "s/PATH='([^']+)'/PATH=\"\$(cygpath -u -p '\1')\"/g"
    }

    local activate_str=$(_mise_wrapper activate zsh)
    local activate_str=${activate_str//$mise_path_win/_mise_wrapper}

    echo MISE PATH:
    print -r $mise_path
    echo ACTIVATE STR:
    print -r $activate_str
    eval $activate_str
  else
    eval "$(mise activate zsh)"
  fi
fi

if type sheldon &> /dev/null; then
  eval "$(sheldon source)"
fi

