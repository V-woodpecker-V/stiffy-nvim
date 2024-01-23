local M = {
    "folke/which-key.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "Shatur/neovim-ayu",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme ayu]])
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "github/copilot.vim"
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
            "neovim/nvim-lspconfig",
        },
        config = function()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.setup(require("stiffy.config.nvim-cmp"))
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )

        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = require("stiffy.lsp_info").get_names(),
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = require("stiffy.lsp_info").get_treesitter_names()
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sharkdp/fd"
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        opts= {},
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    {
        "folke/neodev.nvim",
        opts = {
            library = {
                plugins = {
                    "nvim-dap-ui"
                },
                types = true,
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function ()
          local null_ls = require("null-ls")
          null_ls.setup(
          {
              sources = {
                  null_ls.builtins.formatting.csharpier,
            }
          }
          )
        end
    },
}
return M
