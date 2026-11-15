return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_lua").load({
      paths = vim.fn.stdpath("config") .. "/lua/snippets"
    })

    local ls = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if ls.expandable() then
        ls.expand()
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<C-n>", true, false, true),
          "n", false
        )
      end
    end)

	vim.keymap.set({"i" , "s"},"<C-k>", function() 
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end,{silent = true})


	vim.keymap.set({"i" , "s"},"<C-j>", function() 
		if ls.jumpable(1) then
			ls.jump(1)
		end
	end,{silent = true})


  end
}
