local M = {
    lsps = {
        {
            name = "lua_ls",
            opts = {
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
            },
            treesitter_name = "lua",
        },
        {
            name = "pyright",
            opts = nil,
            treesitter_name = "python",
        },
        {
            name = "rust_analyzer",
            opts = nil,
            treesitter_name = "rust",
        },
        {
            name = "tsserver",
            opts = nil,
            treesitter_name = "typescript",
        },
        {
            name = "marksman",
            opts = nil,
            treesitter_name = "markdown_inline"
        }
    },
}

M.get_by_prop = function (prop_name)
    local m = {}
    for _, l in ipairs(M.lsps) do
        if l ~= nil and l[prop_name] ~= nil then
            table.insert(m, l[prop_name])
        end
    end
end

M.get_names = function ()
    return M.get_by_prop("name")
end

M.get_treesitter_names = function ()
    return M.get_by_prop("treesitter_name")
end

return M
