local function telescope(fn)
	return function()
		return require("telescope.builtin")[fn]()
	end
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "*",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
	keys = {
		{
			"<leader>ff",
			telescope("find_files"),
			desc = "Telescope find files",
		},
		{
			"<leader>fo",
			telescope("oldfiles"),
			desc = "Telescope recent files",
		},
		{
			"<leader>fg",
			telescope("live_grep"),
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			telescope("buffers"),
			desc = "Telescope buffers",
		},
		{
			"<leader>fib",
			telescope("current_buffer_fuzzy_find"),
			desc = "Telescope find in current buffer",
		},
		{
			"<leader>fh",
			telescope("help_tags"),
			desc = "Telescope help tags",
		},
		{
			"<leader>fw",
			telescope("grep_string"),
			desc = "Telescope grep string",
		},
	},
	config = function()
		require("telescope").setup({
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})
	end,
}
