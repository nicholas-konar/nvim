return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		priority = 1000,
		config = function()
			require("nvim-treesitter").setup({})

			pcall(function()
				require("nvim-treesitter").install({
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"yaml",
					"html",
					"css",
				})
			end)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"lua",
					"vim",
					"bash",
					"javascript",
					"typescript",
					"typescriptreact",
					"javascriptreact",
					"tsx",
					"json",
					"yaml",
					"html",
					"css",
				},
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"lua",
					"javascript",
					"typescript",
					"typescriptreact",
					"javascriptreact",
					"tsx",
					"json",
					"html",
					"css",
				},
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						-- ["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
				-- swap has no config table in the new README; just keymaps calling swap module
			})

			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end, { desc = "TS: function outer" })

			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end, { desc = "TS: function inner" })

			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end, { desc = "TS: class outer" })

			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end, { desc = "TS: class inner" })

			vim.keymap.set({ "x", "o" }, "aa", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
			end, { desc = "TS: param outer" })

			vim.keymap.set({ "x", "o" }, "ia", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
			end, { desc = "TS: param inner" })

			-- Move (normal)
			vim.keymap.set("n", "]m", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end, { desc = "TS: next function" })

			vim.keymap.set("n", "[m", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end, { desc = "TS: prev function" })

			-- Swap params (normal)
			vim.keymap.set("n", "<leader>a", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end, { desc = "TS: swap param next" })

			vim.keymap.set("n", "<leader>A", function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
			end, { desc = "TS: swap param prev" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
}
