-- nvim-ufo setup

require('ufo').setup({
  open_fold_hl_timeout = 0,
  close_fold_kinds = { 'imports' },
  -- enable_get_fold_virt_text = false,
  -- return an empty array for fold virtext.
  ---@diagnostic disable-next-line: unused-local
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    -- handler that will output the ff. virtext:
    -- ━┫ function M.hello() ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫  43 ┣━

    -- helper functions.
    ---Test for blanks
    ---@param str string
    ---@return boolean
    local function is_blank(str)
      return (str == nil or #string.gsub(str, "^%s*(.-)%s*$", "%1") == 0)
    end

    ---Test if chunk should be included on the fold text.
    ---@param chunk string
    ---@param chunks integer
    ---@return boolean
    local function should_insert(chunk, chunks)
      if is_blank(chunk) then
        if chunks == 0 then
          return false
        end
      end
      return true
    end

    -- final virtext
    local virt_text = {}
    -- prefix and suffix
    local prefix = '━┫ '
    local suffix = ' ┣━'
    -- filler
    local filler_char = '━'
    local filler_char_star = ' * '

    -- folded lines
    local lines = ('━┫ Lines: %d ┣━' .. filler_char_star .. filler_char):format(endLnum - lnum)

    -- widths
    local lines_width = vim.fn.strdisplaywidth(lines)
    local pref_width = vim.fn.strdisplaywidth(prefix)
    local suff_width = vim.fn.strdisplaywidth(suffix)
    local filler_width = width - 10
    local text_width = 0
    -- uniform highlights for fold text.
    local hl = 'UfoFoldedFg'
    -- chunks counter
    local chunks = 0

    -- add filler char
    table.insert(virt_text, { filler_char, hl })
    -- add some more filler char
    table.insert(virt_text, { filler_char_star, hl })
    -- add '━┫' prefix
    table.insert(virt_text, { prefix, hl })

    -- loop through the chunks of text and them to the final virttext
    -- a chunk is composed of a text and a highlight, like below:
    -- {'local', '@keyword'}
    for _, chunk in ipairs(virtText) do
      local text_chunk = chunk[1]
      local text_chunk_width = vim.fn.strdisplaywidth(text_chunk)
      -- do not add leading spaces.
      if should_insert(text_chunk, chunks) then
        chunks = chunks + 1
        -- track the total width so that we can subtract it
        -- later to the filler_width
        text_width = text_width + text_chunk_width
        table.insert(virt_text, { text_chunk, "UfoFoldedFg" })
      end
    end
    -- build filler characters to insert at the middle.
    filler_width = filler_width - pref_width - text_width - suff_width - lines_width
    local filler = string.rep(filler_char, filler_width)

    -- add '┣━' suffix
    table.insert(virt_text, { suffix, hl })
    -- add filler
    table.insert(virt_text, { filler, hl })
    -- add folded lines count
    table.insert(virt_text, { lines, hl })

    return virt_text
  end,
  preview = {
    win_config = {
      winblend = 0,
    },
  },
})