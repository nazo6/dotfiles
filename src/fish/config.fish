set -U fish_greeting

if type -q mise
  mise activate fish | source
end

if status is-interactive
  # shell extensions
  if type -q zoxide
    zoxide init fish | source
  end
  if type -q starship
    starship init fish | source
  end

  # aliases
  abbr -a n nvim
  abbr -a lg lazygit
  abbr -a fish-reload 'source ~/.config/fish/**/*.fish'

  if type -q eza
    alias ls='eza'
    alias ll='eza -la'
  else
    alias ll='ls -la'
  end

  # env
  if type -q nvim
    set -x EDITOR nvim
  end

  # If terminal is kitty, open ssh with TERM=xterm option
  if test "$TERM" = "xterm-kitty"
    alias ssh='TERM=xterm command ssh'
  end
end
