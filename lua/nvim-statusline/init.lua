local Module = {}

function Module.statusline_explorer()
  local git_branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if (git_branch == "") then
    return "  [No Branch]"
  end
  return string.format("  %s", git_branch) 
end

function Module.statusline_editor()
  local project_path = vim.fn.expand("%:.")
  if (project_path == "") then
    return "  [No File]"
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINTS })

  return string.format("  %s  %d  %d 󰉻 %%l/%%L", project_path, errors, warnings  + info + hints)
end

function Module.set_statusline()
  if vim.bo.filetype == "NvimTree" then
    vim.opt_local.statusline = Module.statusline_explorer()
    return
  end
  vim.opt_local.statusline = Module.statusline_editor()
end

return Module
