return {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- Patch deprecated vim.lsp.get_active_clients() -> vim.lsp.get_clients()
		local lfo = require("lsp-file-operations")
		local original_on_rename = lfo.on_rename

		lfo.on_rename = function(ctx)
			-- Replace deprecated function call
			local old_get_active_clients = vim.lsp.get_active_clients
			vim.lsp.get_active_clients = vim.lsp.get_clients

			local success, result = pcall(original_on_rename, ctx)

			-- Restore if it existed
			if old_get_active_clients then
				vim.lsp.get_active_clients = old_get_active_clients
			end

			if not success then
				error(result)
			end
			return result
		end

		lfo.setup()
	end,
}
