local config = function()
  require('neo-tree').setup({
    default_component_configs = {
      container = {
        enable_character_fade = false,
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      git_status = {
        symbols = {
          -- Change type
          --added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          --modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          added     = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "M", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "D", -- this can only be used in the git_status source
          renamed   = "R", -- this can only be used in the git_status source
          --deleted   = "✖", -- this can only be used in the git_status source
          --renamed   = "󰁕", -- this can only be used in the git_status source
          -- Status type
          -- untracked = "",
          -- ignored   = "",
          -- unstaged  = "󰄱",
          -- staged    = "",
          -- conflict  = "",
          untracked = "",
          ignored   = 'I',
          unstaged  = 'U',
          staged    = 'S',
          conflict  = 'C',
        }
      },
    },
    window = {
      width = 45,
      mappings = {
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' and node:is_expanded() then
            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
          else
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
            elseif node:has_children() then
              require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      }
    },
  })
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = config,
}
