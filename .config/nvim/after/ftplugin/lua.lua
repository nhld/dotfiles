require("nvim-surround").buffer_setup {
  surrounds = {
    F = {
      add = function()
        return {
          {
            string.format("function %s() ", require("nvim-surround.config").get_input "Enter function name: "),
          },
          { " end" },
        }
      end,
    },
  },
}
