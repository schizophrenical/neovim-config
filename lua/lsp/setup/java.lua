--- Java LSP config

-- Java tools path
local expand = vim.fn.expand
local java_tools = expand(expand('~/Dev/tools/java'))

-- DAP bundles (Debugger)
local debug_jars = {}
local glob = vim.fn.glob
local split = vim.split
local expr = '*.jar'
-- managed by mason
local bundles_path = vim.fn.stdpath('data') .. '/mason/packages/'

-- Decompiler bundles
local decompiler_path = bundles_path .. 'vscode-java-decompiler/'
--stylua: ignore
vim.list_extend(
  debug_jars,
  split(glob(decompiler_path .. expr, true),
  '\n')
)
-- Java Debug plugin bundle
local java_debug_path = bundles_path .. 'java-debug-adapter/'
--stylua: ignore
vim.list_extend(
  debug_jars,
  split(glob(java_debug_path .. expr, true),
  '\n')
)
-- VSCode java test plugin bundle
local vscode_test_path = bundles_path .. 'java-test/'
for _, jar in pairs(split(glob(vscode_test_path .. expr, true), '\n')) do
  if not vim.endswith(jar, 'runner-jar-with-dependencies.jar') then
    table.insert(debug_jars, jar)
  end
end

---Workspace directory should be unique to every project.
---Here we get the project name.
---i.e.: dir/to/project/my_project will have workspace folder of my_project
local workspace_id = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

return {
  ---Push status with different highlight group
  ---This handler is specific to JDTLS
  ---@param _ any any
  ---@param result table|nil result
  status_update_handler = function(_, result)
    if result and result.message then
      -- Language server is ready
      if result.message == 'ServiceReady' then
        vim.api.nvim_echo(
          { { '[Language Server] : ' .. '﫠 Connected', 'Directory' } },
          false,
          {}
        )
      else
        vim.api.nvim_echo({
          {
            '[Language Server] : .. ' .. string.sub(result.message, 20, 70),
            'Type',
          },
        }, false, {})
      end
    end
  end,
  ---DAP related overrides
  dap_overrides = {
    config_overrides = {
      vmArgs = '--add-modules=ALL-SYSTEM '
        .. '--add-opens java.base/java.util=ALL-UNNAMED '
        .. '--add-opens java.base/java.lang=ALL-UNNAMED '
        .. '--add-opens java.base/java.io=ALL-UNNAMED ',
    },
  },
  -- Java compiler preference file
  compiler_prefs = java_tools .. '/eclipse-compiler-prefs/compiler.prefs',
  -- Debug bundles
  bundles = debug_jars,
  -- Project exclusions
  exclusions = {},
  -- JDK installations
  jdk = {
    jdk_8 = java_tools .. '/jdk-1.8.0.331',
    jdk_11 = java_tools .. '/jdk-11.0.18',
    jdk_17 = java_tools .. '/jdk-17.0.6',
  },
  ---Language server command
  cmd = {
    'jdtls', -- managed by mason
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Xms8g',
    '-Xmx10g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    '-configuration',
    expand(expand('~/.cache/jdtls')),
    '-data',
    expand(expand('~/Dev/tools/java/workspaces')) .. '/' .. workspace_id,
  },
}
