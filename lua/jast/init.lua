require("jast.set")
require("jast.remap")
require("jast.packer")

local augroup = vim.api.nvim_create_augroup
local jastGroup = augroup('jast', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local setIndent = augroup('setIndent', { clear = true })

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = jastGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('Filetype', {
    desc = "format files according to standards using 2 spaces for tabs",
    group = setIndent,
    pattern = {'c', 'h', 'xml', 'css', 'javascript', 'typescript', 'yaml', 'lua'},
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab=false'
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
