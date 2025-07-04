local config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "cpp",
      "diff",
      "dockerfile",
      "fish",
      "gitcommit",
      "git_config",
      "go",
      "html",
      "json",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "python",
      "scss",
      "tsx",
      "typescript",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
      "ruby",
    },
    auto_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
    indent = { enable = true, disable = { "ruby" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = false,
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
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
          "[g",
          function()
            if vim.wo.diff then
              return "[g"
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
  cmd = { "TSInstall", "TSUpdate" },
  config = config,
}
