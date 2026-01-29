return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFocus",
		"NvimTreeClose",
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
		{ "<leader>o", "<cmd>NvimTreeFindFile<cr>", desc = "Open nvim-tree" },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close parent directory"))
			vim.keymap.set("n", "l", api.node.open.preview, opts("Open"))
		end,

		hijack_cursor = true,
		respect_buf_cwd = true,
		sync_root_with_cwd = true,
		reload_on_bufenter = false,

		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = {},
		},

		update_focused_file = {
			enable = true,
			update_root = false,
		},

		view = {
			width = 38,
			side = "left",
			preserve_window_proportions = true,
		},

		renderer = {
			root_folder_label = false,
			highlight_git = true,
			highlight_opened_files = "name",
			indent_markers = { enable = true },
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
			},
		},

		filters = {
			dotfiles = false,
			git_ignored = false,
		},

		git = {
			enable = true,
			ignore = false,
		},

		actions = {
			open_file = {
				quit_on_open = false,
				resize_window = true,
			},
			file_popup = {
				open_win_config = {
					border = "rounded",
				},
			},
		},

		diagnostics = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeFileRenamed",
			callback = function()
				pcall(vim.lsp.codelens.refresh)
			end,
		})
	end,
}
