return{
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        vim.keymap.set({"n", "x"}, "<leader>j", function() mc.matchAddCursor(1) end)
        vim.keymap.set({"n", "x"}, "<leader>k", function() mc.matchAddCursor(-1) end)

        vim.keymap.set({"n", "x"}, "<leader>J", mc.nextCursor)
        vim.keymap.set({"n", "x"}, "<leader>K", mc.prevCursor)
		vim.keymap.set({"n", "x"}, "<c-q>",function() mc.toggleCursor() end)

        mc.addKeymapLayer(function(layerSet)
			layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

    end
}
