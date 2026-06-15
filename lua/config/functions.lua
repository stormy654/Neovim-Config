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
        vim.cmd("split | terminal javac *.java -d output && java % -cp ./output/")
    end
end
-- lsp buf rename
vim.api.nvim_create_user_command(
  "Rn",
  function(opts)
  vim.lsp.buf.rename(opts.args)
  end,
  {nargs =1, desc = "LSP Rename Symbol" }
)
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
