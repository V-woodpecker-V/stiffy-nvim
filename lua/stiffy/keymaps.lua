local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})

vim.keymap.set("n", "<leader>fs", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function (ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        
        vim.keymap.set("n", "<leader>wl", function ()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

    end
})

vim.keymap.set("n", "<leader>cf", function()
    local filename = vim.fn.input("File name: ")
    if filename == "" then
        return
    end
    vim.cmd("edit " .. vim.fn.expand("%:h") .. "/" .. filename)
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>ls",function()
    vim.cmd("!ls " .. vim.fn.expand("%:h"))
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>cdc",function()
    vim.cmd("lcd " .. vim.fn.expand("%:h"))
end, {noremap = true, silent = true})

vim.keymap.set("n", "<leader>cdd",function()
    vim.cmd("lcd ..")
end, {noremap = true, silent = true})
