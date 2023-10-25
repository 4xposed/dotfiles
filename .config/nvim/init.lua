-- Convenience Aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- Auxiliary functions
local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function bufmap(bufnr, mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Package manager
local paq = require('paq').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true} -- paq-nvim manages itself

-- Packages
-- General Packages
paq {'lifepillar/vim-solarized8'} -- Solarized colorscheme
paq {'nvim-tree/nvim-web-devicons'} -- Icons
paq {'onsails/lspkind-nvim'} -- pictograms for nvim-lsp
paq {'nvim-lua/plenary.nvim'} -- Lua Neovim utils
paq {'echasnovski/mini.nvim'} -- Mini Neovim Utils framework

-- NVIM LSP
paq {'williamboman/nvim-lsp-installer'} -- lsp server installer
paq {'neovim/nvim-lspconfig'} -- nvim-lsp configs
paq {'hrsh7th/cmp-nvim-lsp'} -- nvim-cmp support for nvim-lsp
paq {'folke/lsp-colors.nvim'} -- colors for nvim-lsp
paq {'folke/trouble.nvim'} -- Error collection

-- paq { 'vim-ruby/vim-ruby' }
paq {'tpope/vim-rails'}
paq {'hashivim/vim-terraform'}
-- paq { 'tpope/vim-rails' }
-- paq { 'plasticboy/vim-markdown' }

-- Autocompletion packages
paq {'hrsh7th/nvim-cmp'} -- Autocompletion
paq {'hrsh7th/cmp-buffer'} -- nvim-cmp support for buffer words
paq {'hrsh7th/cmp-path'} --nvim-cmp support for fs paths
paq {'hrsh7th/cmp-cmdline'} --nvim-cmp support for vim's cmdline
paq {'dcampos/cmp-snippy'} -- snippy integration for nvim-cmp
paq {'dcampos/nvim-snippy'} -- snipy

paq {'nvim-lualine/lualine.nvim'} -- airline
paq {'nvim-telescope/telescope.nvim'} -- Fuzzyfinder
paq {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- Sintax trees
paq {'lewis6991/spellsitter.nvim'} -- Spellchecker
paq {'nvim-tree/nvim-tree.lua'} -- tree
paq {'matbme/JABS.nvim'} -- buffer explorer
paq {'lewis6991/gitsigns.nvim'} -- Git signs
paq {'windwp/nvim-autopairs'} -- Convenience auto-close certain structures
paq {'christoomey/vim-tmux-navigator'} -- Convenience jump from vim to tmux

-- Basic setup
g.mapleader = ','
opt.autowrite   = true
opt.expandtab 	= false  -- Use spaces instead of tabs
opt.tabstop 	  = 2     -- Visual spaces per tab
opt.softtabstop = 2     -- spaces for tabs when editing
opt.shiftwidth  = 2     -- spaces for tabs when autoindent
opt.number 	    = true  -- Show line numbers
opt.clipboard   = 'unnamed,unnamedplus'
opt.foldenable = false

-- Make it obvious where 100 chars is
opt.textwidth = 100
opt.colorcolumn = '+1'

-- WildIgnore
opt.wildignore:append '*/.git/*'
opt.wildignore:append '*/.DS_Store'
opt.wildignore:append '*/vendor/*'
opt.wildignore:append '*/doc/*'
opt.wildignore:append '*/tmp/*'
opt.wildignore:append '*/deps/*'

-- Convenience mappings
cmd('command! Q q')
cmd('command! W w')
cmd('command! E e')
cmd('command! Qall qall')
cmd('command! QA qall')

-- Template
opt.termguicolors = true            -- True color support
cmd 'colorscheme solarized8'
cmd 'set background=dark'

-- Icons
require('nvim-web-devicons').setup { default = true; }

-- nvim-treesitter

require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "ruby", "typescript", "go", "javascript", "dockerfile" },
	sync_install = true,
	auto_install = true,
	ignore_install = {},
	indent = {
		enable = true
	},
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = true,
	}

}

-- Tabline
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'solarized_dark',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			'branch',
			'diff',
			{
				'diagnostics',
				sources = { 'nvim_lsp' },
				sections = { 'error', 'warn', 'info', 'hint' },
				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = 'DiagnosticError', -- Changes diagnostics' error color.
					warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
					info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
					hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
				},
				symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
				colored = true,           -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false,   -- Show diagnostics even if there are none
			}
		},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
		},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
}

-- CMP
opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspkind = require('lspkind')
local snippy = require("snippy")
local cmp = require 'cmp'

lspkind.init({})

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 50,
		})
	},
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'snippy' }
	}, {
			{
				name = 'buffer',
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end
				}
			}
		})
})

-- LSP

require("nvim-lsp-installer").setup {}
local lsp = require 'lspconfig'

map('n', '<space>,', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.diagnostic.goto_next()<CR>')


local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	bufmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
	bufmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
	bufmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	bufmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	bufmap(bufnr, 'n', '<C-o>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	bufmap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
	bufmap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
	bufmap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
	bufmap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	bufmap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	bufmap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	bufmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
	bufmap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

local servers =  { 'solargraph', 'rust_analyzer', 'gopls', 'golangci_lint_ls', 'eslint', 'tsserver' }

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp_s in pairs(servers) do
	lsp[lsp_s].setup {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150
		}
	}
end

-- Tweak LSP diagnostics signs

vim.diagnostic.config({
	virtual_text = false,
	signs = true
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#e0af68",
	Information = "#0db9d7",
	Hint = "#10B981"
})

require("trouble").setup {}

map("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true })
map("n", "<leader>xq", "<cmd>TroubleClose<cr>", { silent = true })

-- Disable Arrows
map("n", "<Up>", "<NOP>")
map("n", "<Down>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- Surround
require('mini.surround').setup {
	mappings = {
		add = 'ca', -- Add surrounding
		delete = 'cd', -- Delete surrounding
		replace = 'cs', -- Replace surrounding
	},
}
-- Trailing Whitespace
require('mini.trailspace').setup {
	trim = true
}

-- Comments
require('mini.comment').setup {
	mappings = {
		comment = '<leader>c',
		comment_line = '<leader>cc'
	}
}

cmd('autocmd BufWritePre * lua MiniTrailspace.trim()')

-- GoLang Imports
function go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end

cmd('autocmd BufWritePre *.go lua go_org_imports()')

-- Telscope Fuzzyfinder config
local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')
map('n', '<C-p>', "<cmd>Telescope find_files<cr>", { silent = true })
map('n', '<C-f>', "<cmd>Telescope live_grep<cr>", { silent = true })

-- Endwise
local npairs = require('nvim-autopairs')
npairs.setup()
npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

-- Spellchecker
require('spellsitter').setup()

-- Tree
local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " ..desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
	vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
end
require'nvim-tree'.setup{
	on_attach = my_on_attach,
}

map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>')

-- Buffer Explorer
local ui = vim.api.nvim_list_uis()[1]

require 'jabs'.setup {
	position = 'corner', -- center, corner
	width = 50,
	height = 10,
	border = 'shadow', -- none, single, double, rounded, solid, shadow, (or an array or chars)

	-- Options for preview window
	preview_position = 'left', -- top, bottom, left, right
	preview = {
		width = 40,
		height = 30,
		border = 'double', -- none, single, double, rounded, solid, shadow, (or an array or chars)
	},

	-- the options below are ignored when position = 'center'
	col = ui.width,  -- Window appears on the right
	row = ui.height/2, -- Window appears in the vertical middle
}

map('n', '<leader>b', '<cmd>JABSOpen<CR>')

require('gitsigns').setup()


