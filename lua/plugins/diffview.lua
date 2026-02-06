return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
        { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
        { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView File History" },
        { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView Current File History" },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            default = {
                winbar_info = true,
            },
            merge_tool = {
                layout = "diff3_horizontal",
                disable_diagnostics = true,
                winbar_info = true,
            },
            file_history = {
                winbar_info = true,
            },
        },
        hooks = {
            diff_buf_read = function(bufnr)
                vim.bo[bufnr].modifiable = false
            end,
        },
    },
}
