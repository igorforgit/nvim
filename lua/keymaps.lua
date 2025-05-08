-- leader
vim.g.mapleader = ' '

local map = vim.keymap.set -- map

-- Навигация меню
map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })

-- Переключение между окнами
map('n', '<C-h>', '<C-w>h', { desc = 'Move to the window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to the window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to the window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to the window right' })

-- создание сплитов
map('n', '<leader>sj', ':split<CR><C-w>j', { desc = 'Horizontal split and move down' })
map('n', '<leader>sk', ':split<CR><C-w>k', { desc = 'Horizontal split and move up' })
map('n', '<leader>sl', ':vsplit<CR><C-w>l', { desc = 'Vertical split and move right' })
map('n', '<leader>sh', ':vsplit<CR><C-w>h', { desc = 'Vertical split and move left' })
map('n', '<leader>x', '<C-w>c', { desc = 'Close current window (split)' })

-- Увеличить/уменьшить высоту
map('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-0>', '<C-w>=', { desc = 'Equalize window sizes' })

-- Увеличить/уменьшить ширину
map('n', '<C-Right>', ':vertical resize +4<CR>', { desc = 'Increase window width' })
map('n', '<C-Left>', ':vertical resize -4<CR>', { desc = 'Decrease window width' })

-- Вкладки
map('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true, desc = 'New tab' })
map('n', '<C-x>', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close tab' })
map('n', 'th', 'gT', { desc = 'Previous tab' })
map('n', 'tl', 'gt', { desc = 'Next tab' })
map('n', '<C-t>h', ':tabmove -1<CR>', { desc = 'Move tab left' })
map('n', '<C-t>l', ':tabmove +1<CR>', { desc = 'Move tab right' })

-- Навигация по методам
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

map('n', '<leader>gd', function()
    vim.cmd('tab split')
    vim.lsp.buf.definition()
end, { desc = 'Go to definition in new tab' })

-- Снять выделение по Ctrl+L
map('n', '<leader>l', ':nohlsearch<CR>', opts)

-- бинды для удобного доступа к поиску
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Найти файл" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Поиск по содержимому" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Открытые буферы" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Поиск в справке" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Символы в файле" })
map("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Символы в проекте" })

-- Отключить стрелочки
map('n', '<Up>', ':echo "/ arrow is disabled!"<CR>', { noremap = true })
map('n', '<Down>', ':echo "/ arrow is disabled!"<CR>', { noremap = true })
map('n', '<Left>', ':echo "/ arrow is disabled!"<CR>', { noremap = true })
map('n', '<Right>', ':echo "/ arrow is disabled!"<CR>', { noremap = true })

-- Отключить Ctrl+Z
map('n', '<C-z>', ':echo "/ Ctrl+Z is disabled!"<CR>', opts)

-- Отключить команды gu и gU
map('n', 'gu', ':echo "/ gu is disabled"<CR>', opts)
map('n', 'gU', ':echo "/ gU is disabled"<CR>', opts)

-- Отключить команды u и U в визуальном режиме
map('v', 'u', ':<C-u>echo "/ u is disabled"<CR>', opts)  -- Отключаем 'u' в визуальном режиме
map('v', 'U', ':<C-u>echo "/ U is disabled"<CR>', opts)  -- Отключаем 'U' в визуальном режим

-- Показать ошибки
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Показать ошибку под курсором" })




-- ###
