-- file: 7551
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

achievements = {}
achievements.LIST = {
    "FREELOADER", "PUPIL", "GUNNUT20", "TACTICOOL", "UPTO11", "WEAPONIZEDPERFORATOR", "SFFMG",
    "BULLETHOSE", "DRUMFEDMONSTROSITY", "GUNSCHIZO", "AMMOHOARDER", "RODENTANNIHILATOR",
    "BULLETWHISPERER", "SILENTDEATH", "GHOSTTRICK", "SILENTJACKHAMMER", "FLAWLESSERGONOMICS",
    "COOKINGWITHGAS", "BBQENJOYER", "ARSONIST", "CHAINREACTION", "RELAX", "SLEEPOVER",
    "MASSHYPNOSIS", "DAMNINGEVIDENCE", "BUSYNIGHT", "PRIVATEINTERVIEW", "WETWORKS", "PUNISHER",
    "TRUEPACIFIST", "ABSTINENT", "STRAIGHTEDGE", "STIMJUNKIE", "DUALITYOFMAN", "SKYDIVER", "GHOST",
    "PACIFIST", "HIDDENDANGEROUS", "HOOLIGAN", "DUMPSTERDIVER", "DIABETESINACAN", "UNLIKELYALLIANCE",
    "HOOKLINESINKER", "DRAGONSLAYER", "TOHELLANDBACK", "LORDOFNOTHING", "MONEYLAUNDERER", "BMA",
    "KINGPIN", "CODEOFHONOR", "ALLSWELL", "GOOSEISCOOKED", "COLLATERAL", "RISETOTHECHALLENGE",
    "CLASSIC"
}
achievements.ENUM = {}
for key, id in ipairs(achievements.LIST) do
    achievements.ENUM[id] = id
end
achievements.STATS = {}
achievements.REQ_PROGRESS = {}
achievements.STAT_BOUNDARIES = {}

function achievements:init() -- proto#19 params=1 locals=3 upvalues=0 vararg=false source=7551 lines=129-143
    self.platformAPI = love.platformAPI
    local r19_0 = {}
    self.progress = r19_0
    r19_0 = self.stats
    if not r19_0 then
        self.stats = {}
    end
    if not self.unlocked then
        self.unlocked = {}
    end
    for key, id in ipairs(achievements.LIST) do
        self.progress[id] = 0
    end
end

function achievements.setStatData(self, data) -- proto#18 params=2 locals=5 upvalues=0 vararg=false source=7551 lines=146-153
    do
        local r18_0 = {}
        self.stats = r18_0
    end
    for i = 1, #data, 2 do
        local id = data[i]
        local value = data[i + 1]
        self.stats[id] = value
    end
end

function achievements.attemptSetStat(self, id, value, achvID) -- proto#17 params=4 locals=11 upvalues=0 vararg=false source=7551 lines=156-179
    local r17_0 = game.curGametype
    local r17_1 = r17_0
    r17_0 = r17_1.preventAchievements
    if r17_0(r17_1) or mapEditor:isActive() then
        return
    end
    if self.stats then
        self.platformAPI.SetStat(id, value)
        local prevVal = self.stats[id]
        local req = self.STAT_BOUNDARIES[id]
        if type(achvID) == "table" then
            for key, id2 in ipairs(achvID) do
                if not self.unlocked[achvID] then
                    self:_advanceProgress(value, prevVal, id2, req)
                end
            end
        else
            self:_advanceProgress(value, prevVal, achvID, req)
        end
        local newVal = math.min(req, value)
        local r17_7 = self.stats
        local r17_8 = math.max(prevVal, newVal)
        r17_7[id] = r17_8
        r17_7 = self.platformAPI.SetStat
        r17_8 = nil
        r17_7(id, newVal)
    end
end

function achievements:_advanceProgress(newValue, oldValue, achvID, req) -- proto#16 params=5 locals=0 upvalues=0 vararg=false source=7551 lines=182-191
    if not achvID then
        return
    end
    self:_indicateProgress(newValue, oldValue, achvID)
    if req <= newValue then
        self.platformAPI.SetAchievement(achvID)
    end
end

function achievements:_indicateProgress(newValue, oldValue, achvID) -- proto#15 params=4 locals=5 upvalues=0 vararg=false source=7551 lines=194-204
    local req = self.REQ_PROGRESS[achvID]
    if oldValue < newValue then
        local r15_1 = math.floor(oldValue / req * 10)
        local oldScalar = r15_1 / 10
        r15_1 = nil
        local r15_3 = math.floor(newValue / req * 10)
        local newScalar = r15_3 / 10
        r15_3 = nil
        if oldScalar < newScalar then
            self.platformAPI.IndicateAchievementProgress(achvID, newValue, req)
        end
    end
