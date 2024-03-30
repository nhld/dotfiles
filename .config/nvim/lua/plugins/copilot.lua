return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  opts = {
    panel = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<A-y>",
        accept_word = false,
        accept_line = "<A-l>",
        next = "<A-]>",
        prev = "<A-[>",
        dismiss = "<C-/>",
      },
    },
    filetypes = { markdown = true },
  },
}
