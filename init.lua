require 'options'
require 'keymaps'
require 'plugins'

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreeSitterStart', { clear = true }),
  -- if you only want to enable it for certain file types
  -- pattern = { <filetype> },
  -- callback = function() vim.treesitter.start() end,

  callback = function(args)
    -- List of filetypes where treesitter shouldn't be forced
    local ignore_filetypes = { 'TelescopePrompt', 'netrw', 'lazy', 'mason' }
    if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then return end

    -- Safely attempt to start treesitter
    pcall(vim.treesitter.start)
  end,
})

-- to allow navigating references in vim.lsp using tab
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('QuickfixTabNav', { clear = true }),
  pattern = 'qf',
  callback = function()
    -- Map Tab and Shift-Tab to navigate up and down in normal mode
    vim.keymap.set('n', '<Tab>', 'j', { buffer = true, silent = true })
    vim.keymap.set('n', '<S-Tab>', 'k', { buffer = true, silent = true })
  end,
})
