require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- remove defaults from ~/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")

-- shared id so session persists across orientations
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "shared" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "shared" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "shared" }
end, { desc = "terminal toggle floating term" })

-- LSP keymaps: set per-buffer when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local buf = ev.buf

    local function bufmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    -- Hover / docs
    bufmap("n", "K", vim.lsp.buf.hover, "LSP: hover docs")

    -- Go to…
    bufmap("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
    bufmap("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
    bufmap("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
    bufmap("n", "gr", vim.lsp.buf.references, "LSP: references")

    -- Signature help
    bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: signature help")

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
  end,
})
