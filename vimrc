" Vim configuration optimzed for Python development
" Heavily influnced by http://sontek.net/turning-vim-into-a-modern-python-ide

" Load vim plugins via Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Code folding
set foldmethod=indent
set foldlevel=99

" Task list
map <leader>td <Plug>TaskList

" Revision History
map <leader>g :GundoToggle<CR>

" Syntex Highlighting and Validation
syntax on " syntax highlighting
filetype on " try to detect filetypes 
filetype plugin indent on    " enable loading indent file for filetype

" Disable quickfix window for PyFlakes
let g:pyflakes_use_quickfix = 0

" Pep8
let g:pep8_map='<leader>8'

" Tab Completion and Documentation
" Use SuperTab to make tab completion be context sensitive and enable 
" omni code completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" Enable menu and pydoc preview
set completeopt=menuone,longest,preview

" File Browser
" Bind a shortcut key for opening the NERD Tree file browser
map <leader>n :NERDTreeToggle<CR>

" Refactoring and Go to definition
" Bind some shortcut keys for frequently used Rope operations
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" Test Integration
" This will just give you a green bar at the bottom of vim if your test passed
" or a red bar with the message of the failed test if it doesn't.
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" py.test vim plugin key bindings
" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" Virtualenv
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Statuslines
" 
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html 
" is useful documentation on statuslines 
" Make status line show for all windows, not just split ones
set laststatus=2

set statusline=%-.100f     " tail of the filename
set statusline+=%10l " cusor line
set statusline+=,%c   " cursor column
set statusline+=%40{fugitive#statusline()}    " Show which Git branch we're currently working on
