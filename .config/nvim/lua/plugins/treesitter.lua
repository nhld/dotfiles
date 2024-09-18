local config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "tsx",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "html",
      "json",
      "css",
      "markdown",
      "markdown_inline",
      "fish",
      "gitcommit",
      "toml",
      "bash",
      "yaml",
      "query",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(_, buf)
        if not vim.bo[buf].modifiable then
          return false
        end

        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true },
    folding = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = false,
        node_decremental = "<M-space>",
      },
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        max_lines = 5,
        multiline_threshold = 1,
        min_window_height = 20,
      },
      keys = {
        {
          "[c",
          function()
            -- Jump to previous change when in diffview.
            if vim.wo.diff then
              return "[c"
            else
              vim.schedule(function()
                require("treesitter-context").go_to_context()
              end)
              return "<Ignore>"
            end
          end,
          desc = "Jump to upper context",
          expr = true,
        },
      },
    },
  },
  build = ":TSUpdate",
  config = config,
}
