return {
	"rcarriga/nvim-notify",
	lazy = false,
	config = function()
		local notify = require("notify")

		notify.setup({
			max_width = 60,
			max_height = 15,
			position = "top_right",
			timeout = 3000,
			stages = "fade_in_slide_out",
		})

		vim.notify = notify

		-- View notification history with Telescope
		vim.keymap.set("n", "<leader>fn", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Find notifications" })
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
}
