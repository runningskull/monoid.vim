"-----------------------------------------------------------------------
" monoid.vim / a subtle color theme using only 6 shades of grey
"
" Version: 1.2020-1-30
" Author:  https://github.com/runningskull
" License: CC0 (https://creativecommons.org/publicdomain/zero/1.0/)
"-----------------------------------------------------------------------

syn reset


function! s:rgboff(rgb, offset)
	return map(copy(a:rgb), 'max([0, min([v:val + a:offset, 255])])')
endfunction


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if &bg ==? 'light'
	let s:bg_0_gui = s:rgboff([244, 245, 245], get(g:, 'monoid_shift', 0))
	let s:fg_0_gui = s:rgboff([ 25,  25,  25], get(g:, 'monoid_shift', 0))
	let s:bg_1_gui = s:rgboff(s:bg_0_gui,  -5)
	let s:fg_1_gui = s:rgboff(s:fg_0_gui,  33)
	let s:fg_2_gui = s:rgboff(s:fg_0_gui, 111)
	let s:fg_3_gui = s:rgboff(s:fg_0_gui, 191)
else
	let s:bg_0  = get(g:, 'bg_0', '#282828')
	let s:bg_1  = get(g:, 'bg_1', '#303030')
	let s:fg_0  = get(g:, 'fg_0', '#ffffff')
	let s:fg_1	= get(g:, 'fg_1', '#eaeaea')
	let s:fg_2  = get(g:, 'fg_2', '#888888')
	let s:fg_3  = get(g:, 'fg_3', '#444444')
endif
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

if exists('g:monoid_nobold') | let s:bold = '' | endif
if exists('g:monoid_noitalic') | let s:italic = '' | endif

function! s:rgb2hex(rgb)
	let [r,g,b] = a:rgb
	return printf("#%02x%02x%02x", r, g, b)
endfunction

function! s:hi_fmt(list)
	let fmt = join(map(copy(a:list), 'get(s:,v:val,v:val)'), ',')
	return 'gui='.fmt.' cterm='.fmt
endfunction

function! s:hi_clr(role, var)
	if a:var ==? 'none'
		let [gui, term] = ['none', 'none']
	else
		let gui = s:rgb2hex(get(s:, a:var.'_gui'))
		let term = get(s:, a:var.'_term')
	endif
	return 'gui'.a:role.'='.gui.' cterm'.a:role.'='.term
endfunction

function! s:hi_group(group, ...)
	let hicmd = 'hi '.a:group.' '
	for kv in a:000
		let [key, val] = split(kv, '=')
		let role = matchlist(key, '\v(fg|bg)$')
		if len(role)
			let hicmd .= s:hi_clr(role[0], val) . ' '
		else
			let hicmd .= s:hi_fmt(split(val, ',')) . ' '
		endif
	endfor
	exe hicmd.''
endfunction
command! -nargs=+ HI call s:hi_group(<f-args>)



" Vim Core (see :h highlight-groups)

HI Normal			guifg=fg_0	  guibg=bg_0	gui=none
HI ColorColumn					  guibg=bg_1
HI Cursor										gui=reverse
HI CursorLine					  guibg=bg_1
HI CursorColumn					  guibg=bg_1
HI Directory		guifg=fg_0	  guibg=bg_0	gui=bold
HI EndOfBuffer		guifg=fg_3
HI VertSplit		guifg=fg_3	  guibg=bg_1	gui=none
HI Folded			guifg=fg_2	  guibg=none	gui=bold
HI FoldColumn		guifg=fg_2    guibg=bg_1	gui=bold
HI SignColumn		guifg=fg_2	  guibg=bg_1	gui=bold
HI IncSearch		guifg=fg_1	  guibg=bg_0	gui=reverse
HI LineNr			guifg=fg_3	  guibg=none	gui=none
HI CursorLineNr		guifg=fg_3	  guibg=none	gui=bold
HI MatchParen		guifg=fg_0	  guibg=fg_3	gui=bold
HI ModeMsg			guifg=fg_2					gui=bold
HI NonText			guifg=fg_3
HI Pmenu			guifg=fg_1	  guibg=fg_3
HI PmenuSel			guifg=bg_0    guibg=fg_2	gui=bold
HI QuickFixLine		guifg=fg_0	  guibg=fg_3	gui=bold
HI Search						  guibg=bg_0	gui=reverse
HI StatusLine		guifg=fg_2	  guibg=bg_0	gui=reverse,bold
HI StatusLineNC		guifg=fg_3	  guibg=fg_2	gui=reverse
HI TabLineFill					  guibg=fg_3	gui=none
HI TabLine										gui=italic
HI Title			guifg=fg_1					gui=bold
HI Visual						  guibg=fg_3


" Syntax (see :h group-name)

HI Comment			guifg=fg_2					gui=italic
HI Constant			guifg=fg_0	  				gui=italic
HI String			guifg=fg_1	  				gui=italic
HI Character		guifg=fg_0	  				gui=italic
HI Number			guifg=fg_0	  				gui=none
HI Boolean			guifg=fg_0	  				gui=none
HI Float			guifg=fg_0	  				gui=none

HI Identifier		guifg=fg_0	  				gui=none
HI Function			guifg=fg_0	  				gui=none

HI Statement		guifg=fg_1	  				gui=bold
HI Conditional		guifg=fg_1	  				gui=bold
HI Repeat			guifg=fg_1	  				gui=bold
HI Label			guifg=fg_1	  				gui=bold
HI Operator 		guifg=fg_1	  				gui=bold
HI Keyword			guifg=fg_1	  				gui=bold
HI Exception		guifg=fg_1	  				gui=bold

HI PreProc			guifg=fg_1	  				gui=bold
HI Include			guifg=fg_1	  				gui=bold
HI Define			guifg=fg_1	  				gui=bold
HI Macro			guifg=fg_1	  				gui=bold
HI PreCondit		guifg=fg_1	  				gui=bold

HI Type				guifg=fg_1	  				gui=none
HI StorageClass		guifg=fg_1	  				gui=none
HI Structure		guifg=fg_1	  				gui=bold
HI Typedef			guifg=fg_1	  				gui=none

HI Special			guifg=fg_2
HI Todo				guifg=fg_2	  guibg=none	gui=bold,italic


" Language-Specific Additions

HI cppFunctionDecl	guifg=fg_0					gui=bold
HI cppClassDecl		guifg=fg_0					gui=bold
HI cppVarDecl		guifg=fg_0					gui=bold

hi link qfLineNr NONE



delcommand HI

" vim: set noet ts=4 sw=4 fdm=indent :
