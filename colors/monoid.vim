"-----------------------------------------------------------------------
" monoid.vim / a subtle color theme using only 6 shades of grey
"
" Version: 2020.05.12
" Source:  https://github.com/runningskull/monoid.vim
" License: CC0 (https://creativecommons.org/publicdomain/zero/1.0/)
"-----------------------------------------------------------------------

syn reset


function! s:rgbclamp(x)
	return max([0, min([float2nr(round(a:x)), 255])])
endfunction

function! s:rgbscale(rgb, scale)
	return map(copy(a:rgb), 's:rgbclamp(v:val * a:scale)')
endfunction


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if &bg ==? 'light'
	let s:bg_0_gui = get(g:,'monoid_bg_gui', [244, 245, 245])
	let s:bg_1_gui = s:rgbscale(s:bg_0_gui, 0.98)
	let s:fg_0_gui = s:rgbscale(s:bg_0_gui, 0.10)
	let s:fg_1_gui = s:rgbscale(s:bg_0_gui, 0.24)
	let s:fg_2_gui = s:rgbscale(s:bg_0_gui, 0.56)
	let s:fg_3_gui = s:rgbscale(s:bg_0_gui, 0.88)
else
	let s:bg_0_gui  = get(g:,'monoid_bg_gui', [39, 40, 40])
	let s:bg_1_gui  = s:rgbscale(s:bg_0_gui, 1.20)
	let s:fg_0_gui  = s:rgbscale(s:bg_0_gui, 6.38)
	let s:fg_1_gui	= s:rgbscale(s:bg_0_gui, 5.85)
	let s:fg_2_gui  = s:rgbscale(s:bg_0_gui, 3.40)
	let s:fg_3_gui  = s:rgbscale(s:bg_0_gui, 1.70)
endif
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


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

if exists('g:monoid_nobold') | let s:bold = '' | endif
if exists('g:monoid_noitalic') | let s:italic = '' | endif



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
