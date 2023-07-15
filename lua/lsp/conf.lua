--- Base config file for LSP Servers

local anim = {
  '⣾',
  '⣽',
  '⣻',
  '⢿',
  '⡿',
  '⣟',
  '⣯',
  '⣷',
}
local anim_i = 1

local M = {}

---Progress report handler
---@param _ any any
---@param result table|nil result
---@param ctx table|nil context
function M.progress_handler(_, result, ctx)
  if not ctx then return end

  if not result then return end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then return end

  if result.value then
    local message = result.value
    if message.kind then
      local title = message.title or client.name or ''
      local sub_message = message.message or 'Loading'
      local percent = message.percentage or ''
      if message.kind == 'begin' or message.kind == 'report' then
        -- NOTE: When debugging an issue with config, set boolean to true
        -- to store echoes to :messages
        vim.api.nvim_echo({
          {
            anim[anim_i] .. ' (' .. percent .. '%) ' .. string.sub(
              title,
              1,
              20
            ) .. '..' .. ' >> ' .. string.sub(sub_message, 1, 80) .. '..',
            'Constant',
          },
        }, false, {})
      elseif message.kind == 'end' then
        -- end
        -- blank echo to clear last update
        vim.api.nvim_echo({ { '', 'Constant' } }, false, {})
      end
    end
    -- little animation
    if anim_i <= 5 then
      anim_i = anim_i + 1
    else
      anim_i = 1
    end
  end
end

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Add folding range to capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = capabilities
M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 170,
}

return M
