return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  opts = {
    panel = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = { -- M = meta (can also be A = alt) = opt key
        accept = "<M-y>",
        accept_word = false,
        accept_line = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-/>",
      },
    },
    filetypes = { markdown = true },
  },
}
