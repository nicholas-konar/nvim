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

				-- mini.tabline hooks into these links
				hl.TabLineCurrent = { bg = c.base03 }
				hl.TabLineVisible = { bg = c.base04 }
				hl.TabLineHidden = { bg = c.base04 }

				hl.TabLineModifiedCurrent = { bg = c.base03, italic = true, underline = true }
				hl.TabLineModifiedVisible = { bg = c.base04, italic = true, underline = true }
				hl.TabLineModifiedHidden = { bg = c.base04, italic = true, underline = true }
			end,
		})

		vim.cmd.colorscheme("solarized-osaka")
	end,
}

-- base0 = "#9eabac",
-- base00 = "#637981",
-- base01 = "#576d74",
-- base02 = "#063540",
-- base03 = "#002c38",
-- base04 = "#001419",
-- base1 = "#adb7b7",
-- base2 = "#ede7d3",
-- base3 = "#fdf5e2",
-- base4 = "#ffffff",
-- bg = "#001419",
-- bg_float = "#001419",
-- bg_highlight = "#002c38",
-- bg_popup = "#001419",
-- bg_sidebar = "#001419",
-- bg_statusline = "#002c38",
-- black = "#001014",
-- blue = "#268bd3",
-- blue100 = "#a8daff",
-- blue300 = "#46acf5",
-- blue500 = "#268bd3",
-- blue700 = "#1a6397",
-- blue900 = "#0f3856",
-- border = "#001014",
-- cyan = "#29a298",
-- cyan100 = "#b7fefa",
-- cyan300 = "#2aeddd",
-- cyan500 = "#29a298",
-- cyan700 = "#1a6265",
-- cyan900 = "#103a3c",
-- error = "#db302d",
-- fg = "#839395",
-- fg_float = "#839395",
-- green = "#849900",
-- green100 = "#d6fead",
-- green300 = "#b7f900",
-- green500 = "#849900",
-- green700 = "#586600",
-- green900 = "#2c3300",
-- hint = "#29a298",
-- info = "#268bd3",
-- magenta = "#d23681",
-- magenta100 = "#ff75b7",
-- magenta300 = "#f254a0",
-- magenta500 = "#d23681",
-- magenta700 = "#af2668",
-- magenta900 = "#541131",
-- none = "NONE",
-- orange = "#c94c16",
-- orange100 = "#ff9165",
-- orange300 = "#f74f0c",
-- orange500 = "#c94c16",
-- orange700 = "#a13c10",
-- orange900 = "#5b220a",
-- red = "#db302d",
-- red100 = "#ff9a99",
-- red300 = "#f55350",
-- red500 = "#db302d",
-- red700 = "#b7211f",
-- red900 = "#570f0e",
-- todo = "#6d71c4",
-- violet = "#6d71c4",
-- violet100 = "#cccffe",
-- violet300 = "#9b9fec",
-- violet500 = "#6d71c4",
-- violet700 = "#484eb6",
-- violet900 = "#24275a",
-- warning = "#b28500",
-- yellow = "#b28500",
-- yellow100 = "#ffe899",
-- yellow300 = "#ffbf00",
-- yellow500 = "#b28500",
-- yellow700 = "#664c00",
-- yellow900 = "#332700"
--
