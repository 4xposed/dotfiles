-- Convenience Aliases
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- Auxiliary function (kept for convenience, wraps modern API)
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- ============================================================================
-- Leader key (must be set before lazy)
-- ============================================================================
g.mapleader = ','

-- ============================================================================
-- Plugin specs (lazy.nvim)
-- ============================================================================
require("config.lazy")
require("lazy").setup({
  spec = {
    -- Themes
    { 'ishan9299/nvim-solarized-lua', priority = 1000 },
    { 'folke/tokyonight.nvim', lazy = true },
    { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
    { 'rebelot/kanagawa.nvim', lazy = true },
    { 'projekt0n/github-nvim-theme', lazy = true },
    { 'lightnolimit/cosmic-latte-nvim', lazy = true },
    { 'craftzdog/solarized-osaka.nvim', lazy = true },
    { 'shaunsingh/nord.nvim', lazy = true },
    { 'sainnhe/edge', lazy = true },
    { 'AlexvZyl/nordic.nvim', lazy = true },
    { 'mhartington/oceanic-next', lazy = true },
    { 'sainnhe/sonokai', lazy = true },
    { 'EdenEast/nightfox.nvim', lazy = true },
    {
      'zaldih/themery.nvim',
      lazy = false,
      opts = {
        themes = {
          'solarized-flat',
          'tokyonight',
          'tokyonight-night',
          'tokyonight-storm',
          'catppuccin',
          'catppuccin-mocha',
          'catppuccin-frappe',
          'catppuccin-macchiato',
          'kanagawa',
          'kanagawa-wave',
          'kanagawa-dragon',
          'github_dark',
          'github_dark_dimmed',
          'github_light',
          'cosmic-latte',
          'solarized-osaka',
          'nord',
          'edge',
          'nordic',
          'OceanicNext',
          'sonokai',
          'nightfox',
          'duskfox',
          'nordfox',
          'carbonfox',
        },
        livePreview = true,
      },
    },

    -- Core dependencies
    'nvim-lua/plenary.nvim',
    'echasnovski/mini.nvim',

    -- Icons
    'nvim-tree/nvim-web-devicons',

    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    'neovim/nvim-lspconfig',
    'folke/trouble.nvim',

    -- Completion (replaces nvim-cmp + 6 plugins)
    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = {
          preset = 'none',
          ['<CR>'] = { 'accept', 'fallback' },
          ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          documentation = { auto_show = true },
          menu = { border = 'rounded' },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },

    -- Formatting (replaces vim.lsp.buf.formatting)
    {
      'stevearc/conform.nvim',
      event = { 'BufWritePre' },
      cmd = { 'ConformInfo' },
      opts = {
        formatters_by_ft = {
          go = { 'goimports', 'gofmt' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          ruby = { lsp_format = 'fallback' },
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          terraform = { 'terraform_fmt' },
          elixir = { lsp_format = 'fallback' },
          lua = { 'stylua' },
        },
        default_format_opts = { lsp_format = 'fallback' },
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      },
    },

    -- Linting
    {
      'mfussenegger/nvim-lint',
      event = { 'BufReadPre', 'BufNewFile' },
    },

    -- File explorer (replaces nvim-tree)
    {
      'stevearc/oil.nvim',
      lazy = false,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        default_file_explorer = true,
        columns = { 'icon' },
        skip_confirm_for_simple_edits = true,
        view_options = { show_hidden = true },
      },
    },

    -- Snacks (replaces telescope, JABS, adds lazygit/notifier/explorer/indent/terminal)
    {
      'folke/snacks.nvim',
      priority = 1000,
      lazy = false,
      opts = {
        picker = { enabled = true, win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } } },
        explorer = {
          enabled = true,
          replace_netrw = true,
          win = {
            list = {
              keys = {
                ["s"] = { "edit_vsplit", mode = { "n" } },
                ["i"] = { "edit_split", mode = { "n" } },
              },
            },
          },
        },
        lazygit = { enabled = true, configure = true },
        notifier = { enabled = true, timeout = 3000 },
        bigfile = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
      },
    },

    -- Language support
    'tpope/vim-rails',
    'hashivim/vim-terraform',

    -- Rust
    {
      'mrcjkb/rustaceanvim',
      version = '^6',
      lazy = false,
    },
    {
      'Saecki/crates.nvim',
      event = { 'BufRead Cargo.toml' },
      opts = {
        completion = {
          cmp = { enabled = false },
          crates = { enabled = true },
        },
      },
    },

    -- Debugging
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
        'leoluz/nvim-dap-go',
      },
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- UI
    'nvim-lualine/lualine.nvim',
    'lewis6991/gitsigns.nvim',
    { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory' } },

    -- Editing
    'christoomey/vim-tmux-navigator',

    -- Keybinding discovery
    {
      'folke/which-key.nvim',
      event = 'VeryLazy',
      opts = {},
    },

    -- LLM
    {
      'olimorris/codecompanion.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
      opts = {
        strategies = {
          chat = { adapter = 'anthropic' },
        },
        opts = { log_level = 'DEBUG' },
      },
    },
  },
  checker = { enabled = false },
})

