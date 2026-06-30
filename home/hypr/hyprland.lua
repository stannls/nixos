-- Hyprland Lua config
-- Converted from hyprland.conf for Hyprland 0.55+

local mainMod = "SUPER"

-----------------------
---- AUTOSTART ----
-----------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("~/.config/hypr/background.sh")
  hl.exec_cmd("waybar")
  hl.exec_cmd("alacritty")
  hl.exec_cmd("dunst")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("flameshot")
end)

-----------------------
---- MONITORS ----
-----------------------
hl.monitor({ output = "HDMI-A-1", mode = "1680x1050", position = "0x0", scale = "1" })
hl.monitor({ output = "DVI-D-1", mode = "1920x1080", position = "1680x0", scale = "1" })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-----------------------
---- INPUT ----
-----------------------
hl.config({
  input = {
    kb_layout = "us,de",
    kb_options = "grp:alt_space_toggle",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
    },
  },
})

-----------------------
---- GENERAL ----
-----------------------
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 5,
    border_size = 2,
    col = {
      inactive_border = { colors = { "rgba(f7768eff)", "rgba(73dacaff)" }, angle = 45 },
      active_border = { colors = { "rgba(73dacaff)", "rgba(f7768eff)" }, angle = 45 },
    },
    no_border_on_floating = false,
    layout = "dwindle",
  },
})

-----------------------
---- MISC ----
-----------------------
hl.config({
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    mouse_move_enables_dpms = true,
    enable_swallow = true,
    swallow_regex = "^(kitty)$",
  },
})

