
local M = {}

function M.set_cursor_color()
  if vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "black" })
  else
    vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "white" })
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      M.set_cursor_color()
    end,
  })

  -- применяем сразу
  M.set_cursor_color()

  -- guicursor, чтобы применился highlight Cursor
  vim.opt.guicursor = {
    "n-v-c:block-Cursor",
    "i-ci:ver25-Cursor",
    "r:hor20-Cursor",
  }
end

return M
