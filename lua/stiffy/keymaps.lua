-- File ops
local telescope = require("telescope.builtin")

-- Telescope
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>ft", ":Telescope themes<CR>", {})

-- Create file
vim.keymap.set("n", "<leader>cf", function()
    local filename = vim.fn.input("File name: ")
    if filename == "" then
        return
    end
    vim.cmd("edit " .. vim.fn.expand("%:h") .. "/" .. filename)
end, { noremap = true, silent = true })

-- Change dir to current
vim.keymap.set("n", "<leader>cdc", function()
    vim.cmd("lcd " .. vim.fn.expand("%:h"))
end, { noremap = true, silent = true })

-- Change dir to parent
vim.keymap.set("n", "<leader>cdd", function()
    vim.cmd("lcd ..")
end, { noremap = true, silent = true })

-- LSP
vim.keymap.set("n", "<leader>fs", function()
    local function default_format()
        vim.lsp.buf.format()
    end

    if vim.bo.filetype ~= "cs" then
        return default_format()
    end

    -- C# workaround

    local workspace_folders = vim.lsp.buf.list_workspace_folders()
    local root_dir = workspace_folders[1] or vim.fn.getcwd()

    local function find_file_in_dir(dir, pattern)
        local files = vim.fn.glob(dir .. "/" .. pattern, false, true)
        return #files > 0 and files[1] or nil
    end
    local root_file = find_file_in_dir(root_dir, "*.sln")
    if not root_file then
        root_file = find_file_in_dir(root_dir, "*.csproj")
    end
    if not root_file then
        return default_format()
    end

    vim.cmd("!dotnet format " .. root_file)
end, {})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
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
    end
})

--Hardmode
-- vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<BS>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Del>", "<Nop>", { noremap = true, silent = true })
--
--
--
-- vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
