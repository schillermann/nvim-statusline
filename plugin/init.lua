vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {
  pattern = "*",
  callback = function(event)
    require("nvim-statusline").set_statusline()
  end
})
