local cur_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[\\/])")

local M = {
    -- Can freely add/remove
    {
        "rktjmp/lush.nvim",
        lazy = true,
    },
    {
        "rktjmp/shipwright.nvim",
        lazy = true,
    },
    {
        "Shatur/neovim-ayu",
    },
    {
        dir = cur_dir .. "themes/runa",
    },
    {
        dir = cur_dir .. "themes/stiff",
    },
    {
        "declancm/cinnamon.nvim",
        version = "*",
        opts = {
            keymaps = {
                basic = true,
                extra = true,
            },
            options = {
                mode = "cursor",
                max_delta = {
                    time = 100,
                }
            }
            
        }
    },
    -- Fokin Mandatory
    "nvim-tree/nvim-web-devicons",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            options = {
                mode = "cursor"
            }
        },
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
                ["gdscript"] = function ()
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    
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
                    local lspconfig = require("lspconfig")
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
                end,
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
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "arkav/lualine-lsp-progress"
        },
        opts = {
            options = {
                theme = "auto",
                icons_enabled = true,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 }, 'lsp_progress' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        }
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sharkdp/fd",
                "nvim-telescope/telescope-ui-select.nvim",
                "nvim-telescope/telescope-fzy-native.nvim",
                "andrew-george/telescope-themes"
            },
            config = function()
                local telescope = require("telescope")
                telescope.setup {
                    extensions = {
                        fzy_native = {
                            override_generic_sorter = false,
                            override_file_sorter = true,
                        },
                        themes = {
                            enable_previewer = false,
                            persist = {
                                enabled = true
                            }
                        }
                    },
                }
                telescope.load_extension('ui-select')
                telescope.load_extension('fzy_native')
                telescope.load_extension('themes')
            end
        },
    }
}
return M
