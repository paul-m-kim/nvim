-- ~/.config/nvim/lua/plugins.lua

-- Automatically download/load lightweight utility plugins using vim.pack
vim.pack.add({
	-- A modular library for statuslines, icons, fuzzy finding, or pairs if needed
	{ src = "https://github.com/echasnovski/mini.nvim" },
	-- lsp
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- lsp auto install
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	-- formatter
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- tree-sitter (syntax-highter)
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	-- git signs (for the gutter)
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- git fugitive
	{ src = "https://github.com/tpope/vim-fugitive" },

	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/AlexvZyl/nordic.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/esmuellert/codediff.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local flash = require("flash")

flash.setup({
	modes = {
		char = {
			enabled = true,
			jump_labels = true,
		},
	},
})

-- 3. Set up Keymaps
vim.keymap.set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	flash.remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
	flash.treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
	flash.toggle()
end, { desc = "Toggle Flash Search" })

-- Set up the icons module
require("nvim-web-devicons").setup({
	-- -- Enable color highlights per icon (default: true)
	-- color_icons = true,
	-- -- Enable default icon fallback when no specific filetype icon is found (default: false)
	-- default = true,
	-- -- Custom icon overrides (optional)
	-- override = {
	--   zsh = {
	--     icon = '',
	--     color = '#428850',
	--     cterm_color = '65',
	--     name = 'Zsh',
	--   },
	-- },
})

-- auto complete extension
require("blink.cmp").build()
require("blink.cmp").setup({
	-- Keymap presets: 'default', 'super-tab', or 'enter'
	keymap = { preset = "default" },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},

	-- Enable default completion sources
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

-- Set the colorscheme
vim.cmd.colorscheme("nordic")

-- require('nordic').setup {
--   -- This callback can be used to override the colors used in the base palette.
--   on_palette = function(palette) end,
--   -- This callback can be used to override the colors used in the extended palette.
--   after_palette = function(palette) end,
--   -- This callback can be used to override highlights before they are applied.
--   on_highlight = function(highlights, palette) end,
--   -- Enable bold keywords.
--   bold_keywords = false,
--   -- Enable italic comments.
--   italic_comments = true,
--   -- Enable editor background transparency.
--   transparent = {
--     -- Enable transparent background.
--     bg = false,
--     -- Enable transparent background for floating windows.
--     float = false,
--   },
--   -- Enable brighter float border.
--   bright_border = false,
--   -- Reduce the overall amount of blue in the theme (diverges from base Nord).
--   reduced_blue = true,
--   -- Swap the dark background with the normal one.
--   swap_backgrounds = false,
--   -- Cursorline options.
--   cursorline = {
--     -- Bold font in cursorline.
--     bold = false,
--     -- Bold cursorline number.
--     bold_number = true,
--     -- Available styles: 'dark', 'light'.
--     theme = 'dark',
--     -- Blending the cursorline bg with the buffer bg.
--     blend = 0.85,
--   },
--   -- Visual selection options.
--   visual = {
--     -- Bold font in visual selection.
--     bold = false,
--     -- Bold visual selection number.
--     bold_number = true,
--     -- Available styles: 'dark', 'light'.
--     theme = 'dark',
--     -- Blending the visual selection bg with the buffer bg.
--     blend = 0.85,
--   },
--   noice = {
--     -- Available styles: `classic`, `flat`.
--     style = 'classic',
--   },
--   telescope = {
--     -- Available styles: `classic`, `flat`.
--     style = 'flat',
--   },
--   leap = {
--     -- Dims the backdrop when using leap.
--     dim_backdrop = false,
--   },
--   ts_context = {
--     -- Enables dark background for treesitter-context window
--     dark_background = true,
--   },
-- }

-- require('harpoon').setup {}
local harpoon = require("harpoon")
harpoon:setup()

-- Basic keymaps
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon file" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon menu" })

-- Jump to files 1 through 4 instantly
vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end)

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		file_ignore_patterns = { "node_modules", ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

local builtin = require("telescope.builtin")

-- Essential keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
-- vim.keymap.set('v', '<leader>fg', function()
--   vim.cmd('noau normal! "vy') -- :noautocmd, force normal mode, select register 'v', yank
--   local selection = vim.fn.getreg 'v'
--   builtin.live_grep { default_text = selection }
-- end, { desc = 'Telescop live grep selection' })

-- 2. Automatically compile fzf-native when it's installed or updated
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(args)
		local spec, event = args.data.spec, args.data.event
		-- Check if the changed plugin is fzf-native and was installed or updated
		if spec.src and spec.src:find("telescope-fzf-native.nvim") and (event == "install" or event == "update") then
			vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)

			-- Run 'make' in the plugin directory
			local obj = vim.system({ "make" }, { cwd = args.data.path }):wait()
			if obj.code ~= 0 then
				vim.notify("Failed to build telescope-fzf-native:\n" .. obj.stderr, vim.log.levels.ERROR)
			else
				vim.notify("telescope-fzf-native built successfully!", vim.log.levels.INFO)
			end
		end
	end,
})

-- 3. Telescope Setup & Configuration
local telescope = require("telescope")
telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
	},
})

-- Setup mini.nvim modules lightly (example: auto-pairs and basic statusline)
require("mini.pairs").setup({})
require("mini.statusline").setup({})

