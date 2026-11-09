-- file: 3136
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

function log(...) -- proto#5 params=0 locals=0 upvalues=0 vararg=true source=3136 lines=1-4
    if DEBUG_MODE then
        print(...)
    end
end

function love.filesystem.loadLuaJITBytecode(filePath) -- proto#4 params=1 locals=5 upvalues=0 vararg=false source=3136 lines=7-8
    loadstring(love.filesystem.read("src/" .. filePath .. ".ljb"))()
end

function love.window.setScreenSizeVariables() -- proto#3 params=0 locals=1 upvalues=0 vararg=false source=3136 lines=11-16
    scrH = love.graphics.getHeight()
    scrW = love.graphics.getWidth()
    local r3_0 = scrH
    r3_0 = r3_0 * 0.5
    halfScrH = r3_0
    r3_0 = scrW
    r3_0 = r3_0 * 0.5
    halfScrW = r3_0
end

love.window.setScreenSizeVariables()

function vunpack(t, i) -- proto#2 params=2 locals=0 upvalues=0 vararg=false source=3136 lines=22-27
    i = i or 1
    if t[i] == nil then
        return
    end
    return t[i], unpack(t, i + 1)
end

function getFrameTime() -- proto#1 params=0 locals=0 upvalues=0 vararg=false source=3136 lines=30-31
    return frameTime
end

audio = {}
game = {}
curTime = 0
local dir = love.filesystem.getSourceBaseDirectory()
local success = love.filesystem.mount(dir, BASE_GAME_FOLDER)
require("engine/extralove")
require("engine/extraphysics")
require("engine/extramath")
require("engine/extratable")
require("engine/extrastring")
require("engine/extrafilesystem")
require("engine/extragraphics")
require("engine/classify")
require("engine/fonts")
require("engine/translation")
require("engine/sprite_data")
require("engine/color")
require("engine/vector")
require("engine/timers")
require("engine/scaling")
require("engine/stream")
require("engine/config_loader")
require("engine/tilegrid")
require("engine/objectgrid")
require("engine/tilegrid_visibility_handler")
require("engine/json")
require("engine/bitser")
require("engine/byteops")
require("engine/ffisounddata")
require("engine/registry")
require("engine/events")
require("engine/spritebatchcontroller")
require("engine/npcstates")
require("engine/util")
require("engine/cullingtester")
require("engine/screenshot_encoder_initializer")
require("engine/filecache")
require("engine/quad_loader")
require("engine/text_mixins")
require("engine/particle_system_registration")
require("engine/shaders")
require("engine/soundchannel")
require("engine/hooks")
require("engine/coroutinemanager")
require("engine/atlas")
require("engine/garbagecompare")
require("engine/noise_templates")
require("engine/inventory_slot")
require("engine/collision")
require("engine/camera")
require("engine/input_service")
require("engine/anim")
require("engine/splash")
require("engine/gui")
require("engine/parallax")
require("engine/dynmusic")
require("engine/pathfinding")
require("engine/middleofimage")
require("engine/npc_state_machines")
require("engine/profiler")
require("engine/spritesheet_parser")
require("engine/framebuffer")
require("engine/priority_renderer")
require("engine/post_init")
require("engine/key_binding")
require("engine/joystick_handler")
require("engine/mouse_vis_handler")
require("engine/layer_renderer")
require("engine/game_state_service")
require("engine/particle_effects")
require("engine/mic_input")
class = require("engine/middleclass/middleclass")
require("engine/quadtree")
tdas.tool = require("engine/animtool")
micInput:updateDeviceList()