-- ============================================================================
-- Basic settings
-- ============================================================================
opt.autowrite   = true
opt.expandtab   = false  -- Use tabs
opt.tabstop     = 2      -- Visual spaces per tab
opt.softtabstop = 2      -- Spaces for tabs when editing
opt.shiftwidth  = 2      -- Spaces for tabs when autoindent
opt.number      = true   -- Show line numbers
opt.clipboard   = 'unnamed,unnamedplus'
opt.foldenable  = false

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

-- Convenience commands
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('E', 'e', {})
vim.api.nvim_create_user_command('Qall', 'qall', {})
vim.api.nvim_create_user_command('QA', 'qall', {})

-- ============================================================================
-- Theme
-- ============================================================================
opt.termguicolors = true
vim.cmd 'colorscheme solarized-flat'
vim.cmd 'set background=dark'

-- Ensure floating windows and sidebars inherit the colorscheme background
local bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
if bg then
  local bg_hex = string.format('#%06x', bg)
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg_hex })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = bg_hex })
  vim.api.nvim_set_hl(0, 'NormalSB', { bg = bg_hex })
end

-- ============================================================================
-- Icons
-- ============================================================================
require('nvim-web-devicons').setup { default = true }

-- ============================================================================
-- Treesitter
-- ============================================================================
require('nvim-treesitter.configs').setup {
  ensure_installed = { "rust", "ruby", "typescript", "go", "javascript", "dockerfile", "toml", "lua", "json", "yaml", "elixir" },
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  indent = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  }
}

-- ============================================================================
-- Statusline (lualine)
-- ============================================================================
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
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
        symbols = {error = '', warn = '', info = '', hint = '󰎞'},
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }
    },
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

-- ============================================================================
-- LSP (Neovim 0.11+ native config)
-- ============================================================================
require("mason").setup()
require("mason-lspconfig").setup()

map('n', '<space>,', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.diagnostic.goto_next()<CR>')

-- LSP keymaps via LspAttach autocmd (replaces on_attach)
local on_attach = function(client, bufnr)
  local bufopts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-o>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, bufopts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      on_attach(client, ev.buf)
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- LSP server configs (rust_analyzer removed — rustaceanvim manages it)
local shared = { capabilities = capabilities }

vim.lsp.config('ruby_lsp', shared)
vim.lsp.config('golangci_lint_ls', shared)
vim.lsp.config('eslint', shared)
vim.lsp.config('ts_ls', shared)

vim.lsp.config('elixirls', vim.tbl_extend('force', shared, {
  cmd = { '/Users/daniel/.local/share/nvim/mason/packages/elixir-ls/language_server.sh' },
}))

vim.lsp.config('gopls', vim.tbl_extend('force', shared, {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local mod_cache = vim.trim(vim.fn.system 'go env GOMODCACHE')
    if fname:sub(1, #mod_cache) == mod_cache then
      local clients = vim.lsp.get_clients { name = 'gopls' }
      if #clients > 0 then
        on_dir(clients[#clients].config.root_dir)
        return
      end
    end
    -- Find root from go.work, go.mod, or .git
    local root = vim.fs.root(bufnr, { 'go.work', 'go.mod', '.git' })
    on_dir(root)
  end,
}))

vim.lsp.enable({ 'ruby_lsp', 'golangci_lint_ls', 'eslint', 'ts_ls', 'elixirls', 'gopls' })

-- LSP diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

-- ============================================================================
-- Trouble (diagnostics list)
-- ============================================================================
require("trouble").setup {
  modes = {
    test = {
      mode = "diagnostics",
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.3,
      },
    },
  },
}

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
map("n", "<leader>xq", "<cmd>TroubleClose<cr>")

-- ============================================================================
-- Linting
-- ============================================================================
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- ============================================================================
-- Rustaceanvim
-- ============================================================================
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    default_settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        cargo = { allFeatures = true },
      },
    },
  },
  dap = {
    autoload_configurations = true,
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(ev)
    local bufopts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set('n', '<leader>re', function() vim.cmd.RustLsp('expandMacro') end, bufopts)
    vim.keymap.set('n', '<leader>rr', function() vim.cmd.RustLsp('runnables') end, bufopts)
    vim.keymap.set('n', '<leader>rd', function() vim.cmd.RustLsp('debuggables') end, bufopts)
    vim.keymap.set('n', '<leader>rt', function() vim.cmd.RustLsp('testables') end, bufopts)
    vim.keymap.set('n', '<leader>rp', function() vim.cmd.RustLsp('parentModule') end, bufopts)
    vim.keymap.set('n', 'K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, bufopts)
    vim.keymap.set('n', '<space>ca', function() vim.cmd.RustLsp('codeAction') end, bufopts)
  end,
})

