local colorscheme = require("lua.stiffy.themes.stiff.lua.lush_theme.stiff")

run(colorscheme,
    function(groups)
        local f = io.open("debug.txt", "w")
        if f ~= nil then
            f:write(vim.inspect(groups))
        end
        return {
            fg = groups.Normal.fg,
            bg = groups.Normal.bg,
            cursor_fg = groups.Cursor.fg,
            cursor_bg = groups.Cursor.bg,
            cursor_border = groups.Cursor.bg,
            selection_fg = groups.Visual.fg,
            selection_bg = groups.Visual.bg,
            black = groups.ColorBlack.bg,
            red = groups.ColorRed.bg,
            green = groups.ColorGreen.bg,
            yellow = groups.ColorYellow.bg,
            blue = groups.ColorBlue.bg,
            magenta = groups.ColorMagenta.bg,
            cyan = groups.ColorCyan.bg,
            white = groups.ColorWhite.bg,
            bright_black = groups.ColorBrightBlack.bg,
            bright_red = groups.ColorBrightRed.bg,
            bright_green = groups.ColorBrightGreen.bg,
            bright_yellow = groups.ColorBrightYellow.bg,
            bright_blue = groups.ColorBrightBlue.bg,
            bright_magenta = groups.ColorBrightMagenta.bg,
            bright_cyan = groups.ColorBrightCyan.bg,
            bright_white = groups.ColorBrightWhite.bg,
        }
    end,
    contrib.wezterm,
    { overwrite, os.getenv("HOME") or os.getenv("USERPROFILE").. "/.config/wezterm/colors/stiff.toml" }
)
