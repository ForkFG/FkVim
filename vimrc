" Basic
set		mouse=a

set		number
set		cursorline

inor	<C-Z> <ESC>ua
nnor	ve :vnew $VIMRC<CR> 
nnor	vs :source $VIMRC<CR> 

set		hlsearch
set		incsearch
nnor	<silent> <ESC>/ :set hlsearch!<CR>
nnor	/iw yiw/\<<C-R>"\><CR>
nnor	siw yiw:%s/\<<C-R>"\>/
vnor	/ y<ESC>/\<<C-R>"\><CR>
vnor	s y<ESC>:%s/\<<C-R>"\>/

nnor	; :
nnor	?? :h 
nnor	Q :q<CR>
nnor	S :w<CR>
nnor	Sq :wq<CR>
nnor	Sg :w<CR>:!gulp<CR>
nnor	Sgg :w<CR>:!gulp 

set		shiftwidth=4
set		tabstop=4
set		softtabstop=4

set		nowrap
nnor	<silent> <ESC>w :set wrap!<CR>

set		foldmethod=indent
" nnor	za zA
" nnor	zA za

inor	<C-\>p Ψ

" Learner
map <Left>	<Nop>
map <Right>	<Nop>
map <Up>	<Nop>
map <Down>	<Nop>

" Highlight " Vim
set t_Co=256
syntax on

hi LineNr					ctermfg=White
hi CursorLine									cterm=underline
hi CursorLineNr									cterm=bold

hi qfLineNr					ctermfg=DarkGreen

" Highlight " Via
hi Annotation				ctermfg=Blue
hi AnnotationBracket		ctermfg=Grey
hi AnnotationSymbol			ctermfg=Red
hi AnnotationComma			ctermfg=Grey
hi AnnotationType			ctermfg=DarkBlue	cterm=underline
hi AnnotationNote			ctermfg=DarkGrey

" Highlight " JS
hi javaScriptFkUtilAPI              ctermfg=55              cterm=underline
hi javaScriptFkUtilConst            ctermfg=77              cterm=underline

hi javaScriptDefine                 ctermfg=69              cterm=bold
hi javaScriptDefineProper           ctermfg=21
hi javaScriptDefineException        ctermfg=196
hi javaScriptFuncKeyword            ctermfg=69              cterm=bold
hi javaScriptFuncDef                ctermfg=18
hi javaScriptFuncArg                ctermfg=99
hi javaScriptFuncComma              ctermfg=240
hi javaScriptFuncEq                 ctermfg=240

hi javaScriptOperatorKeyword        ctermfg=248             cterm=bold
hi javaScriptOperatorSymbol         ctermfg=248
hi javaScriptOperatorSymbolLogic    ctermfg=248

hi javaScriptNumber                 ctermfg=77
hi javaScriptGlobalLiteral          ctermfg=77
hi javaScriptBoolean                ctermfg=77
hi javaScriptNull                   ctermfg=77
hi javaScriptString                 ctermfg=128
hi javaScriptTemplate               ctermfg=128
hi javaScriptTemplateSubstitution   ctermfg=99
hi javaScriptRegexpString           ctermfg=77

hi javaScriptBraces                 ctermfg=74
hi javaScriptParens                 ctermfg=74

hi javaScriptModule                 ctermfg=199
hi javaScriptCommonModule           ctermfg=199

hi javaScriptGlobalObjects          ctermfg=129
hi javaScriptScope                  ctermfg=199

hi javaScriptDollar                 ctermfg=240
hi javaScriptSpecial                ctermfg=99
hi javaScriptDebug                  ctermfg=238             cterm=underline

hi javaScriptShebang                ctermfg=19              cterm=bold,underline
hi javaScriptCommentLine            ctermfg=20              cterm=bold
hi javaScriptComment                ctermfg=20              cterm=bold
hi javaScriptCommentTodo            ctermfg=233             cterm=bold,underline

