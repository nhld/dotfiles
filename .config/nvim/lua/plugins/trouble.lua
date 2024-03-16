local config = function()
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = desc })
  end

  map("<leader>xx", function()
    require("trouble").toggle()
  end, "Toggle Trouble")
  map("<leader>xw", function()
    require("trouble").toggle "workspace_diagnostics"
  end, "Workspace Diagnostics")
  map("<leader>xd", function()
    require("trouble").toggle "document_diagnostics"
  end, "Document Diagnostics")
  map("<leader>xq", function()
    require("trouble").toggle "quickfix"
  end, "Quickfix")
  map("<leader>xl", function()
    require("trouble").toggle "loclist"
  end, "Loclist")
  map("gR", function()
    require("trouble").toggle "lsp_references"
  end, "LSP References")
end

return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = config,
  opts = {
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  },
}
