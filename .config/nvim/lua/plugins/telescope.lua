local config = function()
  require("telescope").setup {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
      fzf = {},
    },
  }

  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "ui-select")
  pcall(require("telescope").load_extension, "yank_history")

  local function find_git_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    if current_file == "" then
      current_dir = cwd
    else
      current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
      print "Not a git repository. Searching on current working directory"
      return cwd
    end
    return git_root
  end

  local builtin = require "telescope.builtin"

  local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
      builtin.live_grep {
        search_dirs = { git_root },
      }
    end
  end

  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = desc })
  end

  vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

  map("<leader>?", builtin.oldfiles, "Find recently opened files")
  map("<leader><space>", builtin.buffers, "Find existing buffers")
  map("<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, "Fuzzily search in current buffer")

  local function telescope_live_grep_open_files()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = "Live Grep in Open Files",
    }
  end

  map("<leader>s/", telescope_live_grep_open_files, "Search [/] in Open Files")
  map("<leader>ss", builtin.builtin, "Search Select Telescope")
  map("<leader>gf", builtin.git_files, "Search Git Files")
  map("<leader>sf", builtin.find_files, "Search Files")
  map("<leader>st", builtin.help_tags, "Search Help")
  map("<leader>sw", builtin.grep_string, "Search current Word")
  map("<leader>sg", builtin.live_grep, "Search by Grep")
  map("<leader>sG", ":LiveGrepGitRoot<cr>", "Search by Grep on Git Root")
  map("<leader>sd", builtin.diagnostics, "Search Diagnostics")

  map("<leader>sn", function()
    builtin.find_files { cwd = vim.fn.stdpath "config" }
  end, "Search Neovim files")
end

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>sf", desc = "Search Files" },
    { "<leader>sn", desc = "Search Nvim Conf Files" },
    { "<leader>sg", desc = "Search by Grep" },
  },
  cmd = "Telescope",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
}
