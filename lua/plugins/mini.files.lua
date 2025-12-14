return {
	{
		"nvim-mini/mini.files",
		version = "*",
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "MiniFiles.open()",
			},
		},
		config = function()
			require("mini.files").setup()
		end,
	},
}
