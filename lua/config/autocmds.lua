vim.api.nvim_create_autocmd("User", {
    pattern = "MasonLspInstalled",
    callback = function(opts)
        if opts.data.name == "jdtls" then
            require("config.jdtls").setup_jdtls()
        end
    end,
})