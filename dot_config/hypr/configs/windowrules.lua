hl.window_rule({
    match = { title = "rbw" },
    float = true,
    size = { 1000, 300 },
    center = true,
})

hl.window_rule({
    match = { class = "imv" },
    float = true,
    center = true,
    opacity = "1 override",
})

hl.window_rule({ match = { initial_title = "filechooser" }, float = true, center = true })
hl.window_rule({ match = { title = "filechooser" }, size = { 1920, 1080 } })

hl.window_rule({ match = { title = "Minecraft" }, opacity = "1 override" })
hl.window_rule({ match = { pin = true }, opacity = "1 0.3" })
hl.window_rule({ match = { class = "mpv" }, opacity = "1 override" })
