source ~/.config/nushell/oh-my.nu
source ~/.config/nushell/completions.nu

source ~/.zoxide.nu

let-env PROMPT_COMMAND = { (get_prompt 8bit).left_prompt }
let-env PROMPT_COMMAND_RIGHT = { (get_prompt 8bit).right_prompt }
let-env PROMPT_INDICATOR = { "" }

use completions *

let-env config = {
  show_banner: false
}

