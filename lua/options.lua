local opt = vim.opt

opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Relative line numbers
opt.cursorline = true      -- Highlight current line
opt.expandtab = true       -- Use spaces instead of tabs
opt.shiftwidth = 2         -- Size of an indent
opt.tabstop = 2            -- Number of spaces tabs count for
opt.smartindent = true     -- Insert indents automatically
opt.ignorecase = true      -- Case-insensitive search
opt.smartcase = true       -- Override ignorecase if uppercase letters are used
opt.termguicolors = true   -- True color support
opt.undofile = true        -- Persistent undo history
opt.updatetime = 250       -- Faster completion and diagnostic updates
opt.signcolumn = "yes"     -- Always show sign column to prevent text shifting

