local function augroup(name)
  return vim.api.nvim_create_augroup("" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "qf",
    "query",
    "startuptime",
    "checkhealth",
    "man",
    "TelescopePrompt",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>q!<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.spell = false
    vim.cmd "startinsert"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup "json_conceal",
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("n/last_location", { clear = true }),
  desc = "Go to the last location when opening a buffer",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd 'normal! g`"zz'
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("n/yank_highlight", { clear = true }),
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

local startup_group = vim.api.nvim_create_augroup("startup", { clear = false })

local function mark_buffer_persistent(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.b[bufnr].persistent = true
end

vim.api.nvim_create_autocmd("BufRead", {
  group = startup_group,
  pattern = "*",
  callback = function(args)
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = args.buf,
      once = true,
      callback = function()
        mark_buffer_persistent(args.buf)
      end,
    })
  end,
})

local function close_non_persistent_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted and bufnr ~= current_buf and not vim.b[bufnr].persistent then
      vim.api.nvim_buf_delete(bufnr, { force = false })
    end
  end
end

vim.keymap.set("n", "<leader>bc", close_non_persistent_buffers, {
  silent = true,
  desc = "Close all untouched buffers",
})

local function close_all_buffers_except_current()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.api.nvim_buf_delete, buf, { force = false })
    end
  end
end

vim.keymap.set("n", "<leader>bq", close_all_buffers_except_current, {
  silent = true,
  desc = "Close all buffers except current",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "checkhealth",
  callback = function()
    vim.opt_local.colorcolumn = ""
    vim.opt_local.number = false
    vim.opt_local.rnu = false
    vim.b.miniindentscope_disable = true
  end,
})
