"-----------------------------------------------------------------------
" monoid.vim / a subtle color theme using only 6 shades of grey
"
" Version: 1.2019-11-10
" Author:  https://github.com/runningskull
" License: CC0 (https://creativecommons.org/publicdomain/zero/1.0/)
"-----------------------------------------------------------------------

syn reset


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if &bg ==? 'light'
	let s:fg_0  = '#3a3a3a'
	let s:fg_1  = '#191919'
	let s:fg_2  = '#888888'
	let s:fg_3  = '#d8d8d8'
	let s:bg_1  = '#ffffff'
	let s:bg_2  = '#f6f6f6'
else
	let s:fg_0	= '#eaeaea'
	let s:fg_1  = '#ffffff'
	let s:fg_2  = '#888888'
	let s:fg_3  = '#444444'
	let s:bg_1  = '#282828'
	let s:bg_2  = '#303030'
endif
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


if exists('g:monoid_nobold') | let s:bold = '' | endif
if exists('g:monoid_noitalic') | let s:italic = '' | endif

function! s:hi_group(group, ...)
	let hicmd = 'hi ' . a:group
	for kv in a:000
		let [k, vlist] = split(kv, '=')
		let vstr = ''
		for v in split(vlist, ',') | let vstr .= get(s:,v,v) . ',' | endfor
		let hicmd .= ' ' . k . '=' . substitute(vstr, ",$", "", "") 
	endfor
	exe hicmd.''
endfunction
command! -nargs=+ HI call s:hi_group(<f-args>)



" Vim Core (see :h highlight-groups)

HI Normal			guifg=fg_1	  guibg=bg_1	gui=none
HI ColorColumn					  guibg=bg_3
HI Cursor										gui=reverse
HI CursorLine					  guibg=bg_2
HI CursorColumn					  guibg=bg_2
HI Directory		guifg=fg_1	  guibg=bg_1	gui=bold
HI EndOfBuffer		guifg=fg_3
HI VertSplit		guifg=fg_3	  guibg=none	gui=none
HI Folded			guifg=fg_2	  guibg=none	gui=bold
HI FoldColumn		guifg=fg_2    guibg=bg_2	gui=bold
HI SignColumn		guifg=fg_2	  guibg=bg_2	gui=bold
HI IncSearch		guifg=fg_0	  guibg=bg_1	gui=reverse
HI LineNr			guifg=fg_3	  guibg=none	gui=none
HI CursorLineNr		guifg=fg_3	  guibg=none	gui=bold
HI MatchParen		guifg=fg_1	  guibg=fg_3	gui=bold
HI ModeMsg			guifg=fg_2					gui=bold
HI NonText			guifg=fg_3
HI Pmenu			guifg=fg_0	  guibg=fg_3
HI PmenuSel			guifg=bg_1    guibg=fg_2	gui=bold
HI QuickFixLine		guifg=fg_1	  guibg=fg_3	gui=bold
HI Search						  guibg=bg_1	gui=reverse
HI StatusLine		guifg=fg_2	  guibg=bg_1	gui=reverse,bold
HI StatusLineNC		guifg=fg_3	  guibg=fg_2	gui=reverse
HI TabLineFill					  guibg=fg_3	gui=none
HI Title			guifg=fg_0					gui=bold
HI Visual						  guibg=fg_3


" Syntax (see :h group-name)

HI Comment			guifg=fg_2					gui=italic
HI Constant			guifg=fg_1	  				gui=italic
HI String			guifg=fg_0	  				gui=italic
HI Character		guifg=fg_1	  				gui=italic
HI Number			guifg=fg_1	  				gui=none
HI Boolean			guifg=fg_1	  				gui=none
HI Float			guifg=fg_1	  				gui=none

HI Identifier		guifg=fg_1	  				gui=none
HI Function			guifg=fg_1	  				gui=none

HI Statement		guifg=fg_0	  				gui=bold
HI Conditional		guifg=fg_0	  				gui=bold
HI Repeat			guifg=fg_0	  				gui=bold
HI Label			guifg=fg_0	  				gui=bold
HI Operator 		guifg=fg_0	  				gui=bold
HI Keyword			guifg=fg_0	  				gui=bold
HI Exception		guifg=fg_0	  				gui=bold

HI PreProc			guifg=fg_0	  				gui=bold
HI Include			guifg=fg_0	  				gui=bold
HI Define			guifg=fg_0	  				gui=bold
HI Macro			guifg=fg_0	  				gui=bold
HI PreCondit		guifg=fg_0	  				gui=bold

HI Type				guifg=fg_0	  				gui=none
HI StorageClass		guifg=fg_0	  				gui=none
HI Structure		guifg=fg_0	  				gui=bold
HI Typedef			guifg=fg_0	  				gui=none

HI Special			guifg=fg_2
HI Todo				guifg=fg_2	  guibg=none	gui=bold,italic


" Language-Specific Additions

HI cppFunctionDecl	guifg=fg_1					gui=bold
HI cppClassDecl		guifg=fg_1					gui=bold

hi link qfLineNr __NULL__



delcommand HI

" vim: set noet ts=4 sw=4 fdm=indent :
