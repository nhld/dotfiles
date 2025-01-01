vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.formatonsave = not vim.g.formatonsave
  vim.notify(string.format("%s format on save...", vim.g.formatonsave and "Enabling" or "Disabling"), vim.log.levels.INFO)
end, { desc = "Toggle Conform format on save", nargs = 0 })
