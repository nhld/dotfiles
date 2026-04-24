-- npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    embeddedLanguages = { css = true, javascript = true },
  },
}
