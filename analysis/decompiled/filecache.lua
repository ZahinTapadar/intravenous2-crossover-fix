-- file: 6199
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

cache = {}
cache.cachedSounds = {}
cache.soundVolumes = {}
local r0_0 = love
r0_0 = r0_0.audio
local newSource = r0_0.newSource
local r0_2 = MAIN_THREAD
if r0_2 then
    cache.imageCounter = 0
    local r0_3 = cache
    local r0_4 = {}
    r0_3.cachedTextures = r0_4
    local r0_5 = cache
    r0_4 = {}
    r0_5.cachedTexturesList = r0_4
    local r0_6 = cache
    r0_4 = {}
    r0_6.texturesByID = r0_4
    local r0_7 = cache
    r0_4 = {}
    r0_7.idsByTextures = r0_4
    local r0_8 = cache
    r0_4 = {}
    r0_8.texturePaths = r0_4
    local r0_9 = cache
    r0_4 = {}
    r0_9.texturePathsByID = r0_4
    local r0_10 = cache
    r0_4 = {}
    r0_10.textureDimensions = r0_4
    local r0_11 = cache
    r0_4 = 0
    r0_11.sourcesIn = r0_4
    cache.sourcesOut = 0
    cache.queuedSources = {}
    local newImage = love.graphics.newImage
    love.graphics.setDefaultFilter("linear", "nearest", 0)

    function cache.getTexturePath(textureObject) -- proto#18 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=27-28
        return cache.texturePaths[textureObject]
    end

    function cache.getTexturePathByID(id) -- proto#17 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=31-32
        return cache.texturePathsByID[id]
    end

    function cache.newImage(img, filterMin, filterMag) -- proto#16 params=3 locals=11 upvalues=1 vararg=false source=6199 lines=35-58
        if cache.cachedTextures[img] then
            return cache.cachedTextures[img]
        end
        do
            filterMin = filterMin or "nearest"
            filterMag = filterMag or "nearest"
            cache.imageCounter = cache.imageCounter + 1
            local image = newImage(img)
            local refW, refH = image:getDimensions()
            image:setFilter(filterMin, filterMag, 1)
            image:setWrap("repeat", "repeat")
            cache.cachedTextures[img] = image
            table.insert(cache.cachedTexturesList, img)
            cache.texturePaths[image] = img
            cache.texturePathsByID[cache.imageCounter] = img
            cache.textureDimensions[image] = { refW, refH }
            cache.texturesByID[cache.imageCounter] = image
            cache.idsByTextures[image] = cache.imageCounter
            return image
        end
    end

    function cache.getImageID(texture) -- proto#15 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=61-62
        return cache.idsByTextures[texture]
    end

    function cache.getImageByID(id) -- proto#14 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=65-66
        return cache.texturesByID[id]
    end

    function cache.newImageNamed(name, img, wraph, wrapv, filterMin, filterMag) -- proto#13 params=6 locals=3 upvalues=1 vararg=false source=6199 lines=69-87
        if cache.cachedTextures[name] then
            return cache.cachedTextures[name]
        end
        filterMin = filterMin or "nearest"
        filterMag = filterMag or "nearest"
        local r13_0 = newImage(img)
        img = r13_0
        r13_0 = img.setFilter
        r13_0(img, filterMin, filterMag, 1)
        r13_0 = cache
        r13_0 = r13_0.cachedTextures
        r13_0[name] = img
        r13_0 = cache
        r13_0 = r13_0.texturePaths
        r13_0[img] = name
        if wraph then
            wrapv = wrapv or "clamp"
            img:setWrap(wraph, wrapv)
        end
        r13_0 = cache.cachedTextures
        return r13_0[name]
    end

    function cache.getImageIDByName(name) -- proto#12 params=1 locals=2 upvalues=0 vararg=false source=6199 lines=90-91
        return cache.idsByTextures[cache.cachedTextures[name]]
    end

    function cache.getImage(img) -- proto#11 params=1 locals=3 upvalues=0 vararg=false source=6199 lines=94-99
        if cache.cachedTextures[img] then
            return cache.cachedTextures[img]
        end
        return cache.newImage(img)
    end

    function cache.removeImage(img) -- proto#10 params=1 locals=3 upvalues=0 vararg=false source=6199 lines=102-109
        local imgObj = cache.cachedTextures[img]
        cache.cachedTextures[img] = nil
        cache.texturesByID[cache.idsByTextures[imgObj]] = nil
        cache.idsByTextures[imgObj] = nil
        table.removeObject(cache.cachedTexturesList, imgObj)
    end

    local sourceID = 0
    local workerCount = math.max(1, math.min(5, love.system.getProcessorCount() - 1))
    local batchSize = 32
    local batch = {}
    local workers = {}
    local audioLoaderChanIn = "audioLoaderChannelIn"
    local audioLoaderChanOut = "audioLoaderChannelOut"
    local audioLoaderChannelIn = love.thread.getChannel(audioLoaderChanIn)
    local audioLoaderChannelOut = love.thread.getChannel(audioLoaderChanOut)
    for i = 1, workerCount do
        local thread = love.thread.newThread("engine/sound_loader_thread.lua")
        thread:start(audioLoaderChanIn, audioLoaderChanOut)
        workers[i] = thread
    end

    function cache.submitSourceBatch() -- proto#9 params=0 locals=0 upvalues=1 vararg=false source=6199 lines=127-130
        if #batch > 0 then
            cache._submitSourceBatch()
        end
    end

    function cache._submitSourceBatch() -- proto#8 params=0 locals=4 upvalues=2 vararg=false source=6199 lines=133-136
        cache.sourcesIn = cache.sourcesIn + #batch
        audioLoaderChannelIn:push(batch)
        table.clearArray(batch)
    end

    function cache.newSoundThreaded(name, path, stype, vol, loop, clones) -- proto#7 params=6 locals=3 upvalues=3 vararg=false source=6199 lines=139-160
        local thisID = sourceID
        local send = {
            path = path, name = name, stype = stype, vol = vol, loop = loop, id = thisID,
            clones = clones
        }
        sourceID = sourceID + 1
        table.insert(batch, send)
        local r7_2 = #batch
        if batchSize <= r7_2 then
            cache._submitSourceBatch()
        end
        return thisID
    end

    function cache.processSourceLoadCache() -- proto#6 params=0 locals=12 upvalues=1 vararg=false source=6199 lines=163-180
        cache.submitSourceBatch()
        while true do
            local r6_0 = cache.sourcesIn
            if not (cache.sourcesOut < r6_0) then
                break
            end
            local batch = audioLoaderChannelOut:demand()
            local r6_2 = cache
            local r6_3 = cache.sourcesOut
            local r6_4 = #batch
            r6_2.sourcesOut = r6_3 + r6_4
            r6_3 = #batch
            r6_4 = 1
            for i = 1, r6_3, r6_4 do
                local data = batch[i]
                local name = data.name
                cache.soundVolumes[name] = data.vol
                local r6_8 = cache.cachedSounds
                local r6_9 = data.source
                r6_8[name] = r6_9
                r6_8 = sound.onSoundLoaded
                local r6_10 = data.id
                local r6_11 = data.source
                local r6_12 = data.clones
                r6_9 = nil
                r6_8(r6_10, r6_11, r6_12)
            end
        end
    end
