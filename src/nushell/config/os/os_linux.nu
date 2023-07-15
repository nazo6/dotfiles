let-env PNPM_HOME = "/home/nazo/.local/share/pnpm"
let-env PATH = ($env.PATH | split row (char esep) | prepend PNPM_HOME)