-- ============================================================================
-- Debugging (DAP)
-- ============================================================================
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()
require('dap-go').setup()

-- Auto open/close DAP UI
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

map('n', '<leader>db', function() dap.toggle_breakpoint() end)
map('n', '<leader>dc', function() dap.continue() end)
map('n', '<leader>di', function() dap.step_into() end)
map('n', '<leader>do', function() dap.step_over() end)
map('n', '<leader>du', function() dapui.toggle() end)
map('n', '<leader>dr', function() dap.repl.open() end)

-- ============================================================================
-- Disable arrow keys
-- ============================================================================
map("n", "<Up>", "<NOP>")
map("n", "<Down>", "<NOP>")
map("n", "<Left>", "<NOP>")
map("n", "<Right>", "<NOP>")

-- ============================================================================
-- Mini modules
-- ============================================================================
-- Surround
require('mini.surround').setup {
  mappings = {
    add = 'ca',
    delete = 'cd',
    replace = 'cs',
  },
}

-- Trailing Whitespace
require('mini.trailspace').setup { trim = true }

-- Comments
require('mini.comment').setup {
  mappings = {
    comment = '<leader>c',
    comment_line = '<leader>cc',
    comment_visual = '<leader>c',
  },
}

-- Auto-pairs (replaces nvim-autopairs)
require('mini.pairs').setup()

-- Extended textobjects
require('mini.ai').setup()

-- ============================================================================
-- Autocommands
-- ============================================================================
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function() MiniTrailspace.trim() end,
})

-- GoLang Imports
function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local clients = vim.lsp.get_clients({ id = cid })
        local enc = (clients[1] or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function() go_org_imports() end,
})

-- ============================================================================
-- Navigation keymaps
-- ============================================================================
-- File search (snacks picker — replaces telescope)
map('n', '<C-p>', function() Snacks.picker.files() end)
map('n', '<C-f>', function() Snacks.picker.grep() end)
map('n', '<leader>b', function() Snacks.picker.buffers() end)

-- File explorer (snacks explorer — replaces nvim-tree, oil for buffer-style)
map('n', '<C-n>', function() Snacks.explorer() end)
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Git
map('n', '<leader>lg', function() Snacks.lazygit() end)
map('n', '<leader>dv', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>dh', '<cmd>DiffviewFileHistory %<CR>')

-- Theme picker
map('n', '<leader>th', '<cmd>Themery<cr>')

-- Terminal
map('n', '<C-/>', function() Snacks.terminal() end)

-- ============================================================================
-- Git signs
-- ============================================================================
require('gitsigns').setup()

-- ============================================================================
-- Which-key labels
-- ============================================================================
require('which-key').add({
  { '<leader>d', group = 'Debug/Diff' },
  { '<leader>r', group = 'Rust' },
  { '<leader>x', group = 'Diagnostics' },
  { '<leader>l', group = 'Lazygit' },
  { '<leader>c', group = 'Comment' },
  { '<space>w', group = 'Workspace' },
  { '<space>r', group = 'Rename' },
  { '<space>c', group = 'Code Action' },
})
