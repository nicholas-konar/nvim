local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = { "html", "cssls", "pyright", "ts_ls", "omnisharp" }
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
  init_options = {
    preferences = {
      -- leverage TS path aliases
      importModuleSpecifierPreference = "non-relative",
      importModuleSpecifier = "non-relative",
    },
  },
}

-- omnisharp (C#) config for Mason + Unity
lspconfig.omnisharp.setup {
  cmd = {
    vim.fn.stdpath "data" .. "/mason/packages/omnisharp/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  root_dir = util.root_pattern("*.sln", ".git"),
}

-- prevent fn signature popup from stealing focus
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false })
