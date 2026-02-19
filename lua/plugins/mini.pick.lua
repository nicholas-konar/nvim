return {
	"nvim-mini/mini.pick",
	version = "*",
	config = function()
		local MiniPick = require("mini.pick")

		-- Setup with custom mappings: j/k for navigation
		MiniPick.setup({
			mappings = {
				move_down = "j",
				move_up = "k",
				toggle_preview = "<C-p>",
				toggle_info = "<C-i>",
			},
		})

		-- Override vim.ui.select with custom window sizing
		vim.ui.select = function(items, opts, on_choice)
			local item_count = #items
			-- Dynamic height: number of items + 2 for padding, capped at screen size
			local height = math.min(item_count + 2, vim.o.lines - 4)
			local width = 80

			-- Center the window on screen
			local col = math.floor((vim.o.columns - width) / 2)
			local row = math.floor((vim.o.lines - height) / 2)

			local start_opts = {
				window = {
					config = {
						anchor = "NW",
						height = height,
						width = width,
						row = row,
						col = col,
						border = "rounded",
					},
				},
			}

			return MiniPick.ui_select(items, opts, on_choice, start_opts)
		end
	end,
}
