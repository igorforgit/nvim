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

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- -- Получаем путь к Node через nvm
            local nvm_version = "v23.11.0"
            local nvm_root = os.getenv("NVM_DIR") or "/Users/igorgorovenko/.nvm"
            local node_bin = nvm_root .. "/versions/node/" .. nvm_version .. "/bin"
            local tsdk_path = nvm_root .. "/versions/node/" .. nvm_version .. "/lib/node_modules/typescript/lib"

            -- Добавляем Node.js в PATH
            vim.env.PATH = vim.env.PATH .. ":" .. node_bin

            -- PHP
            lspconfig.intelephense.setup {
                cmd = { "intelephense", "--stdio" },
                capabilities = capabilities,
            }

            -- Vue / Volar
            require'lspconfig'.volar.setup {
                filetypes = { "vue" },
                cmd = { "vue-language-server", "--stdio" },  -- команду запуска для LSP
                capabilities = capabilities,
                init_options = {
                    typescript = {
                        tsdk = tsdk_path
                    },
                    languageFeatures = {
                        definition = { enabled = true },
                        declaration = { enabled = true },
                    }
                }
            }
        end,
    },
}
