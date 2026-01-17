return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("solarized-osaka").setup({
			transparent = false,
			dim_inactive = true,
			on_highlights = function(hl, c)
				hl.NormalNC = { bg = c.bg }

				hl.LineNr = { fg = c.base01 }
				hl.LineNrAbove = { fg = c.base02 }
				hl.LineNrBelow = { fg = c.base02 }
				hl.CursorLineNr = { fg = c.base1, bold = true }

				-- nvim-cmp groups
				hl.CmpItemAbbrMatch = { fg = c.yellow500, bold = true }
				hl.CmpItemAbbrMatchFuzzy = { fg = c.yellow500, bold = true }
				hl.CmpItemKindText = { fg = c.cyan500 }
				hl.CmpItemKindVariable = { fg = c.blue500 }
				hl.CmpItemKindClass = { fg = c.yellow500 }
				hl.CmpItemKindFunction = { fg = "#cb4b16" }
				hl.CmpItemKindMethod = { fg = "#d33682" }
				hl.CmpItemKindKeyword = { fg = c.green500 }
				hl.CmpItemKindField = { fg = "#6c71c4" }
				hl.CmpItemKindProperty = { fg = c.cyan500 }
				hl.CmpItemKindInterface = { fg = c.blue500 }
				hl.CmpItemKindModule = { fg = "#d33682" }
				hl.CmpItemKindStruct = { fg = "#cb4b16" }
				hl.CmpItemKindEnum = { fg = c.green500 }
				hl.CmpItemKindConstant = { fg = c.yellow500 }

				-- treesitter groups (must be accessed via string key)
				hl["@variable.typescript"] = { fg = "#9FACAC" }
				hl["@variable.builtin.typescript"] = { fg = c.green500 }
				hl["@variable.builtin.tsx"] = { fg = c.green500 }
				hl["@keyword.import.typescript"] = { fg = c.green500 }
				hl["@keyword.import.tsx"] = { fg = c.green500 }

				-- lsp global namespaces (e.g. jest)
				hl["@lsp.type.namespace.typescript"] = { fg = "#D33682" }
			end,
		})

		vim.cmd.colorscheme("solarized-osaka")
	end,
}
