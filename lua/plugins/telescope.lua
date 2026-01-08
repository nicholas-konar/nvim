local function telescope(fn)
	return function()
		return require("telescope.builtin")[fn]()
	end
end

return {
	"nvim-telescope/telescope.nvim",
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
			"<leader>fw",
			telescope("live_grep"),
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			telescope("buffers"),
			desc = "Telescope buffers",
		},
		{
			"<leader>fi",
			"<Nop>",
			desc = "Telescope find in ...",
		},
		{
			"<leader>fib",
			telescope("current_buffer_fuzzy_find"),
			desc = "Telescope find in current buffer",
		},
		{
			"<leader>fm",
			telescope("marks"),
			desc = "Telescope find marks",
		},
		{
			"<leader>fh",
			telescope("help_tags"),
			desc = "Telescope help tags",
		},
		{
			"<leader>fs",
			telescope("grep_string"),
			desc = "Telescope grep string",
		},
		{
			"<leader>fg",
			"<Nop>",
			desc = "Telescope git",
		},
		{
			"<leader>fgs",
			telescope("git_status"),
			desc = "Telescope git status",
		},
		{
			-- might want to make this default, and wire in fallback logic for non-git directories
			"<leader>fgf",
			telescope("git_files"),
			desc = "Telescope git files",
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
