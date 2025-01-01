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
    formatters_by_ft = {
      bash = { "shfmt" },
      fish = { "fish_indent" },
      lua = { "stylua" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "dprint", "prettierd", "prettier", stop_after_first = true },
      typescript = { "dprint", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "dprint" },
      typescriptreact = { "dprint" },
      json = { "prettier" },
      jsonc = { "prettier" },
      markdown = { "prettier" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
      python = { "black" },
    },
    formatters = {
      dprint = {
        condition = function(_, ctx)
          return vim.fs.find({ "dprint.json", ".dprint.jsonc" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function()
      if vim.g.formatonsave then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    notify_on_error = false,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.g.formatonsave = true
  end,
}
