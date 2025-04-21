-- config nvim init.lua

vim.opt.number = true               -- отображение номеров строк
vim.opt.relativenumber = true       -- относительная нумерация строк (относительно курсора)
vim.opt.expandtab = true            -- использовать пробелы вместо табов
vim.opt.shiftwidth = 4              -- размер отступа при сдвиге (<< >>) — 4 пробела
vim.opt.tabstop = 4                 -- ширина таба — 4 пробела
vim.opt.swapfile = false            -- отключение создания swap-файлов
vim.opt.smartcase = true            -- умный поиск: регистр учитывается, если есть заглавные буквы
vim.opt.ignorecase = true           -- игнорировать регистр при поиске
vim.opt.termguicolors = true        -- включить поддержку 24-битных цветов в терминале
vim.opt.mouse = "a"                 -- включить поддержку мыши во всех режимах
vim.opt.clipboard = "unnamedplus"   -- использовать системный буфер обмена
vim.opt.undofile = true             -- сохранять историю изменений между сессиями
vim.opt.wrap = false                -- отключить перенос строк
vim.opt.signcolumn = "yes"          -- всегда показывать колонку для знаков (например, Git или ошибки LSP)
vim.opt.updatetime = 300            -- задержка перед срабатыванием событий (например, отображение диагностики)
vim.opt.timeoutlen = 500            -- время ожидания для маппингов (например, при нажатии <leader>)

vim.opt.scrolloff = 8               -- минимальный отступ сверху и снизу от курсора до края
vim.opt.sidescrolloff = 16          -- минимальный отступ слева и справа от курсора до края

vim.opt.cursorline = true           -- подсветка текущей строки
vim.opt.showmatch = true            -- подсветка парных скобок
vim.opt.hlsearch = true             -- подсветка всех найденных совпадений
vim.opt.incsearch = true            -- поиск с подсветкой по мере ввода

vim.opt.list = true                                             -- добавление вертикальных линий для отступов
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }     -- заменить символы для табуляции и пробелов

vim.cmd [[set colorcolumn=80]]      -- вертикальная линия

-- автокомплит вручную — убираем автопоявление
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
-- menu — отобразить меню автокомплита
-- menuone — даже если одно предложение, всё равно показывать меню
-- noinsert — не вставлять автоматически первый вариант
-- noselect — не выбирать автоматически вариант из списка

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

-- Подключение конфигураций плагинов и LSP
require('lazy').setup({
    require('plugins'),  -- файл с плагинами
    require('lsp'),      -- файл с настройками Language Server Protocol
})

-- Подключение файла с кастомными клавишами
require('keymaps')       -- файл с пользовательскими сочетаниями клавиш
