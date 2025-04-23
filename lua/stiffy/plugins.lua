local M = {
    -- Can freely add/remove
    {
        "Shatur/neovim-ayu",
    },
    {
        "RRethy/base16-nvim"
    },
    {
        "declancm/cinnamon.nvim",
        event = "VeryLazy",
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
    {
        "folke/trouble.nvim",
        opts = {
            focus = true,
            warn_no_results = false,
            open_no_results = true,
        },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.netcoredbg = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
                args = { "--interpreter=vscode" },
            }

            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'Error', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'WarningMsg', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '✖', texthl = 'ErrorMsg', linehl = '', numhl = '' })
            vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'Title', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '→', texthl = 'Identifier', linehl = 'Visual', numhl = 'Debug' })

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<S-CR>", dap.continue, {})
            vim.keymap.set("n", "<S-Right>", dap.step_over, {})
            vim.keymap.set("n", "<S-Down>", dap.step_into, {})
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies =
        {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dapui = require("dapui")
            local dap = require("dap")
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<S-Up>", require("dapui").toggle, {})
            vim.keymap.set("n", "<leader>w", function()
                dapui.elements.watches.add(vim.fn.expand("<cword>"))
            end, {})
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {}
    },
    {
        {
            "nvim-neotest/neotest",
            dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
                "Issafalcon/neotest-dotnet"
            },
            config = function()
                require("neotest").setup({
                    adapters = {
                        require("neotest-dotnet")({
                            dap = {
                                args = {
                                    justMyCode = false,
                                },
                                console = "internalConsole",
                            },
                        }),
                    }
                })
            end
        },
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
            local function custom_on_attach()
                vim.keymap.set("n", "<leader>fs", function()
                    vim.lsp.buf.format()
                end, {})

                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                    callback = function(ev)
                        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                        local key_opts = { buffer = ev.buf }
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)

                        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, key_opts)
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key_opts)
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key_opts)
                    end
                })
            end

            local m_lspconfig = require("mason-lspconfig")

            m_lspconfig.setup()
            m_lspconfig.setup_handlers {
                function(server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig")[server_name].setup {
                        on_attach = custom_on_attach,
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
                        on_attach = custom_on_attach,
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
                        on_attach = custom_on_attach,
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
        event = "BufReadPost",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
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
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.selectionRangeProvider then
                        vim.cmd("TSBufDisable highlight")
                    end
                end
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                callback = function()
                    vim.cmd("TSBufEnable highlight")
                end
            })
        end
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
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sharkdp/fd",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "andrew-george/telescope-themes",
            "nvim-telescope/telescope-file-browser.nvim",
            "polirritmico/telescope-lazy-plugins.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
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
                    },
                    file_browser = {
                        hijack_netrw = true,
                        initial_mode = "insert"
                    },
                    lazy_plugins = {
                        lazy_config = debug.getinfo(1, "S").source:sub(2)
                    },
                },
            }
            telescope.load_extension('ui-select')
            telescope.load_extension('fzy_native')
            telescope.load_extension('themes')
            telescope.load_extension('file_browser')
            telescope.load_extension('lazy_plugins')

            local custom_pickers = require("stiffy.pickers")
            -- Keymaps
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>FT", ":Telescope themes<CR>", {})

            vim.keymap.set("n", "<leader>FF", function()
                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    select_buffer = true
                })
            end, { noremap = true })

            vim.keymap.set("n", "<leader>fp", function()
                telescope.extensions.lazy_plugins.lazy_plugins({
                    initial_mode = "insert"
                })
            end, { noremap = true })


            local neotest = require("neotest")
            local dap = require("dap")
            vim.keymap.set("n", "<leader>ft", custom_pickers.create_picker(
                {
                    ["Run test"] = function()
                        neotest.run.run()
                    end,
                    ["Debug test"] = function()
                        neotest.run.run({ strategy = "dap" })
                    end,
                    ["Run test file"] = function()
                        neotest.run.run({ vim.fn.expand("%") })
                    end,
                    ["Debug test file"] = function()
                        neotest.run.run({ vim.fn.expand("%"), strategy = "dap" })
                    end,
                    ["Stop test"] = function()
                        neotest.run.stop()
                        dap.disconnect({ terminateDebuggee = true })
                    end
                },
                {
                    prompt_title = "Test",
                    initial_mode = "insert",
                    close_on_action = true
                }
            ), { noremap = true })
        end
    },
}
return M
