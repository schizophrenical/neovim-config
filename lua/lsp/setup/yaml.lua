--- YAML LSP Config

return {
  cmd = { 'yaml-language-server', '--stdio' },
  single_file_support = true,
  settings = {
    schemasStrore = {
      enabled = false,
    },
    schemas = require('schemastore').yaml.schemas(),
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
