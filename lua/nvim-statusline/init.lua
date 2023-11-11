local Module = {}

Module.print_editor_statusline = function()
  -- TODO: display current line number for whole file
  vim.opt_local.statusline = "  " .. vim.fn.expand("%:.") .. "  1  0 󰉻 " .. vim.fn.winline()
end

Module.print_nvimtree_statusline = function()
  vim.opt_local.statusline = "feature/foo"
end

return Module
