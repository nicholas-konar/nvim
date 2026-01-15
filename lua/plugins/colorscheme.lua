return {
	"craftzdog/solarized-osaka.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		require("solarized-osaka").setup({
			transparent = false,
			dim_inactive = true,
			on_highlights = function(hl, c)
				hl.NormalNC = { bg = "#001116" }
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
			end,
		})

		vim.cmd.colorscheme("solarized-osaka")

		vim.api.nvim_set_hl(0, "LineNr", {
			fg = "#586e75", -- base01 (muted)
		})

		vim.api.nvim_set_hl(0, "CursorLineNr", {
			fg = "#93a1a1", -- base1
			bold = true,
		})

		vim.api.nvim_set_hl(0, "LineNrAbove", {
			fg = "#073642", -- base02 (very subtle)
		})

		vim.api.nvim_set_hl(0, "LineNrBelow", {
			fg = "#073642", -- base02
		})

		-- TypeScript: variable identifiers (Tree-sitter)
		vim.api.nvim_set_hl(0, "@variable.typescript", { fg = "#9FACAC" })

		-- TypeScript/TSX: imports and global test identifiers
		vim.api.nvim_set_hl(0, "@keyword.import.typescript", { fg = "#859800" })
		vim.api.nvim_set_hl(0, "@keyword.import.tsx", { fg = "#859800" })
		vim.api.nvim_set_hl(0, "@variable.builtin.typescript", { fg = "#859800" })
		vim.api.nvim_set_hl(0, "@variable.builtin.tsx", { fg = "#859800" })

		-- TypeScript: global namespace (e.g. jest via LSP semantic tokens)
		vim.api.nvim_set_hl(0, "@lsp.type.namespace.typescript", { fg = "#D33682" })
	end,
}