end

function achievements.attemptGetStat(self, id) -- proto#14 params=2 locals=1 upvalues=0 vararg=false source=7551 lines=207-210
    if not self.stats then
        return
    end
    return self.stats[id]
end

function achievements.remove(self) -- proto#13 params=1 locals=0 upvalues=0 vararg=false source=7551 lines=213-214
    table.clear(self.progress)
end

function achievements.getRequiredProgress(self, id) -- proto#12 params=2 locals=1 upvalues=0 vararg=false source=7551 lines=217-218
    return self.REQ_PROGRESS[id]
end

function achievements.canUnlock(self, id) -- proto#11 params=2 locals=2 upvalues=0 vararg=false source=7551 lines=221-222
    local r11_0 = self.progress[id]
    return self.REQ_PROGRESS[id] <= r11_0
end

function achievements.changeProgress(self, id, prog, statID) -- proto#10 params=4 locals=12 upvalues=0 vararg=false source=7551 lines=226-252
    if not id then
        return
    end
    do
        local r10_0 = game.curGametype
        local r10_1 = r10_0
        r10_0 = r10_1.preventAchievements
        if r10_0(r10_1) or mapEditor:isActive() then
            return
        end
        local req = self.REQ_PROGRESS[id]
        local newVal = math.min(self.progress[id] + prog, req)
        self.progress[id] = newVal
        if statID then
            local oldVal = self.stats[statID] or 0
            local r10_5 = self.stats
            local r10_6 = math.max(oldVal, newVal)
            r10_5[statID] = r10_6
            r10_5 = self.platformAPI.SetStat
            r10_6 = nil
            r10_5(statID, newVal)
            self:_indicateProgress(newVal, oldVal, id)
        end
        if req <= newVal then
            self.platformAPI.SetAchievement(id)
            return true
        end
        return false
    end
end

function achievements.setProgress(self, id, prog) -- proto#9 params=3 locals=2 upvalues=0 vararg=false source=7551 lines=255-269
    if not id then
        return
    end
    do
        local req = self.REQ_PROGRESS[id]
        local newVal = math.min(req, prog)
        self.progress[id] = newVal
        if req <= newVal then
            self.platformAPI.SetAchievement(id)
            return true
        end
        return false
    end
end

function achievements.attemptSetAchievement(self, id, skipPrevention) -- proto#8 params=3 locals=0 upvalues=0 vararg=false source=7551 lines=272-292
    if not (id and not mapEditor:isActive()) then
        return
    end
    print("attempt set achv", id)
    if not id then
        print("setting nil achievement in", debug.traceback())
    end
    if not self.platformAPI then
        return
    end
    if game.difficulty and game.difficulty:getPreventsAchievements() and not skipPrevention then
        return
    end
    if not self.unlocked[id] then
        self.platformAPI.SetAchievement(id)
    end
end

function achievements.getProgress(self, id) -- proto#7 params=2 locals=1 upvalues=0 vararg=false source=7551 lines=295-296
    return self.progress[id]
end

function achievements.getAllProgress(self) -- proto#6 params=1 locals=0 upvalues=0 vararg=false source=7551 lines=299-300
    return self.progress
end

function achievements.setAchievements(self, data) -- proto#5 params=2 locals=3 upvalues=0 vararg=false source=7551 lines=303-309
    for i = 1, #data, 2 do
        local id = data[i]
        local achieved = data[i + 1]
        self.unlocked[id] = achieved
    end
end

function achievements.isUnlocked(self, id) -- proto#4 params=2 locals=1 upvalues=0 vararg=false source=7551 lines=312-313
    return self.unlocked[id]
end

function achievements.setAchievement(self, id) -- proto#3 params=2 locals=0 upvalues=0 vararg=false source=7551 lines=316-317
    self.unlocked[id] = true
end

function achievements.save(self) -- proto#2 params=1 locals=1 upvalues=0 vararg=false source=7551 lines=320-323
    return { progress = self.progress }
end

function achievements.load(self, data) -- proto#1 params=2 locals=0 upvalues=0 vararg=false source=7551 lines=326-327
    self.progress = data.progress
end

achievements:init()
