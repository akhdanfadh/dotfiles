return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return "" .. str
				-- return " " .. str
				-- return " " .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			cond = hide_in_width,
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local function conda_env()
			local handle = io.popen("which python")
			local result = handle:read("*a")
			handle:close()

			-- Check if the Python path is from Conda
			if result:find("/envs/") then
				local env_name = result:match("/envs/([%w_-]+)/")
				return "󰌠 " .. env_name
			elseif result:find("/.miniconda3/") then
				return "󰌠 base" -- In case it's using the base Conda environment
			else
				return "󰌠 !conda" -- If Python is not from Conda
			end
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				-- theme = "monokai-pro",
				-- theme = "onedark",
				-- theme = "catppuccin-macchiato", -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--          
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree", "startify" },
			},
			sections = {
				lualine_a = { mode }, -- not "mode" as we use our defined `mode` above
				-- lualine_b = { conda_env, "branch" },
				lualine_b = { "branch" },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location", "progress" },
				lualine_z = {}, -- test it here https://strftime.net/
			},
			inactive_sections = { -- see `disabled_filetypes` above
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "fugitive" },
		})
	end,
}
