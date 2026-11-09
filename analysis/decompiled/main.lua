-- file: 26130
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local _print = print
love.filesystem.newFile("debuglog")
love.filesystem.write("debuglog", "")

function print(...) -- proto#40 params=0 locals=0 upvalues=1 vararg=true source=26130 lines=19-30
    if DEBUG_MODE then
        _print(curTime, ...)
    end
end

love.keyboard.setTextInput(false)
require("dojitflags")

function getFrameTime() -- proto#39 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=66-67
    return frameTime
end

function getGameFrameTime() -- proto#38 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=70-71
    return gameDT
end

function getPlayerActor() -- proto#37 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=74-75
    return game.playerActor
end

function getScreenSize() -- proto#36 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=78-79
    return scrW, scrH
end

function getScreenWidth() -- proto#35 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=82-83
    return scrW
end

function getScreenHeight() -- proto#34 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=86-87
    return scrH
end

love.platformAPI = nil

function love.setFPSLimit(limit) -- proto#33 params=1 locals=0 upvalues=0 vararg=false source=26130 lines=93-100
    love.targetFPS = limit
    if limit then
        love.frameDelta = 1 / limit
    else
        love.frameDelta = nil
    end
end

function love.capFPSLimit() -- proto#32 params=0 locals=3 upvalues=0 vararg=false source=26130 lines=103-110
    if love.targetFPS then
        local maxFPS, maxFPSNoOffset = render:getMaxFPS()
        if maxFPS < love.targetFPS then
            love.setFPSLimit(maxFPSNoOffset)
        end
    end
end

love.clearColor = { 0, 0, 0, 0 }

function love.setClearColor(r, g, b, a) -- proto#31 params=4 locals=2 upvalues=0 vararg=false source=26130 lines=115-119
    love.clearColor[1] = r / 255
    love.clearColor[2] = g / 255
    love.clearColor[3] = b / 255
    love.clearColor[4] = a / 255
end

function love.resize(w, h) -- proto#30 params=2 locals=4 upvalues=0 vararg=false source=26130 lines=122-127
    local windowW, windowH = love.graphics.getDimensions()
    if resolutionHandler:setDesiredResolution(windowW, windowH) then
        resolutionHandler:onResized()
    end
end

function love.run() -- proto#29 params=0 locals=10 upvalues=0 vararg=false source=26130 lines=130-183
    if love.math then
        love.math.setRandomSeed(os.time())
    end
    if love.load then
        love.load(arg)
    end
    if love.timer then
        love.timer.step()
    end
    local dt = 0
    local sleptTime = 0
    local clr = love.graphics.bgClr
    while true do
        love.event.pump()
        for name, a, b, c, d, e, f in love.event.poll() do
            if name == "quit" and (not love.quit or not love.quit()) then
                goto L0
            end
            love.handlers[name](a, b, c, d, e, f)
        end
        local r29_10 = love.timer.step()
        dt = r29_10 - sleptTime
        sleptTime = 0
        r29_10 = love
        r29_10 = r29_10.targetFPS
        if r29_10 and love.frameDelta > dt then
            sleptTime = love.frameDelta - dt
            love.timer.sleep(sleptTime)
            dt = love.frameDelta
        end
        r29_10 = love
        r29_10.update(dt)
        r29_10 = love
        r29_10 = r29_10.graphics
        r29_10.origin()
        r29_10 = love
        r29_10.draw()
        r29_10 = love
        r29_10 = r29_10.graphics
        r29_10.present()
    end
    ::L0::
    return a
end

local utf8 = require("utf8")

local function error_printer(msg, layer) -- proto#28 params=2 locals=3 upvalues=0 vararg=false source=26130 lines=188-189
    print((debug.traceback("Error: " .. tostring(msg), 1 + (layer or 1)):gsub("\n[^\n]+$", "")))
end

