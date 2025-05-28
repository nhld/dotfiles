local M = {}

function M.mode_component()
  -- Note that: \19 = ^S and \22 = ^V.
  local mode_to_str = {
    ["n"] = "NORMAL",
    ["no"] = "OP-PENDING",
    ["nov"] = "OP-PENDING",
    ["noV"] = "OP-PENDING",
    ["no\22"] = "OP-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["ntT"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "VISUAL",
    ["Vs"] = "VISUAL",
    ["\22"] = "VISUAL",
    ["\22s"] = "VISUAL",
    ["s"] = "SELECT",
    ["S"] = "SELECT",
    ["\19"] = "SELECT",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "VIRT REPLACE",
    ["Rvc"] = "VIRT REPLACE",
    ["Rvx"] = "VIRT REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }

  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"
  local hl = "Other"
  if mode:find "NORMAL" then
    hl = "Normal"
  elseif mode:find "PENDING" then
    hl = "Pending"
  elseif mode:find "VISUAL" then
    hl = "Visual"
  elseif mode:find "INSERT" or mode:find "SELECT" then
    hl = "Insert"
  elseif mode:find "COMMAND" or mode:find "TERMINAL" or mode:find "EX" then
    hl = "Command"
  end

  return table.concat {
    string.format("%%#StatuslineMode%s#[%s]", hl, mode),
  }
end

function M.git_component()
  local head = vim.b.gitsigns_head
  if not head or head == "" then
    return ""
  end
  return string.format(" %s", head)
end

function M.filename_component()
  return "%t %m"
end

function M.filetype_component()
  local devicons = require "nvim-web-devicons"
  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "[No Name]"
  end
  local icon, icon_hl
  local buf_name = vim.api.nvim_buf_get_name(0)
  local name, ext = vim.fn.fnamemodify(buf_name, ":t"), vim.fn.fnamemodify(buf_name, ":e")
  icon, icon_hl = devicons.get_icon(name, ext)
  if not icon then
    icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
  end
  icon_hl = M.get_or_create_hl(icon_hl)
  return string.format("%%#%s#%s %%#StatuslineTitle#%s", icon_hl, icon, filetype)
end

local statusline_hls = {}

function M.get_or_create_hl(hl)
  local hl_name = "Statusline" .. hl
  if not statusline_hls[hl] then
    local bg_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
    local fg_hl = vim.api.nvim_get_hl(0, { name = hl })
    -- vim.api.nvim_set_hl(0, hl_name, { bg = ("#%06x"):format(bg_hl.bg), fg = ("#%06x"):format(fg_hl.fg) })
    statusline_hls[hl] = true
  end

  return hl_name
end

local icons = {
  lsp_signs = {
    ERROR = " ",
    WARN = " ",
    HINT = " ",
    INFO = " ",
  },
}

function M.diagnostics_component()
  if vim.bo.filetype == "lazy" then
    return ""
  end
  local counts = vim.iter(vim.diagnostic.get(0)):fold({
    ERROR = 0,
    WARN = 0,
    HINT = 0,
    INFO = 0,
  }, function(acc, diagnostic)
    local severity = vim.diagnostic.severity[diagnostic.severity]
    acc[severity] = acc[severity] + 1
    return acc
  end)
  local parts = vim
    .iter(counts)
    :map(function(severity, count)
      if count == 0 then
        return nil
      end
      local hl = "Diagnostic" .. severity:sub(1, 1) .. severity:sub(2):lower()
      return string.format("%%#%s#%s%d", M.get_or_create_hl(hl), icons.lsp_signs[severity], count)
    end)
    :totable()

  return table.concat(parts, " ")
end

function M.lineinfo_component()
  local line = vim.fn.line "."
  local line_count = vim.api.nvim_buf_line_count(0)
  local col = vim.fn.virtcol "."
  return table.concat { "[l:", string.format("%d/%d c:%2d]", line, line_count, col) }
end

function M.encoding_component()
  local encoding = vim.opt.fileencoding:get()
  return encoding ~= "" and string.format("%%#StatuslineModeSeparatorOther#%s", encoding) or ""
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

function M.diff_status_component()
  vim.api.nvim_set_hl(0, "GitSignsAddx", { fg = "#4fd6be", bg = "#181825" })
  vim.api.nvim_set_hl(0, "GitSignsChangex", { fg = "#ffc777", bg = "#181825" })
  vim.api.nvim_set_hl(0, "GitSignsDeletex", { fg = "#ff757f", bg = "#181825" })
  local diff = diff_source()
  if not diff then
    return ""
  end
  local diff_string = ""
  if diff.added and diff.added > 0 then
    diff_string = diff_string .. "%#GitSignsAddx#" .. "+" .. diff.added .. "" .. "%#StatuslineModeSeparatorOther#"
  end
  if diff.modified and diff.modified > 0 then
    diff_string = diff_string .. " %#GitSignsChangex#" .. "~" .. diff.modified .. "" .. "%#StatuslineModeSeparatorOther#"
  end
  if diff.removed and diff.removed > 0 then
    diff_string = diff_string .. " %#GitSignsDeletex#" .. "-" .. diff.removed .. "" .. "%#StatuslineModeSeparatorOther#"
  end
  return diff_string
end

function M.render()
  local function concat_components(components)
    return vim.iter(components):skip(1):fold(components[1], function(acc, component)
      return #component > 0 and string.format("%s %s", acc, component) or acc
    end)
  end

  return table.concat {
    concat_components {
      M.mode_component(),
      M.git_component(),
      M.diff_status_component(),
      M.filename_component(),
    },
    "%#StatusLine#%=",
    concat_components {
      M.diagnostics_component(),
      M.filetype_component(),
      M.encoding_component(),
      M.lineinfo_component(),
    },
    " ",
  }
end

return M
