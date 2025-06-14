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
      javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      markdown = { "prettier" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
      python = { "black" },
      cpp = { name = "clangd", timeout_ms = 500, lsp_format = "fallback" },
      c = { name = "clangd", timeout_ms = 500, lsp_format = "fallback" },
      ruby = { "rubocop", name = "ruby-lsp", timeout_ms = 500, lsp_format = "fallback" },
    },
    format_on_save = function()
      if vim.g.skip_formatting then
        vim.g.skip_formatting = false
        return nil
      end

      if not vim.g.formatonsave then
        return nil
      end

      return {}
    end,
    notify_on_error = false,
    notify_no_formatters = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.g.formatonsave = true
  end,
}
