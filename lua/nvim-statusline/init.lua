local Module = {}

vim.api.nvim_command("highlight NvimStatuslineError guifg=#e12636")
vim.api.nvim_command("highlight NvimStatuslineWarning guifg=#ffdf00")
vim.api.nvim_command("highlight NvimStatuslineHint guifg=#ffffff")
vim.api.nvim_command("highlight NvimStatuslineInfo guifg=#ffffff")

function Module.git_branch_name()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if not handle then
    return ""
  end
  local branch = handle:read("*a")
  handle:close()
  return string.len(branch) > 0 and string.gsub(branch, "\n", "") or ""
end

function Module.lsp_number_of_error()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
end

function Module.lsp_number_of_warning()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
end

function Module.lsp_number_of_hint()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
end

function Module.lsp_number_of_info()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
end

function Module.file_status_icon()
  if vim.bo.modified then
    return "●"
  end

  if vim.bo.filetype == "help" then
    return "'"
  end

  if vim.bo.readonly then
    return ""
  end

  return ""
end

function Module.diagnostic_line_part()
  local error = Module.lsp_number_of_error()
  local warning = Module.lsp_number_of_warning()
  local hint = Module.lsp_number_of_hint()
  local info = Module.lsp_number_of_info()
  local line_part = {}

  if error > 0 then
    table.insert(line_part, "%#NvimStatuslineError# %*" .. error)
  end

  if warning > 0 then
    table.insert(line_part, "%#NvimStatuslineWarning# %*" .. warning)
  end

  if hint > 0 then
    table.insert(line_part, "%#NvimStatuslineHint# %*" .. hint)
  end

  if info > 0 then
    table.insert(line_part, "%#NvimStatuslineInfo# %*" .. info)
  end

  if #line_part == 0 then
    return ""
  end

  return " " .. table.concat(line_part, " ")
end

function Module.advanced_line()
  return table.concat({
    Module.file_status_icon(),
    " %f",
    Module.diagnostic_line_part(),
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

function Module.default_line()
  return table.concat({
    vim.bo.filetype == "help" and "'" or "",
    " %f",
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

function Module.short_line()
  local git_branch_name = Module.git_branch_name()
  return table.concat({
    " %f",
    git_branch_name == "" and "" or "  " .. git_branch_name,
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

return Module
