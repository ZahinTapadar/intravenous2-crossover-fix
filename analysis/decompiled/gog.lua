-- file: 1210
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

if not gog then
    return
end
print("GOG API loaded")
do
    local apiUpdateFrequency = 0.016666666666666666
    local apiTimestamp = 0

    function gog.updateAPI(self, dt) -- proto#9 params=2 locals=0 upvalues=2 vararg=false source=1210 lines=10-16
        apiTimestamp = apiTimestamp - dt
        if apiTimestamp <= 0 then
            apiTimestamp = apiUpdateFrequency
            gog.update()
        end
    end

    function gog.release(self) -- proto#8 params=1 locals=0 upvalues=0 vararg=false source=1210 lines=19-20

    end

    function gog.getIsDLCOwned(self, id) -- proto#7 params=2 locals=0 upvalues=0 vararg=false source=1210 lines=23-24
        return true
    end

    local _cppSetAchievement = gog.SetAchievement

    function gog.SetAchievement(achID) -- proto#6 params=1 locals=0 upvalues=1 vararg=false source=1210 lines=33-35
        _cppSetAchievement(achID)
        gog.StoreStatsAndAchievements()
    end

    function gog.OnAuthSuccess() -- proto#5 params=0 locals=0 upvalues=0 vararg=false source=1210 lines=42-44
        gog.GetStatsAndAchievements()
    end

    function gog.OnAuthFailure() -- proto#4 params=0 locals=0 upvalues=0 vararg=false source=1210 lines=47-48

    end

    function gog.OnAuthLost() -- proto#3 params=0 locals=0 upvalues=0 vararg=false source=1210 lines=51-53
        gog.SignIn(false)
    end

    function gog.OnUserStatsAndAchievementsRetrieveSuccess() -- proto#2 params=0 locals=0 upvalues=0 vararg=false source=1210 lines=56-57

    end

    function gog.OnUserStatsAndAchievementsRetrieveFailure() -- proto#1 params=0 locals=0 upvalues=0 vararg=false source=1210 lines=60-61

    end

    love.platformAPI = gog
    gog.SignIn(false)
end
