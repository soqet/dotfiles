return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			local wk = require("which-key")
			wk.setup()

			wk.add({
				{ "<leader>c", desc = "[C]ode" },
				{ "<leader>d", desc = "[D]ocument" },
				{ "<leader>r", desc = "[R]ename" },
				{ "<leader>s", desc = "[S]earch" },
				{ "<leader>w", desc = "[W]orkspace" },
				{ "<leader>t", desc = "[T]oggle" },
				{ "<leader>h", desc = "Git [H]unk" },
				{ "<leader>h", desc = "Git [H]unk", mode = "v" },
			})
		end,
	},
}