hl.env("HYPRCURSOR_THEME", "Dracula-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- DECORATION ----
-----------------------
hl.config({
  decoration = {
    rounding = 18,
    active_opacity = 1.0,
    inactive_opacity = 0.95,
    blur = {
      enabled = true,
      size = 2,
      passes = 2,
    },
    blurls = { "gtk-layer-shell", "lockscreen" },
  },
})

-----------------------
---- ANIMATIONS ----
-----------------------
hl.curve("overshot",   { type = "bezier", points = { { 0.05, 0.5 }, { 0.1, 1.05 } } })
hl.curve("smoothOut",  { type = "bezier", points = { { 0.36, 0 },   { 0.66, -0.56 } } })
hl.curve("smoothIn",   { type = "bezier", points = { { 0.25, 0.8 }, { 0.5, 1 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 5,   bezier = "overshot",   style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4,   bezier = "smoothOut",  style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4,   bezier = "default" })
hl.animation({ leaf = "border",      enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10,  bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 10,  bezier = "smoothIn" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,   bezier = "default" })

-----------------------
---- LAYOUTS ----
-----------------------
hl.config({
  dwindle = {
    pseudotile = true,
    preserve_split = true,
  },
  group = {
    groupbar = { enabled = false },
  },
})

-----------------------
---- WINDOW RULES ----
-----------------------
hl.window_rule({ name = "float-file-progress",    match = { class = "file_progress" },     float = true })
hl.window_rule({ name = "float-confirm",          match = { class = "confirm" },            float = true })
hl.window_rule({ name = "float-dialog",           match = { class = "dialog" },             float = true })
hl.window_rule({ name = "float-download",         match = { class = "download" },           float = true })
hl.window_rule({ name = "float-notification",     match = { class = "notification" },       float = true })
hl.window_rule({ name = "float-error",            match = { class = "error" },              float = true })
hl.window_rule({ name = "float-splash",           match = { class = "splash" },             float = true })
hl.window_rule({ name = "float-confirmreset",     match = { class = "confirmreset" },       float = true })
hl.window_rule({ name = "float-open-file",        match = { title = "Open File" },          float = true })
hl.window_rule({ name = "float-branchdialog",     match = { title = "branchdialog" },       float = true })
hl.window_rule({ name = "float-lxappearance",     match = { title = "Lxappearance" },       float = true })
hl.window_rule({ name = "float-wofi",             match = { title = "wofi" },               float = true })
hl.window_rule({ name = "float-viewnior",         match = { title = "viewnior" },           float = true })
hl.window_rule({ name = "float-feh",              match = { title = "feh" },                float = true })
hl.window_rule({ name = "float-yubioath",         match = { title = "yubioath-flutter" },   float = true })
hl.window_rule({ name = "float-anki",             match = { title = "anki" },               float = true })
hl.window_rule({ name = "float-pavucontrol-qt",   match = { title = "pavucontrol-qt" },     float = true })
hl.window_rule({ name = "float-pavucontrol",      match = { title = "pavucontrol" },        float = true })

hl.window_rule({ name = "wlogout",                match = { title = "wlogout" },            fullscreen = true })
hl.window_rule({ name = "wlogout-float",          match = { title = "wlogout" },            float = true })

hl.window_rule({ name = "idleinhibit-mpv",        match = { title = "mpv" },                idleinhibit = "focus" })
hl.window_rule({ name = "idleinhibit-firefox",    match = { title = "firefox" },            idleinhibit = "fullscreen" })

hl.window_rule({ name = "float-media-viewer",     match = { title = "^Media viewer$" },     float = true })
hl.window_rule({ name = "float-volume-control",   match = { title = "^Volume Control$" },   float = true })
hl.window_rule({ name = "size-volume-control",    match = { title = "^Volume Control$" },   size = "800 600" })
hl.window_rule({ name = "move-volume-control",    match = { title = "^Volume Control$" },   move = "39% 420" })

hl.window_rule({ name = "workspace-1-kitty",      match = { class = "^(kitty)$" },          workspace = "1" })
hl.window_rule({ name = "workspace-2-firefox",    match = { class = "^(firefox)$" },        workspace = "2" })
hl.window_rule({ name = "workspace-3-discord",    match = { class = "^(discord)$" },        workspace = "3" })
hl.window_rule({ name = "workspace-3-slack",      match = { class = "^(Slack)$" },          workspace = "3" })
hl.window_rule({ name = "workspace-4-dbeaver",    match = { class = "^(DBeaver)$" },        workspace = "4" })
hl.window_rule({ name = "workspace-5-docker",     match = { class = "^Docker Desktop$" },   workspace = "5" })
hl.window_rule({ name = "workspace-special-thunar",       match = { class = "^(thunar)$" },           workspace = "special" })
hl.window_rule({ name = "workspace-special-youtube-music", match = { class = "^(YouTube Music)$" },   workspace = "special" })

hl.window_rule({ name = "opacity-discord",        match = { class = "^(discord)$" },        opacity = 0.9 })

-----------------------
---- KEYBINDS ----
-----------------------
-- Application launchers
hl.bind(mainMod .. " + O",     hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("wlogout"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),  { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),  { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"),                        { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"),                        { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),                              { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),                          { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"),                     { repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set +10%"),                      { repeating = true })

-- Screenshots
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("slurp | grim -g - ~/Pictures/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'"))
hl.bind("Print",                    hl.dsp.exec_cmd("grimblast --notify --cursor copysave output"))
hl.bind("ALT + Print",              hl.dsp.exec_cmd("grimblast --notify --cursor copysave screen"))

-- Utilities
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprpicker -a -n"))
hl.bind("CTRL + ALT + L",          hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/rofi-pass/rofi-pass"))
hl.bind(mainMod .. " + F1",        hl.dsp.exec_cmd("systemctl suspend | swaylock"))
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd("discord"))

-- Window management
hl.bind(mainMod .. " + Q",          hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q",  hl.dsp.exit())
hl.bind(mainMod .. " + M",          hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",          hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S",          hl.dsp.layout("togglesplit"))

-- Focus movement
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Resize windows (TODO: verify resize API)
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ direction = "left", amount = 20 }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ direction = "right", amount = 20 }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ direction = "up", amount = 20 }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ direction = "down", amount = 20 }))

-- Groups
hl.bind(mainMod .. " + g",          hl.dispatch("togglegroup"))
hl.bind(mainMod .. " + SHIFT + g",  hl.dispatch("lockactivegroup toggle"))
hl.bind(mainMod .. " + Tab",        hl.dispatch("changegroupactive f"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dispatch("changegroupactive b"))

-- Workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + ALT + up",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.focus({ workspace = "e-1" }))

-- Move to workspace
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
