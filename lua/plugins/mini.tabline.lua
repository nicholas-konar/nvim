return {
	"nvim-mini/mini.tabline",
	version = false,
	config = function()
		require("mini.tabline").setup()
		local hl = vim.api.nvim_set_hl

		hl(0, "MiniTablineCurrent", { link = "TabLineCurrent" })
		hl(0, "MiniTablineVisible", { link = "TabLineVisible" })
		hl(0, "MiniTablineHidden", { link = "TabLineHidden" })

		hl(0, "MiniTablineModifiedCurrent", { link = "TabLineModifiedCurrent" })
		hl(0, "MiniTablineModifiedVisible", { link = "TabLineModifiedVisible" })
		hl(0, "MiniTablineModifiedHidden", { link = "TabLineModifiedHidden" })
	end,
}
