local M = {}

local function on_attach(client, bufnr)
  local function map(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local telescope_builtin = require "telescope.builtin"

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
    map("gd", telescope_builtin.lsp_definitions, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  end

  map("gr", telescope_builtin.lsp_references, "Goto References")
  map("gI", telescope_builtin.lsp_implementations, "Goto Implementation")
  map("<leader>D", telescope_builtin.lsp_type_definitions, "Type Definition")
  map("<leader>ds", telescope_builtin.lsp_document_symbols, "Document Symbols")
  map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")

  map("[e", function()
    vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
  end, "Previous error")
  map("]e", function()
    vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
  end, "Next error")

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("nv/cursor_highlights", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    local inlay_hints_group = vim.api.nvim_create_augroup("nv/toggle_inlay_hints", { clear = false })

    if vim.g.inlay_hints then
      vim.defer_fn(function()
        local mode = vim.api.nvim_get_mode().mode
        vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
      end, 500)
    end

    vim.api.nvim_create_autocmd("InsertEnter", {
      group = inlay_hints_group,
      desc = "Enable inlay hints",
      buffer = bufnr,
      callback = function()
        if vim.g.inlay_hints then
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        end
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = inlay_hints_group,
      desc = "Disable inlay hints",
      buffer = bufnr,
      callback = function()
        if vim.g.inlay_hints then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
    })
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
    map("<C-k>", function()
      if require("blink.cmp.completion.windows.menu").win:is_open() then
        require("blink.cmp").hide()
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