hi javaScriptAsync                  ctermfg=208             cterm=bold
hi javaScriptClass                  ctermfg=205             cterm=bold

hi javaScriptConditional            ctermfg=37              cterm=bold
hi javaScriptRepeat                 ctermfg=41              cterm=bold
hi javaScriptControl                ctermfg=27              cterm=bold
hi javaScriptExceptions             ctermfg=196             cterm=bold
hi javaScriptLabel                  ctermfg=202

" FtDetect
aug FtDetect | au!
	au BufRead,BufNewFile	*.via		setf via " VIm Annotated
	au FileType				via			cal VimAnn()
	au FileType				javascript	cal JS()
aug END

" Via

let g:via_map = 'English'
fun! VimAnn()
	setl	nofoldenable

	" Syntax
	fun! SynAnn()
		if exists('b:via_syn') | retu | endif
		let b:via_syn = 1
		" echom '[via] Syn: ' . (&ft == 'via' ? 'main' : 'loc') . '.'

		sy match	Annotation			/(.\{-})/				contains=
			\AnnotationBracket,AnnotationSymbol,AnnotationComma,
			\AnnotationType,AnnotationNote
		sy match	AnnotationBracket	/[()]/					contained
		sy match	AnnotationSymbol	/[@*!=<>#\-|:]/			contained
		sy match	AnnotationComma		/,/						contained
		sy match	AnnotationType		/#[^()@*!=<>#\-|:]\+\./	contained
		sy match	AnnotationNote		/\(:\)\@<=[^)]\+/		contained
	endfun
	cal SynAnn()

	" Map

	let s:umap_dict = g:via_map
	if s:umap_dict == 'English'
		let s:umap_dict = #{
		\ InsertAnn: '<C-A>a',
		\ OpenAnnWin: '<C-A>o',
		\ UpdOpenAnnWin: '<C-A>p',
		\ CloseAnnWin: '<C-A>q',
		\ NextAnnWin: '<C-A>]',
		\ PrevAnnWin: '<C-A>[',
		\ }
	elseif s:umap_dict == 'Chinese'
		let s:umap_dict = #{
		\ InsertAnn: '；',
		\ NextAnnInl: '】',
		\ PrevAnnInl: '【',
		\ EscBang: '！',
		\ EscComma: '，',
		\ EscAngleL: '《',
		\ EscAngleR: '》',
		\ OpenAnnWin: '。',
		\ UpdOpenAnnWin: '。。',
		\ CloseAnnWin: '。，',
		\ NextAnnWin: '｝',
		\ PrevAnnWin: '｛',
		\ CopyCurWord: '、'
		\ }
	endif

	cal _umap('InsertAnn', '<Right>()<Left>', 'i', { 'necessary': 1 })
	cal _umap('InsertAnn', 'a()<Left>', 'n')
	cal _umap('NextAnnInl', 'f(', 'ni')
	cal _umap('PrevAnnInl', 'F(', 'ni')

  	cal _umap('EscBang', '!', 'i')
  	cal _umap('EscBang', ',', 'i')
  	cal _umap('EscBang', '<', 'i')
  	cal _umap('EscBang', '>', 'i')
	
	cal _umap('OpenAnnWin', ':lop<CR><C-W>k', 'ni', { 'silent': 1 })
	cal _umap('UpdOpenAnnWin', ':cal UpdAnn()<CR>:lop<CR>:cal SynAnn()<CR><C-W>k', 'ni', { 'silent': 1 })
	cal _umap('CloseAnnWin', ':lclose<CR>', 'ni')

	cal _umap('NextAnnWin', ':lnext<CR>', 'ni', { 'silent': 1 })
	cal _umap('PrevAnnWin', ':lprev<CR>', 'ni', { 'silent': 1 })

	cal _umap('CopyCurWord', '<ESC>mUyiw`Ua', 'i')

	setl	iskeyword+=-
	iabb	via-h 
		\(Title          @)<CR>
		\(LocaleTitle    @)<CR>
		\(Author         @)<CR>

	" Annotation location window
	fun! GetAnn(fmt)
		let ls = getline(1, '$')
		let a = []
		let i = 0 | whi i < len(ls)
			let aR = { 'R': i, 'ann': [] }
			let j = 0 | whi 1
				let r = matchstrpos(ls[i], '[A-Za-z\-]\{-}(.\{-})', j)
				let j = r[2]
				if j == -1 | brea | endif
				let aC = { 'C': r[1], 'txt': r[0] }
				if type(a:fmt) == 2
					let f = a:fmt(r[0])
					for k in keys(f)
						let aC[k] = f[k]
					endfor
				endif
				cal add(aR.ann, aC)
			endwhi
			if len(aR.ann) > 0
				cal add(a, aR)
			endif
		let i += 1 | endwhi
		retu a
	endfun

	fun! UpdAnn()
		fun! EngAnn(t)
			let r = split(a:t[:-2], '(')
			if len(r) == 1 | let r = [ "" ] + r | endif
			let n = { 'tar': r[0], 'ann': r[1] }
			if match(r[1], '@') != -1
				let n.meta = split(r[1], '\s\?@')
			endif
			retu n
		endfun

		fun! TxtAnn(d)
			let is = getloclist(0, { 'id': a:d.id, 'items': 1 }).items
			let ls = []
			for i in range(a:d.start_idx - 1, a:d.end_idx - 1)
				let it = is[i]
				cal add(ls,
					\ it.type . '|' .
					\ _space(it.lnum, 4) . ', ' .
					\ _space(it.col, 5) . '| ' .
					\ it.text)
			endfor
			retu ls
		endfun

		cal setloclist(0, [])
		" echom '[via] Clr.'
		
		let a = GetAnn(funcref('EngAnn'))
		let is = []
		for aR in a
			for aC in aR.ann
				let m = aC.tar == "" && exists("aC.meta")
				let it = {
					\ 'lnum': (aR.R + 1), 'col': (aC.C + 1),
					\ 'type': (m ? 'M' : 'A'),
					\ 'text': (m ? aC.meta[0] . ' @ ' . aC.meta[1]
					\			 : aC.txt),
					\ 'bufnr': bufnr() }
				cal add(is, it)
			endfor
		endfor
		
		cal setloclist(0, [], 'r', {
			\ 'title': 'Annotations', 'items': is,
			\ 'quickfixtextfunc': 'TxtAnn' })
		" echom '[via] Upd.'
		if exists("b:via_syn") | unlet b:via_syn | endif
	endfun
