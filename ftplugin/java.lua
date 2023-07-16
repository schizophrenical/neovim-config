---Java filetype opts.
---
---Mainly LSP settings and some buffer options.

local conf = require('lsp.conf')
local java_conf = conf.java
local jdtls = require('jdtls')

---LSP config (JDTLS)
local lsp_conf = {
  -- Common LSP config settings.
  -- executable
  cmd = java_conf.cmd,
  -- client flags
  flags = conf.flags,
  -- client capabilities
  capabilities = conf.capabilities,
  -- NOTE: This is not really needed as this is a lspconfig specific
  -- config. We just add it here so that the custom statusline can
  -- detect the LSP server name.
  filetypes = {
    'java',
  },
  -- JDTLS specific options
  -- initializationOptions
  init_options = {
    -- bundles for test and decompiler
    bundles = java_conf.bundles,
  },
  -- WARN: Only enabled due to experimental inlay hint plugin.
  inlayHint = {
    parameterNames = {
      enabled = true,
    },
  },
  -- log/message handlers
  handlers = {
    ['language/status'] = conf.status_update_handler,
    -- progress adds slowness (to me)
    ['$/progress'] = function() end,
  },
  -- Java settings.
  settings = {
    java = {
      -- disable autobuild for faster startup.
      autobuild = {
        enabled = true,
      },
      -- clean up (mostly executed on save)
      cleanup = {
        actionsOnSave = {
          'invertEquals',
          'addFinalModifier',
        },
      },
      -- completions (mostly auto import)
      completion = {
        enabled = true,
        favoriteStaticMembers = {
          -- JUnit assertions
          'org.junit.Assert.*',
          -- mockito argument matchers.
          'org.mockito.ArgumentMatchers.*',
        },
        filteredTypes = {
          'com.sun.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        -- TODO: Check if will conflict with CMP
        guessMethodArguments = true,
      },
      configuration = {
        -- NOTE: Enable as needed.
        maven = {
          downloadSources = true,
        },
        -- JDKs available.
        runtimes = {
          {
            name = 'JavaSE-1.8',
            path = java_conf.jdk.jdk_8,
          },
          {
            name = 'JavaSE-11',
            path = java_conf.jdk.jdk_11,
            default = true,
          },
          {
            name = 'JavaSE-17',
            path = java_conf.jdk.jdk_17,
          },
        },
      },
      -- Decompiler (should have a decompiler bundle on init options)
      contentProvider = {
        preferred = 'fernflower',
      },
      -- Enable folding range.
      foldingRange = {
        enabled = true,
      },
      -- Disable formatting (no need because of google format)
      format = {
        enabled = false,
      },
      -- Import options. Import to workspace not import to code.
      import = {
        exclusions = java_conf.project_exclusions,
        -- enable maven imports
        maven = {
          enabled = true,
        },
        -- not using gradle, disable.
        gradle = {
          enabled = false,
        },
      },
      -- Could be CPU heavy, auto build is disabled by default though.
      maxConcurrentBuilds = 2,
      reference = {
        includeAccessors = true,
        -- no need to show references to libraries.
        includeDecompiledSources = false,
      },
      -- enable workspace-wide renames.
      rename = {
        enabled = true,
      },
      -- do not organize imports on save.
      saveActions = {
        organizeImports = false,
      },
      -- compiler preferences.
      settings = {
        url = java_conf.compiler_prefs_file,
      },
      -- enable signature help
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      symbols = {
        includeSourceMethodDeclarations = true,
      },
    },
  },
}

-- Start the connection to LSP Server.
jdtls.start_or_attach(lsp_conf)
