# If not running interactively
[[ $- != *i* ]] && return

# If fish is not installed, show warning message
if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed."
else
  exec fish
fi
