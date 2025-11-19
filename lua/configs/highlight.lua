local highlights = {
  IlluminatedWordText = { bg = "#f7e96d", fg = "#00212b", bold = true },
  IlluminatedWordRead = { bg = "#f0d545", fg = "#00212b", bold = true },
  IlluminatedWordWrite = { bg = "#ffb347", fg = "#00212b", bold = true },
  LspReferenceText = { link = "IlluminatedWordText" },
  LspReferenceRead = { link = "IlluminatedWordRead" },
  LspReferenceWrite = { link = "IlluminatedWordWrite" },
}

local M = {}

function M.apply()
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M
