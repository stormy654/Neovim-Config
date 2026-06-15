return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.compile_mode = {
     default_command = {
         c    = "gcc -o %:r % && ./%:r",
		 rust = "cargo run",
         java = "javac *.java -d output % && java % -cp output",
         tex  = "latexmk -file-line-error -c -pdf %:r",
		 lua  = "lua %",
     },
    default_command = "make -k ",
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
			lua = {
				regex = [[\v([a-zA-Z0-9\\/._-]+\.lua):(\d+):]],
				filename = 1,
				row = 2
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
  end
}
