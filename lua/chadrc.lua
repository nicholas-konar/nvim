-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_osaka",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- Bright highlight groups for vim-illuminate + LSP references
    IlluminatedWordText = { bg = "#ffd75f", fg = "#00212b", bold = true },
    IlluminatedWordRead = { link = "IlluminatedWordText" },
    IlluminatedWordWrite = { bg = "#ffb347", fg = "#00212b", bold = true },
    LspReferenceText = { link = "IlluminatedWordText" },
    LspReferenceRead = { link = "IlluminatedWordText" },
    LspReferenceWrite = { link = "IlluminatedWordWrite" },
  },
}

M.plugins = "plugins.init"
M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

M.colorify = {
  highlight = {
    lspvars = false,
  },
}

return M
