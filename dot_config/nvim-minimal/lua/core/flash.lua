return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
    -- stylua: ignore
    keys = {
        { "<leader><leader>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash search" },
        { "<leader>mf", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "FLASH: Treesitter Jump" },
        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
