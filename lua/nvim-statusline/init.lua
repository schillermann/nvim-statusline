local Module = {}

vim.api.nvim_command("highlight NvimStatuslineErrors guifg=#e12636")
vim.api.nvim_command("highlight NvimStatuslineWarnings guifg=#ffdf00")
vim.api.nvim_command("highlight NvimStatuslineHints guifg=#ffffff")
vim.api.nvim_command("highlight NvimStatuslineInfo guifg=#ffffff")

function Module.get_git_branch_name()
    local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
    local branch = handle:read("*a")
    handle:close()
    return string.len(branch) > 0 and branch:gsub("\n", "") or ""
end

function Module.lspNumberOfErrors()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
end

function Module.lspNumberOfWarnings()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
end

function Module.lspNumberOfHints()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINTS })
end

function Module.lspNumberOfInfo()
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
end

function Module.get_advanced_line()
  return table.concat({
    (vim.bo.readonly or not vim.bo.modifiable) and " " or "",
    vim.bo.modified and "● " or "",
    vim.bo.filetype == "help" and "' " or " ",
    "%f",
    Module.lspNumberOfErrors() > 0 and "%#NvimStatuslineErrors# %* " .. Module.lspNumberOfErrors() or "",
    Module.lspNumberOfWarnings() > 0 and "%#NvimStatuslineWarnings# %* " .. Module.lspNumberOfWarnings() or "",
    Module.lspNumberOfHints() > 0 and "%#NvimStatuslineHints# %* " .. Module.lspNumberOfHints() or "",
    Module.lspNumberOfInfo() > 0 and "%#NvimStatuslineInfo# %* " .. Module.lspNumberOfInfo() or "",
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

function Module.get_default_line()
  return table.concat({
    vim.bo.filetype == "help" and "' " or " ",
    "%f",
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

function Module.get_short_line()
  local git_branch_name = Module.get_git_branch_name()
  return table.concat({
    " %f ",
    git_branch_name ~= "" and " " .. git_branch_name or "",
    "%=%-14.(󰉻 %l,%c%V%) %P"
  })
end

return Module
