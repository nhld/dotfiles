local keys = {
  {
    "<leader>f",
    function()
      require("conform").format { async = true, lsp_format = "fallback" }
    end,
    mode = "",
    desc = "Format buffer",
  },
}

local fmt = { "prettier", "prettierd", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = keys,
  opts = {
    formatters_by_ft = {
      javascript = fmt,
      javascriptreact = fmt,
      typescript = fmt,
      typescriptreact = fmt,
      vue = fmt,
      css = fmt,
      scss = fmt,
      less = fmt,
      html = { "prettier" },
      jsonc = fmt,
      yaml = fmt,
      markdown = fmt,
      ["markdown.mdx"] = fmt,
      json = fmt,
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      fish = { "fish_indent" },
      go = { "gofumpt", "goimports-reviser", "goimports" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function()
      if not vim.g.autoformat then
        return
      end
      return { timeout_ms = 500 }
    end,
    notify_on_error = false,
  },
  init = function()
    vim.g.autoformat = true
  end,
}
