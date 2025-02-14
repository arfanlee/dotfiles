-- Set leader key to <Space>
vim.g.mapleader = " "

-- Configure nvim-cmp
local cmp = require('cmp')

-- Icons for completion items
local kind_icons = {
  Text = "󰊄", Method = "", Function = "󰊕", Constructor = "", Field = "",
  Variable = "", Class = "", Interface = "", Module = "", Property = "",
  Unit = "", Value = "󰎠", Enum = "", Keyword = "󰌋", Snippet = "",
  Color = "󰏘", File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
  Constant = "󰇽", Struct = "", Event = "", Operator = "󰆕", TypeParameter = "󰊄",
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Use vsnip as the snippet engine
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "󰞵",
        vsnip = "",
        buffer = "",
        path = "󰝰",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  }),
})

-- Configure cmp for command line
cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Configure LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off" -- Disable type checking
      }
    }
  }
})

require('lspconfig').rust_analyzer.setup({ capabilities = capabilities })
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- Declare `vim` as a global
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false, -- Disable telemetry (optional)
      },
    },
  },
})
require('lspconfig').clangd.setup({ capabilities = capabilities })

-- Configure Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup({
  defaults = {
    -- Default configurations
  },
  pickers = {
    find_files = {
	  cwd = "~",
	  hidden = "false",
      theme = "dropdown", -- Use a dropdown theme for the finder
    },
  },
})

-- Configure nvim-surround
require("nvim-surround").setup()

-- Configure indent-blankline
require("ibl").setup()
