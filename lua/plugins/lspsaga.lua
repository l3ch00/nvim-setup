return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lspsaga").setup({
            ui = {
                border = "rounded",
                title = true,
                winblend = 0,
                expand = "",
                collapse = "",
                code_action = "",
                incoming = "",
                outgoing = "",
                hover = "",
                kind = {},
            },
            hover = {
                max_width = 0.6,
                open_link = "gx",
                open_browser = "!chrome",
            },
            diagnostic = {
                show_code_action = true,
                show_source = true,
                jump_num_shortcut = true,
                max_width = 0.7,
                max_height = 0.6,
                text_hl_follow = false,
                border_follow = false,
                extend_relatedInformation = true,
                keys = {
                    exec_action = "o",
                    quit = "q",
                    toggle_or_jump = "<CR>",
                    quit_in_show = { "q", "<ESC>" },
                },
            },
            code_action = {
                num_shortcut = true,
                show_server_name = true,
                extend_gitsigns = true,
                keys = {
                    quit = "q",
                    exec = "<CR>",
                },
            },
            lightbulb = {
                enable = true,
                sign = true,
                sign_priority = 40,
                virtual_text = false,
            },
            rename = {
                quit = "q",
                exec = "<CR>",
                mark = "x",
                confirm = "<CR>",
                in_select = true,
                whole_project = true,
            },
            outline = {
                win_position = "right",
                win_with = "",
                win_width = 30,
                preview_width = 0.4,
                show_detail = true,
                auto_preview = true,
                auto_refresh = true,
                auto_close = true,
                custom_sort = nil,
                keys = {
                    jump = "o",
                    expand_collapse = "u",
                    quit = "q",
                },
            },
            callhierarchy = {
                show_detail = false,
                keys = {
                    edit = "e",
                    vsplit = "s",
                    split = "i",
                    tabe = "t",
                    jump = "o",
                    quit = "q",
                    expand_collapse = "u",
                },
            },
            symbol_in_winbar = {
                enable = true,
                separator = " > ",
                hide_keyword = false,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
        })

        -- Keymaps
        vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder" })
        vim.keymap.set("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
        vim.keymap.set("n", "gpt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek Type Definition" })
        vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Outline" })
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
        vim.keymap.set("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
    end,
}
