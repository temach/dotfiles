set nocompatible
set enc=utf-8
set fileencoding=utf-8

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'sheerun/vim-polyglot'
Plug 'pearofducks/ansible-vim'

Plug 'weynhamz/vim-plugin-minibufexpl'

" see: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#vim-plug
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'ibhagwan/fzf-lua'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()


lua << EOF
  -- Setup for CopilotChat
  -- see: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#integration-with-pickers
  require("CopilotChat").setup({})
  require('fzf-lua').register_ui_select()
  vim.o.completeopt = "menu,noinsert,popup"

  -- copy to system clipboard and back without "+
  -- any yank also goes to system clipboard, but deletes do NOT
  -- using (set clipboard=unnamedplus) also deletes into system clipboard
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      if vim.v.event.operator == 'y' then
        vim.fn.system('wl-copy', vim.fn.getreg('"'))
      end
    end,
  })

  -- Disable documentation lookup with Shift + K, it was annoying
  vim.keymap.set('n', '<S-k>', '<Nop>')

  -- Reduce updatetime for better UX, default is 4000 ms (4s)
  vim.o.updatetime = 300

  -- Always show signcolumn, avoids text shifting when errors appear/disappear
  vim.wo.signcolumn = "yes"

  -- Buffer navigation mappings, like vim-unimpaired plugin
  vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })
  vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
  vim.keymap.set('n', '[B', ':bfirst<CR>', { silent = true })
  vim.keymap.set('n', ']B', ':blast<CR>', { silent = true })

  -- same as: set number
  vim.wo.number = true

  -- Filetype settings
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.conf",
    command = "setfiletype apache",
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "apache",
    command = "set syntax=apache",
  })

  -- anible, see: " from: https://github.com/pearofducks/ansible-vim
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.j2",
    command = "set filetype=yaml.ansible",
  })

EOF
