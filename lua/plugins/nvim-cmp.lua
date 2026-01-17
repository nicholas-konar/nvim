-- lua/plugins/cmp.lua
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	enabled = true,
	dependencies = {
		-- completion sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",

		-- snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local float_winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"
		local menu_winhighlight =
			"Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None,Pmenu:NormalFloat"

		-- load VS Code–style snippet collections
		pcall(function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end)

		-- labels for completion sources
		local source_labels = {
			nvim_lsp = "[LSP]",
			nvim_lua = "[API]",
			luasnip = "[Snip]",
			buffer = "[Buf]",
			path = "[Path]",
		}

		return {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			preselect = cmp.PreselectMode.Item,

			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			view = {
				entries = "custom",
			},

			window = {
				completion = cmp.config.window.bordered({
					border = "single",
					winhighlight = menu_winhighlight,
				}),
				documentation = cmp.config.window.bordered({
					border = "single",
					winhighlight = float_winhighlight,
				}),
			},

			mapping = cmp.mapping.preset.insert({
				-- navigate completion items and snippet jumps
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),

				-- documentation and control
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				cmp.mapping.scroll_docs(""),
			}),

			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
			},

			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item.menu = source_labels[entry.source.name] or ""
					return vim_item
				end,
			},
		}
	end,
	config = function(_, opts)
		local cmp = require("cmp")

		cmp.setup(opts)

		cmp.setup.filetype("lua", {
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "path" },
				-- { name = "buffer" },
			},
		})
	end,
}
