require("config.lazy")
require("config.functions")
require("config.lsp")
require("config.yankhighlight")
require("config.keymaps")
require("config.configs")
--vim.api.nvim_set_hl(0, "@lsp.type.variable.rust", { link = "GruvboxBlue" })
--vim.api.nvim_set_hl(0, "@lsp.type.parameter.rust", { link = "GruvboxOrange" })
--vim.api.nvim_set_hl(0, "@lsp.type.function.rust", { link = "GruvboxGreen" })

--komisches Zeug mit shada tmp files
--vim.opt.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"
--vim.opt.shada = "!,'50,<20,s10,h"

