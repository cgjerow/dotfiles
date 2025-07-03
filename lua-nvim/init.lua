--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

local colors = {
  black = '#1A1E29',
  red = '#ED8274',
  green = '#A6CC70',
  yellow = '#FAD07B',
  blue = '#6DCBFA',
  magenta = '#CFBAFA',
  cyan = '#90E1C6',
  white = '#C7C7C7',

  black_bright = '#686868',
  red_bright = '#F28779',
  green_bright = '#C7F489',
  yellow_bright = '#FFD580',
  blue_bright = '#73D0FF',
  magenta_bright = '#D4BFFF',
  cyan_bright = '#95E6CB',
  white_bright = '#FFFFFF',
}
_G.set_colors = function()
  local hl = vim.api.nvim_set_hl
  -- Basic UI
  hl(0, 'Normal', { fg = colors.white, bg = colors.black })
  hl(0, 'NormalNC', { fg = colors.white, bg = colors.black })
  hl(0, 'Comment', { fg = colors.black_bright, italic = false })
  hl(0, 'LineNr', { fg = colors.black_bright })
  hl(0, 'CursorLineNr', { fg = colors.black_bright, bold = true })
  hl(0, 'Keyword', { fg = colors.cyan, bold = true })
  hl(0, 'Function', { fg = colors.red })
  hl(0, 'Type', { fg = colors.magenta_bright })
  hl(0, 'String', { fg = colors.green_bright })
  hl(0, 'Search', { fg = colors.white, bg = colors.black_bright })
  hl(0, 'CurSearch', { fg = colors.black_bright, bg = colors.white, bold = true })

  -- LSP (Language Server Protocol)
  hl(0, 'LspDiagnosticsDefaultError', { fg = colors.red })
  hl(0, 'LspDiagnosticsDefaultWarning', { fg = colors.yellow })
  hl(0, 'LspDiagnosticsDefaultInformation', { fg = colors.black_bright })
  hl(0, 'LspDiagnosticsDefaultHint', { fg = colors.black_bright })
  hl(0, 'LspReferenceText', { bg = colors.black_bright }) -- Highlight referenced text
  hl(0, 'LspReferenceRead', { bg = colors.black_bright })
  hl(0, 'LspReferenceWrite', { bg = colors.black_bright })

  -- Treesitter (Syntax Highlighting)
  hl(0, 'TSFunction', { fg = colors.red, bold = true })
  hl(0, 'TSKeyword', { fg = colors.cyan, bold = true })
  hl(0, 'TSString', { fg = colors.green_bright })
  hl(0, 'TSVariable', { fg = colors.white_bright })
  hl(0, 'TSProperty', { fg = colors.magenta })
  hl(0, 'TSComment', { fg = colors.black_bright, italic = true })
  hl(0, 'TSOperator', { fg = colors.white_bright })

  -- Telescope (Fuzzy Finder)
  hl(0, 'TelescopeNormal', { fg = colors.white, bg = colors.black })
  hl(0, 'TelescopePromptBorder', { fg = colors.magenta })
  hl(0, 'TelescopeResultsBorder', { fg = colors.magenta })
  hl(0, 'TelescopePreviewBorder', { fg = colors.cyan })
end

-- wrap line
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- P:lua require "telescope.builtin".lsp_definitions { jump_type = "never" }review substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-n>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- TODO: vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Basic Autocommands

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Install `lazy.nvim` plugin manager
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins you can run
--    :Lazy update
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-fugitive',
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      local ignore_gitignore = true

      function ToggleIgnoreGitignore()
        ignore_gitignore = not ignore_gitignore
        local status = ignore_gitignore and 'Ignoring .gitignore 🚀' or 'Respecting .gitignore ✅'
        print(status)
        require('telescope.builtin').find_files { hidden = true, no_ignore = ignore_gitignore }
      end

      vim.api.nvim_set_keymap('n', '<leader>fi', ':lua ToggleIgnoreGitignore()<CR>', { noremap = true, silent = true })

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x', -- make sure you’re on the latest 2.x branch
    dependencies = {
      -- LSP support
      { 'neovim/nvim-lspconfig' },
      -- Automatic installer
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Completion integration
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/nvim-cmp' },
      -- (optional) Snippet engine + sources
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      local lsp = require('lsp-zero').preset {
        name = 'minimal',
        -- Automatically install LSP servers when you open a buffer
        manage_nvim_cmp = true,
        set_lsp_keymaps = false, -- we’ll do our own on_attach
        suggest_lsp_servers = false,
      }

      -- Tell lsp-zero to use Mason for installing missing servers
      lsp.ensure_installed {} -- empty = on-demand only
      lsp.setup_servers() -- applies ensure_installed + mason-lspconfig

      -- Configure nvim-cmp through lsp-zero
      lsp.setup_nvim_cmp {
        mapping = lsp.defaults.cmp_mappings {
          ['<Tab>'] = require('cmp').mapping.confirm { select = true },
          ['<C-Space>'] = require('cmp').mapping.complete(),
        },
      }

      -- Your on_attach, with buffer‑local LSP keymaps
      lsp.on_attach(function(client, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc and 'LSP: ' .. desc, silent = true })
        end

        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gr', vim.lsp.buf.references, 'Find references')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('K', vim.lsp.buf.hover, 'Hover docs')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>a', vim.lsp.buf.code_action, 'Code action')
        map(']d', function()
          vim.diagnostic.goto_next { float = true }
        end, 'Next diagnostic')
        map('[d', function()
          vim.diagnostic.goto_prev { float = true }
        end, 'Prev diagnostic')
      end)

      -- Finally, run the whole setup
      lsp.setup()

      -- now override only lua_ls with your custom settings
      require('lspconfig').lua_ls.setup(vim.tbl_deep_extend(
        'force',
        lsp.nvim_lua_ls(), -- base Neovim Lua settings from lsp-zero
        {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'love' },
                disable = { 'missing-fields', 'missing-parameter' },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        }
      ))
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        kotlin = { 'ktlint' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        typescriptreact = { 'prettierd', 'prettier' },
        javascriptreact = { 'prettierd', 'prettier' },
      },
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Right>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Show Symbol Details' }),
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- Configure Treesitter See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'kotlin',
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'java',
        'javascript',
        'typescript',
        'tsx', -- for .tsx (TypeScript React) files
        'json', -- if you're working with JSON often},
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = false },
    },
  },
}

vim.cmd [[
  set path+=**
  set list
  " set listchars=eol:↩,space:·,tab:··
  set listchars=space:·,tab:··
  set linebreak " Break line at full word
  set showbreak=\ \ \ \ ↪\ \  " show eliipsis at breaking

  " Spellcheck for features and markdown
  au BufRead,BufNewFile *.md setlocal spell

  map <C-j> 3<C-E>
  map <C-k> 3<C-Y>

  " netrw
  let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,.git/,^\.\.\=/\=$'
  let g:netrw_banner=0

  command E Explore

  set shiftwidth=2 tabstop=2 softtabstop=0 expandtab
]]

vim.api.nvim_create_user_command('ReloadColors', function()
  _G.set_colors()
end, {})

-- Load the colorscheme
set_colors()
