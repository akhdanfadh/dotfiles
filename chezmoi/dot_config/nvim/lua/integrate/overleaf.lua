return {
	"dmadisetti/AirLatex.vim",
	-- commit = "f9b361d", -- Airmount bug, https://github.com/dmadisetti/AirLatex.vim/issues/29
	build = ":UpdateRemotePlugins",
	config = function()
		-- Session key is platform-independent, e.g.,
		-- WSL can access the internet through Windows, so it can communicate with Overleaf servers
		vim.g.AirLatexCookie =
			"overleaf_session2=session_key"
		vim.g.AirLatexDomain = "www.overleaf.com"

		-- Optional additional settings
		-- vim.g.AirLatexDomain = "www.overleaf.com"
		-- vim.g.AirLatexLogLevel = "DEBUG"

		-- Check if required Python packages are installed
		local required_packages = { "pynvim", "tornado", "requests", "intervaltree", "beautifulsoup4" }
		for _, package in ipairs(required_packages) do
			local success, _ = pcall(function()
				vim.fn.system("python -c 'import " .. package .. "'")
			end)
			if not success then
				print(
					"Warning: Python package '"
						.. package
						.. "' is not installed. AirLatex.vim may not function correctly."
				)
			end
		end
	end,
}

-- vim: syntax=lua commentstring=--\ %s
