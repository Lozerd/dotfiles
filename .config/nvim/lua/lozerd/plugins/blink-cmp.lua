return {
	"saghen/blink.cmp",
	lazy = false,
	version = "1.*",
	dependencies = {
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						-- Optionally load custom snippets too
						require("luasnip.loaders.from_vscode").lazy_load({
							paths = { vim.fn.stdpath("config") .. "/snippets" },
						})
					end,
				},
			},
		},
		{
			"supermaven-inc/supermaven-nvim",
			config = function(opts)
				local supermaven = require("supermaven-nvim")
				local log = require("supermaven-nvim.logger")

				supermaven.setup(opts)
				-- Disable pesky hardcoded vim.api.nvim_notify in log.warn
				---@diagnostic disable-next-line: unused-local
				local mock = function(msg) end
				log.warn = mock
				log.error = mock
			end,
			opts = {
				log_level = "off",
				disable_inline_completion = true, -- disables inline completion for use with cmp
				disable_keymaps = true, -- disables built in keymaps for more manual control
			},
		},
		{ "huijiro/blink-cmp-supermaven" },
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = {
			preset = "luasnip",
		},
		completion = {
			ghost_text = { enabled = true, show_with_menu = false },
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
			preset = "none",
			["<C-Space>"] = { "show" },
			["<C-e>"] = { "hide" },
			["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward" },
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
		},
		sources = {
			default = {
				-- "lazydev",
				"supermaven",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				supermaven = {
					name = "supermaven",
					module = "blink-cmp-supermaven",
					async = false,
				},
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