-- Initialize Mason (automatically manages and links binaries to Neovim's path)
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- ==========================================
-- SPECIFY YOUR AUTO-INSTALL LIST HERE:
-- ==========================================
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"bash-language-server",
		"elixir-ls",
		"elp",
		"rust-analyzer",
		"zls",
		-- "gopls",
		"typescript-language-server",
		"taplo",
		"yaml-language-server",
		"clangd",
		"pyright",
		"stylua",
		"black",
		"prettier",
		"tree-sitter-cli",
	},
	auto_update = true,
	run_on_start = true, -- Automatically installs missing binaries when Neovim opens
})

-- ==========================================
-- TREE-SITTER (Syntax Highlighting)
-- ==========================================
-- Automatically download/update desired language parsers
require("nvim-treesitter").install({
	"lua",
	"bash",
	"python",
	"json",
	"javascript",
	"typescript",
	"rust",
	"html",
	"css",
	"elixir",
	"erlang",
	"c",
	"go",
	"zig",
	"rust",
	"yaml",
})

-- require('nvim-treesitter').setup {
--   ensure_installed = { 'lua', 'bash', 'python', 'json', 'javascript', 'typescript', 'rust', 'html', 'css' },
--   highlight = {
--     enable = true,
--   },
-- }

-- ==========================================
-- FORMATTERS
-- ==========================================

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
	-- Optional: Automatically format on save
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- ==========================================
-- GIT
-- ==========================================

require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true, -- Shows git author inline next to your cursor
	current_line_blame_opts = {
		delay = 500, -- Milliseconds before the blame text appears
	},
})

-- ==========================================
-- Native LSP Setup (Neovim 0.12+)
-- ==========================================

-- language agnostic root markers
vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Ensure you have your language servers installed externally (e.g., viaMason, brew, or npm)
local language_server_configs = {
	lua = {
		cmd = { "lua-langauge-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	},
	bash = { cmd = { "bash-language-server", "start" }, filetypes = { "sh", "bash", "zsh" }, root_markers = { ".git" } },
	elixir = {
		cmd = { "elixir-ls" },
		filetypes = { "elixir", "eelixir", "heex", "surface" },
		root_markers = { "mix.exs", ".git" },
	},
	erlang = {
		cmd = { "elp", "server" },
		filetypes = { "erlang" },
		root_markers = { "rebar.config", "erlang.mk", ".git" },
	},
	rust = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	},
	zig = { cmd = { "zls" }, filetypes = { "zig", "zir" }, root_markers = { "zls.json", "build.zig", ".git" } },
	golang = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
	},
	typescript = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	},
	toml = {
		cmd = { "taplo", "lsp", "stdio" },
		filetypes = { "toml" },
		root_markers = { "taplo.toml", ".toml", ".git" },
	}, -- TOML
	yaml = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose", "yml" },
		root_markers = { ".git" },
	}, -- YAML
	c = {
		cmd = { "clangd" },
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		root_markers = { ".clangd", ".clang-format", "compile_commands.json", "Makefile", "CMakeLists.txt", ".git" },
	},
	python = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
	},
}

-- Register and enable each server conditionally if its binary is installed
for language, config in pairs(language_server_configs) do
	if vim.fn.executable(config.cmd[1]) == 1 then
		vim.lsp.config(language, config)
		vim.lsp.enable(language)
	end
end

-- Example: Configuring Lua LSP (lua_ls)
-- if vim.fn.executable("lua-language-server") == 1 then
--   vim.lsp.config("lua_ls", {
--     settings = {
--       Lua = {
--         diagnostics = { globals = { "vim" } }
--       }
--     }
--   })
--   vim.lsp.enable("lua_ls")
-- end

-- Global diagnostic layout tweaks
vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = false,
	float = { border = "rounded" },
})

-- Common LSP keybindings mapped on attachment
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		local map = vim.keymap.set
		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to References' })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
		-- vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = 'Document Symbols' })
		-- vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { desc = 'Workspace Symbols' })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Hover Function Signature" })

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Float LSP Diagnostics" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Jump to next err/wrn" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Jump to prev err/wrn" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Float Code Actions" })
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format Selection" })

		-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
		-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
		-- vim.keymap.set('n', '<leader>wl', vim.lsp.buf.list_workspace_folders)

		-- telescope
		-- Navigation & Symbols
		-- vim.keymap.set('n', 'gd', telescope.lsp_definitions, { desc = 'Telescope LSP Definitions' })
		vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "Telescope LSP References" })
		-- vim.keymap.set('n', 'gi', telescope.lsp_implementations, { desc = 'Telescope LSP Implementations' })
		-- vim.keymap.set('n', 'gy', telescope.lsp_type_definitions, { desc = 'Telescope LSP Type Definitions' })

		-- Symbols & Diagnostics
		vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "Telescope LSP Document Symbols" })
		vim.keymap.set("n", "<leader>ws", telescope.lsp_workspace_symbols, { desc = "Telescope LSP Workspace Symbols" })
		-- vim.keymap.set('n', '<leader>vd', telescope.diagnostics, { desc = 'Telescope Workspace Diagnostics' })

		-- Call hierarchy
		vim.keymap.set("n", "<leader>ci", telescope.lsp_incoming_calls, { desc = "Telescope LSP Incoming Calls" })
		vim.keymap.set("n", "<leader>co", telescope.lsp_outgoing_calls, { desc = "Telescope LSP Outgoing Calls" })
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range" })
