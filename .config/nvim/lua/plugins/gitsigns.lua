local opts = {
  signs = require("config.icons").git_signs,
  current_line_blame_opts = {
    virt_text_pos = "right_align",
    delay = 300,
  },
  current_line_blame = true,
  attach_to_untracked = true,
}

return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = opts,
}
