vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>s',builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n','<Esc>','<cmd>nohlsearch<CR>')

vim.keymap.set('i', '<C-H>', '<C-w>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.api.nvim_set_keymap('n', '<leader>t', ':lua OpenTerminal()<CR>', { noremap = true, silent = true })


function compile()
    local ft = vim.bo.filetype
    if ft == "tex" then
        vim.cmd("VimtexCompile")
    elseif ft == "rust" then
        vim.cmd("split | terminal cargo run")
    elseif ft == "c" then
        local file = vim.fn.expand("%:p")
        local out = vim.fn.expand("%:p:r") -- same path without extension
        vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. out)
    elseif ft == "java" then
        local file = vim.fn.expand("%:p")
        vim.cmd("split | terminal java " .. file)
    end
end

vim.keymap.set('n', '<leader>c', compile,{desc = "filetype -> compile"})


-- Function to open a terminal in insert mode
function OpenTerminal()
  vim.cmd('split | terminal')
  vim.cmd('startinsert')
end

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


