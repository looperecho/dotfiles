-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Define the config
local config = wezterm.config_builder()

-- Adjust the Lua module search path
package.path = wezterm.config_dir .. '/?.lua;' .. package.path

-- Load configuration from separate files
require 'config.colors'(config)
require 'config.font'(config)
require 'config.keys'(config)
require 'config.window'(config)

-- Disable wayland
config.enable_wayland = false

-- Return the configuration
return config
