-- file: 6385
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local function makeRequire(path, modSource, skipEnv, envTable) -- proto#21 params=4 locals=0 upvalues=1 vararg=false source=6385 lines=1-34
    return function(mainFile) -- proto#22 params=1 locals=20 upvalues=5 vararg=false source=6385 lines=2-33
        mainFile = mainFile .. ".lua"
        local fileHandle = io.open(path .. "/" .. mainFile, "r")
        if not fileHandle then
            return
        end
        do
            local readData = fileHandle:read("*all")
            fileHandle:close()
            local f, err = loadstring(readData, modSource .. mainFile)
            if err then
                error(err)
            end
            local r22_4 = skipEnv
            if not r22_4 then
                for k, v in pairs(MODENV) do
                    envTable[k] = v
                end
                local r22_7 = envTable
                local r22_8 = makeRequire(path, modSource, true, envTable)
                r22_7.require = r22_8
            end
            setfenv(f, envTable)
            r22_4 = f
            return r22_4()
        end
    end
end

function makeRequireMethod(path, modSource) -- proto#20 params=2 locals=3 upvalues=1 vararg=false source=6385 lines=37-44
    modSource = not modSource and "" or modSource == "" and "" or modSource .. "/"
    return makeRequire(path, modSource, nil, {})
end

love.filesystem.modEnv = MODENV
love.filesystem.modEnvInitializer = makeRequireMethod
love.filesystem.mainModFile = "main"
love.filesystem.mainModFileFull = love.filesystem.mainModFile .. ".lua"
if not steam then
    return
end
do
    print("Steam API loaded")

    function steam.OnAchievementSet(id) -- proto#19 params=1 locals=1 upvalues=0 vararg=false source=6385 lines=61-62
        achievements:setAchievement(id)
    end

    function steam.OnUserStatsReceived(statData) -- proto#18 params=1 locals=1 upvalues=0 vararg=false source=6385 lines=65-66
        achievements:setStatData(statData)
    end

    function steam.OnAchievementsReceived(achvList) -- proto#17 params=1 locals=1 upvalues=0 vararg=false source=6385 lines=69-70
        achievements:setAchievements(achvList)
    end

    steam.MAIN_MOD_FILE = "main"
    steam.MAIN_MOD_FILE_FULL = "main.lua"

    local function readMetadataJson(input) -- proto#16 params=1 locals=2 upvalues=0 vararg=false source=6385 lines=85-90
        local result = json:decode(input)
        if result and result.title then
            MOD_LOAD_NAME = result.title
        end
    end

    function steam.LoadMod(path, id) -- proto#15 params=2 locals=10 upvalues=1 vararg=false source=6385 lines=93-133
        MOD_DIRECTORY = path
        MOD_LOAD_ID = id
        love.filesystem.setCurrentDirectory(path)
        maps:registerModMaps("")
        if love.filesystem.getInfo("metadata") then
            local metadata = love.filesystem.read("metadata")
            if metadata then
                pcall(readMetadataJson, metadata)
            end
        end
        local handle = io.open(path .. "/" .. steam.MAIN_MOD_FILE_FULL)
        local success = false
        if handle then
            handle:close()
            local method = makeRequireMethod(path)
            if method then
                method(steam.MAIN_MOD_FILE)
                love.filesystem.loadedMods = love.filesystem.loadedMods + 1
                success = true
            end
        else
            print("failed to load mod (no main.lua)", path)
        end
        love.filesystem.clearCurrentDirectory(path)
        MOD_DIRECTORY = nil
        MOD_LOAD_ID = nil
        MOD_LOAD_NAME = nil
        return success
    end

    function steam.LoadMods() -- proto#14 params=0 locals=1 upvalues=0 vararg=false source=6385 lines=136-137
        workshop:loadMods()
    end

    function steam.OnWorkshopUploadSuccess() -- proto#13 params=0 locals=1 upvalues=0 vararg=false source=6385 lines=144-146
        workshop:onUploadedItem()
    end

    function steam.OnWorkshopUploadFailure() -- proto#12 params=0 locals=1 upvalues=0 vararg=false source=6385 lines=149-151
        workshop:onFailedUploadItem()
    end

    function steam.OnWorkshopCreationSuccess(m_nPublishedFileId) -- proto#11 params=1 locals=1 upvalues=0 vararg=false source=6385 lines=154-156
        workshop:onCreatedItem(m_nPublishedFileId)
    end

    function steam.OnWorkshopCreationFailure() -- proto#10 params=0 locals=1 upvalues=0 vararg=false source=6385 lines=159-161
        workshop:onFailedUploadItem()
        print("creation failure")
    end

    function steam.OnModQueryFinished(data, queryType, queryPage, lastPage) -- proto#9 params=4 locals=1 upvalues=0 vararg=false source=6385 lines=179-180
        workshop:onModQueryFinished(data, queryType, queryPage, lastPage)
    end

    function steam.OnOwnershipCheckFailed(modID) -- proto#8 params=1 locals=1 upvalues=0 vararg=false source=6385 lines=183-184
        workshop:onOwnershipFailed(modID)
    end

    function steam.OnOwnershipCheckResult(modID, result) -- proto#7 params=2 locals=2 upvalues=0 vararg=false source=6385 lines=187-192
        if result then
            workshop:onOwnershipVerified(modID)
        else
            workshop:onOwnershipFailed(modID)
        end
    end

    function steam.OnPreviewImageReceived(id, data) -- proto#6 params=2 locals=1 upvalues=0 vararg=false source=6385 lines=195-202
        workshop:onPreviewImageReceived(id, data)
    end

    function steam.OnPreviewImageDownloadFailed() -- proto#5 params=0 locals=1 upvalues=0 vararg=false source=6385 lines=205-206
        workshop:onPreviewImageDownloadFailed()
    end

    function steam.OnModQueryLastPage(queryType, queriedPage) -- proto#4 params=2 locals=1 upvalues=0 vararg=false source=6385 lines=211-212
        workshop:onModQueryLastPage(queryType, queriedPage)
    end

    local apiUpdateFrequency = 0.03333333333333333
    local apiTimestamp = 0

    function steam.updateAPI(self, dt) -- proto#3 params=2 locals=0 upvalues=2 vararg=false source=6385 lines=218-224
        apiTimestamp = apiTimestamp - dt
        if apiTimestamp <= 0 then
            apiTimestamp = apiUpdateFrequency
            steam.RunCallbacks()
        end
    end

    function steam.getIsDLCOwned(self, id) -- proto#2 params=2 locals=2 upvalues=0 vararg=false source=6385 lines=227-228
        return self.IsDLCOwned(id)
    end

    function steam.release(self) -- proto#1 params=1 locals=0 upvalues=0 vararg=false source=6385 lines=231-232

    end

    love.platformAPI = steam
    return
end
