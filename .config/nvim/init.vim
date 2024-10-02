call plug#begin()
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'tjdevries/colorbuddy.nvim'
Plug 'svrana/neosolarized.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" lsp-zero ------
" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim'           " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion Engine
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'hrsh7th/cmp-buffer'       " Optional
Plug 'hrsh7th/cmp-path'         " Optional
Plug 'saadparwaiz1/cmp_luasnip' " Optional
Plug 'hrsh7th/cmp-nvim-lua'     " Optional

"  Snippets
Plug 'L3MON4D3/LuaSnip'             " Required
Plug 'rafamadriz/friendly-snippets' " Optional

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}
" lsp-zero ------

Plug 'simrat39/rust-tools.nvim'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'vim-test/vim-test'

Plug 'dense-analysis/ale'

Plug 'wellle/targets.vim'

Plug 'CopilotC-Nvim/CopilotChat.nvim'
call plug#end()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  augroup js_ident
  	au!
  	autocmd FileType javascript setlocal ts=4 sw=4 expandtab
  	autocmd FileType typescript setlocal ts=4 sw=4 expandtab
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set shiftwidth=4
set tabstop=4
set textwidth=78
set expandtab
set number
set guioptions-=T
set guioptions-=m

if has("gui_running") 
	set columns=85
endif

"ajustar largura do parágrafo
map <C-j> mt { gq} 't

command! PrefWinPos :call PrefWinPosFunc()
function! PrefWinPosFunc()
	set lines=42
	set columns=85
	winpos 270 0
endfunction

" txt2tags syntax
au BufNewFile,BufRead *.t2t set ft=txt2tags sidescroll=5
au BufNewFile,BufRead *.t2t set nowrap listchars+=precedes:<,extends:>

"Jenkinsfile expandtab
au BufNewFile,BufRead Jenkinsfile set expandtab

"change files with C-N and C-P
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

"set window width to 84
nnoremap \| 84<C-W>\|

"allow hidden buffers
set hidden

"enable ctags.vim
let g:ctags_statusline=1
let generate_tags=1

"map arrow keys to scroll
map <Down> <c-e>
map <Up> <c-y>

"Refresh CSCOPE
nnoremap <silent> <C-C> :!cd /; find /linuxppc/SELF/build/application/{PD2300/,Linux*,linux*,PD2301/,DMlib} -not -type l -and \( -name "*.c" -o -name "*.h" \) > /a/cscope.files; cd -; cd /a; cscope -b -q -k; cd -;<CR>:cs reset<CR>

"Pathogen
"execute pathogen#infect()

"Solarized
"set background=dark
set termguicolors
"colorscheme solarized8

"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set wildmenu

function! EmberGetFilename(file)
    let match = matchlist(a:file,'app/\([^/]*\)/\([^.]*\)\..*$')
    if len(match) <= 1
        return ''
    endif
    let type = l:match[1]
    let name = l:match[2]
    if !empty(name)
        if type == "templates" && match(name,'^component/') >= 0
            let name = substitute(name,'^component/','','')
        endif
        return name
    endif
endfunction

function! EmberFilterFiles(list)
    let newList = []
    for item in a:list
        if item !~ '\~$'
            if filereadable(item)
                let newList = add(newList,item)
            endif
        endif
    endfor
    return newList
endfunction

function! EmberWildFileList(filename)
    return split(expand('app/**/'.a:filename.'.*'),'\n')
endfunction

function! EmberSimilarFiles(files)
    "let files=split(expand('app/**/'.GetEmberFile(a:filename).'.*'),'\n')
    let files=EmberFilterFiles(a:files)
    if len(files) == 0
        echo 'No Ember files found'
        return
    endif
    let c=1
    for f in files
        echom c . ': ' . f
        let c += 1
    endfor
    let index = input('Select file (0 cancel): ')
    if index > 0
        execute 'edit' files[index-1]
    endif
endfunction
nnoremap \el :call EmberSimilarFiles(EmberWildFileList(EmberGetFilename(expand('%@'))))<CR>
nnoremap \e] :call EmberSimilarFiles(EmberWildFileList(expand('<cfile>')))<CR>
nnoremap \ef :call EmberSimilarFiles(EmberWildFileList(input('Component name: ')))<CR>
command! -nargs=1 EmberFind call EmberSimilarFiles(EmberWildFileList(<f-args>))<CR>

"buffer navigation
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> [b :bp<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
lua << EOF
vim.api.nvim_set_keymap( 'n', '<leader>fG', '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', {})
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "javascript", "vue", "terraform", "php", "lua", "vim", "dockerfile" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- disable = { "vim" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
      enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

lua << EOF
  require('neosolarized').setup({
    comment_italics = true,
    background_set = false,
  })
EOF

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup{
    ensure_installed = { "tsserver", "phpactor" },
}
EOF

"lspconfig
lua << EOF
--[[
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

-- languages
require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
--]]
EOF

"lsp-zero config
set completeopt=menu,menuone,noselect
lua << EOF
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = false,
  suggest_lsp_servers = false,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.skip_server_setup({'rust-analyzer'})

lsp.setup()

local cmp = require('cmp')
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
        {name = 'path'},
    },
    preselect=cmp.PreselectMode.None,
    mapping = {
        ['<C-j>'] = cmp.mapping.confirm({select = false}),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-p>'] = cmp.mapping(function()
        if cmp.visible() then
            cmp.select_prev_item({behavior = 'insert'})
        else
            cmp.complete()
        end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
        end,
        },
    })
EOF

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <leader>rn :call NumberToggle()<CR>

lua << EOF
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
EOF

lua << EOF
-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
EOF

"trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

"vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

"ale
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0

"clear search highlight until next search with C-L
nnoremap <nowait><silent> <C-H> :noh<CR>

"copilot remaps
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
imap <C-L> <Plug>(copilot-accept-word)
let g:copilot_filetypes = {
            \ 'markdown': v:false,
            \ 'text': v:false,
            \ }

"copilot chat
lua << EOF
local copilot_chat = require("CopilotChat")
copilot_chat.setup({
  debug = true,
  show_help = "yes",
  prompts = {
    Explain = "Explain how it works.",
    Review = "Review the following code and provide concise suggestions.",
    Tests = "Briefly explain how the selected code works, then generate unit tests.",
    Refactor = "Refactor the code to improve clarity and readability.",
  },
  build = function()
    vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
  end,
  event = "VeryLazy",
})

EOF

nnoremap <leader>ccb <cmd>CopilotChatBuffer<cr>
nnoremap <leader>cce <cmd>CopilotChatExplain<cr>
nnoremap <leader>cct <cmd>CopilotChatTests<cr>
xnoremap <leader>ccv :CopilotChatVisual<cr>
xnoremap <leader>ccx :CopilotChatInPlace<cr>
nnoremap <leader>cpo <cmd>CopilotChatOpen<cr>
nnoremap <leader>cpc <cmd>CopilotChatClose<cr>

"map to set relative numbers
nnoremap <leader>nr <cmd>set relativenumber<cr>
nnoremap <leader>nn <cmd>set norelativenumber<cr>
