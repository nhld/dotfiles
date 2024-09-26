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

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "LspAttach" },
  cmd = { "ConformInfo" },
  keys = keys,
  opts = {
    formatters_by_ft = {
      css = { "stylelint" },
      scss = { "stylelint" },
      less = { "stylelint" },
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      fish = { "fish_indent" },
      go = { "gofumpt", "goimports-reviser", "goimports" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if not vim.g.format_on_save then
        return
      end
      local res = { timeout_ms = 500 }
      local filetype = vim.bo[bufnr].filetype
      if
        vim.tbl_contains({ "typescript", "javascript", "typescriptreact", "javascriptreact" }, filetype)
        and require("conform").get_formatter_info("dprint", bufnr).available
      then
        res.lsp_format = "fallback"
      else
        res.lsp_format = vim.tbl_contains({ "c", "json", "jsonc", "rust" }, filetype) and "fallback" or nil
      end
      return res
    end,
    notify_on_error = false,
  },
  init = function()
    vim.g.format_on_save = true
    vim.keymap.set("n", "<leader>fm", ":lua ToggleFormatOnSave()<CR>", { noremap = true, silent = true, desc = "Toggle format on save" })

    function ToggleFormatOnSave()
      if vim.g.format_on_save then
        vim.g.format_on_save = false
        print "Format on save OFF"
      else
        vim.g.format_on_save = true
        print "Format on save ON"
      end
    end
  end,
}
