-- file: 39551
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local playthroughRecord = {}
require("game/attack_record")
local bitser = require("engine/bitser")
playthroughRecord.mtindex = { __index = playthroughRecord }
playthroughRecord.FACTS = { USED_SLOMO = 2, USED_WEAPON = 1 }
playthroughRecord.UNLOCKS_BITVALUES = {
    AMMO = 2, LEARNINGPOINTS = 16, MODS = 1, MONEY = 4, WEAPONS = 8
}
playthroughRecord.TRUST = { lossPerPedestrian = 4, max = 100, min = 0 }
playthroughRecord.START_TRUST = 10
playthroughRecord.EVENTS = {
    MONEY_CHANGED = events:new(), WEAPON_BOUGHT = events:new(),
    MOD_UNLOCKED = events:new("loadoutModUnlocked"),
    AMMO_UNLOCKED = events:new("loadoutAmmoUnlocked"),
    PRESET_SAVED = events:new("loadoutPresetSaved"),
    PRESET_CLEARED = events:new("loadoutPresetCleared")
}
playthroughRecord.MONEY_ACHIEVEMENTS = {
    { 25000, achievements.ENUM.MONEYLAUNDERER }, { 65000, achievements.ENUM.BMA },
    { 120000, achievements.ENUM.KINGPIN }
}
setmetatable(playthroughRecord, attackRecord.mtindex)

function game.removePlaythrough() -- proto#133 params=0 locals=1 upvalues=0 vararg=false source=39551 lines=46-53
    if game.playthrough then
        game.playthrough:remove()
        game.playthrough = nil
    end
    game.playerInterLevelData = nil
    game.levelStartData = nil
end

function game.changeTrust(reason, change) -- proto#132 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=56-59
    if game.playthrough then
        game.playthrough:changeTrust(change, reason)
    end
end

function game.setPlaythroughFact(id, state) -- proto#131 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=62-69
    if game.playthrough and not game.playthrough:getPrologueLevel() then
        game.playthrough:setFact(id, state)
    end
end

function game.getPlaythroughFact(id) -- proto#130 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=72-79
    if game.playthrough then
        return game.playthrough:getFact(id)
    end
    return nil
end

function game.setPlaythroughFactTable(varName, factID, state) -- proto#129 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=82-89
    if game.playthrough then
        game.playthrough:setFactTable(varName, factID, state)
    end
end

function game.getPlaythroughFactTable(varName, factID) -- proto#128 params=2 locals=4 upvalues=0 vararg=false source=39551 lines=92-99
    if game.playthrough then
        return game.playthrough:getFactTable(varName, factID)
    end
    return nil
end

function game.setNextSideMission(mapID) -- proto#127 params=1 locals=1 upvalues=0 vararg=false source=39551 lines=102-105
    if game.campaign then
        game.campaign:setSideMissionLevel(mapID)
    end
end

function game.attemptGiveLastLevelLoadout() -- proto#126 params=0 locals=1 upvalues=0 vararg=false source=39551 lines=108-113
    local playthrough = game.playthrough
    if playthrough then
        playthrough:loadFinishLoadout()
    end
end

function game.loadPlaythrough(data) -- proto#125 params=1 locals=2 upvalues=1 vararg=false source=39551 lines=116-121
    game.playthrough = playthroughRecord.new()
    if data then
        game.playthrough:load(data)
    end
end

function game.getWeaponUnlocked(id) -- proto#124 params=1 locals=8 upvalues=0 vararg=false source=39551 lines=124-138
    local overrideState = game.worldObject:getWeaponOverride(id)
    local wepData = weapons:getData(id)
    if wepData then
        if overrideState == true then
            return true
        end
        if overrideState == false then
            return wepData:getIsUnlocked(false)
        end
        return wepData:getIsUnlocked(true)
    end
    return false
end

function game.getModUnlocked(modData, wep) -- proto#123 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=141-142
    return modData:getIsUnlocked(wep, true)
end

function game.hasMoney(amt) -- proto#122 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=145-150
    if game.playthrough then
        return game.playthrough:hasMoney(amt)
    end
    return true
end

function game.getUsesMoney() -- proto#121 params=0 locals=2 upvalues=0 vararg=false source=39551 lines=153-158
    if game.playthrough then
        return game.playthrough:getMoney()
    end
    return false
end

function game.changeMoney(amt, logAsFound, pending) -- proto#120 params=3 locals=4 upvalues=0 vararg=false source=39551 lines=162-174
    if game.playthrough then
        if pending then
            game.playthrough:changePendingMoney(amt)
        else
            game.playthrough:changeMoney(amt)
        end
        if logAsFound then
            game.playthrough:changeMoneyThisLevel(amt)
            game.attackRecord:changeStat(attackRecord.STATS.MONEYFOUND, amt)
        end
    end
end

function game.buyWeaponMod(modID, wep) -- proto#119 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=178-191
    if game.playthrough then
        local modData = weapons.getModData(modID)
        local price = modData:getPrice()
        if game.hasMoney(price) then
            game.playthrough:buyMod(modData, wep)
            return true
        end
        return false
    end
    return false
end

function game.buyAmmoType(ammoID) -- proto#118 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=194-206
    if game.playthrough then
        local ammoData = ammo.getConfig(ammoID)
        if game.hasMoney(ammoData:getPrice()) then
            local r118_1 = game.playthrough
            r118_1:buyAmmoType(ammoID)
            return true
        end
        return false
    end
    return false
end

function game.addModBlueprint(factID) -- proto#117 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=209-213
    if game.playthrough then
        game.playthrough:setFact(factID, true)
        game.playthrough:addModBlueprintFact(factID)
    end
end

function game.getAmmoTypeUnlocked(ammoID) -- proto#116 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=216-221
    if game.playthrough then
        return game.playthrough:isAmmoTypeUnlocked(ammoID)
    end
    return false
end

function playthroughRecord.new() -- proto#115 params=0 locals=1 upvalues=1 vararg=false source=39551 lines=224-229
    local new = {}
    setmetatable(new, playthroughRecord.mtindex)
    new:init()
    return new