end

function cache.newSound(name, stype, vol, loop) -- proto#5 params=4 locals=2 upvalues=1 vararg=false source=6199 lines=184-195
    vol = vol or 1
    loop = loop or false
    stype = stype or "static"
    local src = newSource(name, stype, vol, loop)
    cache.soundVolumes[name] = vol
    cache.cachedSounds[name] = src
    return cache.cachedSounds[name]
end

function cache.newSoundNamed(name, sound, stype, vol, loop) -- proto#4 params=5 locals=4 upvalues=1 vararg=false source=6199 lines=198-213
    if cache.cachedSounds[name] then
        return cache.cachedSounds[name]
    end
    do
        vol = vol or 1
        loop = loop or false
        stype = stype or "static"
        local src = newSource(sound, stype)
        src:setVolume(vol)
        src:setLooping(loop)
        cache.soundVolumes[name] = vol
        cache.cachedSounds[name] = src
        return cache.cachedSounds[name]
    end
end

function cache.getSound(snd) -- proto#3 params=1 locals=3 upvalues=0 vararg=false source=6199 lines=216-221
    if cache.cachedSounds[snd] then
        return cache.cachedSounds[snd]
    end
    return cache.newSound(snd, "static")
end

function cache.removeSound(snd) -- proto#2 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=224-231
    local obj = cache.cachedSounds[snd]
    cache.cachedSounds[snd] = nil
    cache.soundVolumes[snd] = nil
    if obj then
        obj:release()
    end
end

function cache.getSoundVolume(sound) -- proto#1 params=1 locals=1 upvalues=0 vararg=false source=6199 lines=234-235
    return cache.soundVolumes[sound]
end
