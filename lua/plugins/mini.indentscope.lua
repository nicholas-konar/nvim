return {
	"nvim-mini/mini.indentscope",
	version = "*",
	config = function()
		require("mini.indentscope").setup({
			symbol = "│",
			options = {
				try_as_border = true,
				indent_at_cursor = false,
				border = "top",
			},
		})
	end,
}
