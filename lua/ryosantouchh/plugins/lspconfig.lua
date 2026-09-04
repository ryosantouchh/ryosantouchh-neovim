return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "simrat39/rust-tools.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- capabilities: tell servers we support nvim-cmp completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic signs (replaces lsp_zero.set_sign_icons)
      local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Keymaps + autoformat on attach (replaces lsp_zero.on_attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
          vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "x" }, "<F3>", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "gx", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gj", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, opts)

          -- format on save, if the client supports it
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
              end,
            })
          end
        end,
      })

      -- Per-server config overrides
      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("ts_ls", {
        root_dir = lspconfig.util.root_pattern(
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json"
        ),
      })

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              kubernetes = "*.k8s.yaml",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            },
            validate = true,
            completion = true,
            hover = true,
            format = {
              enable = true,
            },
          },
        },
      })

      vim.lsp.config("dcmls", {
        cmd = { "dcm", "start-server" },
        filetypes = { "dart", "yaml" },
      })

      vim.lsp.config("dartls", {
        cmd = { "dart", "language-server", "--protocol=lsp" },
      })

      vim.lsp.config("golangci_lint_ls", {
        filetypes = { "go", "gomod" },
      })

      vim.lsp.config("ruby_lsp", {
        filetypes = { "ruby", "eruby" },
        formatter = "auto",
      })

      vim.lsp.config("terraformls", {
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "terraform-vars", "tf" },
        root_markers = { ".terraform", ".git" },
      })

      vim.lsp.config("solidity", {
        cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
      })

      -- lua_ls: point at Neovim's runtime so it understands vim.* globals
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      local ensure_installed = {
        "gopls",
        "terraformls",
        "ts_ls",
        "vtsls",
        "biome",
        "quick_lint_js",
        "html",
        "cssls",
        "cssmodules_ls",
        "unocss",
        "tailwindcss",
        "rust_analyzer",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "spectral",
        "vacuum",
        "yamlls",
        "prismals",
        "sqlls",
        "astro",
        "lua_ls",
      }

      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })

      vim.lsp.enable(ensure_installed)
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = true,
  },
}

