return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    snippets = { preset = "luasnip" },

    keymap = {
      preset = "none", -- no implicit binds, everything explicit

      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },

      ["<C-f>"] = { "snippet_forward", "fallback" },
      ["<C-b>"] = { "snippet_backward", "fallback" },

      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },

    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
        max_items = 50,
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "label",      "label_description", gap = 1 },
            { "kind_icon",  "kind",              gap = 1 },
            { "source_name" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500, -- only renders if you REST on an item
      },
      ghost_text = { enabled = false },
    },

    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
      providers = {
        lsp = { name = "LSP" },
        snippets = { name = "Snip", min_keyword_length = 2 },
        buffer = { name = "Buf", min_keyword_length = 3, score_offset = -3 },
        path = { name = "Path" },
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = { menu = { auto_show = true } },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

-- return {
--
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-buffer", -- source for text in buffer
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-cmdline",
--     "hrsh7th/cmp-path",             -- source for file system paths
--     "L3MON4D3/LuaSnip",             -- snippet engine
--     "saadparwaiz1/cmp_luasnip",     -- for autocompletion
--     "rafamadriz/friendly-snippets", -- useful snippets
--   },
--   config = function()
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")
--
--     -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     -- -- Tab / Shift-Tab that fall through: cmp select -> luasnip jump -> literal tab
--     local supertab = function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end
--
--     local shift_supertab = function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end
--
--     -- Small icon per source, replaces lsp-zero's cmp_format({ details = true }).
--     -- Install "onsails/lspkind.nvim" later if you want real glyph icons instead.
--     local source_menu = {
--       nvim_lsp = "[LSP]",
--       nvim_lua = "[Lua]",
--       luasnip = "[Snip]",
--       buffer = "[Buf]",
--       path = "[Path]",
--     }
--
--     cmp.setup({
--       performance = {
--         debounce = 20,
--         throttle = 10,
--         fetching_timeout = 100, -- default 500; a slow source shouldn't block the menu
--         max_view_entries = 30, -- only render 30 rows
--       },
--       completion = {
--         completeopt = "menu,menuone,preview,noselect",
--       },
--       snippet = { -- configure how nvim-cmp interacts with snippet engine
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<S-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
--         ["<S-j>"] = cmp.mapping.select_next_item(), -- next suggestion
--         ["<C-b>"] = cmp.mapping(function()
--           if luasnip.jumpable(1) then
--             luasnip.jump(1)
--           end
--         end, { "i", "s" }),
--         ["<C-f>"] = cmp.mapping(function()
--           if luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           end
--         end, { "i", "s" }),
--         ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
--         ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<Tab>"] = cmp.mapping(supertab, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(shift_supertab, { "i", "s" }),
--       }),
--       -- sources for autocompletion
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "luasnip" }, -- snippets
--         { name = "buffer" },  -- text within current buffer
--         { name = "path" },    -- file system paths
--       }),
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       formatting = {
--         fields = { "abbr", "kind", "menu" },
--         format = function(entry, item)
--           item.menu = source_menu[entry.source.name]
--           return item
--         end,
--       },
--     })
--
--     -- `:` cmdline setup.
--     cmp.setup.cmdline(":", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = "path" },
--       }, {
--         {
--           name = "cmdline",
--           option = {
--             ignore_cmds = { "Man", "!" },
--           },
--         },
--       }),
--     })
--   end,
-- }

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-buffer", -- source for text in buffer
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-cmdline",
--     "hrsh7th/cmp-path",           -- source for file system paths
--     "L3MON4D3/LuaSnip",           -- snippet engine
--     "saadparwaiz1/cmp_luasnip",   -- for autocompletion
--     "rafamadriz/friendly-snippets", -- useful snippets
--     "VonHeikemen/lsp-zero.nvim",
--   },
--   config = function()
--     local cmp = require("cmp")
--     local cmp_format = require("lsp-zero").cmp_format({ details = true })
--     local cmp_action = require("lsp-zero").cmp_action()
--     local luasnip = require("luasnip")
--
--     -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     cmp.setup({
--       completion = {
--         completeopt = "menu,menuone,preview,noselect",
--       },
--       snippet = { -- configure how nvim-cmp interacts with snippet engine
--         expand = function(args)
--           if not luasnip then
--             return
--           end
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<S-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
--         ["<S-j>"] = cmp.mapping.select_next_item(), -- next suggestion
--         ["<C-b>"] = cmp_action.luasnip_jump_forward(),
--         ["<C-f>"] = cmp_action.luasnip_jump_backward(),
--         ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
--         ["<C-e>"] = cmp.mapping.abort(),    -- close completion window
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<Tab>"] = cmp_action.luasnip_supertab(),
--         ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
--       }),
--       -- sources for autocompletion
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "luasnip" }, -- snippets
--         { name = "buffer" }, -- text within current buffer
--         { name = "path" }, -- file system paths
--       }),
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       -- configure lspkind for vs-code like pictograms in completion menu
--       formatting = cmp_format,
--     })
--
--     -- `:` cmdline setup.
--     cmp.setup.cmdline(":", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = "path" },
--       }, {
--         {
--           name = "cmdline",
--           option = {
--             ignore_cmds = { "Man", "!" },
--           },
--         },
--       }),
--     })
--   end,
-- }
