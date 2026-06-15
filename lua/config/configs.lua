vim.loader.enable()
vim.o.number = true

vim.opt.shortmess:append("I")
vim.o.relativenumber = true

vim.opt.tabstop=4
vim.opt.shiftwidth=4

vim.opt.showmode = false;

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.shell = "pwsh -nologo"
vim.opt.shellcmdflag = "-command"
vim.opt.shellquote = "\""
vim.opt.shellxquote = ""

vim.opt.fillchars = { eob = " " }

--netrw
vim.g.netrw_banner = 0  
--vim.g.netrw_liststyle = 2 --(0=thin, 1=long, 2=wide, 3=tree)



vim.cmd([[colorscheme gruvbox]])

-- set spaces to look like a dot instead of nothing
 vim.opt.list = true
 vim.opt.listchars = {
 	space = "·",
 	tab = "··",
 	trail = "·",
 	nbsp = "·",
 }

-- disable the status line
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.cmdheight = 0

vim.o.cmdwinheight=3

-- set color for spellcheck
vim.cmd [[
  highlight SpellBad gui=underline guisp=#ff0000
]]

 --creating formatoptions for markdown and tex
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "tex" then
			vim.opt_local.comments:append(":\\item")
			vim.opt_local.formatoptions = "tcqjor"
        elseif ft == "markdown" then
			vim.opt_local.comments={"b:-", "n:>","b:+"}
			vim.opt_local.formatoptions = "tcqjor"
		else 
		end
    end,
})

-- colors for <C-n> menu -----
vim.api.nvim_set_hl(0, "Pmenu", {
  bg = "#3c3836",
  fg = "#ebdbb2",
})
vim.api.nvim_set_hl(0, "PmenuSel", {
  bg = "#458588",
  fg = "#1e1e2e",
  italic = true,
})



