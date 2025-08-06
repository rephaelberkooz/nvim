return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
          dependencies = { 'nvim-lua/plenary.nvim' }
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
        'neovim/nvim-lspconfig'
    }
}
