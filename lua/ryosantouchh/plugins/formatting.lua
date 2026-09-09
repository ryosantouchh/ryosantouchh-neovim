return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        dart = { "dart_format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        hcl = { "hcl" },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        dockerfile = { "dockerfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
        make = { "bake" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        lsp_format = "never",
        timeout_ms = 3000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>gf", function()
      conform.format({ lsp_format = "never", timeout_ms = 3000 })
    end, { desc = "Format buffer" })
  end,
}
