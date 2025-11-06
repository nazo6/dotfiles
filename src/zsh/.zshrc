# Interactive, login and non-login shell
# zshrc config to chain-load fish shell (for macOS)

if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed."
else
  exec nu
fi
