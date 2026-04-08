" the prefix to use for leader commands
let g:mapleader=" "

" Use vim-plug to manage your plugins:
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/vendor')

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'vim-pandoc/vim-pandoc'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Raimondi/delimitMate'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'xiyaowong/transparent.nvim'
Plug 'Mofiqul/vscode.nvim'
Plug 'stannls/vim-checkstyle'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

Plug 'startup-nvim/startup.nvim'
" Dependencys for startup plugin
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'fannheyward/telescope-coc.nvim'

let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_inactive_collapse=0
let g:airline_section_a = ''
" let g:airline_section_b = ''
let g:airline_section_c = '%f'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l'
let g:airline_theme='rigel'
let g:rigel_airline = 1

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 500

Plug 'Rigellute/rigel'
Plug 'pineapplegiant/spaceduck'
Plug 'Julian/lean.nvim'
"lua <<EOF
"require("nvim-treesitter.configs").setup({
"    ensure_installed = "maintained",
"    ignore_install = {"latex"},
"    highlight = {
"        enable = true,
"    },
"})
"EOF
call plug#end()

set expandtab
set tabstop=4
set shiftwidth=4 smarttab

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" simplify switching workspaces

" Completion with nvim-cmp
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<Tab>" :
      \ "\<C-x>\<C-o>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> "\<C-x>\<C-o>"

" Navigate diagnostics
nmap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nmap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>

" GoTo code navigation
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

" Show documentation
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" Symbol renaming
nmap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" Formatting
xmap <leader>f  <cmd>lua vim.lsp.buf.format()<CR>
nmap <leader>f  <cmd>lua vim.lsp.buf.format()<CR>

" Code actions
xmap <leader>a  <cmd>lua vim.lsp.buf.code_action()<CR>
nmap <leader>a  <cmd>lua vim.lsp.buf.code_action()<CR>
nmap <leader>ac <cmd>lua vim.lsp.buf.code_action()<CR>

" Search workspace symbols
nnoremap <silent><nowait> <space>w  <cmd>Telescope lsp_workspace_symbols<cr>
" Search document symbols
nnoremap <silent><nowait> <space>s  <cmd>Telescope lsp_document_symbols<cr>
" Show all diagnostics
nnoremap <silent><nowait> <space>d  <cmd>Telescope diagnostics<cr>
" Find file
nnoremap <silent><nowait> <space>f  <cmd>Telescope find_files<cr>
" Fuzzy find
nnoremap <silent><nowait> <space>ff  <cmd>Telescope grep_string<cr>

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-W> <C-W>w

" nerdtree config
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeChDirMode = 2

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-r> :Telescope oldfiles<CR>
nnoremap <C-f> :Telescope live_grep<CR>

set termguicolors
syntax enable
filetype plugin indent on
hi Normal guibg=NONE ctermbg=NONE
set number

colorscheme tokyonight

" CTRL-Tab is next tab
noremap <C-e> :<C-U>tabnext<CR>
inoremap <C-e> <C-\><C-N>:tabnext<CR>
cnoremap <C-e> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-q> :<C-U>tabprevious<CR>
inoremap <C-q> <C-\><C-N>:tabprevious<CR>
cnoremap <C-q> <C-C>:tabprevious<CR>

" Map CRTL-P to open coc commands"
noremap <C-p> :<C-U>CocCommand<CR>
inoremap <C-p> <C-\><C-N>:CocCommand<CR>
cnoremap <C-p> <C-C>:CocCoammand<CR>

"Mapping for new tab"
noremap <C-n> :<C-U>tabnew<CR>
inoremap <expr> <C-n> !pumvisible() ? '<C-\><C-N>:tabnew<CR>' : ''
cnoremap <C-n> <C-C>:tabnew<CR>

:inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<cr>"

set clipboard +=unnamedplus

" Checkstyle plugin
let g:Checkstyle_Classpath = "/usr/share/java/checkstyle/checkstyle.jar"

if has('win32') || has ('win64')
    let g:Checkstyle_XML = $VIM."/Downloads/checkstyle-sheet4-5.xml"
else
    let g:Checkstyle_XML = $HOME."/Downloads/checkstyle-sheet4-5.xml"
endif

" Folding
autocmd BufWritePost *.java :Checkstyle
autocmd BufRead,BufNewFile *.java :Checkstyle
autocmd BufReadPost,FileReadPost * normal zR

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Use lualatex as tex enginge
let g:vimtex_compiler_engine = 'lualatex'

" Bookmarks for startify
let g:startify_bookmarks = [
\	{ 'H': '~/.config/hypr/hyprland.conf' },
\	{ 'V': '~/.config/nvim/init.vim' },
\	{ 'Z': '~/.config/zshrc' },
\	{ 'A': '~/.config/alacritty/alacritty.yml' },
\  ]


lua << EOF
require"startup".setup({
	theme = "dashboard"
})
require("telescope").setup({
})
require('lean').setup{ mappings = true }
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
})
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "path" },
  }),
  experimental = { ghost_text = true },
})
EOF
