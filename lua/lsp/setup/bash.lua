--- Bash LSP config

return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'zsh' },
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
    },
  },
}
