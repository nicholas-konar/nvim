return {
	"neovim/nvim-lspconfig",
	config = function()
		local util = require("lspconfig.util")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Prefer workspace TypeScript when available
		local function get_tsdk(root_dir)
			return vim.fs.find("node_modules/typescript/lib", {
				path = root_dir,
				upward = true,
			})[1]
		end

		local servers = {
			lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},

			ts_ls = {
				capabilities = capabilities,

				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local root =
						util.root_pattern("tsconfig.json", "tsconfig.*.json", "jsconfig.json", "package.json", ".git")(
							fname
						)

					on_dir(root or vim.fn.getcwd())
				end,

				on_new_config = function(new_config, new_root_dir)
					local tsdk = get_tsdk(new_root_dir)
					if tsdk then
						new_config.init_options = new_config.init_options or {}
						new_config.init_options.tsserver = new_config.init_options.tsserver or {}
						new_config.init_options.tsserver.tsdk = tsdk
					end
				end,
			},
		}

		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end
	end,
}
