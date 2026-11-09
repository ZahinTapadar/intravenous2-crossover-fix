-- file: 5200
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

function love.filesystem.saveFileTo(dir, name, data) -- proto#20 params=3 locals=0 upvalues=0 vararg=false source=5200 lines=9-11
    love.filesystem.setIdentity(dir)
    love.filesystem.write(name, data)
end

function love.filesystem.readFileFrom(dir, name) -- proto#19 params=2 locals=0 upvalues=0 vararg=false source=5200 lines=14-16
    love.filesystem.setIdentity(dir)
    love.filesystem.read(name)
end

love.graphics.oldPrint = love.graphics.print

function love.graphics.print(text, x, y, ...) -- proto#18 params=3 locals=0 upvalues=0 vararg=true source=5200 lines=27-28
    love.graphics.oldPrint(text, math.round(x), math.round(y), ...)
end

function love.graphics.printST(text, x, y, tr, tg, tb, ta, sr, sg, sb, sa, rotation, xScale, yScale,
    originOffX, originOffY) -- proto#17 params=16 locals=5 upvalues=0 vararg=false source=5200 lines=31-41
    local r, g, b, a = love.graphics.getColor()
    local r17_4 = math.round(x)
    y = math.round(y)
    x = r17_4
    r17_4 = love
    r17_4 = r17_4.graphics.setColor
    r17_4(sr or 0, sg or 0, sb or 0, sa or 255)
    r17_4 = love
    r17_4 = r17_4.graphics.print
    r17_4(text, x + 1, y + 1, rotation, xScale, yScale, originOffX, originOffY)
    r17_4 = love
    r17_4 = r17_4.graphics.setColor
    r17_4(tr or 255, tg or 255, tb or 255, ta or 255)
    r17_4 = love
    r17_4 = r17_4.graphics.print
    r17_4(text, x, y, rotation, xScale, yScale, originOffX, originOffY)
    r17_4 = love
    r17_4 = r17_4.graphics.setColor
    r17_4(r, g, b, a)
end

love.graphics.colorMod = { 1, 1, 1, 1 }

function love.graphics.setColorModulation(r, g, b, a) -- proto#16 params=4 locals=1 upvalues=0 vararg=false source=5200 lines=48-54
    local cm = love.graphics.colorMod
    cm[1] = r
    cm[2] = g
    cm[3] = b
    cm[4] = a
end

love.graphics.lastColor = { 1, 1, 1, 1 }
local lc = love.graphics.lastColor
local r0_1 = love
r0_1 = r0_1.graphics
local oldSetColor = r0_1.setColor

function love.graphics.setColor(r, g, b, a) -- proto#15 params=4 locals=7 upvalues=1 vararg=false source=5200 lines=62-72
    local mod = love.graphics.colorMod
    local r15_1 = r * mod[1]
    local r15_2 = g * mod[2]
    local r15_3 = b * mod[3]
    a = a * mod[4]
    b = r15_3
    g = r15_2
    r = r15_1
    r15_1 = oldSetColor
    r15_3 = r / 255
    local r15_4 = g / 255
    local r15_5 = b / 255
    local r15_6 = a / 255
    r15_2 = nil
    r15_1(r15_3, r15_4, r15_5, r15_6)
end

function love.graphics.setColorUnmodulated(r, g, b, a) -- proto#14 params=4 locals=0 upvalues=1 vararg=false source=5200 lines=75-76
    oldSetColor(r / 255, g / 255, b / 255, a / 255)
end

function love.graphics.setColorRaw(r, g, b, a) -- proto#13 params=4 locals=0 upvalues=1 vararg=false source=5200 lines=79-81
    oldSetColor(r, g, b, a)
end

local _curFont = love.graphics.getFont()
local _oldSetFont = love.graphics.setFont

function love.graphics.setFont(font) -- proto#12 params=1 locals=0 upvalues=2 vararg=false source=5200 lines=87-91
    if font ~= _curFont then
        _oldSetFont(font)
        _curFont = font
    end
end

