package.path = "/nix/store/lbb40nwzilpzvrvps754vc26b0kcj1ry-luajit-2.1.1774638290-env/share/lua/5.1/?.lua;/nix/store/lbb40nwzilpzvrvps754vc26b0kcj1ry-luajit-2.1.1774638290-env/share/lua/5.1/?/init.lua".. ";" .. package.path
package.cpath = "/nix/store/lbb40nwzilpzvrvps754vc26b0kcj1ry-luajit-2.1.1774638290-env/lib/lua/5.1/?.so".. ";" .. package.cpath

vim.g.loaded_node_provider=0;vim.g.loaded_perl_provider=0;vim.g.loaded_ruby_provider=0;vim.g.loaded_python3_provider=0
vim.loader.enable()
vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "

vim.opt.tabstop=4
vim.opt.shiftwidth=4

vim.opt.showmode = false;

vim.o.ignorecase = true
vim.o.smartcase = true


vim.opt.fillchars = { eob = " " }

--netrw
vim.g.netrw_banner = 0  
vim.g.netrw_liststyle = 0 --(0=thin, 1=long, 2=wide, 3=tree)


vim.o.cmdwinheight=3

vim.cmd([[colorscheme gruvbox]])

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


vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>s',builtin.find_files, { desc = 'Telescope find files' })

vim.keymap.set('n','<Esc>','<cmd>nohlsearch<CR>')

vim.keymap.set('i', '<C-H>', '<C-w>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set("n", "<leader>p", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bd")
  else
    vim.cmd("Explore %:p:h")
  end
end, { noremap = true, silent = true, desc = "Toggle netrw (current dir)" })


vim.api.nvim_set_keymap(
  'n',
  '<leader>e',
  '<cmd>lua vim.diagnostic.open_float(nil, { focusable=false, format = function(d) return d.message end })<CR>',
  { noremap = true, silent = true }
)
--vim.keymap.set('n','<leader>gd',vim.lsp.buf.definition,opts)
--vim.keymap.set('n','<leader>gl',vim.lsp.buf.declaration,opts)


-- set cmdwin as the default
vim.keymap.set('n', ':', 'q:i')
vim.keymap.set('v', ':', 'q:i')

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    local opts = { buffer = true }

    -- close with Esc
    vim.keymap.set("n", "<Esc>", "<C-\\><C-n>", opts)
    vim.keymap.set("i", "<Esc>",  "<C-\\><C-n>", opts)

    -- execute command and close
    vim.keymap.set("n", "<CR>", "<CR>", opts)


  end,
})

vim.keymap.set('n','<C-Right>','<cmd>vertical resize +5<CR>')
vim.keymap.set('n','<C-Left>','<cmd>vertical resize -5<CR>')
vim.keymap.set('n','<C-Up>','<cmd> resize +5<CR>')
vim.keymap.set('n','<C-Down>','<cmd> resize -5<CR>')

vim.keymap.set('n','<leader>n','<cmd>NextError<CR>');
vim.keymap.set('n','<leader>m','<cmd>PrevError<CR>');
vim.keymap.set('n','<leader>x','<cmd>Recompile<CR>');




-- Align Items by String
vim.api.nvim_create_user_command("Align", function(opts)
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    local pattern = opts.fargs[1]

    local ttable = {}
    local max_occurrences = 0

    for i, line in ipairs(lines) do
        ttable[i] = {}
        local start = 1

        while true do
            local col = string.find(line, pattern, start, true)
            if not col then break end

            local disp = vim.fn.strdisplaywidth(string.sub(line, 1, col - 1))

            table.insert(ttable[i], {
                byte = col,
                disp = disp,
            })

            start = col + #pattern
        end

        max_occurrences = math.max(max_occurrences, #ttable[i])
    end

    for k = 1, max_occurrences do
        local global_max = 0

        for i in ipairs(lines) do
            local item = ttable[i][k]
            if item and item.disp > global_max then
                global_max = item.disp
            end
        end

        for i, line in ipairs(lines) do
            local item = ttable[i][k]

            if item then
                local cur_byte = item.byte
                local cur_disp = item.disp

                local diff = global_max - cur_disp

                if diff > 0 then
                    lines[i] =
                        string.sub(line, 1, cur_byte - 1)
                        .. string.rep(" ", diff)
                        .. string.sub(line, cur_byte)
                    for m = k + 1, #ttable[i] do
                        ttable[i][m].byte = ttable[i][m].byte + diff
                    end
                end
            end
        end
    end

    vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, lines)
end, { range = true, nargs = 1 })


require("compile-mode")

    vim.g.compile_mode = {
     default_command = {
         c = "gcc -o %:r % && ./%:r",
		 rust = "cargo run",
         java = "javac % && java %:r",
         --tex = "latexmk -file-line-error -pdf %:r",
     },
    baleia_setup = false,
    bang_expansion = true,
    directory_change_matchers = {},
	error_regexp_table = {
		rustc = {
		      regex = [[^\s*-->\s*\([^:]\+\):\(\d\+\):\(\d\+\)]],
		      filename = 1,
		      row = 2,
		      col = 3,
		    },
		latexmk = {
			regex = [[^\([^:]\+\):\(\d\+\): ]],
		      filename = 1,
		      row = 2,
		      col = 0,
		    },
	},
    error_ignore_file_list = {},
    error_threshold = require("compile-mode").level.WARNING,
    auto_jump_to_first_error = true,
    error_locus_highlight = 500,
    use_diagnostics = false,
    recompile_no_fail = true,
    ask_about_save = true,
    ask_to_interrupt = true,
    buffer_name = "*compilation*",
    time_format = "%a %b %e %H:%M:%S",
    hidden_output = {},
    environment = nil,
    clear_environment = false,
    input_word_completion = false,
    hidden_buffer = false,
    focus_compilation_buffer = false,
    auto_scroll = false,
    use_circular_error_navigation = true,
    debug = false,
    use_pseudo_terminal = false,}


require("luasnip").setup({})

require("luasnip.loaders.from_lua").load({
	paths = "./snippets"
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



require("telescope").setup({
    opts = {
		preview =false,
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
          },
        },
      },
      },
})

vim.lsp.config('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = vim.fs.root(0, { 'Cargo.toml', '.git' }),
})

vim.lsp.enable('rust-analyzer')

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })
  end,
})


