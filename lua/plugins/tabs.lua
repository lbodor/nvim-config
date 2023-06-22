return {
    {
        "nanozuki/tabby.nvim",
        event = { "TabEnter" },
        config = function()
            local theme = {
                current_tab = "TabLineSel",
                tab = "TabLine",
                fill = "TabLineFill",
            }
            require("tabby.tabline").set(function(line)
                local intersperse = function(x, wins)
                    local str = ""
                    for i, w in ipairs(wins) do
                        str = str .. w.buf_name()
                        if i < #wins then
                            str = str .. x
                        end
                    end
                    return str
                end
                return {
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current_tab or theme.tab
                        return {
                            line.sep("", hl, theme.fill),
                            tab.number() .. ": " .. intersperse(" | ", line.wins_in_tab(tab.id).wins),
                            line.sep("", hl, theme.fill),
                            hl = hl,
                            margin = " ",
                        }
                    end),
                }
            end)
        end,
    },
}
