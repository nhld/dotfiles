local opts = {
  use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}

local config = function()
  require('trouble').setup(opts)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
  end

  nmap("<leader>xx", function() require("trouble").toggle() end, "Toggle Trouble")
  nmap("<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, "Workspace Diagnostics")
  nmap("<leader>xd", function() require("trouble").toggle("document_diagnostics") end, "Document Diagnostics")
  nmap("<leader>xq", function() require("trouble").toggle("quickfix") end, "Quickfix")
  nmap("<leader>xl", function() require("trouble").toggle("loclist") end, "Loclist")
  nmap("gR", function() require("trouble").toggle("lsp_references") end, "LSP References")
end

return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = config,
}