-- return {
--   {
--     "VonHeikemen/lsp-zero.nvim",
--     branch = "v3.x",
--     lazy = true,
--     config = false,
--     init = function()
--       -- Disable automatic setup, we are doing it manually
--       vim.g.lsp_zero_extend_cmp = 0
--       vim.g.lsp_zero_extend_lspconfig = 0
--     end,
--   },
--   {
--     "williamboman/mason.nvim",
--     lazy = true,
--     config = true,
--   },
--   {
--     "neovim/nvim-lspconfig",
--     cmd = "LspInfo",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       { "hrsh7th/cmp-nvim-lsp" },
--       { "williamboman/mason-lspconfig.nvim" },
--       -- { "kkharji/lspsaga.nvim" },
--       -- { "nvimdev/lspsaga.nvim" },
--       { "simrat39/rust-tools.nvim" }
--     },
--     config = function()
--       -- This is where all the LSP shenanigans will live
--       local lsp_zero = require("lsp-zero")
--       local mason_lspconfig = require("mason-lspconfig")
--       local lspconfig = require("lspconfig")
--       -- local lspsaga = require("lspsaga")
--       lsp_zero.extend_lspconfig()
--
--       lsp_zero.on_attach(function(client, bufnr)
--         -- see :help lsp-zero-keybindings
--         -- to learn the available actions
--         local opts = { buffer = bufnr }
--
--         lsp_zero.default_keymaps(opts)
--         vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>")
--         vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, {silent = true, noremap = true})
--         vim.keymap.set("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--         vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
--         vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
--         -- vim.keymap.set("n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
--         -- vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
--         -- vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
--
--         lsp_zero.buffer_autoformat()
--       end)
--
--       -- (Optional) Configure lua language server for neovim
--       lsp_zero.set_sign_icons({
--         error = "✘",
--         warn = "▲",
--         hint = "⚑",
--         info = "»",
--       })
--
--       vim.lsp.config("ts_ls", {
--         root_dir = lspconfig.util.root_pattern(
--           '.eslintrc',
--           '.eslintrc.js',
--           '.eslintrc.cjs',
--           '.eslintrc.yaml',
--           '.eslintrc.yml',
--           '.eslintrc.json'
--             -- Disabled to prevent "No ESLint configuration found" exceptions
--             -- 'package.json',
--           ), 
--       })
--
--       -- lspconfig.ts_ls.setup({
--       --   root_dir = lspconfig.util.root_pattern(
--       --     '.eslintrc',
--       --     '.eslintrc.js',
--       --     '.eslintrc.cjs',
--       --     '.eslintrc.yaml',
--       --     '.eslintrc.yml',
--       --     '.eslintrc.json'
--       --       -- Disabled to prevent "No ESLint configuration found" exceptions
--       --       -- 'package.json',
--       --     ), 
--       -- })
--       --
--       
--       vim.lsp.config("dcmls", {
--        	capabilities = capabilities,
--        	cmd = {
--        		"dcm",
--        		"start-server",
--        	},
--        	filetypes = { "dart", "yaml" },
--       })
--
--       -- lspconfig.dcmls.setup({
--       --  	capabilities = capabilities,
--       --  	cmd = {
--       --  		"dcm",
--       --  		"start-server",
--       --  	},
--       --  	filetypes = { "dart", "yaml" },
--       -- })
--
--       vim.lsp.config("dartls", {
--         capabilities = capabilities,
--         cmd = { "dart", "language-server", "--protocol=lsp" },
--       })
--
--       -- lspconfig.dartls.setup({
--       --   capabilities = capabilities,
--       --   cmd = { "dart", "language-server", "--protocol=lsp" },
--       -- })
--
--       vim.lsp.config("rust_analyzer", {
--        	capabilities = capabilities,
--       })
--
--       -- lspconfig.rust_analyzer.setup({
--       --   capabilities = capabilities,
--       -- })
--
--       vim.lsp.config("golangci_lint_ls", {
--         filetypes = { "go", "gomod" },
--       })
--
--       vim.lsp.config("ruby_lsp", {
--         filetypes = { "ruby", "eruby" },
--         formatter = "auto"
--       })
--
--       vim.lsp.config('terraformls', {
--         cmd = { 'terraform-ls', 'serve' },
--         filetypes = { 'terraform', 'terraform-vars', 'tf' },
--         root_markers = { '.terraform', '.git' },
--       })
--
--       -- lspconfig.golangci_lint_ls.setup({
--       --   filetypes = { "go", "gomod" },
--       -- })
--
--       vim.lsp.config("solidity", {
--         cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
--         filetypes = { 'solidity' },
--         root_dir = lspconfig.util.find_git_ancestor,
--         single_file_support = true,
--       })
--
--       -- lspconfig.solidity.setup({
--       --   cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
--       --   filetypes = { 'solidity' },
--       --   root_dir = lspconfig.util.find_git_ancestor,
--       --   single_file_support = true,
--       -- })
--
--       mason_lspconfig.setup({
--         ensure_installed = {
--           -- golang
--           "gopls",
--           -- "golangci_lint_ls",
--           'terraformls',
--
--           -- typescript/javascript
--           "ts_ls",
--           "vtsls",
--           "biome",
--           "quick_lint_js",
--
--           -- frontend core
--           "html",
--           "cssls",
--           "cssmodules_ls",
--           "unocss",
--           "tailwindcss",
--
--           "rust_analyzer",
--
--           -- docker
--           "dockerls",
--           "docker_compose_language_service",
--
--           "eslint",
--           -- "eslint_d",
--
--           -- haskell
--           -- "hls",
--
--           -- openapi/yaml
--           "spectral",
--           "vacuum",
--           -- "hydra_lsp",
--           "yamlls",
--
--           "prismals", -- prisma
--
--           -- sql
--           "sqlls",
--           -- "sqls",
--
--           -- astro
--           "astro",
--
--
--           -- solidity
--         },
--         automatic_installation = true,
--         handlers = {
--           lsp_zero.default_setup,
--           lua_ls = function()
--             local lua_opts = lsp_zero.nvim_lua_ls()
--             lspconfig.lua_ls.setup(lua_opts)
--           end,
--         },
--       })
--     end,
--   },
--   -- {
--   --   "rust-lang/rust.vim",
--   --   ft = "rust",
--   --   init = function()
--   --     vim.g.rustfmt_autosave = 1
--   --   end
--   -- },
--   {
--     "mrcjkb/rustaceanvim",
--     version = '^5',
--     lazy = true,
--   },
-- }