end

function playthroughRecord:init() -- proto#114 params=1 locals=18 upvalues=0 vararg=false source=39551 lines=232-290
    attackRecord.init(self)
    self.money = 0
    self.moneyThisLevel = 0
    self.pendingMoney = 0
    self.unlockedModsCounter = 0
    self.playthroughTime = 0
    self.trust = self.START_TRUST
    local r114_0 = {}
    self.unlockedWeapons = r114_0
    r114_0 = {}
    self.unlockedMods = r114_0
    r114_0 = {}
    self.unlockedAmmoTypes = r114_0
    r114_0 = {}
    self.unlockedModBlueprints = r114_0
    r114_0 = {}
    self.playerTypes = r114_0
    r114_0 = {}
    self.learningCap = r114_0
    r114_0 = {}
    self.persistentMapData = r114_0
    r114_0 = {}
    self.finishedObjectives = r114_0
    r114_0 = 1
    for i = r114_0, #playerActor.playerTypes do
        local this = playerActor.playerTypes[i]
        local thisID = this.id
        local r114_4 = playerActor
        local skillsTbl, exp
        skillsTbl, exp = r114_4:initSkills()
        local skillsExpGainLimits = playerActor:initExperienceLimits()
        this:initFirstTimeSkills(skillsTbl)
        local r114_8 = self.playerTypes
        local r114_9 = {
            skills = skillsTbl, experience = exp, experienceLimits = skillsExpGainLimits
        }
        r114_8[thisID] = r114_9
        r114_8 = self.learningCap
        r114_9 = 0
        r114_8[thisID] = r114_9
    end
    local r114_10 = {}
    self.presets = r114_10
    r114_10 = ipairs
    for key, wepData in r114_10(weapons.registered) do
        local presetList = {}
        for i2 = 1, loadoutSelectionMenu.presets do
            local r114_15 = { ammo = nil, mods = {} }
            presetList[i2] = r114_15
        end
        self.presets[wepData.id] = presetList
    end
    r114_10 = {}
    self.difficultyMutators = r114_10
    r114_10 = {}
    self.finishedLevels = r114_10
    r114_10 = nil
    self.lastLevel = r114_10
    local r114_16 = {}
    self.facts = r114_16
    r114_16 = {}
    self.playtime = r114_16
    r114_16 = {}
    self.levelKills = r114_16
    r114_16 = true
    self.loadoutAvailable = r114_16
end

function playthroughRecord.getPlaythroughTime(self) -- proto#113 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=293-294
    return self.playthroughTime
end

function playthroughRecord:setPlaythroughTime(time) -- proto#112 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=297-298
    self.playthroughTime = time
end

function playthroughRecord.changePlaythroughTime(self, time) -- proto#111 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=301-302
    self.playthroughTime = self.playthroughTime + time
end

function playthroughRecord:addModBlueprintFact(fact) -- proto#110 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=305-308
    if not table.find(self.unlockedModBlueprints, fact) then
        table.insert(self.unlockedModBlueprints, fact)
    end
end

function playthroughRecord.verifyModBlueprintFacts(self) -- proto#109 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=311-321
    for key, mod in ipairs(weapons.registeredMods) do
        if mod.unlockFact
            and self.facts[mod.unlockFact]
            and not table.find(self.unlockedModBlueprints, mod.unlockFact) then
            table.insert(self.unlockedModBlueprints, mod.unlockFact)
        end
    end
end

function playthroughRecord.getModBlueprintFacts(self) -- proto#108 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=324-325
    return self.unlockedModBlueprints
end

function playthroughRecord.addFinishedObjective(self, id) -- proto#107 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=328-329
    table.insert(self.finishedObjectives, id)
end

function playthroughRecord.hasFinishedObjective(self, id) -- proto#106 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=332-333
    return table.find(self.finishedObjectives, id)
end

function playthroughRecord.setPersistentMapData(self, mapID, data) -- proto#105 params=3 locals=2 upvalues=1 vararg=false source=39551 lines=336-337
    self.persistentMapData[mapID] = bitser.dumps(data)
end

function playthroughRecord.getPersistentMapData(self, mapID) -- proto#104 params=2 locals=7 upvalues=1 vararg=false source=39551 lines=340-347
    local data = self.persistentMapData[mapID]
    if data then
        return bitser.loads(data)
    end
    error("attempt to get persistent map data of level that was not loaded '" .. mapID .. "'")
end

function playthroughRecord.clearPersistentMapData(self, mapID) -- proto#103 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=350-351
    self.persistentMapData[mapID] = nil
end

function playthroughRecord.getWeaponPresets(self, wepID) -- proto#102 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=354-355
    return self.presets[wepID]
end

function playthroughRecord:getWeaponPreset(wepID, presetID) -- proto#101 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=358-359
    return self.presets[wepID][presetID]
end

function playthroughRecord.saveWeaponPreset(self, wepInst, presetID) -- proto#100 params=3 locals=11 upvalues=1 vararg=false source=39551 lines=362-377
    local wepID = wepInst:getID()
    local mods = wepInst:getMods()
    local modList = {}
    for i = 1, #mods do
        modList[i] = { mods[i]:getID(), mods[i]:getCategory() }
    end
    local presetCfg = self.presets[wepID][presetID]
    presetCfg.mods = modList
    presetCfg.ammo = wepInst:getAmmoType()
    events:fire(playthroughRecord.EVENTS.PRESET_SAVED, wepInst, presetID)
    return presetCfg
end

function playthroughRecord.clearWeaponPreset(self, wepInst, presetID) -- proto#99 params=3 locals=5 upvalues=1 vararg=false source=39551 lines=380-393
    local wepID = wepInst:getID()
    local presetData = self:getWeaponPreset(wepID, presetID)
    local presetModList = presetData.mods
    local validReset = #presetModList > 0 or presetData.ammo
    if #presetModList > 0 then
        table.clearArray(presetModList)
    end
    presetData.ammo = nil
    events:fire(playthroughRecord.EVENTS.PRESET_CLEARED, wepInst, presetID)
    return validReset
