local M = {
	"ThePrimeagen/99",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local _99 = require("99")
		local cwd = vim.uv.cwd()
		local basename = vim.fs.basename(cwd)

		_99.setup({
			logger = {
				level = _99.DEBUG,
				path = "/tmp/" .. basename .. ".99.debug",
				print_on_error = true,
			},
			completion = {
				source = "cmp",
				custom_rules = {
					vim.fn.stdpath("config") .. "/skills/",
				},
			},
			md_files = {
				"AGENT.md",
			},
		})

		-- Patch OpenCodeProvider to add retry logic for file reading
		local Providers = require("99.providers")
		local original_retrieve = Providers.OpenCodeProvider._retrieve_response
		Providers.OpenCodeProvider._retrieve_response = function(self, request)
			local logger = request.logger:set_area(self:_get_provider_name())
			local tmp = request.context.tmp_file

			-- Retry up to 30 times with 1 second delay (30 seconds total)
			for i = 1, 30 do
				local success, result = pcall(function()
					return vim.fn.readfile(tmp)
				end)

				if success then
					local str = table.concat(result, "\n")
					logger:debug("retrieve_results", "results", str)
					return true, str
				end

				logger:debug("retrieve_results: retry " .. i .. "/30, file not ready yet")
				vim.wait(1000) -- Wait 1 second
			end

			-- All retries failed
			logger:error("retrieve_results: failed to read file after 30 retries", "tmp_name", tmp)
			return false, ""
		end

		-- Keybindings
		vim.keymap.set("n", "<leader>9f", function()
			_99.fill_in_function()
		end, { desc = "99: Fill in function" })

		vim.keymap.set("v", "<leader>9v", function()
			_99.visual()
		end, { desc = "99: Process visual selection" })

		vim.keymap.set("n", "<leader>9s", function()
			_99.stop_all_requests()
		end, { desc = "99: Stop all requests" })

		vim.keymap.set("n", "<leader>9l", function()
			_99.view_logs()
		end, { desc = "99: View logs" })
	end,
}

return M
