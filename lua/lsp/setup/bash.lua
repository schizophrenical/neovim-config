--- Bash LSP config

return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh' },
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
}
