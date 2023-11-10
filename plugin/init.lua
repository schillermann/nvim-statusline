local api = vim.api
local statusline = api.nvim_create_augroup("statusline", {})

-- vim.opt.statusline = "active statusline"


api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
  pattern = "*",
  callback = function(event)
    if vim.bo.filetype == "NvimTree" then
      vim.opt_local.statusline = "feature/foo"
      return
    end
    vim.opt_local.statusline = "  " .. vim.fn.expand("%:.") .. "  1  0 󰉻 " .. vim.fn.winline()
  end,
  group = statusline
})
 
api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      return
    end
    vim.opt_local.statusline = "inactive statusline"
  end,
  group = statuslineGroup
})
