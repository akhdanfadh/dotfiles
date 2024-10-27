return {
	"dmadisetti/AirLatex.vim",
	commit = "f9b361d", -- Airmount bug, https://github.com/dmadisetti/AirLatex.vim/issues/29
	build = ":UpdateRemotePlugins",
	config = function()
		-- Point to the cookie database on the Windows file system from WSL
		-- vim.g.AirLatexCookieDB = "/mnt/c/Users/akhdan/AppData/Roaming/Mozilla/Firefox/Profiles/*.default/cookies.sqlite"

		-- Session key is platform-independent
		-- WSL can access the internet through Windoes, so it can communicate with Overleaf servers
		vim.g.AirLatexCookie =
			"overleaf_session2=s%3ArHOr5tmRuPoTCnWhUY9vbiLOSyhTQu0T.fOR6gvJRhx2RpImBZKfAFOblSsA86n%2ByY6CxzmjspRo"
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
