vim.api.nvim_create_autocmd("User", {
    pattern = "MasonLspInstalled",
    callback = function(opts)
        if opts.data.name == "jdtls" then
            require("config.jdtls").setup_jdtls()
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require("config.jdtls").setup_jdtls()
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
