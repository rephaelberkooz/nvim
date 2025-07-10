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
   }
}
