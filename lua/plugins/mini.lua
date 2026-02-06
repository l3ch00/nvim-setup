return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
        -- Auto pairs
        require("mini.pairs").setup({
            modes = { insert = true, command = true, terminal = false },
            mappings = {
                ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
                [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
                ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
            },
        })

        -- Surround
        require("mini.surround").setup({
            mappings = {
                add = "gsa",
                delete = "gsd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "gsn",
            },
        })

        -- Comment
        require("mini.comment").setup({
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc",
            },
        })

        -- AI (textobjects)
        require("mini.ai").setup({
            n_lines = 500,
            custom_textobjects = {
                o = require("mini.ai").gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                f = require("mini.ai").gen_spec.treesitter({
                    a = "@function.outer",
                    i = "@function.inner",
                }),
                c = require("mini.ai").gen_spec.treesitter({
                    a = "@class.outer",
                    i = "@class.inner",
                }),
                t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
            },
        })

        -- Move (move text blocks)
        require("mini.move").setup({
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
        })

        -- Bracketed (enhanced ]/[ motions)
        require("mini.bracketed").setup({
            buffer = { suffix = "b", options = {} },
            comment = { suffix = "c", options = {} },
            conflict = { suffix = "x", options = {} },
            diagnostic = { suffix = "d", options = {} },
            file = { suffix = "f", options = {} },
            indent = { suffix = "i", options = {} },
            jump = { suffix = "j", options = {} },
            location = { suffix = "l", options = {} },
            oldfile = { suffix = "o", options = {} },
            quickfix = { suffix = "q", options = {} },
            treesitter = { suffix = "t", options = {} },
            undo = { suffix = "u", options = {} },
            window = { suffix = "w", options = {} },
            yank = { suffix = "y", options = {} },
        })
    end,
}
