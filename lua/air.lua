require("lspconfig").air.setup({
    capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
    },
    on_attach = function(_, bufnr)
        -- Disable LSP's formatexpr to allow gq to work for comment wrapping
        vim.bo[bufnr].formatexpr = ""

        -- Re-apply after a delay to ensure it sticks
        vim.defer_fn(function()
            vim.bo[bufnr].formatexpr = ""
        end, 100)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
})
