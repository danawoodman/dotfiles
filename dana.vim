
" Default GUI Colours
let s:foreground = "c5c8c6"
let s:background = "1d1f21"
let s:white = "ffffff"
let s:selection = "373b41"
let s:line = "282a2e"
let s:comment = "969896"
let s:gray = "7f7f7f"
let s:red = "ef4a3e"
let s:orange = "ef8e45"
let s:yellow = "edd81c"
let s:muted_yellow = "ccbc33"
let s:green = "8dba46"
let s:dark_green = "6b8e48"
let s:aqua = "5dd7dd"
let s:cyan = "38d8a8"
let s:blue = "61afd3"
let s:purple = "b294bb"
let s:magenta = "f230a7"
let s:window = "4d5057"

" Console 256 Colours
if !has("gui_running")
  let s:background = "303030"
  let s:window = "5e5e5e"
  let s:line = "3a3a3a"
  let s:selection = "585858"
end

hi clear
syntax reset

let g:colors_name = "dana"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  " Returns an approximate grey index for the given grey level
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " Returns the palette index for the given grey index
  fun <SID>grey_colour(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " Returns an approximate colour index for the given colour level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual colour level for the given colour index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " Returns the palette index for the given R/G/B colour indices
  fun <SID>rgb_colour(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " Returns the palette index to approximate the given R/G/B colour levels
  fun <SID>colour(r, g, b)
    " Get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " Get the closest colour
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " There are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " Use the grey
        return <SID>grey_colour(l:gx)
      else
        " Use the colour
        return <SID>rgb_colour(l:x, l:y, l:z)
      endif
    else
      " Only one possibility
      return <SID>rgb_colour(l:x, l:y, l:z)
    endif
  endfun

  " Returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return <SID>colour(l:r, l:g, l:b)
  endfun

  " Sets the highlighting for the given group
  fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
      exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
    if a:bg != ""
      exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
  endfun

  " Vim Highlighting
  call <SID>X("Normal", s:foreground, s:background, "")
  call <SID>X("LineNr", s:selection, "", "")
  call <SID>X("NonText", s:selection, "", "")
  call <SID>X("SpecialKey", s:selection, "", "")
  call <SID>X("Search", s:background, s:yellow, "")
  call <SID>X("TabLine", s:window, s:foreground, "reverse")
  call <SID>X("TabLineFill", s:window, s:foreground, "reverse")
  call <SID>X("StatusLine", s:window, s:yellow, "reverse")
  call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
  call <SID>X("VertSplit", s:window, s:window, "none")
  call <SID>X("Visual", "", s:selection, "")
  call <SID>X("Directory", s:blue, "", "")
  call <SID>X("ModeMsg", s:green, "", "")
  call <SID>X("MoreMsg", s:green, "", "")
  call <SID>X("Question", s:green, "", "")
  call <SID>X("WarningMsg", s:white, s:red, "")
  call <SID>X("MatchParen", "", s:selection, "")
  call <SID>X("Folded", s:comment, s:background, "")
  call <SID>X("FoldColumn", "", s:background, "")
  if version >= 700
    call <SID>X("CursorLine", "", s:line, "none")
    call <SID>X("CursorColumn", "", s:line, "none")
    call <SID>X("PMenu", s:foreground, s:selection, "none")
    call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
    call <SID>X("SignColumn", "", s:background, "none")
  end
  if version >= 703
    call <SID>X("ColorColumn", "", s:line, "none")
  end

  " Standard Highlighting
  call <SID>X("Comment", s:comment, "", "")
  call <SID>X("Todo", s:comment, s:background, "")
  call <SID>X("Title", s:comment, "", "")
  call <SID>X("Identifier", s:red, "", "none")
  call <SID>X("Statement", s:blue, "", "")
  call <SID>X("Repeat", s:foreground, "", "")
  call <SID>X("Structure", s:purple, "", "")
  call <SID>X("Function", s:red, "", "bold")
  call <SID>X("Constant", s:aqua, "", "")
  call <SID>X("Keyword", s:aqua, "", "")
  call <SID>X("Conditional", s:yellow, "", "")
  call <SID>X("String", s:green, "", "")
  call <SID>X("Boolean", s:magenta, "", "")
  call <SID>X("Number", s:magenta, "", "")
  call <SID>X("Special", s:yellow, "", "bold")
  call <SID>X("PreProc", s:purple, "", "")
  call <SID>X("Operator", s:cyan, "", "none")
  call <SID>X("Delimiter", s:yellow, "", "none")
  call <SID>X("Type", s:purple, "", "none")
  call <SID>X("Define", s:purple, "", "none")
  call <SID>X("Include", s:blue, "", "")
  "call <SID>X("Ignore", "666666", "", "")

  " JavaScript Highlighting
  call <SID>X("jsIfElseBraces", s:gray, "", "")
  call <SID>X("jsFuncBraces", s:gray, "", "")
  call <SID>X("jsParens", s:gray, "", "")
  call <SID>X("jsParen", s:blue, "", "")
  call <SID>X("jsParensIfElse", s:gray, "", "")
  call <SID>X("jsFuncParens", s:gray, "", "")
  call <SID>X("jsVariableDef", s:orange, "", "")
  call <SID>X("jsTemplateBraces", s:gray, "", "")
  call <SID>X("jsObjectBraces", s:gray, "", "")
  "call <SID>X("jsTemplateExpression", s:yellow, "", "")
  call <SID>X("jsFuncCall", s:muted_yellow, "", "")
  call <SID>X("jsObjectFuncName", s:yellow, "", "")
  call <SID>X("jsObjectProp", s:blue, "", "")
  call <SID>X("jsFuncName", s:red, "", "bold,underline")
  "call <SID>X("jsFuncArgs", s:aqua, "", "")
  call <SID>X("jsGlobalObjects", s:orange, "", "")
  call <SID>X("jsStorageClass", s:purple, "", "")
  call <SID>X("jsFunction", s:orange, "", "")
  call <SID>X("jsTaggedTemplate", s:green, "", "")
  call <SID>X("jsTemplateString", s:green, "", "")
  call <SID>X("jsReturn", s:magenta, "", "underline,bold")
  "call <SID>X("javaScriptBraces", s:foreground, "", "")
  "call <SID>X("javaScriptFunction", s:purple, "", "")
  "call <SID>X("javaScriptConditional", s:purple, "", "")
  "call <SID>X("javaScriptRepeat", s:purple, "", "")
  "call <SID>X("javaScriptNumber", s:orange, "", "")
  "call <SID>X("javaScriptMember", s:orange, "", "")
  "call <SID>X("javascriptNull", s:orange, "", "")
  "call <SID>X("javascriptGlobal", s:blue, "", "")
  "call <SID>X("javascriptStatement", s:red, "", "")

  " XML/JSX/HTML
  call <SID>X("xmlTag", s:yellow, "", "")
  call <SID>X("xmlEndTag", s:yellow, "", "")
  call <SID>X("xmlTagName", s:yellow, "", "")
  call <SID>X("htmlTag", s:gray, "", "")
  call <SID>X("htmlEndTag", s:gray, "", "")
  call <SID>X("htmlTagName", s:yellow, "", "")
  call <SID>X("htmlArg", s:blue, "", "")
  call <SID>X("htmlScriptTag", s:red, "", "")

  " CSS/Sass
  call <SID>X("cssColor", s:orange, "", "")
  call <SID>X("cssAuralAttr", s:magenta, "", "")
  call <SID>X("cssUnitDecorators", s:purple, "", "")
  call <SID>X("sassVariableAssignment", s:gray, "", "")
  call <SID>X("sassVariable", s:yellow, "", "")

  " Vim Highlighting
  call <SID>X("vimCommand", s:red, "", "none")

  " Vim Highlighting
  call <SID>X("markdownHeadingDelimiter", s:gray, "", "")
  call <SID>X("markdownH1", s:red, "", "bold")
  call <SID>X("markdownH2", s:red, "", "bold")
  call <SID>X("markdownH3", s:red, "", "bold")
  call <SID>X("markdownItalic", s:orange, "", "italic")
  call <SID>X("markdownBold", s:green, "", "bold")
  call <SID>X("markdownCode", s:yellow, "", "")
  call <SID>X("markdownCodeDelimiter", s:gray, "", "")
  call <SID>X("markdownUrl", s:blue, "", "underline")
  call <SID>X("markdownLinkTextDelimiter", s:gray, "", "")
  call <SID>X("markdownLinkDelimiter", s:gray, "", "")
  call <SID>X("githubFlavoredMarkdownCode", s:yellow, "", "")

  " C Highlighting
  "call <SID>X("cType", s:yellow, "", "")
  "call <SID>X("cStorageClass", s:purple, "", "")
  "call <SID>X("cConditional", s:purple, "", "")
  "call <SID>X("cRepeat", s:purple, "", "")

  " PHP Highlighting
  "call <SID>X("phpVarSelector", s:red, "", "")
  "call <SID>X("phpKeyword", s:purple, "", "")
  "call <SID>X("phpRepeat", s:purple, "", "")
  "call <SID>X("phpConditional", s:purple, "", "")
  "call <SID>X("phpStatement", s:purple, "", "")
  "call <SID>X("phpMemberSelector", s:foreground, "", "")

  " Ruby Highlighting
  call <SID>X("rubySymbol", s:green, "", "")
  call <SID>X("rubyConstant", s:yellow, "", "")
  call <SID>X("rubyAccess", s:yellow, "", "")
  call <SID>X("rubyAttribute", s:blue, "", "")
  call <SID>X("rubyInclude", s:blue, "", "")
  call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
  call <SID>X("rubyCurlyBlock", s:orange, "", "")
  call <SID>X("rubyStringDelimiter", s:green, "", "")
  call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
  call <SID>X("rubyConditional", s:purple, "", "")
  call <SID>X("rubyRepeat", s:purple, "", "")
  call <SID>X("rubyControl", s:purple, "", "")
  call <SID>X("rubyException", s:purple, "", "")

  " Crystal Highlighting
  "call <SID>X("crystalSymbol", s:green, "", "")
  "call <SID>X("crystalConstant", s:yellow, "", "")
  "call <SID>X("crystalAccess", s:yellow, "", "")
  "call <SID>X("crystalAttribute", s:blue, "", "")
  "call <SID>X("crystalInclude", s:blue, "", "")
  "call <SID>X("crystalLocalVariableOrMethod", s:orange, "", "")
  "call <SID>X("crystalCurlyBlock", s:orange, "", "")
  "call <SID>X("crystalStringDelimiter", s:green, "", "")
  "call <SID>X("crystalInterpolationDelimiter", s:orange, "", "")
  "call <SID>X("crystalConditional", s:purple, "", "")
  "call <SID>X("crystalRepeat", s:purple, "", "")
  "call <SID>X("crystalControl", s:purple, "", "")
  "call <SID>X("crystalException", s:purple, "", "")

  " Python Highlighting
  call <SID>X("pythonInclude", s:purple, "", "")
  call <SID>X("pythonStatement", s:purple, "", "")
  call <SID>X("pythonConditional", s:purple, "", "")
  call <SID>X("pythonRepeat", s:purple, "", "")
  call <SID>X("pythonException", s:purple, "", "")
  call <SID>X("pythonFunction", s:blue, "", "")
  call <SID>X("pythonPreCondit", s:purple, "", "")
  call <SID>X("pythonRepeat", s:aqua, "", "")
  call <SID>X("pythonExClass", s:orange, "", "")

  " CoffeeScript Highlighting
  "call <SID>X("coffeeRepeat", s:purple, "", "")
  "call <SID>X("coffeeConditional", s:purple, "", "")
  "call <SID>X("coffeeKeyword", s:purple, "", "")
  "call <SID>X("coffeeObject", s:yellow, "", "")

  " Diff Highlighting
  call <SID>X("diffAdd", s:white, s:dark_green, "")
  call <SID>X("diffDelete", s:white, s:red, "")
  call <SID>X("diffChange", s:white, "2B5B77", "")
  call <SID>X("diffText", s:line, s:blue, "")

  " vim-indent-guides
  call <SID>X("IndentGuidesOdd", "", s:blue, "")
  call <SID>X("IndentGuidesEven", "", s:blue, "")

  " ShowMarks Highlighting
  "call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
  "call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
  "call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
  "call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

  " Lua Highlighting
  "call <SID>X("luaStatement", s:purple, "", "")
  "call <SID>X("luaRepeat", s:purple, "", "")
  "call <SID>X("luaCondStart", s:purple, "", "")
  "call <SID>X("luaCondElseif", s:purple, "", "")
  "call <SID>X("luaCond", s:purple, "", "")
  "call <SID>X("luaCondEnd", s:purple, "", "")

  " Cucumber Highlighting
  "call <SID>X("cucumberGiven", s:blue, "", "")
  "call <SID>X("cucumberGivenAnd", s:blue, "", "")

  " Go Highlighting
  call <SID>X("goDirective", s:purple, "", "")
  call <SID>X("goDeclaration", s:purple, "", "")
  call <SID>X("goStatement", s:purple, "", "")
  call <SID>X("goConditional", s:purple, "", "")
  call <SID>X("goConstants", s:orange, "", "")
  call <SID>X("goTodo", s:yellow, "", "")
  call <SID>X("goDeclType", s:blue, "", "")
  call <SID>X("goBuiltins", s:purple, "", "")
  call <SID>X("goRepeat", s:purple, "", "")
  call <SID>X("goLabel", s:purple, "", "")

  " Clojure Highlighting
  "call <SID>X("clojureConstant", s:orange, "", "")
  "call <SID>X("clojureBoolean", s:orange, "", "")
  "call <SID>X("clojureCharacter", s:orange, "", "")
  "call <SID>X("clojureKeyword", s:green, "", "")
  "call <SID>X("clojureNumber", s:orange, "", "")
  "call <SID>X("clojureString", s:green, "", "")
  "call <SID>X("clojureRegexp", s:green, "", "")
  "call <SID>X("clojureParen", s:aqua, "", "")
  "call <SID>X("clojureVariable", s:yellow, "", "")
  "call <SID>X("clojureCond", s:blue, "", "")
  "call <SID>X("clojureDefine", s:purple, "", "")
  "call <SID>X("clojureException", s:red, "", "")
  "call <SID>X("clojureFunc", s:blue, "", "")
  "call <SID>X("clojureMacro", s:blue, "", "")
  "call <SID>X("clojureRepeat", s:blue, "", "")
  "call <SID>X("clojureSpecial", s:purple, "", "")
  "call <SID>X("clojureQuote", s:blue, "", "")
  "call <SID>X("clojureUnquote", s:blue, "", "")
  "call <SID>X("clojureMeta", s:blue, "", "")
  "call <SID>X("clojureDeref", s:blue, "", "")
  "call <SID>X("clojureAnonArg", s:blue, "", "")
  "call <SID>X("clojureRepeat", s:blue, "", "")
  "call <SID>X("clojureDispatch", s:blue, "", "")

  " Scala Highlighting
  "call <SID>X("scalaKeyword", s:purple, "", "")
  "call <SID>X("scalaKeywordModifier", s:purple, "", "")
  "call <SID>X("scalaOperator", s:blue, "", "")
  "call <SID>X("scalaPackage", s:red, "", "")
  "call <SID>X("scalaFqn", s:foreground, "", "")
  "call <SID>X("scalaFqnSet", s:foreground, "", "")
  "call <SID>X("scalaImport", s:purple, "", "")
  "call <SID>X("scalaBoolean", s:orange, "", "")
  "call <SID>X("scalaDef", s:purple, "", "")
  "call <SID>X("scalaVal", s:purple, "", "")
  "call <SID>X("scalaVar", s:aqua, "", "")
  "call <SID>X("scalaClass", s:purple, "", "")
  "call <SID>X("scalaObject", s:purple, "", "")
  "call <SID>X("scalaTrait", s:purple, "", "")
  "call <SID>X("scalaDefName", s:blue, "", "")
  "call <SID>X("scalaValName", s:foreground, "", "")
  "call <SID>X("scalaVarName", s:foreground, "", "")
  "call <SID>X("scalaClassName", s:foreground, "", "")
  "call <SID>X("scalaType", s:yellow, "", "")
  "call <SID>X("scalaTypeSpecializer", s:yellow, "", "")
  "call <SID>X("scalaAnnotation", s:orange, "", "")
  "call <SID>X("scalaNumber", s:orange, "", "")
  "call <SID>X("scalaDefSpecializer", s:yellow, "", "")
  "call <SID>X("scalaClassSpecializer", s:yellow, "", "")
  "call <SID>X("scalaBackTick", s:green, "", "")
  "call <SID>X("scalaRoot", s:foreground, "", "")
  "call <SID>X("scalaMethodCall", s:blue, "", "")
  "call <SID>X("scalaCaseType", s:yellow, "", "")
  "call <SID>X("scalaLineComment", s:comment, "", "")
  "call <SID>X("scalaComment", s:comment, "", "")
  "call <SID>X("scalaDocComment", s:comment, "", "")
  "call <SID>X("scalaDocTags", s:comment, "", "")
  "call <SID>X("scalaEmptyString", s:green, "", "")
  "call <SID>X("scalaMultiLineString", s:green, "", "")
  "call <SID>X("scalaUnicode", s:orange, "", "")
  "call <SID>X("scalaString", s:green, "", "")
  "call <SID>X("scalaStringEscape", s:green, "", "")
  "call <SID>X("scalaSymbol", s:orange, "", "")
  "call <SID>X("scalaChar", s:orange, "", "")
  "call <SID>X("scalaXml", s:green, "", "")
  "call <SID>X("scalaConstructorSpecializer", s:yellow, "", "")
  "call <SID>X("scalaBackTick", s:blue, "", "")

  " Git
  call <SID>X("diffAdded", s:green, "", "")
  call <SID>X("diffRemoved", s:red, "", "")
  call <SID>X("gitcommitSummary", "", "", "bold")

  " Delete Functions
  delf <SID>X
  delf <SID>rgb
  delf <SID>colour
  delf <SID>rgb_colour
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_colour
  delf <SID>grey_level
  delf <SID>grey_number
endif

set background=dark
