def ip-info [] {
  http get https://am.i.mullvad.net/json | table --expand
}

def --env gs [...rest] {
  if (which "ghq" | length) > 0 and (which "fzf" | length) > 0  {
    let repo_path = (ghq list | fzf --height 40% --reverse)
    print $"Moving to (ghq root | path join $repo_path)"
    cd (ghq root | path join $repo_path)
  } else {
    echo "ghq or fzf not found"
  }
}
