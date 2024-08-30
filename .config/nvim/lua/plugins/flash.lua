-- stylua: ignore
local keys = {
  { "SS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
  { "ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
  { "r", mode = "o", function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
}

return {
  "folke/flash.nvim",
  keys = keys,
  opts = {
    jump = { nohlsearch = true },
    search = {
      exclude = {
        "cmp_menu",
        "flash_prompt",
      },
    },
  },
}
