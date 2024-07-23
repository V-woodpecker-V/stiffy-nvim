--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

local background = hsl(215, 0, 8)
local foreground = hsl(50, 0, 90)
local primary = hsl(0, 60, 50)
local secondary = hsl(40, 100, 70)
local tertiary = hsl(210, 80, 70)

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `{}` will clear all styling, leaving elements looking
        -- like the 'Normal' group.
        -- To be able to link to a group, it must already be defined, so you may have
        -- to reorder items as you go.
        --
        -- See :h highlight-groups
        --
        ColorTest1 { fg = background, bg = background },
        ColorTest2 { fg = foreground, bg = foreground },
        ColorTest3 { fg = primary, bg = primary },
        ColorTest4 { fg = secondary, bg = secondary },
        ColorTest5 { fg = tertiary, bg = tertiary },

        ColorColumn { fg = background, bg = primary }, -- Columns set with 'colorcolumn'
        -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor { fg = background, bg = foreground },   -- Character under the cursor
        CurSearch { fg = background, bg = primary },   -- Highlighting a search pattern under the cursor (see 'hlsearch')
        lCursor { Cursor },                            -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM { Cursor },                           -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn { bg = background.darken(30) },   -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine { CursorColumn },                   -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        -- Directory      { }, -- Directory names (and other special names in listings)
        -- DiffAdd        { }, -- Diff mode: Added line |diff.txt|
        -- DiffChange     { }, -- Diff mode: Changed line |diff.txt|
        -- DiffDelete     { }, -- Diff mode: Deleted line |diff.txt|
        -- DiffText       { }, -- Diff mode: Changed text within a changed line |diff.txt|
        -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        TermCursor { Cursor },                                                -- Cursor in a focused terminal
        TermCursorNC { Cursor },                                              -- Cursor in an unfocused terminal
        ErrorMsg { gui = "italic;underline", fg = foreground, bg = primary }, -- Error messages on the command line
        VertSplit { ColorColumn },                                            -- Column separating vertically split windows
        -- Folded         { }, -- Line used for closed folds
        -- FoldColumn     { }, -- 'foldcolumn'
        -- SignColumn     { }, -- Column where |signs| are displayed
        IncSearch { CurSearch },                             -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Substitute { IncSearch },                            -- |:substitute| replacement text highlighting
        LineNr { fg = primary },                             -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNrAbove { LineNr, fg = LineNr.fg.darken(30) },                              -- Line number for when the 'relativenumber' option is set, above the cursor line
        LineNrBelow { LineNr, fg = LineNr.fg.darken(30) },                              -- Line number for when the 'relativenumber' option is set, below the cursor line
        CursorLineNr { fg = LineNr.fg, bg = CursorLine.bg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
        -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
        MatchParen { gui = "underline", fg = foreground, bg = primary },                          -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg { gui = "italic", fg = foreground },                                              -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea { ModeMsg },                                                                      -- Area for messages and cmdline
        MsgSeparator { gui = "italic", fg = background, bg = foreground.darken(50) },             -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg { gui = "italic", fg = secondary },                                               -- |more-prompt|
        NonText { gui = "italic", fg = tertiary },                                                -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal { bg = background, fg = foreground },                                              -- Normal text
        NormalFloat { Normal },                                                                   -- Normal text in floating windows.
        FloatBorder { gui = "italic", bg = primary, fg = background },                            -- Border of floating windows.
        FloatTitle { gui = "italic", bg = background, fg = foreground },                          -- Title of floating windows.
        NormalNC { Normal },                                                                      -- normal text in non-current windows
        Pmenu { bg = background.darken(20), fg = foreground },                                    -- Popup menu: Normal item.
        PmenuSel { bg = Pmenu.fg, fg = Pmenu.bg },                                                -- Popup menu: Selected item.
        PmenuKind { Pmenu },                                                                      -- Popup menu: Normal item "kind"
        PmenuKindSel { PmenuSel },                                                                -- Popup menu: Selected item "kind"
        PmenuExtra { Pmenu },                                                                     -- Popup menu: Normal item "extra text"
        PmenuExtraSel { PmenuSel },                                                               -- Popup menu: Selected item "extra text"
        PmenuSbar { bg = background },                                                            -- Popup menu: Scrollbar.
        PmenuThumb { bg = primary },                                                              -- Popup menu: Thumb of the scrollbar.
        Question { gui = "italic", fg = tertiary },                                               -- |hit-enter| prompt and yes/no questions
        QuickFixLine { CurSearch },                                                               -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search { CurSearch },                                                                     -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        SpecialKey { gui = "italic", fg = tertiary },                                           -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad { gui = "italic;underline" },                                                    -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap { SpellBad },                                                                    -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal { SpellBad },                                                                  -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare { SpellBad },                                                                   -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine { gui = "italic", fg = Normal.bg, bg = Normal.fg.darken(50) },                 -- Status line of current window
        StatusLineNC { StatusLine },                                                              -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine { gui = "italic;underline", fg = StatusLine.fg, bg = StatusLine.bg.lighten(10) }, -- Tab pages line, not active tab page label
        TabLineFill { StatusLine },                                                               -- Tab pages line, where there are no labels
        TabLineSel { gui = "italic", fg = StatusLine.bg },                                        -- Tab pages line, active tab page label
        Title { fg = primary },                                                                   -- Titles for output from ":set all", ":autocmd" etc.
        Visual { CurSearch },                                                                     -- Visual mode selection
        VisualNOS { fg = Visual.bg },                                                             -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg { fg = primary },                                                              -- Warning messages
        Whitespace { gui = "italic", fg = tertiary },                                           -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { ColorColumn },                                                             -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        WildMenu { gui = "italic", CurSearch },                                                   -- Current match in 'wildmenu' completion
        -- WinBar         { }, -- Window bar of current window
        -- WinBarNC       { }, -- Window bar of not-current windows

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment { gui = "italic", fg = Normal.bg.lighten(40).desaturate(40) }, -- Any comment

        Constant { fg = secondary.saturate(30).darken(20) },                                             -- (*) Any constant
        String { Constant },                                                   --   A string constant: "this is a string"
        Character { Constant },                                                --   A character constant: 'c', '\n'
        Number { Constant },                                                   --   A number constant: 234, 0xff
        Boolean { Constant },                                                  --   A boolean constant: TRUE, false
        Float { Constant },                                                    --   A floating point constant: 2.3e10

        Identifier { fg = primary },                                                 -- (*) Any variable name
        Function { Identifier },                                               --   Function name (also: methods for classes)

        Statement { fg = secondary.saturate(70) },                                            -- (*) Any statement
        Conditional { Statement },                                             --   if, then, else, endif, switch, etc.
        Repeat { Statement },                                                  --   for, do, while, etc.
        Label { Statement },                                                   --   case, default, etc.
        Operator { Statement },                                                --   "sizeof", "+", "*", etc.
        Keyword { Statement },                                                 --   any other keyword
        Exception { Statement },                                               --   try, catch, throw

        PreProc { fg = tertiary },                                            -- (*) Generic Preprocessor
        Include { PreProc },                                                   --   Preprocessor #include
        Define { PreProc },                                                    --   Preprocessor #define
        Macro { PreProc },                                                     --   Same as Define
        PreCondit { PreProc },                                                 --   Preprocessor #if, #else, #endif, etc.

        Type { fg = tertiary.lighten(20).saturate(50) },                                               -- (*) int, long, char, etc.
        StorageClass { Type },                                                 --   static, register, volatile, etc.
        Structure { Type },                                                    --   struct, union, enum, etc.
        Typedef { Type },                                                      --   A typedef

        Special { fg = tertiary.darken(20).desaturate(10) },                                           -- (*) Any special symbol
        SpecialChar { Special },                                               --   Special character in a constant
        Tag { Special },                                                       --   You can use CTRL-] on this
        Delimiter { Special },                                                 --   Character that needs attention
        SpecialComment { Special },                                            --   Special things inside a comment (e.g. '\n')
        Debug { Special },                                                     --   Debugging statements

        Underlined { gui = "underline" },                                      -- Text that stands out, HTML links
        Ignore { gui = "italic", fg = Comment.fg },                            -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error { fg = Normal.fg, bg = primary },                                -- Any erroneous construct
        Todo { gui = "italic", fg = tertiary },                                -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- LspReferenceText            { } , -- Used for highlighting "text" references
        -- LspReferenceRead            { } , -- Used for highlighting "read" references
        -- LspReferenceWrite           { } , -- Used for highlighting "write" references
        -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
        -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
        -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
        -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
        -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
        -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
        -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
        -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
        -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
        -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
        -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
        -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

        -- Tree-Sitter syntax groups.
        --
        -- See :h treesitter-highlight-groups, some groups may not be listed,
        -- submit a PR fix to lush-template!
        --
        -- Tree-Sitter groups are defined with an "@" symbol, which must be
        -- specially handled to be valid lua code, we do this via the special
        -- sym function. The following are all valid ways to call the sym function,
        -- for more details see https://www.lua.org/pil/5.html
        --
        -- sym("@text.literal")
        -- sym('@text.literal')
        -- sym"@text.literal"
        -- sym'@text.literal'
        --
        -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

        sym "@text.literal" { Comment },          -- Comment
        sym "@text.reference" { Identifier },     -- Identifier
        sym "@text.title" { Title },              -- Title
        sym "@text.uri" { Underlined },           -- Underlined
        sym "@text.underline" { Underlined },     -- Underlined
        sym "@text.todo" { Todo },                -- Todo
        sym "@comment" { Comment },               -- Comment
        sym "@punctuation" { Delimiter },         -- Delimiter
        sym "@constant" { Constant },             -- Constant
        sym "@constant.builtin" { Special },      -- Special
        sym "@constant.macro" { Define },         -- Define
        sym "@define" { Define },                 -- Define
        sym "@macro" { Macro },                   -- Macro
        sym "@string" { String },                 -- String
        sym "@string.escape" { SpecialChar },     -- SpecialChar
        sym "@string.special" { SpecialChar },    -- SpecialChar
        sym "@character" { Character },           -- Character
        sym "@character.special" { SpecialChar }, -- SpecialChar
        sym "@number" { Number },                 -- Number
        sym "@boolean" { Boolean },               -- Boolean
        sym "@float" { Float },                   -- Float
        sym "@function" { Function },             -- Function
        sym "@function.builtin" { Special },      -- Special
        sym "@function.macro" { Macro },          -- Macro
        sym "@parameter" { Identifier },          -- Identifier
        sym "@method" { Function },               -- Function
        sym "@field" { Identifier },              -- Identifier
        sym "@property" { Identifier },           -- Identifier
        sym "@constructor" { Special },           -- Special
        sym "@conditional" { Conditional },       -- Conditional
        sym "@repeat" { Repeat },                 -- Repeat
        sym "@label" { Label },                   -- Label
        sym "@operator" { Operator },             -- Operator
        sym "@keyword" { Keyword },               -- Keyword
        sym "@exception" { Exception },           -- Exception
        sym "@variable" { Identifier },           -- Identifier
        sym "@type" { Type },                     -- Type
        sym "@type.definition" { Typedef },       -- Typedef
        sym "@storageclass" { StorageClass },     -- StorageClass
        sym "@structure" { Structure },           -- Structure
        sym "@namespace" { Identifier },          -- Identifier
        sym "@include" { Include },               -- Include
        sym "@preproc" { PreProc },               -- PreProc
        sym "@debug" { Debug },                   -- Debug
        sym "@tag" { Tag },                       -- Tag
    }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
