vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP keymaps",
	callback = function(event)
		local map = vim.keymap.set
		local opts = { buffer = event.buf }

		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP Rename" }))
		map("n", "gd", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "LSP: go to implementation" }))
		map("n", "gD", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: go to definition" }))
	end,
})
