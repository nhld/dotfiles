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

local config = function()
  require("conform").setup {
    formatters = {
      prettier = { -- see https://github.com/stevearc/conform.nvim/issues/208
        ---@diagnostic disable-next-line: unused-local
        args = function(self, ctx)
          if vim.endswith(ctx.filename, ".ejs") then
            return { "--stdin-filepath", "$FILENAME", "--parser", "html" }
          end
          return { "--stdin-filepath", "$FILENAME" }
        end,
      },
    },
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      less = { "prettierd", "prettier" },
      html = { "prettier" }, --NOTE: prettierd cause error with .ejs
      jsonc = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      ["markdown.mdx"] = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      lua = { "stylua" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      fish = { "fish_indent" },
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
