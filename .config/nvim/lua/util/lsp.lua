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

  -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
  --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --
  --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  --
  --   vim.api.nvim_create_autocmd("LspDetach", {
  --     callback = function(event2)
  --       vim.lsp.buf.clear_references()
  --       vim.api.nvim_clear_autocmds { buffer = event2.buf }
  --     end,
  --   })
  -- end

  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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

local show_handler = vim.diagnostic.handlers.virtual_text.show
assert(show_handler)
local hide_handler = vim.diagnostic.handlers.virtual_text.hide

vim.diagnostic.handlers.virtual_text = {
  show = function(ns, bufnr, diagnostics, opts)
    table.sort(diagnostics, function(diag1, diag2)
      return diag1.severity > diag2.severity
    end)
    return show_handler(ns, bufnr, diagnostics, opts)
  end,
  hide = hide_handler,
}

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
