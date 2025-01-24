local function on_attach(client, bufnr)
  local function map(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local telescope_builtin = require "telescope.builtin"
  map("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation", "i")
  map("gd", telescope_builtin.lsp_definitions, "Goto Definition")
  map("gr", telescope_builtin.lsp_references, "Goto References")
  map("gI", telescope_builtin.lsp_implementations, "Goto Implementation")
  map("<leader>D", telescope_builtin.lsp_type_definitions, "Type Definition")
  map("<leader>ds", telescope_builtin.lsp_document_symbols, "Document Symbols")
  map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")

  map("[e", function()
    vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, "Previous error")
  map("]e", function()
    vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
  end, "Next error")

  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
end

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "if_many",
  },
}

local signs = require("config.icons").lsp_signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP keymaps",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    on_attach(client, args.buf)
  end,
})

return {}
