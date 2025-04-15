-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = { "html", "cssls", "pyright", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- override ts_ls config for better JS support
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = util.root_pattern("jsconfig.json", "tsconfig.json", ".git"),
}
