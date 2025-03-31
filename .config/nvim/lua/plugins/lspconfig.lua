require "util.lsp"

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      opts_extend = { "ensure_installed" },
      opts = {
        ensure_installed = {
          "stylua",
          "shfmt",
          "fish_indent",
        },
      },
    },
    "yioneko/nvim-vtsls",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  opts = {
    servers = {
      clangd = {
        settings = {
          cmd = {
            "clangd",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--fallback-style=none",
            "--function-arg-placeholders=false",
          },
          init_options = {
            fallbackFlags = { "-std=c++17" },
          },
        },
      },
      html = {},
      cssls = {},
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = true },
          },
        },
      },
      bashls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LUAJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
            telemetry = { enable = false },
            -- diagnostics = { disable = { "missing-fields" } },
            completion = { callSnippet = "Replace" },
          },
        },
      },
      vtsls = {
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              -- maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      emmet_language_server = {},
      eslint = {
        settings = {
          workingDirectories = { mode = "auto" },
          format = false,
        },
      },
      dprint = {},
      gopls = {
        root_dir = function(fname)
          return require("lspconfig/util").root_pattern("go.work", "go.mod", ".git")(fname) or vim.fn.getcwd()
        end,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    if opts.servers.vtsls and opts.servers.vtsls.settings and opts.servers.vtsls.settings.typescript then
      opts.servers.vtsls.settings.javascript =
        vim.tbl_deep_extend("force", {}, opts.servers.vtsls.settings.typescript, opts.servers.vtsls.settings.javascript or {})
    end

    require("mason-lspconfig").setup {
      ensure_installed = vim.tbl_keys(opts.servers or {}),
      handlers = {
        function(server_name)
          local server = opts.servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
