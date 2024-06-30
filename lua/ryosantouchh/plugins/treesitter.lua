return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      local nvim_ts_autotag = require("nvim-ts-autotag")
      -- local ft = {
      --   "javascript",
      --   "javascriptreact",
      --   "typescript",
      --   "typescriptreact",
      -- }

      local autotag_opt = {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false
        },

        -- override config for specific filetype 
        per_filetype = {
          ["html"] = {
            enable_close = true
          }
        }
      }

      -- FOR WINDOWS OS --- need to install C compilers clang , mingw , whatever --- can check in notion
      -- local treesitter_install = require("nvim-treesitter.install")
      -- treesitter_install.compilers = { "clang", "gcc" }

      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        -- autotag = {
        --   enable = true,
        --   enable_rename = true,
        --   enable_close = true,
        --   enable_close_on_slash = true,
        -- },
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "prisma",
          "markdown",
          "markdown_inline",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "go",
          "query",
          "vimdoc",
        },
      })

      -- nvim_ts_autotag.setup(ft)
      nvim_ts_autotag.setup(autotag_opt)
    end,
}
