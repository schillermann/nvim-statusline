vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
  pattern = "*",
  callback = function(event)
    require("nvim-statusline").set_statusline()
  end
})