end

function playthroughRecord.setTrust(self, value, minToStart) -- proto#98 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=396-397
    self.trust = math.max(value, self.START_TRUST)
end

function playthroughRecord:changeTrust(change, reason) -- proto#97 params=3 locals=7 upvalues=0 vararg=false source=39551 lines=400-407
    local old = self.trust
    self.trust = math.max(self.TRUST.min, math.min(self.TRUST.max, self.trust + change))
    local r97_1 = self.trust
    local trustDiff = r97_1 - old
    if change ~= 0 and reason then
        game.createTrustElement(reason, change)
    end
end

function playthroughRecord.getTrust(self) -- proto#96 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=410-411
    return self.trust
end

function playthroughRecord.unlockStartingMods(self) -- proto#95 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=414-416
    print("todo: playthroughRecord:unlockStartingMods()")
end

function playthroughRecord.changeLearningCapacity(self, playerType, change) -- proto#94 params=3 locals=12 upvalues=0 vararg=false source=39551 lines=419-430
    if playerType then
        self.learningCap[playerType] = math.max(0, self.learningCap[playerType] + change)
    else
        for i = 1, #playerActor.playerTypes do
            local this = playerActor.playerTypes[i].id
            self.learningCap[this] = math.max(0, self.learningCap[this] + change)
        end
    end
    events:fire(playerActor.EVENTS.LEARNING_CAPACITY_CHANGED, game.playerActor, change)
end

function playthroughRecord.getLearningCapacity(self, playerType) -- proto#93 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=433-434
    return self.learningCap[playerType]
end

function playthroughRecord.getExperience(self, playerType) -- proto#92 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=437-438
    return self.playerTypes[playerType].experience
end

function playthroughRecord.getSkills(self, playerType) -- proto#91 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=441-442
    return self.playerTypes[playerType].skills
end

function playthroughRecord.getExperienceLimits(self, playerType) -- proto#90 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=445-446
    return self.playerTypes[playerType].experienceLimits
end

function playthroughRecord.setPrologueLevel(self, state) -- proto#89 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=449-450
    self.prologueLevel = state
end

function playthroughRecord:getPrologueLevel() -- proto#88 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=453-454
    return self.prologueLevel
end

function playthroughRecord:changeMoneyThisLevel(money) -- proto#87 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=457-458
    self.moneyThisLevel = self.moneyThisLevel + money
end

function playthroughRecord.setMoneyThisLevel(self, money) -- proto#86 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=461-462
    self.moneyThisLevel = money
end

function playthroughRecord.getMoneyThisLevel(self) -- proto#85 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=465-466
    return self.moneyThisLevel
end

function playthroughRecord:changePendingMoney(money) -- proto#84 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=469-470
    self.pendingMoney = self.pendingMoney + money
end

function playthroughRecord.getPendingMoney(self) -- proto#83 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=473-474
    return self.pendingMoney
end

function playthroughRecord.transferPendingMoney(self) -- proto#82 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=477-481
    if self.pendingMoney > 0 then
        self:changeMoney(self.pendingMoney)
        self.pendingMoney = 0
    end
end

function playthroughRecord.saveFinishLoadout(self) -- proto#81 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=485-487
    self.lastLevelLoadout = {}
    game.playerActor:saveEquipment(self.lastLevelLoadout)
end

function playthroughRecord:loadFinishLoadout() -- proto#80 params=1 locals=9 upvalues=0 vararg=false source=39551 lines=490-508
    if self.lastLevelLoadout then
        local wepList = self.lastLevelLoadout.weapons
        for i = 1, #wepList do
            local wepData = wepList[i]
            local wepClass = weapons.registeredByID[wepData.id]
            if wepClass.carriesOverLevels then
                game.playerActor:addWeapon(weapons:instantiate(wepData.id), true, false, false)
            end
        end
        game.playerActor:loadArmor(self.lastLevelLoadout, true)
        game.playerActor:postGiveLoadout()
    end
end

function playthroughRecord.getLastLevelLoadout(self) -- proto#79 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=511-512
    return self.lastLevelLoadout
end

function playthroughRecord.unlockAllWeapons(self) -- proto#78 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=515-518
    for key, wepData in ipairs(weapons.registered) do
        table.insert(self.unlockedWeapons, wepData.id)
    end
end

function playthroughRecord.lockAllWeapons(self) -- proto#77 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=521-522
    table.clearArray(self.unlockedWeapons)
end

function playthroughRecord.getUnlockedWeapons(self) -- proto#76 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=525-526
    return self.unlockedWeapons
end

function playthroughRecord.getModUnlocked(self, modData, wep) -- proto#75 params=3 locals=9 upvalues=0 vararg=false source=39551 lines=530-553
    if modData:getUniversalUnlock() then
        return table.find(self.unlockedMods, modData:getID())
    end
    do
        local list = self.unlockedMods
        local modID = modData:getID()
        for i = 1, #list do
            local t = list[i]
            if t.id == modID then
                local wepID = wep:getID()
                for j = 1, #t.weapons do
                    if t.weapons[j] == wepID then
                        return true
                    end
                end
            end
        end
        return false
    end
end

function playthroughRecord:unlockMod(modData, wep) -- proto#74 params=3 locals=18 upvalues=0 vararg=false source=39551 lines=557-594
    if modData:getUniversalUnlock() then
        table.insert(self.unlockedMods, modData:getID())
        self:attemptIncreaseUnlockedModCounter(modData)
        if game.campaign then
            game.campaign:onModUnlocked(modData, wep)
        end
        return
    end
    do
        local list = self.unlockedMods
        local modID = modData:getID()
        for i = 1, #list do
            local t = list[i]
            if type(t) == "table" and t.id == modID then
                table.insert(t.weapons, wep:getID())
                self:attemptIncreaseUnlockedModCounter(modData)
                if game.campaign then
                    game.campaign:onModUnlocked(modData, wep)
                end
                return
            end
        end
        table.insert(list, { id = modID, weapons = { wep:getID() } })
        self:attemptIncreaseUnlockedModCounter(modData)
        if game.campaign then
            game.campaign:onModUnlocked(modData, wep)
        end
        return
    end
