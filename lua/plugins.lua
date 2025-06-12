-- CONFIG NVIM

-- Темы, индекс начинается с 1
local themeList = {
    "tokyonight",
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-day",
    "tokyonight-moon",
}

local selectedThemeIndex = 3 -- выбираем тему по индексу

return {
    -- боковая панель файлов
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- Стандартные бинды
                api.config.mappings.default_on_attach(bufnr)

                -- Кастомные бинды
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close directory"))
                vim.keymap.set("n", "t", api.node.open.tab, opts("Open in new tab"))
                vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "U", api.tree.change_root_to_parent, opts("Up"))
            end

            require("nvim-tree").setup({
                open_on_tab = true,
                hijack_netrw = true,
                on_attach = my_on_attach,
                view = {
                    width = 40,
                    side = "left",
                },
                filters = {
                    dotfiles = false,           -- Показывать скрытые файлы (в том числе .nuxt)
                    custom = { ".DS_Store" },   -- Исключить .DS_Store
                },
                git = {
                    enable = true,
                    ignore = false,  -- ← отключает скрытие git-ignored файлов
                },
            })
        end,
    },

    -- Подсветка синтаксиса
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "php", "vue", "html", "css", "javascript",
                    "typescript", "go"
                },
                highlight = {
                    enable = true,  -- Включаем подсветку синтаксиса
                    additional_vim_regex_highlighting = false,  -- Отключаем стандартную подсветку
                },
                indent = {
                    enable = true,  -- Включаем автоотступы
                },
                auto_install = true,  -- Автоматическая установка недостающих парсеров
            })
        end,
    },

    -- комментарии
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    -- поиск файлов
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = vim.fn.executable("make") == 1,
            },
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = ">  ",
                    selection_caret = " ",
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "top",
                    },
                    file_ignore_patterns = { "node_modules", "%.git/" },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })

            -- Подключаем fzf расширение
            pcall(telescope.load_extension, "fzf")
        end,
    },

    -- подсказки горячих клавиш
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- загружается при первом нажатии клавиши
        config = function()
            require("which-key").setup({})
        end,
    },

    -- Автодополнение для скобок и кавычек
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- быстрый скролл
    {
        "rainbowhxch/accelerated-jk.nvim",
        config = function()
            require("accelerated-jk").setup({
                mode = "time_driven",         -- ускорение со временем
                enable_deceleration = false,  -- не замедляется при отпускании
                acceleration_motions = {},
                acceleration_limit = 150,     -- уменьшили лимит скорости, чтобы ускорение было менее резким
                acceleration_table = {        -- таблица шагов ускорения (чем меньше число, тем быстрее)
                    5, 10, 15, 20, 25, 30  -- плавнее увеличиваем скорость
                },
            })
            vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
            vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
        end,
    },

    -- git
    {
        "tpope/vim-fugitive",
        config = function()
            -- Дополнительные настройки можно добавить сюда, если нужно
        end,
    },

    -- git линии
    {
        "airblade/vim-gitgutter",
        config = function()
            -- Можно настроить дополнительные параметры
            vim.g.gitgutter_enabled = 1 -- Включить GitGutter
        end,
    },

    -- таббар
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = themeList[selectedThemeIndex],
                },
                sections = {
                    lualine_b = {'branch'},
                    lualine_c = {
                        'filename',
                        { 'filetype', icon_only = true } -- Отображение иконки и типа файла
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'}, -- добавление filetype в тулбар
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            })
        end
    },

    {
        "folke/tokyonight.nvim",
        priority = 1000,  -- плагин загрузится первым
        config = function()
            vim.o.background = "dark"  -- настроить тёмный фон (или 'light' при желании)
            vim.cmd("colorscheme " .. themeList[selectedThemeIndex])
        end,
    },

    -- GitHub Copilot
    {
        "github/copilot.vim",
        event = "InsertEnter",  -- загружается при входе в режим вставки
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end,
    },
}
