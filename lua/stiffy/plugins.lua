local M = {
    "folke/which-key.nvim",
    "folke/neodev.nvim",
    {
        "Shatur/neovim-ayu",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme ayu]])
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",

            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig"
        },

        config = function()
            local opts = require("stiffy.config.nvim-cmp")
            local cmp = require("cmp")
            cmp.setup(opts)
        end, 
    },
}
return M