end

function playthroughRecord.lockWeaponMods(self) -- proto#73 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=597-598
    table.clearArray(self.unlockedMods)
end

function playthroughRecord.getUnlockedMods(self) -- proto#72 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=601-602
    return self.unlockedMods
end

function playthroughRecord:attemptIncreaseUnlockedModCounter(modData) -- proto#71 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=605-608
    if modData:getCountForAchievement() then
        self:increaseUnlockedModCounter(1)
    end
end

function playthroughRecord:increaseUnlockedModCounter(cnt) -- proto#70 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=611-612
    self.unlockedModsCounter = self.unlockedModsCounter + cnt
end

function playthroughRecord.getTotalUnlockedMods(self) -- proto#69 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=615-616
    return self.unlockedModsCounter
end

function playthroughRecord.buyMod(self, modData, wepData) -- proto#68 params=3 locals=4 upvalues=1 vararg=false source=39551 lines=619-625
    if self.money then
        self:changeMoney(-modData:getPrice())
    end
    self:unlockMod(modData, wepData)
    events:fire(playthroughRecord.EVENTS.MOD_UNLOCKED, modData, wepData)
end

function playthroughRecord:isAmmoTypeUnlocked(ammoID) -- proto#67 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=628-641
    local ammoCfg = ammo.getConfig(ammoID)
    if ammoCfg:isFree() then
        return true
    end
    for i = 1, #self.unlockedAmmoTypes do
        if self.unlockedAmmoTypes[i] == ammoID then
            return true
        end
    end
    return false
end

function playthroughRecord.buyAmmoType(self, ammoID) -- proto#66 params=2 locals=6 upvalues=1 vararg=false source=39551 lines=644-660
    if self.money then
        self:changeMoney(-ammo.getConfig(ammoID):getPrice())
    end
    self:unlockAmmoType(ammoID)
    local allAmmo = true
    if game.campaign and #game.campaign:getUnlockableAmmo() <= #self.unlockedAmmoTypes then
        achievements:attemptSetAchievement(achievements.ENUM.AMMOHOARDER)
    end
    events:fire(playthroughRecord.EVENTS.AMMO_UNLOCKED, ammoID)
end

function playthroughRecord:unlockAmmoType(ammoID) -- proto#65 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=663-664
    table.insert(self.unlockedAmmoTypes, ammoID)
end

function playthroughRecord.lockWeapon(self, weaponID) -- proto#64 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=667-668
    table.removeObject(self.unlockedWeapons, weaponID)
end

function playthroughRecord:addUnlockedWeapon(weaponID, soft) -- proto#63 params=3 locals=9 upvalues=0 vararg=false source=39551 lines=671-709
    if not weapons.registeredByID[weaponID] then
        return
    end
    do
        local wepData = weapons.registeredByID[weaponID]
        if not table.find(self.unlockedWeapons, weaponID) then
            table.insert(self.unlockedWeapons, weaponID)
            if not soft then
                wepData:onUnlocked()
            end
        end
        if soft then
            return
        end
        local unlockedWeapons = true
        local list = game.campaign:getUnlockableWeapons()
        for i = 1, #list do
            local id = list[i].id
            if not table.find(self.unlockedWeapons, id) then
                unlockedWeapons = false
                break
            end
        end
        if unlockedWeapons then
            achievements:attemptSetAchievement(achievements.ENUM.GUNNUT20)
        end
        return
    end
end

function playthroughRecord.getWeaponUnlocked(self, weaponID) -- proto#62 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=712-717
    if UNLOCK_WEAPONS then
        return true
    end
    return table.find(self.unlockedWeapons, weaponID)
end

function playthroughRecord.addFinishedLevel(self, level) -- proto#61 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=720-727
    if not table.find(self.finishedLevels, level) then
        table.insert(self.finishedLevels, level)
        if game.campaign then
            game.campaign:evaluateFullCampaignStatus()
        end
    end
end

function playthroughRecord.hasFinishedLevel(self, level) -- proto#60 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=730-731
    return table.find(self.finishedLevels, level)
end

function playthroughRecord.getFinishedLevels(self) -- proto#59 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=734-735
    return self.finishedLevels
end

function playthroughRecord.setNewGamePlus(self, state) -- proto#58 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=738-739
    self.newGamePlus = state
end

function playthroughRecord.getNewGamePlus(self) -- proto#57 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=742-743
    return self.newGamePlus
end

function playthroughRecord.setLastLevel(self, level) -- proto#56 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=746-747
    self.lastLevel = level
end

function playthroughRecord.getLastLevel(self) -- proto#55 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=750-751
    return self.lastLevel
end

function playthroughRecord:addDifficultyMutator(mutator) -- proto#54 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=754-759
    if table.find(self.difficultyMutators, mutator) then
        return
    end
    table.insert(self.difficultyMutators, mutator)
end

function playthroughRecord.getMutators(self) -- proto#53 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=762-763
    return self.difficultyMutators
end

function playthroughRecord.hasDifficultyMutator(self, id) -- proto#52 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=766-773
    for i = 1, #self.difficultyMutators do
        if self.difficultyMutators[i]:getID() == id then
            return true
        end
    end
    return false
end

function playthroughRecord.fillMutatorsList(self, list) -- proto#51 params=2 locals=6 upvalues=0 vararg=false source=39551 lines=776-781
    local muts = self.difficultyMutators
    for i = 1, #muts do
        table.insert(list, muts[i]:getID())
    end
end

function playthroughRecord:applyDifficultyMutators() -- proto#50 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=784-787
    for key, mutator in ipairs(self.difficultyMutators) do
        mutator:apply()
    end
end

function playthroughRecord.applyStartDifficultyMutators(self) -- proto#49 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=790-793
    for key, mutator in ipairs(self.difficultyMutators) do
        mutator:applyStart()
    end
