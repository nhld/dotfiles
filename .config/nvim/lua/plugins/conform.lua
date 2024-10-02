return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "LspAttach" },
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
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 500 },
    notify_on_error = false,
  },
}
