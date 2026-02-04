return {
	-- the colorscheme should be available when starting Neovim
	{
		"olimorris/onedarkpro.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
		  -- load the colorscheme here
		  vim.cmd([[colorscheme onedark]])
		end,
		},
		{
		"OXY2DEV/markview.nvim",
		lazy = false,      -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		}
	},
	{ "folke/todo-comments.nvim", opts = {} },
}
