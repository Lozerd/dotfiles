return {
	"saghen/blink.cmp",
	lazy = false,
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"L3MON4D3/LuaSnip",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			ghost_text = { enabled = true, show_without_menu = true },
			trigger = {
				show_on_trigger_character = true,
				show_on_insert_on_trigger_character = true,
			},
			list = {
				cycle = {
					from_top = true,
					from_bottom = true,
				},
			},
			menu = {
				auto_show = false,
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,
						},
					},
				},
			},
		},
		keymap = {
			["<C-Space>"] = { "show" },
			["<C-e>"] = { "hide" },
			["<Tab>"] = { "accept", "fallback" },
			["<C-b>"] = {
				function(cmp)
					cmp.scroll_documentation_down(4)
				end,
			},
			["<C-f>"] = {
				function(cmp)
					cmp.scroll_documentation_up(4)
				end,
			},
			["<C-p>"] = { "select_prev" },
			["<C-n>"] = { "select_next" },
			["<S-Tab>"] = nil,
		},
		sources = {
			default = {
				-- "lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			-- per_filetype = {
			-- 	sql = { "dadbod" },
			-- 	lua = { inherit_defaults = true, "lazydev" },
			-- },
			-- providers = {
			-- 	-- lsp = { async = true, score_offset = 50 },
			-- 	dadbod = { module = "vim_dadbod_completion.blink" },
			-- 	-- lazydev = {
			-- 	-- 	name = "LazyDev",
			-- 	-- 	module = "lazydev.integrations.blink",
			-- 	-- 	score_offset = 100,
			-- 	-- },
			-- },
		},
	},
	config = function(_, opts)
		require("blink-cmp").setup(opts)
		require("lspkind").init({
			mode = "symbol",
			preset = "codicons",
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		})
	end,
}
