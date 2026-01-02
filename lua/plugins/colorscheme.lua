return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized-osaka").setup({
				transparent = false,
				dim_inactive = true,
				on_highlights = function(hl, c)
					hl.NormalNC = { bg = "#001116" }
				end,
			})

			vim.cmd.colorscheme("solarized-osaka")

			vim.api.nvim_set_hl(0, "LineNr", {
				fg = "#586e75", -- base01 (muted)
			})

			vim.api.nvim_set_hl(0, "CursorLineNr", {
				fg = "#93a1a1", -- base1
				bold = true,
			})

			vim.api.nvim_set_hl(0, "LineNrAbove", {
				fg = "#073642", -- base02 (very subtle)
			})

			vim.api.nvim_set_hl(0, "LineNrBelow", {
				fg = "#073642", -- base02
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
	},
}
