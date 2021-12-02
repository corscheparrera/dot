syntax 



:set relativenumber
:set number
:set expandtab
:set shiftwidth=4

" set leader key
let mapleader = ","


let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
noremap <Leader>y "*y


call plug#begin('~/.vim/plugged')
 "Plug 'psliwka/vim-smoothie'
 "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 "Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'phanviet/vim-monokai-pro'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
 "Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon', {'commit' : '54a47d3590936d81c32ba10fc66b39b41ac83f3'}
 "Plug 'mattn/emmet-vim'
 "Plug 'prettier/vim-prettier', {
 "  \ 'do': 'yarn install',
 "    \ 'branch': 'release/0.x'
 "      \ }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you
 "      don't have it yet!
Plug 'nvim-lua/popup.nvim'
 "      Plug 'mhartington/vim-angular2-snippets'
 "      Plug 'maksimr/vim-jsbeautify'
 "
 "
 "
 call plug#end()
 "
 nnoremap <leader>n :NERDTreeFocus<CR>
 nnoremap <C-n> :NERDTree<CR>

 let g:NERDTreeIgnore = ['^node_modules$']
 nmap <C-n> :NERDTreeToggle<CR>


 map <leader>r :NERDTreeFind<cr>

 nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
 nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
 nnoremap <C-f> :lua require('telescope.builtin').find_files()<CR>
 nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
 nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>


 " sync open file with NERDTree
 " " " Check if NERDTree is open or active
 function! IsNERDTreeOpen()        
   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
 endfunction
 "
 "   " Call NERDTreeFind iff NERDTree is active, current window contains a
 "   modifiable
 "   "
 "   " file, and we're not in vimdiff
   function! SyncTree()
     if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
         NERDTreeFind
             wincmd p
               endif
               endfunction

               let g:NERDTreeWinSize=60
               " Highlight currently open buffer in NERDTree
               autocmd BufEnter * call SyncTree()
                "enable line numbers
                let NERDTreeShowLineNumbers=1
 "               " make sure relative line numbers are used
               autocmd FileType nerdtree setlocal relativenumber

set termguicolors
colorscheme monokai_pro

let g:lightline = {
          \ 'colorscheme': 'monokai_pro',
      \ }

"coc config
 let g:coc_global_extensions = [
   \ 'coc-snippets',
   \ 'coc-pairs',
   \ 'coc-tsserver',
   \ 'coc-eslint', 
   \ 'coc-prettier', 
   \ 'coc-json', 
   \]
" <c-space> to trigger completion.
 if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
  else
  inoremap <silent><expr> <c-@> coc#refresh()
 endif

 " Make <CR> auto-select the first completion item and notify coc.nvim to
 " " format on enter, <cr> could be remapped by other vim plugin
 inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
 \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 
 " GoTo code navigation.
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)
 " Highlight the symbol and its references when holding the cursor.
 autocmd CursorHold * silent call CocActionAsync('highlight')

 " Symbol renaming.
 nmap <leader>rn <Plug>(coc-rename)

 " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
 " Apply AutoFix to problem on the current line.
 nmap <leader>qf  <Plug>(coc-fix-current)

 " Map function and class text objects
 " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
 xmap if <Plug>(coc-funcobj-i)
 omap if <Plug>(coc-funcobj-i)
 xmap af <Plug>(coc-funcobj-a)
 omap af <Plug>(coc-funcobj-a)
 xmap ic <Plug>(coc-classobj-i)
 omap ic <Plug>(coc-classobj-i)
 xmap ac <Plug>(coc-classobj-a)
 omap ac <Plug>(coc-classobj-a)

 " Remap <C-f> and <C-b> for scroll float windows/popups.
 if has('nvim-0.4.0') || has('patch-8.2.0750')
   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
   coc#float#scroll(1) : "\<C-f>"
   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
   coc#float#scroll(0) : "\<C-b>"
   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
   \<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
   \<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
   coc#float#scroll(1) : "\<C-f>"
   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
   coc#float#scroll(0) : "\<C-b>"
   endif

" Add `:OR` command for organize imports of the current buffer.
 command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

 
 " Add (Neo)Vim's native statusline support.
 " NOTE: Please see `:h coc-status` for integrations with external plugins
 " that
 " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
 
 " Mappings for CoCList
 " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
 " Manage extensions.
 nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
 " Show commands.
 nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
 " Find symbol of current document.
 nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
 " Search workspace symbols.
 nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
 " Do default action for next item.
 nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
 " Do default action for previous item.
 nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
 nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" harpoon config
 nnoremap <leader>, :lua require(harpoon.mark"").add_file()<CR>
 nnoremap <C-e> :lua require(harpoon.ui"").toggle_quick_menu()<CR>)")
