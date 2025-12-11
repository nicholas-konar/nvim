return {
	{
		"mason-org/mason.nvim",
		opts = {
			log_level = vim.log.levels.DEBUG,
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"black",
			},
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 12,
		},
	},
}
