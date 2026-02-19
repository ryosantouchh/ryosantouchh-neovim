return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
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
      -- { "kkharji/lspsaga.nvim" },
      -- { "nvimdev/lspsaga.nvim" },
      { "simrat39/rust-tools.nvim" }
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      -- local lspsaga = require("lspsaga")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        local opts = { buffer = bufnr }

        lsp_zero.default_keymaps(opts)
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>")
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, {silent = true, noremap = true})
        vim.keymap.set("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        -- vim.keymap.set("n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
        -- vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
        -- vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})

        lsp_zero.buffer_autoformat()
      end)

      -- (Optional) Configure lua language server for neovim
      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      vim.lsp.config("ts_ls", {
        root_dir = lspconfig.util.root_pattern(
          '.eslintrc',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json'
            -- Disabled to prevent "No ESLint configuration found" exceptions
            -- 'package.json',
          ), 
      })

      -- lspconfig.ts_ls.setup({
      --   root_dir = lspconfig.util.root_pattern(
      --     '.eslintrc',
      --     '.eslintrc.js',
      --     '.eslintrc.cjs',
      --     '.eslintrc.yaml',
      --     '.eslintrc.yml',
      --     '.eslintrc.json'
      --       -- Disabled to prevent "No ESLint configuration found" exceptions
      --       -- 'package.json',
      --     ), 
      -- })
      --
      
      vim.lsp.config("dcmls", {
       	capabilities = capabilities,
       	cmd = {
       		"dcm",
       		"start-server",
       	},
       	filetypes = { "dart", "yaml" },
      })

      -- lspconfig.dcmls.setup({
      --  	capabilities = capabilities,
      --  	cmd = {
      --  		"dcm",
      --  		"start-server",
      --  	},
      --  	filetypes = { "dart", "yaml" },
      -- })

      vim.lsp.config("dartls", {
        capabilities = capabilities,
        cmd = { "dart", "language-server", "--protocol=lsp" },
      })

      -- lspconfig.dartls.setup({
      --   capabilities = capabilities,
      --   cmd = { "dart", "language-server", "--protocol=lsp" },
      -- })

      vim.lsp.config("rust_analyzer", {
       	capabilities = capabilities,
      })

      -- lspconfig.rust_analyzer.setup({
      --   capabilities = capabilities,
      -- })

      vim.lsp.config("golangci_lint_ls", {
        filetypes = { "go", "gomod" },
      })

      vim.lsp.config("ruby_lsp", {
        filetypes = { "ruby", "eruby" },
        formatter = "auto"
      })


      -- lspconfig.golangci_lint_ls.setup({
      --   filetypes = { "go", "gomod" },
      -- })

      vim.lsp.config("solidity", {
        cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
        filetypes = { 'solidity' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
      })

      -- lspconfig.solidity.setup({
      --   cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
      --   filetypes = { 'solidity' },
      --   root_dir = lspconfig.util.find_git_ancestor,
      --   single_file_support = true,
      -- })

      mason_lspconfig.setup({
        ensure_installed = {
          -- golang
          "gopls",
          -- "golangci_lint_ls",

          -- typescript/javascript
          "ts_ls",
          "vtsls",
          "biome",
          "quick_lint_js",

          -- frontend core
          "html",
          "cssls",
          "cssmodules_ls",
          "unocss",
          "tailwindcss",

          "rust_analyzer",

          -- docker
          "dockerls",
          "docker_compose_language_service",

          "eslint",
          -- "eslint_d",

          -- haskell
          -- "hls",

          -- openapi/yaml
          "spectral",
          "vacuum",
          -- "hydra_lsp",
          "yamlls",

          "prismals", -- prisma

          -- sql
          "sqlls",
          -- "sqls",

          -- astro
          "astro",


          -- solidity
        },
        automatic_installation = true,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
  -- {
  --   "rust-lang/rust.vim",
  --   ft = "rust",
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end
  -- },
  {
    "mrcjkb/rustaceanvim",
    version = '^5',
    lazy = true,
  },
}
