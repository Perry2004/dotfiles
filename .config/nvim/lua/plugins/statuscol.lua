-- smart line number: display relative numbers for lines within 9 lines of the cursor, otherwise display absolute line numbers
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")

    local function limited_relative_numbers()
      local current_line = vim.fn.line(".")
      local line_nr = vim.v.lnum

      local relative_line = current_line == line_nr and 0 or math.abs(current_line - line_nr)

      if relative_line > 0 and relative_line <= 9 then
        return string.format("%3d", relative_line)
      else
        return string.format("%3d", line_nr)
      end
    end

    require("statuscol").setup({
      segments = {
        { text = { " " } },
        { text = { limited_relative_numbers }, click = "v:lua.ScLa" },
        { text = { " " } },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
          sign = {
            namespace = { "gitsigns", "diagnostic" },
            maxwidth = 2,
            auto = true,
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
