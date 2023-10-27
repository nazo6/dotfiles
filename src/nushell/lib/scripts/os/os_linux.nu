$env.PNPM_HOME = "/home/nazo/.local/share/pnpm"
$env.PATH = ($env.PATH | append $env.PNPM_HOME)
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.PATH = ($env.PATH | append "~/go/bin")
$env.PATH = ($env.PATH | append "~/.cargo/bin")
$env.PATH = ($env.PATH | append "~/.deno/bin")
$env.PATH = ($env.PATH | append "~/.local/share/bob/nvim-bin")

# if ((sys).host.kernel_version | str contains "WSL2") {}
