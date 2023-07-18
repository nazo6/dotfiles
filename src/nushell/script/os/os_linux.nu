let-env PNPM_HOME = "/home/nazo/.local/share/pnpm"
let-env PATH = ($env.PATH | append $env.PNPM_HOME)
let-env PATH = ($env.PATH | append "~/.local/bin")
let-env PATH = ($env.PATH | append "~/go/bin")
let-env PATH = ($env.PATH | append "~/.cargo/bin")
let-env PATH = ($env.PATH | append "~/.deno/bin")
let-env PATH = ($env.PATH | append "~/.local/share/bob/nvim-bin")

# setup fnm
let-env PATH = ($env.PATH | append "~/.local/share/fnm")
load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
let-env PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

# if ((sys).host.kernel_version | str contains "WSL2") {}
