vim.o.guifont = "Hermit:h11"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_profiler = false
vim.g.neovide_cursor_animation_length = 0

-- Control scaling
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)

-- Setup copy-paste
local sysname = vim.loop.os_uname().sysname
if sysname == 'Linux' then
  vim.keymap.set('v', '<C-S-c>', '"+y') -- Copy
  vim.keymap.set('n', '<C-S-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<C-S-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<C-S-v>', '<C-R>+') -- Paste command mode
  -- vim.keymap.set('i', '<C-S-v>', '<ESC>l"+Pli') -- Paste insert mode
elseif sysname == 'Darwin' then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  -- vim.keymap.set('i, '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
