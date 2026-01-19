return {
	{
		"nvim-mini/mini.files",
		version = "*",
		keys = {
			{
				"<leader>e",
				function()
					local minifiles = require("mini.files")
					local path = vim.api.nvim_buf_get_name(0)
					minifiles.open(path)
					minifiles.reveal_cwd()
				end,
				desc = "MiniFiles.open()",
			},
		},
		config = function()
			require("mini.files").setup()
			require("cmp").setup.filetype("minifiles", { enabled = false })
		end,
	},
}
