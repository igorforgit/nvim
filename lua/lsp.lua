-- config LSP

return {

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

    -- Подключение автодополнения для LSP
    {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
            -- Устанавливаем возможности для LSP
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
        end,
    },
}
