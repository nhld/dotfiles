return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters = {
      prettier = { require_cwd = true },
    },
    formatters_by_ft = {
      bash = { "shfmt" },
      fish = { "fish_indent" },
      lua = { "stylua" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      html = { "prettier" },
      css = { "prettier" },
      -- javascript = { "dprint", "prettierd", "prettier", stop_after_first = true },
      -- typescript = { "dprint", "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      -- javascriptreact = { "dprint" },
      -- typescriptreact = { "dprint" },
      typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      -- json = { "prettier" },
      -- jsonc = { "prettier" },
      json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      markdown = { "prettier" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
      python = { "black" },
      cpp = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
      c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
    },
    format_on_save = function()
      if vim.g.formatonsave then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    notify_on_error = false,
    notify_no_formatters = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.g.formatonsave = true
  end,
}
