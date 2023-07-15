--- Todo comments setup

require('todo-comments').setup({
  keywords = {
    FIX = {
      icon = ' ', -- icon used for the sign, and in search results
      color = 'error', -- can be a hex color, or a named color (see below)
      -- a set of other keywords that all map to this FIX keywords
      alt = {
        'FIXME',
        'BUG',
        'FIXIT',
        'ISSUE',
        'ERROR'
      },
    },
    TODO = {
      color = '#F4A64E'
    },
  },
  highlight = {
    keyword = 'bg',
    pattern = [[.*<(KEYWORDS)[^:]*:]],
  }
})