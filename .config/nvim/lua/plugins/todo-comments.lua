local config = function()
  local todo_comments = require "todo-comments"
  vim.keymap.set("n", "]t", function()
    todo_comments.jump_next()
  end, { desc = "Next todo comment" })
  vim.keymap.set("n", "[t", function()
    todo_comments.jump_prev()
  end, { desc = "Previous todo comment" })
end

return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  opts = { signs = false },
  config = config,
}
