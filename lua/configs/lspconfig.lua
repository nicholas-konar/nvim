local util = require "lspconfig.util"

local nvlsp = require "nvchad.configs.lspconfig"
local highlight_nav = require "configs.illuminate"
local lsp = vim.lsp
local servers = { "html", "cssls", "pyright" }

local function on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  local function bufmap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Hover / docs
  bufmap("n", "K", vim.lsp.buf.hover, "LSP: hover docs")

  -- Go to…
  bufmap("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
  bufmap("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
  bufmap("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
  bufmap("n", "gr", vim.lsp.buf.references, "LSP: references")

  -- Signature help (moved off <C-k> to leave smooth scrolling free)
  bufmap("n", "<leader>cs", vim.lsp.buf.signature_help, "LSP: signature help")

  -- Rename
  bufmap("n", "<leader>cr", vim.lsp.buf.rename, "LSP: rename symbol")

  -- Code actions (current cursor / selection)
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
  bufmap("v", "<leader>ca", vim.lsp.buf.code_action, "LSP: code action range")

  -- TypeScript: add all missing imports in file
  bufmap("n", "<leader>ci", function()
    vim.lsp.buf.code_action {
      context = { only = { "source.addMissingImports.ts" } },
      apply = true,
    }
  end, "TS: add missing imports")

  -- Formatting
  bufmap("n", "<leader>cf", function()
    require("conform").format {
      async = true,
      lsp_fallback = false,
    }
  end, "format (conform)")

  -- Diagnostics navigation
  bufmap("n", "[d", vim.diagnostic.goto_prev, "LSP: prev diagnostic")
  bufmap("n", "]d", vim.diagnostic.goto_next, "LSP: next diagnostic")
  bufmap("n", "<leader>cd", vim.diagnostic.open_float, "LSP: line diagnostics")
  bufmap("n", "<leader>cq", vim.diagnostic.setloclist, "LSP: diagnostics loclist")

  -- VS Code-style highlight mode powered by vim-illuminate
  highlight_nav.attach(bufnr)

  vim.api.nvim_create_autocmd("LspDetach", {
    buffer = bufnr,
    callback = function()
      if not next(vim.lsp.get_clients { bufnr = bufnr }) then
        highlight_nav.detach(bufnr)
      end
    end,
  })
end

-- lsps with default config
local function configure(server, opts)
  lsp.config(server, vim.tbl_extend("force", {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts or {}))

  lsp.enable(server)
end

for _, server in ipairs(servers) do
  configure(server)
end

-- override ts_ls config for better JS support
configure("ts_ls", {
  root_dir = util.root_pattern("jsconfig.json", "tsconfig.json", ".git"),
  init_options = {
    preferences = {
      -- leverage TS path aliases
      importModuleSpecifierPreference = "non-relative",
      importModuleSpecifier = "non-relative",
    },
  },
})

-- omnisharp (C#) config for Mason + Unity
configure("omnisharp", {
  cmd = {
    vim.fn.stdpath "data" .. "/mason/packages/omnisharp/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
  root_dir = util.root_pattern("*.sln", ".git"),
})

-- lua_ls for editing Neovim config
configure("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "config" .. "/lua",
        },
      },
      telemetry = { enable = false },
    },
  },
})

-- prevent fn signature popup from stealing focus
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false })
