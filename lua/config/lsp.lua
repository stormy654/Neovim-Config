-- rust
vim.lsp.config('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = vim.fs.root(0, { 'Cargo.toml', '.git' }),
})
vim.lsp.enable('rust-analyzer')
--java

vim.lsp.config('jdtls', {
  cmd = {
  'java',
  '-jar', 'C:/Users/phili/scoop/apps/jdtls/current/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar',
  '-configuration', 'C:/Users/phili/scoop/apps/jdtls/current/config_win',
  '-data', vim.fn.expand('~/.cache/jdtls/') .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'),
},
filetypes = { 'java' },
  root_dir = vim.fs.root(0, {'som.txt', 'pom.xml', 'build.gradle', '.git' }),
})


vim.lsp.enable('jdtls')

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf

	vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	vim.keymap.set("i", "<C-f>","<C-x><C-o>",{buffer = buf})

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })

  end, })

