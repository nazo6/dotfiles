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

    local activate_str=$(_mise_wrapper activate zsh | sed "s/'[^']*mise\.exe'/_mise_wrapper/g" | sed "s/command _mise_wrapper/_mise_wrapper/g")

    print -r $activate_str

    eval $activate_str

    # Mise adds a command_not_found_handler which is very slow on msys2.
    # With this code, response will be faster, but you lose the feature of suggesting installation of missing commands.
    [[ ! -v functions[command_not_found_handler] ]] || unfunction command_not_found_handler
  else
    eval "$(mise activate zsh)"
  fi
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-autosuggestions

### End of Zinit's installer chunk
