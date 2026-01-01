return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<M-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm (floating)" },
		{ "<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm (horizontal)" },
		{ "<M-v>", "<cmd>ToggleTerm direction=vertical<cr>", desc = "ToggleTerm (vertical)" },
	},
	opts = {
		direction = "float", -- default direction for :ToggleTerm / <C-\>
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		shade_terminals = true,
		close_on_exit = true,
		float_opts = {
			border = "rounded",
			winblend = 0,
		},
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
			return 20
		end,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				local opts = { buffer = true, silent = true }

				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

				vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
				vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
				vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
				vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

				vim.keymap.set("t", "<M-\\>", "<cmd>ToggleTerm direction=float<cr>", opts)
				vim.keymap.set("t", "<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
				vim.keymap.set("t", "<M-v>", "<cmd>ToggleTerm direction=vertical<cr>", opts)
			end,
		})
	end,
}
