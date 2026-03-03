-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable vim_defaults gr* keybindings to avoid prefix conflict with custom gr mapping
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")

local map = vim.keymap.set

-- Basic QoL
map("n", ";", ":", { desc = "enter cmd mode" })
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true })

map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", "<cmd>bnext<bar>bdelete #<CR>", { desc = "Close buffer" })

-- Insert mode nav
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Window nav
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

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

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Lazygit
local lazygit_bufnr = nil

map("n", "<leader>gg", function()
	local path = "~/.config/lazygit/config.nvim.yml"
	vim.env.LG_CONFIG_FILE = vim.fn.expand(path)

	-- Close nvim-tree if open
	local tree_ok, tree = pcall(require, "nvim-tree.api")
	if tree_ok and tree.tree.is_visible() then
		tree.tree.close()
	end

	-- Check if lazygit buffer still exists and is valid
	if lazygit_bufnr and vim.api.nvim_buf_is_valid(lazygit_bufnr) then
		vim.cmd("buffer " .. lazygit_bufnr)
		vim.cmd("startinsert")
		return
	end

	vim.cmd("enew")
	vim.cmd("term lazygit")

	-- Store the buffer number for reuse
	lazygit_bufnr = vim.api.nvim_get_current_buf()

	-- Set a clean buffer name
	vim.api.nvim_buf_set_name(lazygit_bufnr, "lazygit")

	-- Set up lazygit-specific mappings and autocommand
	vim.schedule(function()
		local opts = { buffer = true, silent = true }
		-- Lazygit-specific: use Ctrl+G to exit terminal mode (avoids Esc debounce)
		vim.keymap.set("t", "<C-g>", [[<C-\><C-n>]], opts)

		-- Close buffer when terminal process exits
		vim.api.nvim_create_autocmd("TermClose", {
			buffer = vim.api.nvim_get_current_buf(),
			callback = function()
				vim.cmd("bdelete!")
			end,
		})
	end)

	vim.cmd("startinsert")
end, { desc = "Lazygit (buffer)" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
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

-- LSP (buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local function bufmap(mode, lhs, rhs, desc)
			map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Navigation (Telescope)
		local telescope = require("telescope.builtin")
		bufmap("n", "gt", telescope.lsp_type_definitions, "Telescope type defs")
		bufmap("n", "gd", telescope.lsp_definitions, "Telescope LSP definitions")
		bufmap("n", "gr", telescope.lsp_references, "Telescope LSP references")
		bufmap("n", "gi", telescope.lsp_implementations, "Telescope LSP implementation")

		bufmap("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
		bufmap("n", "K", function()
			vim.lsp.buf.hover({ focus = false })
		end, "LSP hover")

		-- Actions
		bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
		bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code actions")

		-- Symbols (Telescope)
		bufmap("n", "<leader>ds", telescope.lsp_document_symbols, "Telescope document symbols")
		bufmap("n", "<leader>ws", telescope.lsp_workspace_symbols, "Telescope workspace symbols")

		-- Diagnostics
		bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
		bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
		bufmap("n", "<leader>di", vim.diagnostic.open_float, "Line diagnostics")
		bufmap("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics list")
	end,
})
