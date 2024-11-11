return {
	"glacambre/firenvim",
	-- This plugin needs native messaging (manifest) to work well
	-- However, default firefox in Ubuntu is packaged as snap and it won't work
	-- https://github.com/glacambre/firenvim/blob/master/TROUBLESHOOTING.md#make-sure-the-firenvim-native-manifest-has-been-created
	-- https://github.com/glacambre/firenvim/issues/1591
	build = ":call firenvim#install(0)",
	config = function()
		-- Github specific config
		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "github.com_*.txt",
			command = "set filetype=markdown",
		})

		-- Firenvim specific config
		-- https://github.com/glacambre/firenvim/issues/892
		vim.api.nvim_create_autocmd({ "UIEnter" }, {
			callback = function(event)
				local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
				if client ~= nil and client.name == "Firenvim" then
					vim.opt.laststatus = 0
					vim.opt.showtabline = 0
				end
			end,
		})

		-- Broken websites, configuration obtained from wiki
		vim.g.firenvim_config = {
			localSettings = {
				[ [[.*]] ] = {
					cmdline = "firenvim",
					priority = 0,
					selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
					takeover = "never",
				},
			},
		}
	end,
}
