-- File ops

local telescope = require("telescope.builtin")
local harpoon = require("harpoon")

-- Telescope
vim.keymap.set("n", "<leader>FF", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})

-- Harpoon
vim.keymap.set("n", "<leader>fa", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>fp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>fn", function() harpoon:list():next() end)
vim.keymap.set("n", "<leader>fx", function()
    local file = vim.fn.input("File number: ")
    local number = tonumber(file)
    if number ~= nil then
        harpoon:list():select(number)
    end
    vim.cmd(vim.api.nvim_replace_termcodes("normal <C-l>", true, true, true))
end)
vim.keymap.set("n", "<leader>ff", function()
    local harpoon_files = harpoon:list()

    local finder = function()
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end
        return require("telescope.finders").new_table({
            results = file_paths,
        })
    end

    local conf = require("telescope.config").values
    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = finder(),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)
                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
            end)
            return true
        end
    }):find()
end, { desc = "Open harpoon window" })

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
vim.keymap.set("n", "<leader>fs", vim.lsp.buf.format, {})
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

vim.keymap.set("n", "bn", ":bnext<CR>")
vim.keymap.set("n", "bN", ":bprevious<CR>")


vim.keymap.set("n", "<leader>sj", ":resize -2<CR>")
vim.keymap.set("n", "<leader>SJ", ":resize -20<CR>")

vim.keymap.set("n", "<leader>sk", ":resize +2<CR>")
vim.keymap.set("n", "<leader>SK", ":resize +20<CR>")

vim.keymap.set("n", "<leader>sh", ":vertical resize -2<CR>")
vim.keymap.set("n", "<leader>SH", ":vertical resize -20<CR>")

vim.keymap.set("n", "<leader>SL", ":vertical resize +20<CR>")

-- terminal mode shortcuts
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>")
