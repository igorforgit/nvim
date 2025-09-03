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

            -- Функция логирования
            local function log_message(msg)
                local log_path = vim.fn.stdpath("config") .. "/nvim.log"
                local log_file = io.open(log_path, "a")
                if log_file then
                    log_file:write("[", os.date("%Y-%m-%d %H:%M:%S"), "] ", msg, "\n")
                    log_file:close()
                end
            end

            log_message("🔧 LSP конфигурация запущена.")

            -- Настройка gopls
            lspconfig.gopls.setup {
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150, -- задержка перед отправкой изменений
                },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        -- Автоформат при сохранении
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            }

            -- PHP
            lspconfig.intelephense.setup {
                cmd = { "intelephense", "--stdio" },
                capabilities = capabilities,
                -- settings = {
                --     intelephense = {
                --         files = {
                --             exclude = {
                --                 "**/vendor/**",         -- Не кешурем папку vendor
                --             },
                --         },
                --     },
                -- },
            }

            -- -- Vue 3 + TS with takeOverMode
            -- -- Получаем пакет
            local vue_pkg = mason_registry.get_package("vue-language-server")
            log_message("vue package: " .. tostring(vue_pkg))

            -- Получаем путь к vue-language-server
            local vue_language_server_path = "/Users/igorgorovenko/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"
            log_message("vue_language_server_path: " .. tostring(vue_language_server_path))

            lspconfig.ts_ls.setup {
                debounce_text_changes = 700,     -- Увеличьте задержку
                maxDiagnosticDelay = 3000,       -- Задержка для отправки диагностических сообщений (в миллисекундах)
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
