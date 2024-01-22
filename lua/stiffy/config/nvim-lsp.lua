local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.setup = function(lsp_infos)
    local lsp_config = require("lspconfig")
    for _, lsp in ipairs(lsp_infos) do
        local opts = {
            capabilities = M.capabilities
        }

        if lsp.opts ~= nil then
            for k, v in ipairs(lsp.opts) do
                opts[k] = v
            end
        end
        lsp_config[lsp.name].setup(opts)
    end
end

return M
