--- nvim-tree setup

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  select_prompts = true,
  view = {
    adaptive_size = true,
    centralize_selection = true,
    hide_root_folder = false,
  },
  renderer = {
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = '└',
        edge = '│',
        item = '├',
        bottom = '└', --'─',
        none = ' ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      symlink_arrow = '',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        -- PERF: Slow on Windows, don't even try.
        git = true,
      },
      glyphs = {
        default = ' ',
        symlink = ' ',
        bookmark = ' ',
        folder = {
          arrow_closed = '│',
          arrow_open = '├',
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = ' ',
          symlink_open = ' ',
        },
        git = {
          unstaged = '',
          staged = '',
          unmerged = '',
          renamed = '',
          untracked = '',
          deleted = '',
          ignored = '',
        },
      },
    },
    special_files = {
      'Cargo.toml',
      'Makefile',
      'README.md',
      'readme.md',
      'lazy-lock.json',
    },
    symlink_destination = true,
    highlight_opened_files = 'all',
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  -- PERF: slow on big repos
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      error = '',
      warning = '',
      hint = '',
      info = '',
    },
  },
})