function love.graphics.getFont() -- proto#11 params=0 locals=0 upvalues=1 vararg=false source=5200 lines=94-95
    return _curFont
end

function love.graphics.setColorX(r, g, b, a) -- proto#10 params=4 locals=0 upvalues=1 vararg=false source=5200 lines=104-111
    if r ~= lc.r or g ~= lc.g or b ~= lc.b or a ~= lc.a then
        love.graphics.setColor(r, g, b, a)
        lc.r = r
        lc.g = g
        lc.b = b
        lc.a = a
    end
end

function love.audio.playX(snd, x, y) -- proto#9 params=3 locals=1 upvalues=0 vararg=false source=5200 lines=114-131
    if type(snd) == "table" then
        snd = table.random(snd)
    end
    snd:rewind()
    snd:play()
    if not audio[snd] then
        audio[snd] = snd
    end
end

function love.audio.playSoundChannel(snd) -- proto#8 params=1 locals=1 upvalues=0 vararg=false source=5200 lines=134-137
    local chan = sound.pickChannel(snd)
    chan:rewind()
    chan:play()
end

function love.filesystem.findAllFiles(dir, tbl) -- proto#7 params=2 locals=6 upvalues=0 vararg=false source=5200 lines=140-147
    for k, v in pairs(love.filesystem.getDirectoryItems(dir)) do
        local r7_2, r7_3 = love.filesystem.isDirectory, dir
        r7_3 = r7_3 .. "/" .. v
        if r7_2(r7_3) then
            r7_2 = love.filesystem.findAllFiles
            local r7_4 = dir
            r7_4 = r7_4 .. "/" .. v
            r7_2(r7_4, tbl)
        else
            r7_2 = table.insert
            r7_3 = tbl
            local r7_5 = dir
            r7_5 = r7_5 .. "/" .. v
            r7_2(r7_3, r7_5)
        end
    end
end

function love.filesystem.getGameDirectory() -- proto#6 params=0 locals=3 upvalues=0 vararg=false source=5200 lines=150-151
    return love.filesystem.getWorkingDirectory() .. "/" .. game.name .. "/"
end

function love.filesystem.loadAllLuaFiles(directory) -- proto#5 params=1 locals=6 upvalues=0 vararg=false source=5200 lines=154-161
    for key, fileName in pairs(love.filesystem.getDirectoryItems(directory)) do
        local file = love.filesystem.load(directory .. "/" .. fileName)
        if file then
            file()
        end
    end
end

function dofile_game(filePath) -- proto#4 params=1 locals=3 upvalues=0 vararg=false source=5200 lines=164-165
    return dofile(game.rootPath .. filePath)
end

local totalFiles = {}
for k, v in pairs(love.filesystem.getDirectoryItems("mods")) do
    local dir = "mods/" .. v .. "/lua"
    local info = love.filesystem.getInfo(dir)
    if info and info.type == "directory" then
        for k2, v2 in pairs(love.filesystem.getDirectoryItems(dir)) do
            local subDir = dir .. "/" .. v2
            if love.filesystem.isDirectory(subDir) then
                love.filesystem.findAllFiles(subDir, totalFiles)
            end
        end
    end
end
local registry = debug.getregistry()
local imageClass = registry.Image

function imageClass.getScaleToSize(self, desiredSize) -- proto#3 params=2 locals=3 upvalues=0 vararg=false source=5200 lines=190-194
    local w, h = self:getDimensions()
    local largest = math.max(w, h)
    return desiredSize / largest
end

function imageClass.getCenterTo(self, x, y, scale) -- proto#2 params=4 locals=8 upvalues=0 vararg=false source=5200 lines=197-202
    scale = scale or 1
    local w, h = self:getDimensions()
    local r2_2 = w * scale
    h = h * scale
    w = r2_2
    return math.round(x * 0.5 - w * 0.5), math.round(y * 0.5 - h * 0.5)
end

function printd(...) -- proto#1 params=0 locals=2 upvalues=0 vararg=true source=5200 lines=206-207
    print(debug.getinfo(2, "S").source, ...)
end
