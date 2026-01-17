return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("solarized-osaka").setup({
			transparent = false,
			dim_inactive = true,
			on_highlights = function(hl, c)
				hl.NormalNC = { bg = "#001116" }

				hl.LineNr = { fg = "#586e75" } -- base01 (muted)
				hl.LineNrAbove = { fg = "#073642" } -- base02 (very subtle)
				hl.LineNrBelow = { fg = "#073642" } -- base02
				hl.CursorLineNr = { fg = "#93a1a1", bold = true } -- base1

				-- nvim-cmp groups
				hl.CmpItemAbbrMatch = { fg = "#b58900", bold = true }
				hl.CmpItemAbbrMatchFuzzy = { fg = "#b58900", bold = true }
				hl.CmpItemKindText = { fg = "#2aa198" }
				hl.CmpItemKindVariable = { fg = "#268bd2" }
				hl.CmpItemKindClass = { fg = "#b58900" }
				hl.CmpItemKindFunction = { fg = "#cb4b16" }
				hl.CmpItemKindMethod = { fg = "#d33682" }
				hl.CmpItemKindKeyword = { fg = "#859900" }
				hl.CmpItemKindField = { fg = "#6c71c4" }
				hl.CmpItemKindProperty = { fg = "#2aa198" }
				hl.CmpItemKindInterface = { fg = "#268bd2" }
				hl.CmpItemKindModule = { fg = "#d33682" }
				hl.CmpItemKindStruct = { fg = "#cb4b16" }
				hl.CmpItemKindEnum = { fg = "#859900" }
				hl.CmpItemKindConstant = { fg = "#b58900" }

				-- treesitter groups (must be accessed via string key)
				hl["@variable.typescript"] = { fg = "#9FACAC" }
				hl["@variable.builtin.typescript"] = { fg = "#859800" }
				hl["@variable.builtin.tsx"] = { fg = "#859800" }
				hl["@keyword.import.typescript"] = { fg = "#859800" }
				hl["@keyword.import.tsx"] = { fg = "#859800" }

				-- lsp global namespaces (e.g. jest)
				hl["@lsp.type.namespace.typescript"] = { fg = "#D33682" }
			end,
		})

		vim.cmd.colorscheme("solarized-osaka")
	end,
}
