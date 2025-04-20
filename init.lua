-- config nvim init.lua

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

vim.opt.scrolloff = 8           -- минимальный отступ сверху и снизу от курсора до края
vim.opt.sidescrolloff = 16      -- минимальный отступ слева и справа от курсора до края

vim.opt.cursorline = true       -- подсветка строки с курсором
vim.opt.showmatch = true        -- подсветка парных скобок
vim.opt.hlsearch = true         -- подсветка поиска
vim.opt.incsearch = true        -- инкрементальный поиск (подсветка по мере ввода)
vim.opt.ignorecase = true       -- игнорировать регистр в поиске
vim.opt.smartcase = true        -- умное поведение поиска (игнорировать регистр, если запрос не содержит заглавных букв)

vim.opt.termguicolors = true    -- включение поддержки цветов в терминале

-- добавление вертикальных линий для отступов
vim.opt.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }  -- заменить символы для табуляции и пробелов

vim.cmd [[set colorcolumn=80]]  -- вертикальная линия 

-- автокомплит вручную — убираем автопоявление
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- установка lazy.nvim, если ещё нет
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('plugins')) -- plugins
require('keymaps') -- keymaps

require('cursor').setup();


