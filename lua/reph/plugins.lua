return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
          dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim' }
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
       "nvim-treesitter/nvim-treesitter",
       branch = 'master',
       lazy = false,
       build = ":TSUpdate"  
    },
    {
       "nvim-treesitter/playground"
    },
    -- {
    --     "nvim-telescope/telescope-file-browser.nvim",
    --     dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    -- },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    { -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
          -- delay between pressing a key and opening which-key (milliseconds)
          -- this setting is independent of vim.o.timeoutlen
          delay = 0,
          icons = {
            mappings = vim.g.have_nerd_font,
          },

          -- Document existing key chains
          spec = {
            { '<leader>s', group = '[S]earch' },
            { '<leader>t', group = '[T]oggle' },
            { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
          },
        },
    },
    {
      "neovim/nvim-lspconfig",
      lazy = false,
      dependencies = {
        { "ms-jpq/coq_nvim", branch = "coq" },
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { 'ms-jpq/coq.thirdparty', branch = "3p" }
      },
      init = function()
        vim.g.coq_settings = {
          auto_start = 'shut-up',
          keymap = {
            recommended = true,
            jump_to_mark = '<c-k>',
          },
          display = {
            pum = {
              fast_close = false,
              source_context = {"[", "]"},
              kind_context = {"[", "]"},
            },
            preview = {
              border = "rounded",
            }
          },
          clients = {
            lsp = {
              enabled = true,
              resolve_timeout = 0.02,
              weight_adjust = 2.0,
              short_name = "LSP",
            },
            snippets = {
              enabled = true,
              warn = {},
              weight_adjust = 1.5,
              short_name = "SNIP",
            },
            third_party = {
              enabled = true,
              weight_adjust = 1.0,
              short_name = "3P",
            }
          }
        }
      end,
      config = function()
        require("reph.lsp")
      end,
    },
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true,  -- if you want to enable the plugin
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
        },
    }
    
}
