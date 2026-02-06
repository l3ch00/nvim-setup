return {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
        { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
    },
    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        log_level = "error",
        auto_restore_enabled = true,
        auto_save_enabled = true,
        auto_session_use_git_branch = true,
    },
}
