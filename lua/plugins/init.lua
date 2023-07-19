--- Package Manager
---
--- Initializes the package manager

-- Currently in-use: Lazy
local lazy = require('plugins.manager.lazy')

local M = {}

--- Bootstrap the package manager.
function M.bootstrap_packman()
  lazy.bootstrap()
end

--- Initialize the plugins.
function M.setup()
  lazy.setup()
end

return M