end

function playthroughRecord.postLoadDifficultyMutators(self) -- proto#48 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=796-799
    for key, mutator in ipairs(self.difficultyMutators) do
        mutator:postLoad()
    end
end

function playthroughRecord:removeDifficultyMutators() -- proto#47 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=802-805
    for key, mutator in ipairs(self.difficultyMutators) do
        mutator:remove()
    end
end

function playthroughRecord:clearDifficultyMutators() -- proto#46 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=808-812
    for key, mutator in ipairs(self.difficultyMutators) do
        mutator:remove()
        self.difficultyMutators[key] = nil
    end
end

function playthroughRecord.transferAttackRecord(self, record) -- proto#45 params=2 locals=21 upvalues=0 vararg=false source=39551 lines=816-856
    local list = attackRecord.registeredStats
    for i = 1, #list do
        local stat = list[i]
        if stat:getCanTransfer() then
            self:changeStat(stat.id, record:getStat(stat.id))
        end
    end
    local npcs = game.worldObject:getNPCs()
    local validNPCs, entireDeadNPCs = 0, 0
    for i2 = 1, #npcs do
        local npcObj = npcs[i2]
        local r45_8 = npcObj:getState()
        local r45_9 = r45_8
        r45_8 = r45_9.getCountKill
        if r45_8(r45_9) and not npcObj:getDiedDuringCutscene() then
            validNPCs = validNPCs + 1
            if npcObj:isDead() then
                entireDeadNPCs = entireDeadNPCs + 1
            end
        end
    end
    local mapID = game.worldObject:getMapID()
    local mapConfig = game.worldObject:getMapConfig()
    local killCount = math.max(entireDeadNPCs, record:getStat(attackRecord.STATS.KILLS))
    if mapConfig and game.worldObject:getTrackKills() then
        table.insert(self.levelKills, { mapID, killCount, validNPCs })
    end
end

function playthroughRecord.getHasKilledEveryone(self) -- proto#44 params=1 locals=7 upvalues=0 vararg=false source=39551 lines=860-879
    local list = self.levelKills
    local totalMaps, totalKilled = 0, 0
    for i = 1, #list do
        local data = list[i]
        local mapData = maps:getData(data[1])
        if mapData and mapData:getTrackKills() then
            totalMaps = totalMaps + 1
            local r44_6 = data[2]
            if data[3] <= r44_6 then
                totalKilled = totalKilled + 1
            end
        end
    end
    return totalKilled == totalMaps
end

function playthroughRecord.getTotalKills(self) -- proto#43 params=1 locals=2 upvalues=0 vararg=false source=39551 lines=882-889
    local totalKilled = 0
    for i = 1, #self.levelKills do
        totalKilled = totalKilled + self.levelKills[i][2]
    end
    return totalKilled
end

function playthroughRecord.getLevelKills(self, levelID) -- proto#42 params=2 locals=2 upvalues=0 vararg=false source=39551 lines=892-899
    for key, data in ipairs(self.levelKills) do
        if data[1] == levelID then
            return data[2], data[3]
        end
    end
    return nil, nil
end

function playthroughRecord:remove() -- proto#41 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=902-903
    self:removeDifficultyMutators()
end

function playthroughRecord.setLoadoutAvailable(self, state) -- proto#40 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=906-907
    self.loadoutAvailable = state
end

function playthroughRecord.getLoadoutAvailable(self) -- proto#39 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=910-911
    return self.loadoutAvailable
end

function playthroughRecord.setStartTime(self, time) -- proto#38 params=2 locals=0 upvalues=0 vararg=false source=39551 lines=914-915
    self.startTime = time
end

function playthroughRecord.getStartTime(self) -- proto#37 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=918-919
    return self.startTime
end

function playthroughRecord.setPlaytime(self, mapID, time) -- proto#36 params=3 locals=0 upvalues=0 vararg=false source=39551 lines=922-923
    self.playtime[mapID] = time
end

function playthroughRecord:setFact(fact, state) -- proto#35 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=926-931
    self.facts[fact] = state
    if game.campaign then
        game.campaign:onPlaythroughFactSet(fact, state)
    end
end

function playthroughRecord:getFact(fact) -- proto#34 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=934-935
    return self.facts[fact]
end

function playthroughRecord:setFactTable(fact, key, state) -- proto#33 params=4 locals=2 upvalues=0 vararg=false source=39551 lines=938-950
    local tbl = self.facts[fact]
    if not tbl then
        tbl = {}
        self.facts[fact] = tbl
    end
    tbl[key] = state
    if game.campaign then
        game.campaign:onPlaythroughFactSet(fact, state, key)
    end
end

function playthroughRecord:getFactTable(fact, key) -- proto#32 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=953-960
    local tbl = self.facts[fact]
    if tbl then
        return tbl[key]
    end
    return nil
end

function playthroughRecord.initMoney(self, amt, pickMax) -- proto#31 params=3 locals=1 upvalues=0 vararg=false source=39551 lines=963-970
    if pickMax then
        self.money = math.max(self.money, amt)
    else
        self.money = amt
    end
    self:verifyMoneyAchievements()
end

function playthroughRecord:getMoney() -- proto#30 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=973-974
    return self.money
end

function playthroughRecord.changeMoney(self, money) -- proto#29 params=2 locals=5 upvalues=1 vararg=false source=39551 lines=977-983
    local new = math.max(0, self.money + money)
    self.money = new
    self:verifyMoneyAchievements()
    events:fire(playthroughRecord.EVENTS.MONEY_CHANGED, money)
end

function playthroughRecord.verifyMoneyAchievements(self) -- proto#28 params=1 locals=4 upvalues=1 vararg=false source=39551 lines=986-993
    local money = self.money
    for key, data in ipairs(playthroughRecord.MONEY_ACHIEVEMENTS) do
        if data[1] <= money then
            achievements:attemptSetAchievement(data[2])
        end
    end
end

