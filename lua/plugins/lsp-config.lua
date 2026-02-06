return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded"
                }
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "prettierd",
                    "stylua",
                    "eslint_d",
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "jdtls", "cssls", "pylsp" },
            })
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" },
            })
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
            "ray-x/lsp_signature.nvim"
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Add Mason bin to PATH so LSP servers can be found
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
            vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
            
            local icons = require("config.icons")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Native LSP config for Neovim 0.11+
            -- Configure each LSP server using vim.lsp.config
            
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Disable semantic tokens for better performance
                    client.server_capabilities.semanticTokensProvider = nil
                end,
                cmd = { 'lua-language-server' },
                filetypes = { 'lua' },
                root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
            })
            vim.lsp.enable('lua_ls')

            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
                root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
            })
            vim.lsp.enable('ts_ls')

            vim.lsp.config('cssls', {
                capabilities = capabilities,
                cmd = { 'vscode-css-language-server', '--stdio' },
                filetypes = { 'css', 'scss', 'less' },
                root_markers = { 'package.json', '.git' },
            })
            vim.lsp.enable('cssls')

            vim.lsp.config('pylsp', {
                capabilities = capabilities,
                cmd = { 'pylsp' },
                filetypes = { 'python' },
                root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
            })
            vim.lsp.enable('pylsp')

            local default_diagnostic_config = {
                signs = {
                    active = true,
                    values = {
                        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
                        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
                        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
                    },
                },
                virtual_text = false,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            vim.diagnostic.config(default_diagnostic_config)

            -- Keymaps
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            vim.keymap.set(
                "n",
                "<leader>cr",
                require("telescope.builtin").lsp_references,
                { desc = "[C]ode Goto [R]eferences" }
            )
            vim.keymap.set(
                "n",
                "<leader>ci",
                require("telescope.builtin").lsp_implementations,
                { desc = "[C]ode Goto [I]mplementations" }
            )
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end,
    },
}
