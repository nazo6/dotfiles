use nu-config/theme/dark_theme.nu
use nu-config/menu.nu
use nu-config/keybinding.nu

export def main [] {
  {
    show_banner: false
    ls: {
      use_ls_colors: true # use the LS_COLORS environment variable to colorize output
      clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }
    rm: {
      always_trash: false # always act as if -t was given. Can be overridden with -p
    }
    table: {
      mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
      index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
      show_empty: true # show 'empty list' and 'empty record' placeholders for command output
      trim: {
        methodology: wrapping # wrapping or truncating
        wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
        truncating_suffix: "..." # A suffix used by the 'truncating' methodology
      }
    }
  
    # datetime_format determines what a datetime rendered in the shell would look like.
    # Behavior without this configuration point will be to "humanize" the datetime display,
    # showing something like "a day ago."
  
    datetime_format: {
      normal: '%a, %d %b %Y %H:%M:%S %z'  # shows up in displays of variables or other datetime's outside of tables
      # table: '%m/%d/%y %I:%M:%S%p'        # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }
  
    explore: {
      help_banner: true
      exit_esc: true
  
      command_bar_text: '#C4C9C6'
      # command_bar: {fg: '#C4C9C6' bg: '#223311' }
  
      status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
      # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }
  
      highlight: {bg: 'yellow' fg: 'black' }
  
      status: {
        # warn: {bg: 'yellow', fg: 'blue'}
        # error: {bg: 'yellow', fg: 'blue'}
        # info: {bg: 'yellow', fg: 'blue'}
      }
  
      try: {
        # border_color: 'red'
        # highlighted_color: 'blue'
  
        # reactive: false
      }
  
      table: {
        split_line: '#404040'
  
        cursor: true
  
        line_index: true
        line_shift: true
        line_head_top: true
        line_head_bottom: true
  
        show_head: true
        show_index: true
  
        # selected_cell: {fg: 'white', bg: '#777777'}
        # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
        # selected_column: blue
  
        # padding_column_right: 2
        # padding_column_left: 2
  
        # padding_index_left: 2
        # padding_index_right: 1
      }
  
      config: {
        cursor_color: {bg: 'yellow' fg: 'black' }
  
        # border_color: white
        # list_color: green
      }
    }
  
    history: {
      max_size: 100_000 # Session has to be reloaded for this to take effect
      sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
      file_format: "sqlite" # "sqlite" or "plaintext"
      isolation: true # true enables history isolation, false disables it. true will allow the history to be isolated to the current session. false will allow the history to be shared across all sessions.
    }
    completions: {
      case_sensitive: false # set to true to enable case-sensitive completions
      quick: true  # set this to false to prevent auto-selecting completions when only one remains
      partial: true  # set this to false to prevent partial filling of the prompt
      algorithm: "prefix"  # prefix or fuzzy
      external: {
        enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
        max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
        completer: null # check 'carapace_completer' above as an example
      }
    }
    cursor_shape: {
      emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
      vi_insert: block # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
      vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
    }
    color_config: (dark_theme) # if you want a light theme, replace `$dark_theme` to `$light_theme`
    # footer_mode: 25 # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    # buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: emacs # emacs, vi
    # shell_integration: false # enables terminal markers and a workaround to arrow keys stop working issue
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  
    hooks: {
      pre_prompt: [{||
        null  # replace with source code to run before the prompt is shown
      }]
      pre_execution: [{||
        null  # replace with source code to run before the repl input is run
      }]
      env_change: {
        PWD: [{|before, after|
          null  # replace with source code to run if the PWD environment is different since the last repl input
        }]
      }
      display_output: {||
        if (term size).columns >= 100 { table -e } else { table }
      }
      command_not_found: {||
        null  # replace with source code to return an error message when a command is not found
      }
    }
    menus: (menu)
    keybindings: (keybinding)
  }
}