function love.errorhandler(msg) -- proto#24 params=1 locals=50 upvalues=2 vararg=false source=26130 lines=192-372
    local minreqs = true
    if msg:find("shaders are not supported on this system!") then
        msg = "Your system does not meet the minimum requirements! (GLSL 3 shaders are not supported by your graphics card)"
        minreqs = false
    end
    local realmsg = msg
    msg = "GAME VERSION: " .. GAME_VERSION .. "\n"
    if love.filesystem.loadedMods and love.filesystem.loadedMods > 0 then
        msg = msg .. "MODS LOADED! (TOTAL: " .. love.filesystem.loadedMods .. [[)
]]
    end
    if MOD_LOAD_ID then
        msg = msg
            .. _format2("\n!!! CRASH WHILE LOADING MOD!\nMod Steam ID: ${modID}\nMod Name: '${modName}'\n!!! PLEASE REPORT THIS CRASH TO THE MOD AUTHOR!\n",
                "modID", MOD_LOAD_ID, "modName", MOD_LOAD_NAME or "UNKNOWN")
    end
    if game.worldObject then
        msg = msg .. "map: " .. game.worldObject:getMapID() .. "\n"
    end
    if game.playerActor then
        local r24_2 = msg
        local r24_3 = math.floor(game.playerActor.x)
        local r24_4 = math.floor(game.playerActor.y)
        local r24_5 = game.playerActor.state and game.playerActor.state.id or "n/a"
        msg = r24_2 .. "player data: x/y " .. r24_3 .. "/" .. r24_4 .. " " .. r24_5 .. "\n\n"
    end
    msg = msg .. "User CPU model: " .. CPU_MODEL .. "\n"
    msg = msg .. tostring(realmsg)
    local driverMessage = false
    if msg:find("Cannot link shader program object") then
        msg = [[Cannot link shader program object.
Your graphics drivers are outdated or your graphics card is too outdated to run the game.
Update your graphics drivers.]]
        driverMessage = true
    end
    error_printer(msg, 2)
    local r24_7 = love
    r24_7 = r24_7.window
    if not (r24_7 and love.graphics and love.event) then
        return
    end
    do
        if not love.graphics.isCreated() or not love.window.isOpen() then
            local success, status
            success, status = pcall(love.window.setMode, 800, 600)
            if not success or not status then
                return
            end
        end
        if love.mouse then
            love.mouse.setVisible(true)
            love.mouse.setGrabbed(false)
            love.mouse.setRelativeMode(false)
            if love.mouse.isCursorSupported() then
                love.mouse.setCursor()
            end
        end
        if love.joystick then
            local r24_10, r24_11, r24_12 = ipairs(love.joystick.getJoysticks())
            for i, v in r24_10, r24_11, r24_12 do
                v:setVibration()
            end
        end
        if love.audio then
            love.audio.stop()
        end
        love.graphics.reset()
        local font = love.graphics.setNewFont(14)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.origin()
        local sanitizedmsg = {}
        local r24_17, r24_18, r24_19 = msg:gmatch(utf8.charpattern)
        for char in r24_17, r24_18, r24_19 do
            table.insert(sanitizedmsg, char)
        end
        r24_17 = table.concat(sanitizedmsg)
        sanitizedmsg = r24_17
        local err = {}
        r24_17 = nil
        table.insert(err, [[Error
]])
        table.insert(err, sanitizedmsg)
        if #sanitizedmsg ~= #msg then
            table.insert(err, "Invalid UTF-8 string in error message.")
        end
        table.insert(err, "\n")
        if not driverMessage and minreqs then
            local trace = debug.traceback()
            local r24_23, r24_24, r24_25 = trace:gmatch([[(.-)
]])
            for l in r24_23, r24_24, r24_25 do
                if not l:match("boot.lua") then
                    local r24_27 = l:gsub("stack traceback:", [[Traceback
]])
                    l = r24_27
                    r24_27 = table
                    r24_27 = r24_27.insert
                    r24_27(err, l)
                end
            end
        end
        local p = table.concat(err, "\n")
        local r24_29 = p
        local r24_30 = r24_29:gsub("\t", "")
        p = r24_30
        r24_29 = p
        r24_30 = r24_29.gsub
        r24_30 = r24_30(r24_29, '%[string "(.-)"%]', "%1")
        p = r24_30
        r24_30 = love
        r24_30 = r24_30.filesystem.getInfo
        local pathData = r24_30("/crashlogs/", "directory")
        local r24_32 = os.date("%Y-%m-%d %H-%M-%S", os.time())
        local savedFile = "/crashlogs/" .. r24_32 .. ".txt"
        if not pathData then
            love.filesystem.createDirectory("crashlogs/")
        end
        r24_32 = love
        r24_32 = r24_32.filesystem.write
        r24_32(savedFile, p)
        local copied = false

        local function draw() -- proto#27 params=0 locals=1 upvalues=1 vararg=false source=26130 lines=314-320
            local pos = 70
            love.graphics.setBlendMode("alpha", "alphamultiply")
            love.graphics.clear(0.28627450980392155, 0.08627450980392157, 0.043137254901960784, 1)
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.print(p, pos, pos)
            love.graphics.present()
        end

        local fullErrorText = p

        local function copyToClipboard() -- proto#26 params=0 locals=0 upvalues=4 vararg=false source=26130 lines=324-333
            if not love.system then
                return
            end
            love.system.setClipboardText(fullErrorText)
            if not copied then
                p = p .. "\nCopied to clipboard!"
                copied = true
            end
            draw()
        end

        if minreqs and love.system then
            p = p .. "\n\nPress Ctrl+C or tap to copy this error"
            local r24_38 = p
            local r24_39 = love.filesystem.getSaveDirectory()
            local r24_40 = savedFile
            p = r24_38 .. "\nCrashlog saved to: " .. r24_39 .. r24_40 .. "!"
        end
        return function() -- proto#25 params=0 locals=11 upvalues=3 vararg=false source=26130 lines=341-371
            love.event.pump()
            for e, a, b, c in love.event.poll() do
                if e == "quit" then
                    return 1
                end
                if e == "keypressed" and a == "escape" then
                    return 1
                end
                if minreqs
                    and e == "keypressed"
                    and a == "c"
                    and love.keyboard.isDown("lctrl", "rctrl") then
                    copyToClipboard()
                elseif minreqs and e == "touchpressed" then
                    local name = love.window.getTitle()
                    name = (#name == 0 or name == "Untitled") and "Game" or name
                    local buttons = { "OK", "Cancel" }
                    if love.system then
                        buttons[3] = "Copy to clipboard"
                    end
                    local pressed = love.window.showMessageBox("Quit " .. name .. "?", "", buttons)
                    if pressed == 1 then
                        return 1
                    end
                    if pressed == 3 then
                        copyToClipboard()
                    end
                end
            end
            draw()
            if love.timer then
                love.timer.sleep(0.1)
            end
        end
    end
end

RELEASE = true
MAIN_THREAD = true
BASE_GAME_FOLDER = "intravenous/"

function getBaseFolderDirectory(dir) -- proto#23 params=1 locals=2 upvalues=0 vararg=false source=26130 lines=379-384
    if RELEASE then
        return BASE_GAME_FOLDER .. dir
    end
    return dir
end

require("load_engine")
if table.find(arg, "--debug") then
    DEBUG_MODE = true
    SHOW_SPLASH_SCREEN = false
end
if table.find(arg, "--debugp") then
    DEBUG_PANEL = true
    SHOW_SPLASH_SCREEN = false
end
if table.find(arg, "--debugfull") then
    DEBUG_MODE = true
    DEBUG_PANEL = true
    SHOW_SPLASH_SCREEN = false
end
if table.find(arg, "--thorough") then
    DEBUG_THOROUGH_STATS = true
end
if table.find(arg, "--local") then
    RELEASE = false
end
if table.find(arg, "--godmode") then
    GOD_MODE = true
end
if table.find(arg, "--speedhack") then
    SPEEDHACK = true
end
if table.find(arg, "--allweaponsunlocked") then
    UNLOCK_WEAPONS = true
    UNLOCK_WEAPON_MODS = true
end
if table.find(arg, "--nohud") then
    NO_HUD = true
end
scaling.onResolutionChanged(resolutionHandler:getRealScreenResolution())
if love.filesystem.getInfo("ignore_compile/spritecut.lua") then
    require("ignore_compile/spritecut")
end
require("load_game")
if table.find(arg, "--dupecheck") then
    require("localization/ignore_compile/dupecheck")
end
if table.find(arg, "--translationcompare") then
    require("localization/ignore_compile/translationcompare")
end
if love.filesystem.getInfo("dump_to_bytecode.lua") and table.find(arg, "--dump") then
    require("dump_to_bytecode")
end
if love.filesystem.getInfo("ignore_compile/match_translationkeys.lua")
    and table.find(arg, "--translationkeys") then
    require("ignore_compile/match_translationkeys")
end
require("tests")
math.randomseed(os.time())

function love.threaderror(thread, errorstr) -- proto#22 params=2 locals=0 upvalues=0 vararg=false source=26130 lines=610-611
    love.errorhandler(errorstr)
end

local lines = {}

function ADDLINE(x1, y1, x2, y2, clr) -- proto#21 params=5 locals=0 upvalues=1 vararg=false source=26130 lines=616-617
    lines[#lines + 1] = { x1, y1, x2, y2, clr }
end

function RESETLINES() -- proto#20 params=0 locals=0 upvalues=1 vararg=false source=26130 lines=620-621
    table.clearArray(lines)
end

function love.load() -- proto#19 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=624-626

end

local frame = 0
local minFrameTime = 0.03333333333333333
love.gameDTBlockers = {}

function love.addGameDTBlocker(blocker) -- proto#18 params=1 locals=1 upvalues=0 vararg=false source=26130 lines=633-643
    if table.find(love.gameDTBlockers, blocker) then
        return
    end
    table.insert(love.gameDTBlockers, blocker)
    love.gameDTOverride = 0
    if game.worldObject then
        game.worldObject:setNPCLogicState(false)
    end
end

function love.removeGameDTBlocker(blocker) -- proto#17 params=1 locals=1 upvalues=0 vararg=false source=26130 lines=646-657
    table.removeObject(love.gameDTBlockers, blocker)
    if #love.gameDTBlockers > 0 then
        love.gameDTOverride = 0
    else
        love.gameDTOverride = nil
        if game.worldObject then
            game.worldObject:setNPCLogicState(true)
        end
    end
end

function love.clearGameDTBlockers() -- proto#16 params=0 locals=0 upvalues=0 vararg=false source=26130 lines=660-662
    table.clearArray(love.gameDTBlockers)
    love.gameDTOverride = nil
end

function love.setOverrideGameDT(dt) -- proto#15 params=1 locals=0 upvalues=0 vararg=false source=26130 lines=665-666
    love.gameDTOverride = dt
end

function love.update(dt) -- proto#14 params=1 locals=8 upvalues=2 vararg=false source=26130 lines=669-712
    if HALT_GAME then
        return
    end
    if love.platformAPI then
        love.platformAPI:updateAPI(dt)
    end
    dt = math.min(dt, minFrameTime) * game.timescale
    if love.gameDTOverride then
        gameDT = love.gameDTOverride
        gameHalt = love.gameDTOverride == 0
    else
        gameDT = dt
        gameHalt = false
    end
    math.randomseed(curTime)
    frameTime = dt
    gameStateService:updateStates(dt)
    sound:think()
    timer:process(dt)
    gcm:collectGarbage()
    coroutineManager:process()
    curTime = curTime + dt
    frame = frame + 1
end

function love.mousefocus(f) -- proto#13 params=1 locals=0 upvalues=0 vararg=false source=26130 lines=715-720

end

function love.textinput(text) -- proto#12 params=1 locals=1 upvalues=0 vararg=false source=26130 lines=723-728
    if HALT_GAME then
        return
    end
    inputService:handleTextInput(text)
end

love.nonTextKeys = { backspace = true, escape = true, ["return"] = true }

function love.keypressed(key, scancode) -- proto#11 params=2 locals=2 upvalues=0 vararg=false source=26130 lines=737-753
    if HALT_GAME then
        return
    end
    if key == "unknown" then
        key = scancode
    end
    if DEBUG_MODE and scancode == "f10" and love.keyboard.isDown("lshift") then
        require("engine/editor/init_particle_editor")
        return
    end
    inputService:setInputType(inputService.INPUT_TYPES.KEYBOARD)
    love.lastKeyPressed = scancode
    inputService:handleKeyPress(scancode)
end

function love.keyreleased(key, scancode) -- proto#10 params=2 locals=2 upvalues=0 vararg=false source=26130 lines=756-762
    if key == "unknown" then
        key = scancode
    end
    inputService:setInputType(inputService.INPUT_TYPES.KEYBOARD)
    inputService:handleKeyRelease(scancode)
end

function love.wheelmoved(x, y) -- proto#9 params=2 locals=2 upvalues=0 vararg=false source=26130 lines=769-784
    if HALT_GAME then
        return
    end
    if gui.handleClick(0, 0, gui.mouseKeys.NONE, x, y) then
        return
    end
    inputService:handleMouseWheel(y)
end

function love.mousepressed(x, y, key) -- proto#8 params=3 locals=1 upvalues=0 vararg=false source=26130 lines=787-807
    if HALT_GAME then
        return
    end
    inputService:preProcessMousePressed(key)
    if not gui.handleClick(x, y, key)
        and not inputService:handleMouseClick(key, x, y)
        and game.worldObject then

    end
end

function love.mousereleased(x, y, key) -- proto#7 params=3 locals=2 upvalues=0 vararg=false source=26130 lines=810-824
    inputService:preProcessMouseReleased(key)
    if not gui.handleMouseRelease(x, y, key)
        and not inputService:handleMouseRelease(key, x, y)
        and key == gui.mouseKeys.LEFT then
        camera:removeTouch(x, y)
    end
end

function love.mousemoved(x, y, dx, dy) -- proto#6 params=4 locals=9 upvalues=0 vararg=false source=26130 lines=827-844
    if not game.canHaveInput() then
        return
    end
    do
        if inputService:handleMouseMoved(x, y, dx, dy) then
            return
        end
        local x2, y2 = camera:getTouchPosition()
        if x2 then
            local camX, camY = camera:getPosition()
            camera:scroll(-dx, -dy)
        end
        return
    end
end

if DEBUG_PANEL then
    local debugPanel = {}
    debugPanel.LAYER_PRIORITY = 999999999

    function debugPanel:draw() -- proto#5 params=1 locals=24 upvalues=0 vararg=false source=26130 lines=891-910
        local stats = love.graphics.getStats()
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(fonts.get("terminal16"))
        local statsString = _format2([[MEM ${mem}
FPS ${fps}]], "mem",
            tostring(math.round(collectgarbage("count") / 1024, 3)), "fps", love.timer.getFPS())
        if game.worldObject then
            local npcList = game.worldObject:getNPCs()
            local rateLimitList = game.worldObject.activeNPCsRR
            local r5_4 = statsString
            local r5_5 = _format2
            local r5_6 = #npcList - #rateLimitList
            local r5_7 = #rateLimitList
            local r5_8 = #game.dynamicObjects
            local r5_9 = shadowMapping.totalDraws
            local r5_10 = #shadowMapping.validBuffers
            local r5_11 = pathComputeQueue.activePathfinderCount
            local r5_12 = pathComputeQueue.queue and #pathComputeQueue.queue or 0
            local r5_13 = pathComputeQueue.activePathfinderCount
            local r5_14 = game.availablePathfinders
            r5_5 = r5_5("\nNPCS FULL - ${fullRate}\nNPCS RATELIMIT - ${rateLimit}\nDYNOBJ - ${dynObjs}\nRENDERED LIGHTS - ${renderLights}\nACTIVE LIGHTS - ${lightCount}\nACTIVE PFs & QUEUE - ${activePF}/${pfQueue}\nPF COUNTER/PF LIST ${counter} (${list})",
                "fullRate", r5_6, "rateLimit", r5_7, "dynObjs", r5_8, "renderLights", r5_9,
                "lightCount", r5_10, "activePF", r5_11, "pfQueue", r5_12, "counter", r5_13, "list",
                #r5_14)
            statsString = r5_4 .. r5_5
        end
        if DEBUG_THOROUGH_STATS then
            statsString = statsString
                .. _format2("\nVRAM ${vram}\nDRAW ${draw}\n${canvas} RT SWITCHES\n${shader} SHADER SWITCHES",
                    "draw", tostring(stats.drawcalls), "vram",
                    math.round(stats.texturememory / 1024 / 1024, 3), "canvas", stats.canvasswitches,
                    "shader", stats.shaderswitches)
        end
        love.graphics.print(statsString, 0, 0)
    end

    local r0_7 = layerRenderer
    r0_7:addLayer(debugPanel, 999999999)
end

function love.draw() -- proto#4 params=0 locals=3 upvalues=0 vararg=false source=26130 lines=916-979
    GAME_DRAWING = true
    if HALT_GAME then
        return
    end
    render:onNewFrame()
    layerRenderer:draw()
    love.graphics.setShader()
    render:onFrameFinished()
    GAME_DRAWING = false
end

function love.focus(focus) -- proto#3 params=1 locals=0 upvalues=0 vararg=false source=26130 lines=982-999
    love.mouse.setGrabbed(focus)
end

local cpuModelOut = nil

local function _getCPUModel() -- proto#2 params=0 locals=3 upvalues=1 vararg=false source=26130 lines=1004-1007
    local handle = io.popen("wmic cpu get name")
    cpuModelOut = handle:read("*a")
    handle:close()
end

function love.getCPUModel() -- proto#1 params=0 locals=2 upvalues=2 vararg=false source=26130 lines=1010-1015
    pcall(_getCPUModel)
    cpuModelOut = cpuModelOut or "unknown"
    local r1_0 = cpuModelOut:gsub("Name", "")
    return r1_0:gsub("\n", "")
end

CPU_MODEL = love.getCPUModel()
game.onStarted()
game.setTimescale(1)
render:compileShaders()
if table.find(arg, "--finduntranslatedtext") then
    require("localization/ignore_compile/finduntranslatedtext")
end
gameDT = 0
frameTime = 0
if INSTANT_CONTINUE then
    if game.attemptLoadMostRecentSavefile() then
        return
    end
    game.openMainMenu()
else
    game.openMainMenu()
end
