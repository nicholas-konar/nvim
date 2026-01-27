return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<leader>\\", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (floating)" },
		{ "<M-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (floating)" },
		{ "<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm (horizontal)" },
		{ "<M-v>", "<cmd>ToggleTerm direction=vertical<cr>", desc = "ToggleTerm (vertical)" },
		{
			"<leader>gg",
			(function()
				local lazygit_term = nil
				return function()
					local path = "~/.config/lazygit/config.nvim.yml"
					vim.env.LG_CONFIG_FILE = vim.fn.expand(path)

					if not lazygit_term then
						local Terminal = require("toggleterm.terminal").Terminal
						lazygit_term = Terminal:new({
							cmd = "lazygit",
							hidden = true,
							direction = "tab",
							on_open = function(term)
								vim.schedule(function()
									-- let lazygit own <Esc>
									vim.keymap.del("t", "<Esc>", { buffer = term.bufnr })
									vim.keymap.del("t", "<Esc><Esc>", { buffer = term.bufnr })
								end)
							end,
						})
					end

					lazygit_term:toggle()
				end
			end)(),
			desc = "Lazygit (ToggleTerm tab)",
		},
	},
	opts = {
		direction = "float",
		start_in_insert = true,
		persist_mode = false, -- if toggled off in normal mode, toggle on in terminal mode
		insert_mappings = true,
		terminal_mappings = true,
		shade_terminals = false,
		close_on_exit = true,
		float_opts = {
			border = "rounded",
			winblend = 0,
			height = math.floor(vim.o.lines * 0.8),
			width = math.floor(vim.o.columns * 0.95),
		},
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			else
				return 20
			end
		end,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				local opts = { buffer = true, silent = true }

				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<Esc><Esc>", "<cmd>ToggleTerm<cr>", opts)

				vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
				vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
				vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
				vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

				-- redundant keymaps scoped to terminal for toggling off while still in terminal mode
				vim.keymap.set("t", "<M-\\>", "<cmd>ToggleTerm direction=float<cr>", opts)
				vim.keymap.set("t", "<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
				vim.keymap.set("t", "<M-v>", "<cmd>ToggleTerm direction=vertical<cr>", opts)
			end,
		})
	end,
}
