local wezterm = require 'wezterm';

return {
  keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = "LeftArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
    -- IncreaseFontSize
    { key = "=", mods = "CTRL", action = "IncreaseFontSize" },
    -- Split the current terminal into two horizontally-split terminals
    { key = "d", mods = "CMD", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    -- Split the current terminal into two vertically-split terminals
    { key = "d", mods = "CMD|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    -- search for things that look like git hashes
    { key = "H", mods = "SHIFT|CTRL", action = wezterm.action { Search = { Regex = "[a-f0-9]{6,}" } } },
    -- search for the lowercase string "hash" matching the case exactly
    { key = "H", mods = "SHIFT|CTRL", action = wezterm.action { Search = { CaseSensitiveString = "hash" } } },
    -- search for the string "hash" matching regardless of case
    { key = "H", mods = "SHIFT|CTRL", action = wezterm.action { Search = { CaseInSensitiveString = "hash" } } },
  }
}
