local api = vim.api
local statusline = api.nvim_create_augroup("statusline", {})

api.nvim_create_autocmd({"WinEnter", "BufEnter", "CursorMoved"}, {
  pattern = "*",
  callback = function(event)
    local statusline = require("nvim-statusline")
    if vim.bo.filetype == "NvimTree" then
      statusline.print_nvimtree_statusline()
      return
    end
    statusline.print_editor_statusline()
  end,
  group = statusline
})
