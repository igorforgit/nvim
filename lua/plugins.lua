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

    -- Автодополнение с nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",  -- Источник для автодополнения через LSP
            "hrsh7th/cmp-buffer",    -- Источник автодополнения из текущего буфера
            "hrsh7th/cmp-path",      -- Источник автодополнения для путей
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Для сниппетов, если используете их
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-Space>"] = cmp.mapping.complete(),  -- Вызов автодополнения вручную
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Выбор с помощью Enter
                },
                sources = {
                    { name = "nvim_lsp" },  -- LSP автодополнение
                    { name = "buffer" },    -- Автодополнение из текущего буфера
                    { name = "path" },      -- Автодополнение для путей
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",  -- Опции для автодополнения
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",  -- Плагин для LSP-серверов
        config = function()
            -- Настройка LSP для PHP (intelephense)
            require'lspconfig'.intelephense.setup{
                cmd = { "intelephense", "--stdio" },
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            }

        end,
    },

    -- Подключение автодополнения для LSP (с помощью cmp-nvim-lsp)
    {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
            -- Это уже было в предыдущем фрагменте, возможно, оно добавлено ранее
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
        end,
    },


    -- Подключение автодополнения для LSP
    {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
            -- Устанавливаем возможности для LSP
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },


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

    -- git
    {
        "tpope/vim-fugitive",
        config = function()
            -- Дополнительные настройки можно добавить сюда, если нужно
        end,
    },

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
                    theme = 'tokyonight-day',
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
            vim.cmd([[colorscheme tokyonight-day]])  -- установить тему
        end,
    },
}
