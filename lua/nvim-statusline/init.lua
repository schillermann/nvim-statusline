local Module = {}

vim.api.nvim_command("highlight NvimStatuslineErrors guibg=#6f1313")
vim.api.nvim_command("highlight NvimStatuslineWarnings guibg=#264f78")

function Module.statusline_explorer()
  local git_branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if (git_branch == "") then
    return "  [No Branch]"
  end
  return string.format("  %s", git_branch) 
end

function Module.statusline_editor()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) + #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) + #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINTS })

  local statusline = "  %t %=󰉻 %l/%L "
  if (errors > 0) then
    statusline = statusline .. "%#NvimStatuslineErrors#  " .. errors .. " %*"
  else
    statusline = statusline .. "  0 "
  end

  if (info > 0) then
    statusline = statusline .. "%#NvimStatuslineWarnings#  " .. info .. " %*"
  else
    statusline = statusline .. "  0 "
  end
  return statusline
end

function Module.set_statusline()
  if vim.bo.filetype == "NvimTree" then
    vim.opt_local.statusline = Module.statusline_explorer()
    return
  end
  vim.opt_local.statusline = Module.statusline_editor()
end

return Module
