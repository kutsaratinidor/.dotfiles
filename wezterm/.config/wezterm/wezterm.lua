local wezterm = require("wezterm")
local config = require("config")
require("events")

-- Map short names to actual theme names
local themes = {
  nord = "Nord (Gogh)",
  onedark = "One Dark (Gogh)",
}

-- Get theme from env
local success, stdout, stderr = wezterm.run_child_process({
  os.getenv("SHELL"), "-c", "printenv WEZTERM_THEME"
})
local selected_theme = stdout:gsub("%s+", "")

-- Apply theme or fallback
config.color_scheme = themes[selected_theme] or "nord"
wezterm.log_info("Using theme: " .. tostring(config.color_scheme))

return config
