use nu-config/theme/dark_theme.nu
use nu-config/menu.nu
use nu-config/keybinding.nu

export def main [] {
  {
    show_banner: false
    ls: {
      use_ls_colors: true
      clickable_links: true
    }
    rm: {
      always_trash: false
    }
    table: {
      mode: rounded
      index_mode: always
      show_empty: true
      trim: {
        methodology: wrapping
        wrapping_try_keep_words: true
        truncating_suffix: "..."
      }
    }
    datetime_format: {
      normal: '%a, %d %b %Y %H:%M:%S %z'
    }
    explore: {
      help_banner: true
      exit_esc: true
      command_bar_text: '#C4C9C6'
      status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
      highlight: {bg: 'yellow' fg: 'black' }
      table: {
        split_line: '#404040'

        cursor: true

        line_index: true
        line_shift: true
        line_head_top: true
        line_head_bottom: true

        show_head: true
        show_index: true
      }

      config: {
        cursor_color: {bg: 'yellow' fg: 'black' }
      }
    }

    history: {
      max_size: 100_000
      sync_on_enter: true
      file_format: "sqlite"
      isolation: true
    }
    completions: {
      case_sensitive: false
      quick: true
      partial: true
      algorithm: "fuzzy"
      external: {
        enable: true
        max_results: 100
        completer: null
      }
    }
    cursor_shape: {
      emacs: line
      vi_insert: block
      vi_normal: underscore
    }
    color_config: (dark_theme)

    float_precision: 2

    use_ansi_coloring: true
    bracketed_paste: true
    edit_mode: emacs

    render_right_prompt_on_last_line: false

    hooks: {
      display_output: {||
        if (term size).columns >= 100 { table -e } else { table }
      }
    }
    menus: (menu)
    keybindings: (keybinding)

    highlight_resolved_externals: true
  }
}