function playthroughRecord:hasMoney(amt) -- proto#27 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=996-1001
    if self.money then
        return self.money >= amt
    end
    return true
end

function playthroughRecord.buyWeapon(self, wepData) -- proto#26 params=2 locals=4 upvalues=1 vararg=false source=39551 lines=1004-1008
    self:changeMoney(-wepData:getPrice())
    self:addUnlockedWeapon(wepData:getID())
    events:fire(playthroughRecord.EVENTS.WEAPON_BOUGHT, wepData)
end

function playthroughRecord:savePlayerTypes() -- proto#25 params=1 locals=18 upvalues=0 vararg=false source=39551 lines=1011-1034
    local savedPlyTypes, learningCap = {}, {}
    local plyTypes = self.playerTypes
    for i = 1, #playerActor.playerTypes do
        local this = playerActor.playerTypes[i].id
        local plyType = plyTypes[this]
        local subSkills, subExp, subExpLimits = {}, {}, {}
        savedPlyTypes[this] = {
            skills = subSkills, experience = subExp, experienceLimits = subExpLimits
        }
        learningCap[this] = self.learningCap[this]
        local skillData, expData, expLimitData = plyType.skills, plyType.experience, plyType.experienceLimits
        for j = 1, #playerActor.registeredSkills do
            local thisSkill = playerActor.registeredSkills[j].id
            subSkills[thisSkill] = skillData[thisSkill]
            subExp[thisSkill] = expData[thisSkill]
            subExpLimits[thisSkill] = expLimitData[thisSkill]
        end
    end
    return savedPlyTypes, learningCap
end

function playthroughRecord:savePresets() -- proto#24 params=1 locals=11 upvalues=0 vararg=false source=39551 lines=1037-1057
    local presets = {}
    local presetSrc = self.presets
    for key, wepData in ipairs(weapons.registered) do
        local presetData = presetSrc[wepData.id]
        local weaponPresets = {}
        presets[wepData.id] = weaponPresets
        for i = 1, loadoutSelectionMenu.presets do
            local presetCfg = presetData[i]
            local savedPreset = { mods = {}, ammo = presetCfg.ammo }
            weaponPresets[i] = savedPreset
            for j = 1, #presetCfg.mods do
                savedPreset.mods[j] = presetCfg.mods[j]
            end
        end
    end
    return presets
end

function playthroughRecord:loadPresets(data) -- proto#23 params=2 locals=15 upvalues=0 vararg=false source=39551 lines=1060-1086
    if data then
        local presetDest = self.presets
        for key, wepData in ipairs(weapons.registered) do
            local presetData = data[wepData.id]
            if presetData then
                local weaponPresets = {}
                local ourPresets = presetDest[wepData.id]
                for i = 1, loadoutSelectionMenu.presets do
                    local presetModCfg = ourPresets[i].mods
                    table.clearArray(presetModCfg)
                    local loadedPresetData = presetData[i]
                    local loadedPresetMods = loadedPresetData.mods
                    ourPresets[i].ammo = loadedPresetData.ammo
                    for j = 1, #loadedPresetMods do
                        local modCfg = loadedPresetMods[j]
                        presetModCfg[j] = { modCfg[1], modCfg[2] }
                    end
                end
            end
        end
    end
end

function playthroughRecord:saveUnlockedWeapons() -- proto#22 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=1089-1096
    local dest = {}
    for key, id in ipairs(self.unlockedWeapons) do
        dest[key] = id
    end
    return dest
end

function playthroughRecord:savePersistentMapData() -- proto#21 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=1099-1106
    local dest = {}
    for mapID, data in pairs(self.persistentMapData) do
        dest[mapID] = data
    end
    return dest
end

function playthroughRecord:loadPersistentMapData(data) -- proto#20 params=2 locals=3 upvalues=0 vararg=false source=39551 lines=1109-1114
    local dest = self.persistentMapData
    for mapID, data2 in pairs(data) do
        dest[mapID] = data2
    end
end

function playthroughRecord:saveFinishedObjectives() -- proto#19 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=1117-1124
    local data = {}
    for key, id in ipairs(self.finishedObjectives) do
        data[key] = id
    end
    return data
end

function playthroughRecord:loadFinishedObjectives(data) -- proto#18 params=2 locals=2 upvalues=0 vararg=false source=39551 lines=1127-1132
    table.clearArray(self.finishedObjectives)
    for key, id in ipairs(data) do
        self.finishedObjectives[key] = id
    end
end

function playthroughRecord:saveFacts() -- proto#17 params=1 locals=6 upvalues=0 vararg=false source=39551 lines=1135-1153
    local out = {}
    for factID, factData in pairs(self.facts) do
        if type(factData) == "table" then
            local dest = {}
            for k, v in pairs(factData) do
                dest[k] = v
            end
            out[factID] = dest
        else
            out[factID] = factData
        end
    end
    return out
end

function playthroughRecord:savePlaythroughBlueprints() -- proto#16 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=1156-1163
    local saved = {}
    for key, id in ipairs(self.unlockedModBlueprints) do
        table.insert(saved, id)
    end
    return saved
end

