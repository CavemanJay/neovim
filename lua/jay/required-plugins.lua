return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "folke/which-key.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "rose-pine/neovim",                name = "rose-pine" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { 'VonHeikemen/lsp-zero.nvim',       branch = 'v4.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'fatih/vim-go' },
    {
        'williamboman/mason.nvim',
        opts = { ensure_installed = { "goimports", "gofumpt", "gomodifytags", "impl", "delve" } },
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'echasnovski/mini.icons' },
    { 'nvim-tree/nvim-web-devicons' },
}
