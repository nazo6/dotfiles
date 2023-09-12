$env.PNPM_HOME = "/home/nazo/.local/share/pnpm"
$env.PATH = ($env.PATH | append $env.PNPM_HOME)
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.PATH = ($env.PATH | append "~/go/bin")
$env.PATH = ($env.PATH | append "~/.cargo/bin")
$env.PATH = ($env.PATH | append "~/.deno/bin")
$env.PATH = ($env.PATH | append "~/.local/share/bob/nvim-bin")

# setup fnm
$env.PATH = ($env.PATH | append "~/.local/share/fnm")
load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
$env.PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

# if ((sys).host.kernel_version | str contains "WSL2") {}

print linux