function playthroughRecord.save(self) -- proto#15 params=1 locals=13 upvalues=0 vararg=false source=39551 lines=1166-1209
    local saved = attackRecord.save(self)
    local mutators = {}
    for i = 1, #self.difficultyMutators do
        mutators[i] = self.difficultyMutators[i]:getID()
    end
    saved.presets = self:savePresets()
    saved.trust = self.trust
    saved.facts = self:saveFacts()
    saved.loadoutAvailable = self.loadoutAvailable
    saved.startTime = self.startTime
    saved.finishedLevels = self.finishedLevels
    saved.lastLevel = self.lastLevel
    saved.playtime = self.playtime
    saved.difficultyMutators = mutators
    saved.lastLevelLoadout = self.lastLevelLoadout
    saved.unlockedWeapons = self:saveUnlockedWeapons()
    saved.unlockedMods = self:saveUnlockedMods()
    saved.unlockedAmmoTypes = self:saveUnlockedAmmoTypes()
    saved.moneyThisLevel = self.moneyThisLevel
    saved.pendingMoney = self.pendingMoney
    saved.persistentMapData = self:savePersistentMapData()
    saved.unlockedModBlueprints = self:savePlaythroughBlueprints()
    saved.newGamePlus = self.newGamePlus
    saved.money = self.money
    local r15_3, r15_4 = self:savePlayerTypes()
    saved.learningCap = r15_4
    saved.playerTypes = r15_3
    r15_3 = self.saveFinishedObjectives
    r15_4 = nil
    r15_3 = r15_3(self)
    saved.finishedObjectives = r15_3
    r15_3 = self.playthroughTime
    saved.playthroughTime = r15_3
    local levelKills = {}
    saved.levelKills = levelKills
    for i2 = 1, #self.levelKills do
        local this = self.levelKills[i2]
        local r15_8 = {}
        r15_8[1] = this[1]
        r15_8[2] = this[2]
        local r15_9 = this[3]
        r15_8[3] = r15_9
        levelKills[i2] = r15_8
    end
    return saved
end

function playthroughRecord.saveLight(self) -- proto#14 params=1 locals=5 upvalues=0 vararg=false source=39551 lines=1213-1231
    local playerTypes, learningCap = self:savePlayerTypes()
    return {
        money = self.money, unlockedMods = self:saveUnlockedMods(),
        unlockedAmmoTypes = self:saveUnlockedAmmoTypes(),
        unlockedWeapons = self:saveUnlockedWeapons(), playerTypes = playerTypes,
        learningCap = learningCap, presets = self:savePresets(), trust = self.trust,
        moneyThisLevel = self.moneyThisLevel, pendingMoney = self.pendingMoney,
        finishedObjectives = self:saveFinishedObjectives(),
        unlockedModBlueprints = self:savePlaythroughBlueprints(), facts = self:saveFacts(),
        playthroughTime = self.playthroughTime
    }
end

function playthroughRecord:loadPlayerTypes(data) -- proto#13 params=2 locals=18 upvalues=0 vararg=false source=39551 lines=1234-1266
    local loadPlyTypes = data.playerTypes
    if loadPlyTypes then
        local typeData = self.playerTypes
        for i = 1, #playerActor.playerTypes do
            local this = playerActor.playerTypes[i].id
            local thisType = loadPlyTypes[this]
            local runtimeType = typeData[this]
            if data.learningCap then
                self.learningCap[this] = data.learningCap[this] or self.learningCap[this]
            end
            if runtimeType and thisType then
                local loadSkillsType, loadExpType, loadExpLimitsType = thisType.skills, thisType.experience, thisType.experienceLimits
                local subSkills, subExp, subExpLimits = runtimeType.skills, runtimeType.experience, runtimeType.experienceLimits
                for j = 1, #playerActor.registeredSkills do
                    local thisSkill = playerActor.registeredSkills[j].id
                    subSkills[thisSkill] = loadSkillsType[thisSkill] or subSkills[thisSkill]
                    subExp[thisSkill] = loadExpType[thisSkill] or subExp[thisSkill]
                    if loadExpLimitsType then
                        subExpLimits[thisSkill] = loadExpLimitsType[thisSkill]
                            or subExpLimits[thisSkill]
                    end
                end
            end
        end
    end
end

function playthroughRecord:saveUnlockedMods() -- proto#12 params=1 locals=8 upvalues=0 vararg=false source=39551 lines=1269-1292
    local new = {}
    local data = self.unlockedMods
    if data then
        for i = 1, #data do
            local t = data[i]
            if type(t) == "table" then
                local weps = {}
                local dest = { id = t.id, weapons = weps }
                for j = 1, #t.weapons do
                    weps[j] = t.weapons[j]
                end
                new[i] = dest
            else
                new[i] = data[i]
            end
        end
    end
    return new
end

function playthroughRecord:resetUnlockedMods() -- proto#11 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=1295-1297
    table.clearArray(self.unlockedMods)
    self.unlockedModsCounter = 0
end

function playthroughRecord:verifyBlueprintModAddition(modID) -- proto#10 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=1300-1305
    local modData = weapons.getModData(modID)
    if modData and modData.unlockFact then
        game.addModBlueprint(modData.unlockFact)
    end
end

