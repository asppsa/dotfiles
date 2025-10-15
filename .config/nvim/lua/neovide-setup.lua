if vim.loop.os_uname().sysname == 'Darwin' then
  vim.o.guifont = "Hermit:h13"
  vim.g.neovide_padding_top = 4
  vim.g.neovide_padding_bottom = 4
  vim.g.neovide_padding_right = 4
  vim.g.neovide_padding_left = 4
else
  vim.o.guifont = "Hermit:h12"
end
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_profiler = false

-- Transparency
vim.g.neovide_opacity = 0.95
vim.g.neovide_normal_opacity = 0.95
vim.o.winblend = 30
vim.o.pumblend = 30

-- Animation
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_position_animation_length = 0.05
vim.g.neovide_scroll_animation_length = 0.05

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
local copy = '<C-S-c>'
local paste = '<C-S-V>'
local sysname = vim.loop.os_uname().sysname
if sysname == 'Darwin' then
  copy = '<D-c>'
  paste = '<D-v>'
end

vim.keymap.set('v', copy, '"+y') -- Copy
vim.keymap.set(
    {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
    paste,
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)
