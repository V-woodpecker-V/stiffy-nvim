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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",

            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }, {
                    { name = "buffer" },
                })
            }
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        config = function()
            local cmp = require("cmp")
            cmp.setup.cmdline {
                sources = cmp.config.sources({
                    { name = 'cmdline' },
                }, {
                    { name = "cmdline" },
                })
            }
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
        config = function()
            local m_lspconfig = require("mason-lspconfig")
            m_lspconfig.setup()
            m_lspconfig.setup_handlers {
                function(server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        root_dir = function()
                            local lspconfig = require("lspconfig")
                            return lspconfig.util.root_pattern(".git")(vim.fn.getcwd()) or
                                lspconfig.util.root_pattern("package.json")(vim.fn.getcwd()) or
                                lspconfig.util.root_pattern("pyright.json")(vim.fn.getcwd()) or
                                lspconfig.util.root_pattern("Cargo.toml")(vim.fn.getcwd()) or
                                vim.fn.getcwd()
                        end
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig")["lua_ls"].setup {
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    globals = {
                                        "vim",
                                        "require",
                                    },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                telementry = {
                                    enable = false,
                                },
                            },
                        },
                    }
                end,
                ["gopls"] = function()
                    lspconfig = require("lspconfig")
                    require("lspconfig")["gopls"].setup {
                        cmd = { "gopls" },
                        filetypes = { "go", "gomod" },
                        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                            },
                        },
                    }
                end
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua",
                "python",
                "rust",
                "typescript",
                "markdown_inline",
                "gdscript",
                "glsl",
                "go",
                "c_sharp",
                "c",
                "cpp",
                "tsx",
                "yaml",
                "json",
                "html",
                "graphql",
                "gdshader",
                "dockerfile",
                "css",
                "sql",
                "regex",
                "kotlin",
                "just",
            }
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
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
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
        "jay-babu/mason-null-ls.nvim",
        event = { "BufRead", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup(
                {
                    sources = {
                        null_ls.builtins.formatting.csharpier,
                    }
                })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = { theme = "ayu_dark" }
        }
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = {"markown"},
        build = function ()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
return M
