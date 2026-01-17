return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 200,
				ignore_whitespace = true,
			},
		})
		vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
	end,
}
