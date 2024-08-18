local keys = {
  {
    "<leader>f",
    function()
      require("conform").format { async = true, lsp_fallback = true }
    end,
    mode = "",
    desc = "Format buffer",
  },
}

local fmt = { "prettierd", "prettier", stop_after_first = true }

local config = function()
  require("conform").setup {
    formatters_by_ft = {
      javascript = fmt,
      javascriptreact = fmt,
      typescript = fmt,
      typescriptreact = fmt,
      vue = fmt,
      css = fmt,
      scss = fmt,
      less = fmt,
      html = fmt,
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
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    notify_on_error = true,
  }
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = keys,
  config = config,
}
