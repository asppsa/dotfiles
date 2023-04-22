-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
local nvim_tree = require("nvim-tree")
local nvim_tree_api = require("nvim-tree.api")
nvim_tree.setup({
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false
      }
    }
  }
})

-- Add bindings to open the tree
vim.keymap.set('n', '-', function()
  nvim_tree_api.tree.find_file({
    buf = vim.api.nvim_buf_get_name(0),
    open = true,
    update_root = true,
    focus = true
  })
end)
vim.keymap.set('', '<C-n>', function() nvim_tree_api.tree.toggle() end)
