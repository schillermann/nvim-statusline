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
  return string.format("  %s  1  0 󰉻 %%l/%%L", project_path)
end

function Module.set_statusline()
  if vim.bo.filetype == "NvimTree" then
    vim.opt_local.statusline = Module.statusline_explorer()
    return
  end
  vim.opt_local.statusline = Module.statusline_editor()
end

return Module
