return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = require("config.icons").git_signs,
    current_line_blame_opts = {
      virt_text_pos = "right_align",
      delay = 300,
    },
    current_line_blame = false,
    attach_to_untracked = true,
    on_attach = function(bufnr)
      local gitsigns = require "gitsigns"
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal { "]c", bang = true }
        else
          gitsigns.nav_hunk "next"
        end
      end, { desc = "Jump to next git change" })
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal { "[c", bang = true }
        else
          gitsigns.nav_hunk "prev"
        end
      end, { desc = "Jump to previous git change" })
      map("v", "<leader>gs", function()
        gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, { desc = "Stage Git hunk" })
      map("v", "<leader>rh", function()
        gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end, { desc = "Reset git Hunk" })
      map("n", "<leader>gr", gitsigns.reset_buffer, { desc = "Git Reset buffer" })
      map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git Preview hunk" })
      map("n", "<leader>gd", function()
        gitsigns.diffthis "@"
      end, { desc = "git Diff against last commit" })
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git show blame line" })
      map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle git show Deleted" })
    end,
  },
}
