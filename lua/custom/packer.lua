return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Theme
	use("folke/tokyonight.nvim")

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Lsp
 	use("williamboman/mason.nvim")
	use("neovim/nvim-lspconfig")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- Plenary
	use("nvim-lua/plenary.nvim")

	-- Git Fugitive
	use("tpope/vim-fugitive")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")

	-- Dev Icons
	use("kyazdani42/nvim-web-devicons")
end)

