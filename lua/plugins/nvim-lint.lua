return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            java = { "checkstyle" },
        }

        lint.linters.checkstyle = {
            cmd = "checkstyle",
            args = {
                "-c",
                (vim.fs.root(0, { "checkstyle.xml", "pom.xml", ".git" }) or vim.fn.getcwd()) .. "/checkstyle.xml",
            },
            stdin = false,
            ignore_exitcode = true,
            parser = require("lint.parser").from_pattern(
                "^%[([A-Z]+)%]%s+(.+):(%d+):(%d+):%s+(.+)$",
                { "severity", "file", "lnum", "col", "message" },
                {
                    ERROR = vim.diagnostic.severity.ERROR,
                    WARN = vim.diagnostic.severity.WARN,
                },
                { source = "checkstyle" }
            ),
        }

        -- Automatically lint on save and when leaving insert mode
        vim.api.nvim_create_autocmd({
            "BufWritePost",
            "InsertLeave",
        }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
