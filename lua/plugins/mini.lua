return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			vim.o.background = "dark"
			vim.cmd.colorscheme("minispring")
		end,
	},
}
