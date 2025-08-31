# Interactive, login and non-login shell
# zshrc config to chain-load fish shell (for macOS)

# If fish is not installed, show warning message
if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed."
else
  exec fish
fi
