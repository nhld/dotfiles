local M = {}

local function on_attach(client, bufnr)
  local function keymap(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  keymap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation", "i")
  keymap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
  keymap("gr", require("telescope.builtin").lsp_references, "Goto References")
  keymap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
  keymap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
  keymap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  keymap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  keymap("gD", vim.lsp.buf.declaration, "Goto Declaration")

  keymap("[e", function()
    vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, "Previous error")
  keymap("]e", function()
    vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
  end, "Next error")

  if client and client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
  local navic = require "nvim-navic"
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- From here are extra highlights for lsp doc hover
local md_namespace = vim.api.nvim_create_namespace "n/lsp_float"

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
  for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for pattern, hl_group in pairs {
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
      ["|%S-|"] = "@text.reference",
    } do
      local from = 1 ---@type integer?
      while from do
        local to
        from, to = line:find(pattern, from)
        if from then
          vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
            end_col = to,
            hl_group = hl_group,
          })
        end
        from = to and to + 1 or nil
      end
    end
  end
end

--- LSP handler that adds extra inline highlights, keymaps, and window options.
--- Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
---@param focusable boolean
---@return fun(err: any, result: any, ctx: any, config: any)
local function enhanced_float_handler(handler, focusable)
  return function(err, result, ctx, config)
    local bufnr, winnr = handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend("force", config or {}, {
        --border = "rounded",
        focusable = focusable,
        --max_height = math.floor(vim.o.lines * 0.5),
        --max_width = math.floor(vim.o.columns * 0.4),
      })
    )

    if not bufnr or not winnr then
      return
    end

    -- Conceal everything.
    vim.wo[winnr].concealcursor = "n"

    -- Extra highlights.
    add_inline_highlights(bufnr)

    -- Add keymaps for opening links.
    if focusable and not vim.b[bufnr].markdown_keys then
      vim.keymap.set("n", "K", function()
        -- Vim help links.
        local url = (vim.fn.expand "<cWORD>" --[[@as string]]):match "|(%S-)|"
        if url then
          return vim.cmd.help(url)
        end

        -- Markdown links.
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1
        local from, to
        from, to, url = vim.api.nvim_get_current_line():find "%[.-%]%((%S-)%)"
        if from and col >= from and col <= to then
          vim.system({ "xdg-open", url }, nil, function(res)
            if res.code ~= 0 then
              vim.notify("Failed to open URL" .. url, vim.log.levels.ERROR)
            end
          end)
        end
      end, { buffer = bufnr, silent = true })
      vim.b[bufnr].markdown_keys = true
    end
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents)
  vim.bo[bufnr].filetype = "markdown"
  vim.treesitter.start(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
  add_inline_highlights(bufnr)
  return contents
end

vim.lsp.handlers["textDocument/hover"] = enhanced_float_handler(vim.lsp.handlers.hover, true)
vim.lsp.handlers["textDocument/signatureHelp"] = enhanced_float_handler(vim.lsp.handlers.signature_help, false)

---@diagnostic disable-next-line: unused-function, unused-local
local function format_diagnostic(diagnostic)
  local message = string.format("%s", diagnostic.message)
  if diagnostic.code and diagnostic.source then
    message = string.format("[%s][%s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
  elseif diagnostic.code or diagnostic.source then
    message = string.format("[%s] %s", diagnostic.code or diagnostic.source, diagnostic.message)
  end

  return message .. " "
end

vim.diagnostic.config {
  virtual_text = true,
  -- virtual_text = {
  -- 	spacing = 2,
  -- 	format = format_diagnostic,
  -- },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    --border = "rounded",
    --source = "if_many",
  },
}

-- Override the virtual text diagnostic handler so that the most severe diagnostic is shown first.
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

return M
