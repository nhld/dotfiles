local config = function()
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  -- Telescope live_grep in git root
  -- Function to find the git root directory based on the current buffer's path
  local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == '' then
      current_dir = cwd
    else
      -- Extract the directory from the current file's path
      current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
      print 'Not a git repository. Searching on current working directory'
      return cwd
    end
    return git_root
  end

  -- Custom live_grep function to search in git root
  local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
      require('telescope.builtin').live_grep {
        search_dirs = { git_root },
      }
    end
  end

  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
  end

  vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

  -- See `:help telescope.builtin`
  nmap('<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
  nmap('<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
  nmap('<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, '[/] Fuzzily search in current buffer')

  local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end

  nmap('<leader>s/', telescope_live_grep_open_files, '[S]earch [/] in Open Files')
  nmap('<leader>ss', require('telescope.builtin').builtin, '[S]earch [S]elect Telescope')
  nmap('<leader>gf', require('telescope.builtin').git_files, 'Search [G]it [F]iles')
  nmap('<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
  nmap('<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
  nmap('<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
  nmap('<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
  nmap('<leader>sG', ':LiveGrepGitRoot<cr>', '[S]earch by [G]rep on Git Root')
  nmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
  nmap('<leader>sr', require('telescope.builtin').resume, '[S]earch [R]esume')
end


return {
  'nvim-telescope/telescope.nvim',
  config = config,
  event = "VeryLazy",
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
}
