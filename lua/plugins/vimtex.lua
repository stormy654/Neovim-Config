return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.tex_flavor = 'latex'
	

  end,
}
