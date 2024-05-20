local config = function()
  require("neo-tree").setup {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf" },
    default_component_configs = {
      container = {
        enable_character_fade = false,
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      git_status = {
        symbols = require("config.icons").neo_tree,
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    window = {
      width = 45,
      mappings = {
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      },
    },
  }

  vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neotree" })
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  cmd = "Neotree",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = { "<C-b>" },
  config = config,
}
