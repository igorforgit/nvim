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

    -- LSP mason
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local mason_registry = require("mason-registry")

            -- PHP
            lspconfig.intelephense.setup {
                cmd = { "intelephense", "--stdio" },
                capabilities = capabilities,
            }

            -- Vue + TS (через ts_ls)
            local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
            .. "/node_modules/@vue/language-server"

            lspconfig.ts_ls.setup {
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_language_server_path,
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "vue" },
            }
        end
    }
}
