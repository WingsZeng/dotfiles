require("configs.env")
require("configs.monitors")
require("configs.execs")
require("configs.keybinds")
require("configs.animations")
require("configs.windowrules")
require("configs.layers")

hl.config({
    input = {
        repeat_rate = 50,
        repeat_delay = 300,
        sensitivity = -0.2,
        follow_mouse = 2,
        float_switch_override_focus = 0,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },

    general = {
        gaps_in = 8,
        gaps_out = 16,
        border_size = 0,
        col = { inactive_border = "0x00000000" },
        layout = "mosaic",
    },

    decoration = {
        rounding = 16,
        active_opacity = 0.95,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1,
        dim_special = 0.4,
        shadow = {
            enabled = true,
            range = 50,
            render_power = 3,
            color = "0xff000000",
            color_inactive = "0x80000000",
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            brightness = 1,
            contrast = 1,
            popups = true,
            input_methods = true,
        },
    },

    cursor = {
        hide_on_touch = true,
        hide_on_key_press = true,
        no_hardware_cursors = 1,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = "0xff222222",
        exit_window_retains_fullscreen = 1,
        disable_hyprland_guiutils_check = true,
        enable_anr_dialog = false,
    },

    layers = { layers_hog_keyboard_focus = true },

    binds = { movefocus_cycles_fullscreen = true },

    xwayland = { force_zero_scaling = true },

    debug = {
        disable_logs = false,
        enable_stdout_logs = true,
        suppress_errors = true,
    },

})

if hl.plugin.virtual_desktops ~= nil then
    hl.config({
        plugin = {
            ["virtual_desktops"] = { notifyinit = 0 },
        },
    })
end
