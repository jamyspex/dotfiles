vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  })
  use("nanotech/jellybeans.vim")

  use("github/copilot.vim")

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({ "junegunn/fzf", run = "fzf#install()" })
  use("junegunn/fzf.vim")
  
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })

  use("christoomey/vim-tmux-navigator")
  use("tmux-plugins/vim-tmux-focus-events")

  use("tpope/vim-fugitive")

  use({
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    requires = { "rafamadriz/friendly-snippets" },
    -- use a release tag to download pre-built binaries
    tag = "v1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    run = "cargo build --release",
    -- If you use nix, you can build from source using latest nightly rust with:
    -- run = 'nix run .#build-plugin',
    config = function()
      require("blink.cmp").setup({
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "default" },
        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = "mono",
        },
        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = false } },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
      })
    end,
  })

  -- Complete Rust LSP setup with Mason for Packer
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Setup handlers for mason-lspconfig
      require("mason-lspconfig").setup({
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Specific handler for rust-analyzer
        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                },
                checkOnSave = true,
                procMacro = {
                  enable = true,
                },
              },
            },
            on_attach = function(client, bufnr)
              -- Rust-specific keymaps
              local opts = { buffer = bufnr, remap = false }
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
              vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
            end,
          })
        end,
      })
    end,
  })

  use({
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        options = {
          virt_texts = {
            priority = 9999, -- Higher priority than rust-tools (default is 2048)
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  })

  use({
    "simrat39/rust-tools.nvim",
    after = "nvim-lspconfig",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = true,
            },
          },
        },
      })
    end,
  })

  use("roxma/vim-tmux-clipboard")

  use({
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters = {
          stylua = {
            command = "stylua",
            append_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  })
end)