endfun

" JS

fun! JS()
	" Fragment
	inor <C-\>cl console.log()<Left>
endfun

" Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'rust-lang/rust.vim'

Plugin expand('file://$HOME/_/FkVim'), { 'rtp': 'javascript/' }

Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = [ 'eslint' ]
let g:syntastic_always_populate_loc_list = 1

Plugin 'Chiel92/vim-autoformat'

Plugin 'kana/vim-fakeclip'
let g:fakeclip_provide_clipboard_key_mappings = 1

" Plugin 'Yggdroot/indentLine'
" let g:indentLine_setColors = 7

call vundle#end()

" Utility

fun! _space(s, n)
	retu a:s . repeat(' ', a:n - strlen(a:s))
endfun

fun! _umap(id, act, mode, opt = {})
	let o = a:opt
	
	if ! exists('s:umap_dict[a:id]')
		if exists('o.necessary')
			throw '_umap: map id `' . a:id . '` is empty.'
		endif
		retu
	endif

	let cmd = (exists('o.recusive') ? 'map' : 'nor') . ' ' .
			\ (exists('o.global') ? '' : '<buffer> ') .
			\ (exists('o.silent') ? '<silent> ' : '') .
			\ s:umap_dict[a:id] . ' '
	
	exe a:mode[0] . cmd . a:act

	if	a:mode == "ni"
		exe 'i' . cmd . '<ESC>' . a:act . 'a'
	endif
endfun

