require('nvim-treesitter').install { "javascript", "typescript", "jsdoc", "glimmer", "ruby" }

local max_filesize = 100 * 1024 -- 100 KB

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))

    if ok and stats and stats.size > max_filesize then
      vim.treesitter.start()

      -- treesitter for folds
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'

      -- treesitter for indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