function playthroughRecord:loadUnlockedMods(data, additive) -- proto#9 params=3 locals=15 upvalues=0 vararg=false source=39551 lines=1308-1384
    if additive then
        if data then
            for i = 1, #data do
                local t = data[i]
                if type(t) == "table" then
                    local dest, weps = nil, nil
                    for key, existingData in ipairs(self.unlockedMods) do
                        if type(existingData) == "table" and existingData.id == t.id then
                            dest = existingData
                            weps = dest.weapons
                            break
                        end
                    end
                    if not dest then
                        weps = {}
                        dest = { id = t.id, weapons = weps }
                    end
                    if #t.weapons > 0 then
                        for j = 1, #t.weapons do
                            local thisWep = t.weapons[j]
                            if not table.find(weps, thisWep) then
                                weps[j] = thisWep
                                self:increaseUnlockedModCounter(1)
                            end
                        end
                        self:verifyBlueprintModAddition(t.id)
                    end
                    self.unlockedMods[i] = dest
                elseif not table.find(self.unlockedMods, t) then
                    self:increaseUnlockedModCounter(1)
                    table.insert(self.unlockedMods, t)
                    self:verifyBlueprintModAddition(t)
                end
            end
        end
        return
    end
    self:resetUnlockedMods()
    if data then
        for i2 = 1, #data do
            local t2 = data[i2]
            if type(t2) == "table" then
                local weps2 = {}
                local dest2 = { id = t2.id, weapons = weps2 }
                self:increaseUnlockedModCounter(#t2.weapons)
                for j2 = 1, #t2.weapons do
                    weps2[j2] = t2.weapons[j2]
                end
                self.unlockedMods[i2] = dest2
                self:verifyBlueprintModAddition(t2.id)
            else
                local id = data[i2]
                self:increaseUnlockedModCounter(1)
                self.unlockedMods[i2] = id
                self:verifyBlueprintModAddition(id)
            end
        end
    end
end

function playthroughRecord:saveUnlockedAmmoTypes() -- proto#8 params=1 locals=3 upvalues=0 vararg=false source=39551 lines=1387-1397
    local new = {}
    local data = self.unlockedAmmoTypes
    if data then
        for i = 1, #data do
            new[i] = data[i]
        end
    end
    return new
end

function playthroughRecord:resetUnlockedAmmo() -- proto#7 params=1 locals=0 upvalues=0 vararg=false source=39551 lines=1400-1401
    table.clearArray(self.unlockedAmmoTypes)
end

function playthroughRecord:loadUnlockedAmmoTypes(data, additive) -- proto#6 params=3 locals=3 upvalues=0 vararg=false source=39551 lines=1404-1425
    if additive then
        if data then
            for i = 1, #data do
                local thisAmmo = data[i]
                if not table.find(self.unlockedAmmoTypes, thisAmmo) then
                    table.insert(self.unlockedAmmoTypes, thisAmmo)
                end
            end
        end
        return
    end
    self:resetUnlockedAmmo()
    if data then
        for i2 = 1, #data do
            self.unlockedAmmoTypes[i2] = data[i2]
        end
    end
end

function playthroughRecord:loadUnlockedWeapons(data) -- proto#5 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=1428-1435
    table.clearArray(self.unlockedWeapons)
    if data.unlockedWeapons then
        for i = 1, #data.unlockedWeapons do
            self.unlockedWeapons[i] = data.unlockedWeapons[i]
        end
    end
end

function playthroughRecord:loadFacts(data) -- proto#4 params=2 locals=6 upvalues=0 vararg=false source=39551 lines=1438-1454
    self.facts = {}
    for factID, factData in pairs(data.facts) do
        if type(factData) == "table" then
            local dest = {}
            for k, v in pairs(factData) do
                dest[k] = v
            end
            self.facts[factID] = dest
        else
            self.facts[factID] = factData
        end
    end
end

function playthroughRecord:loadUnlockedModBlueprints(data, skipClear) -- proto#3 params=3 locals=2 upvalues=0 vararg=false source=39551 lines=1457-1465
    if not skipClear then
        table.clearArray(self.unlockedModBlueprints)
    end
    for key, factID in ipairs(data) do
        self:addModBlueprintFact(factID)
        self:setFact(factID, true)
    end
end

function playthroughRecord:load(data) -- proto#2 params=2 locals=12 upvalues=0 vararg=false source=39551 lines=1468-1531
    attackRecord.load(self, data)
    self:loadFacts(data)
    self.loadoutAvailable = data.loadoutAvailable
    self.startTime = data.startTime
    self.finishedLevels = data.finishedLevels
    self.lastLevel = data.lastLevel
    local r2_0 = data.playtime
    self.playtime = r2_0 or self.playtime
    self.lastLevelLoadout = data.lastLevelLoadout
    r2_0 = data.money
    self.money = r2_0
    r2_0 = data.trust
    self.trust = r2_0 or self.trust
    self.moneyThisLevel = data.moneyThisLevel or self.moneyThisLevel
    self.pendingMoney = data.pendingMoney or self.pendingMoney
    local r2_1 = self
    r2_0 = r2_1.setPlaythroughTime
    local r2_2 = data.playthroughTime
    r2_0(r2_1, r2_2 or self.playthroughTime)
    r2_1 = self
    r2_1:loadUnlockedWeapons(data)
    self:loadUnlockedMods(data.unlockedMods)
    self:loadUnlockedAmmoTypes(data.unlockedAmmoTypes)
    self.newGamePlus = data.newGamePlus
    if data.persistentMapData then
        self:loadPersistentMapData(data.persistentMapData)
    end
    if data.finishedObjectives then
        self:loadFinishedObjectives(data.finishedObjectives)
    end
    if data.presets then
        self:loadPresets(data.presets)
    end
    if data.unlockedModBlueprints then
        self:loadUnlockedModBlueprints(data.unlockedModBlueprints)
    end
    self:loadPlayerTypes(data)
    local levelKills = {}
    for i = 1, #data.levelKills do
        local this = data.levelKills[i]
        local r2_6 = {}
        r2_6[1] = this[1]
        r2_6[2] = this[2]
        local r2_7 = this[3]
        r2_6[3] = r2_7
        levelKills[i] = r2_6
    end
    self.levelKills = levelKills
    self:clearDifficultyMutators()
    if data.difficultyMutators then
        for i2 = 1, #data.difficultyMutators do
            local mutator = game.DIFFICULTY_MUTATORS_BY_ID[data.difficultyMutators[i2]]
            if mutator then
                self:addDifficultyMutator(mutator)
            end
        end
        self:applyDifficultyMutators()
    end
end

function playthroughRecord.loadLight(self, data) -- proto#1 params=2 locals=1 upvalues=0 vararg=false source=39551 lines=1534-1562
    self.money = data.money
    self.trust = data.trust or self.trust
    self.moneyThisLevel = data.moneyThisLevel or self.moneyThisLevel
    self.pendingMoney = data.pendingMoney or self.pendingMoney
    local r1_0 = self
    r1_0:setPlaythroughTime(data.playthroughTime or self.playthroughTime)
    if data.facts then
        self:loadFacts(data)
    end
    if data.finishedObjectives then
        self:loadFinishedObjectives(data.finishedObjectives)
    end
    r1_0 = self
    r1_0:loadUnlockedWeapons(data)
    self:loadUnlockedMods(data.unlockedMods)
    self:loadUnlockedAmmoTypes(data.unlockedAmmoTypes)
    if data.unlockedModBlueprints then
        self:loadUnlockedModBlueprints(data.unlockedModBlueprints)
    end
    self:loadPlayerTypes(data)
    if data.presets then
        self:loadPresets(data.presets)
    end
end

return playthroughRecord
