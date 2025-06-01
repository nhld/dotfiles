local M = {}

local function on_attach(client, bufnr)
  local function map(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local telescope_builtin = require "telescope.builtin"
  map("gd", telescope_builtin.lsp_definitions, "Goto Definition")
  map("gr", telescope_builtin.lsp_references, "Goto References")
  map("gI", telescope_builtin.lsp_implementations, "Goto Implementation")
  map("<leader>D", telescope_builtin.lsp_type_definitions, "Type Definition")
  map("<leader>ds", telescope_builtin.lsp_document_symbols, "Document Symbols")
  map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")

  map("[e", function()
    vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
  end, "Previous error")
  map("]e", function()
    vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
  end, "Next error")

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
    local blink_window = require "blink.cmp.completion.windows.menu"
    local blink = require "blink.cmp"

    map("<C-k>", function()
      if blink_window.win:is_open() then
        blink.hide()
      end

      vim.lsp.buf.signature_help()
    end, "Signature help", "i")
  end

  if client.name == "eslint" then
    vim.keymap.set("n", "<leader>ce", function()
      if not client then
        return
      end

      client:request(vim.lsp.protocol.Methods.workspace_executeCommand, {
        command = "eslint.applyAllFixes",
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, { desc = "Fix all ESLint errors", buffer = bufnr })
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

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

return M
