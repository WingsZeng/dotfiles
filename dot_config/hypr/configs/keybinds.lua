-- Applications
hl.bind("SUPER + return", hl.dsp.exec_cmd("footclient zellij"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + P", hl.dsp.exec_cmd([[action=$(echo -e "lock-session\npoweroff\nreboot\nlogout" | fuzzel --dmenu); [ -n "$action" ] && ([ $action = "logout" ] && hyprshutdown || loginctl $action)]]))
hl.bind("SUPER + M", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/monitor.sh"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/service.sh"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/toggle-touchpad.sh"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("fnottctl dismiss all"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/sing-box.sh"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("killall yambar || yambar"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/wingshot.sh --window-under-cursor -c directory $XDG_SCREENSHOTS_DIR"))
hl.bind("Print", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/wingshot.sh -c directory $XDG_SCREENSHOTS_DIR"))

-- Windows and workspaces
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind("SUPER + space", function()
    hl.dispatch(hl.dsp.window.float())
    hl.dispatch(hl.dsp.window.resize({ x = 1280, y = 800 }))
    hl.dispatch(hl.dsp.window.center())
end)

local function virtual_desktop(action, desk)
    return function()
        local plugin = hl.plugin.virtual_desktops
        if plugin ~= nil then
            plugin[action](desk)
        end
    end
end

hl.bind("SUPER + ALT + 1", virtual_desktop("movetodesksilent", "1"))
hl.bind("SUPER + ALT + 2", virtual_desktop("movetodesksilent", "2"))
hl.bind("SUPER + ALT + 3", virtual_desktop("movetodesksilent", "3"))
hl.bind("SUPER + ALT + 4", virtual_desktop("movetodesksilent", "4"))
hl.bind("SUPER + ALT + grave", hl.dsp.window.move({ workspace = "special", follow = false }))

hl.bind("SUPER + 1", virtual_desktop("vdesk", "1"))
hl.bind("SUPER + 2", virtual_desktop("vdesk", "2"))
hl.bind("SUPER + 3", virtual_desktop("vdesk", "3"))
hl.bind("SUPER + 4", virtual_desktop("vdesk", "4"))
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special(""))

hl.bind("SUPER + C", hl.dsp.layout("togglefocus"))

-- Hardware controls
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/brightnessctl.sh -"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/brightnessctl.sh +"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/wpctl.sh -"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$XDG_CONFIG_HOME/hypr/scripts/wpctl.sh +"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"))
