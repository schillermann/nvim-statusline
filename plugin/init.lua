vim.api.nvim_create_autocmd({"FileType", "BufEnter", "CursorHold", "InsertLeave"}, {
  pattern = "*",
  callback = function(event)
    local statusline = require("nvim-statusline")
    if not vim.bo.filetype or string.len(vim.bo.filetype) == 0 then
      vim.opt_local.statusline = statusline.get_default_line()
      return
    end
    if vim.bo.filetype == "netrw" or vim.bo.filetype == "NvimTree" then
      vim.opt_local.statusline = statusline.get_short_line()
      return
    end

    vim.opt_local.statusline = statusline.get_advanced_line()
  end
})
