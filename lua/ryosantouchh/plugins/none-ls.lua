return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- null_ls.setup({
    --   sources = {
    --     require("none-ls.diagnostics.eslint_d").with({ --js/ts linter
    --       condition = function(utils)
    --         return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
    --       end,
    --     }),
    --     require("none-ls.code_actions.eslint"),
    --     null_ls.builtins.formatting.stylua,
    --     null_ls.builtins.formatting.prettier,
    --   },
    -- })

    null_ls.setup({
      sources = {
        require("none-ls.diagnostics.eslint_d").with({ --js/ts linter
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        }),
        require("none-ls.code_actions.eslint"),
        -- require("none-ls.code_actions.eslint_d"),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.dart_format,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
