-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- Basic QoL
vim.keymap.set("n", ";", ":", { desc = "enter cmd mode" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Insert mode nav
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up" })

-- Window nav
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Copy path
map("n", "<leader>cp", function()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" or path == nil then
		vim.notify("No path for current buffer", vim.log.levels.WARN)
	end
	local rel = vim.fn.fnamemodify(path, ":.")
	vim.fn.setreg("+", rel)
	vim.notify(rel .. " copied to clipboard", vim.log.levels.INFO)
end, { desc = "Copy relative path" })

-- Treesitter-based tabout (fallback when cmp/snippets aren't active)
vim.keymap.set("i", "<Tab>", function()
	return require("config.tabout_ts").jump_forward() and "" or ""
end, { expr = true, desc = "Step out" })

vim.keymap.set("i", "<S-Tab>", function()
	return require("config.tabout_ts").jump_backward() and "" or ""
end, { expr = true, desc = "Step in" })

vim.keymap.set("i", "<C-Tab>", function()
	return "\t"
end, { expr = true, desc = "Insert tab character" })

vim.keymap.set("i", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, desc = "Confirm selection" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope git_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope recent files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope fuzzy find %" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope pick hidden term" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Telescope find all files" }
)

-- Lazygit
map("n", "<leader>gg", function()
	local path = "~/.config/lazygit/config.nvim.yml"
	vim.env.LG_CONFIG_FILE = vim.fn.expand(path)
	vim.cmd.term("lazygit")
	vim.cmd.startinsert()
end, { desc = "Lazygit terminal" })

-- LSP (buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local function bufmap(mode, lhs, rhs, desc)
			map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Navigation
		bufmap("n", "gd", vim.lsp.buf.definition, "LSP definition")
		bufmap("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
		bufmap("n", "gr", vim.lsp.buf.references, "LSP references")
		bufmap("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
		bufmap("n", "K", vim.lsp.buf.hover, "LSP hover")

		-- Actions
		bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
		bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code action")

		-- Symbols
		bufmap("n", "<leader>ds", vim.lsp.buf.document_symbol, "LSP document symbols")
		bufmap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "LSP workspace symbols")

		-- Diagnostics
		bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
		bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
		bufmap("n", "<leader>di", vim.diagnostic.open_float, "Line diagnostics")
		bufmap("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics list")
	end,
})
