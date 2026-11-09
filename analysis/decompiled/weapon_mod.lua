-- file: 30759
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local mod = {}
mod.id = "base_weapon_mod"
mod.name = false
mod.nameFull = false
mod.UPDATE = false
mod.EQUIP = false
mod.FIRE = false
mod.PRONE = false
mod.TOOLTIP = false
mod.SAVE = true
mod.valueMods = nil
mod.description = nil
mod.unlockFact = nil
mod.universalUnlock = true
mod.price = 500
mod.hideCrosshair = false
mod.icon = "hud_wep_hs2000_active"
mod.iconInactive = "hud_wep_hs2000_inactive"
local r0_1 = {}
mod.statDescriptions = r0_1
r0_1 = {}
mod.statsByWeight = r0_1
r0_1 = nil
mod.iconFallbackClass = r0_1
mod.useInIconRender = true
mod.countForGunSchizo = true

function mod.init(self) -- proto#78 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=27-29
    self.appliedValues = {}
end

local function _sortMethod(a, b) -- proto#77 params=2 locals=3 upvalues=1 vararg=false source=30759 lines=32-33
    local r77_0 = mod.statDescriptions
    r77_0 = r77_0[a[2].statID].weight
    local r77_1 = mod.statDescriptions
    local r77_2 = b[2].statID
    return r77_1[r77_2].weight <= r77_0
end

local positiveText = {}
local negativeText = {}

function mod.onRegister(self) -- proto#76 params=1 locals=10 upvalues=0 vararg=false source=30759 lines=38-66
    self.priceText = _format2("$${cost}", "cost", string.comma(self.price))
    self._valueModsList = self:getValueModsList()
    local doneText = {}
    self.valueModsText = doneText
    self.valueModsMap = {}
    local negativeOffset = 1
    if self._valueModsList then
        for i = 1, #self._valueModsList do
            local list = self._valueModsList[i]
            for j = 1, #list do
                local this = list[j]
                local statID = this[1]
                self.valueModsMap[statID] = this[2]
                if not weapons.modStatsMap[statID] then
                    table.insert(weapons.modStats, statID)
                    weapons.modStatsMap[statID] = true
                end
            end
        end
    end
end

function mod.getCountForAchievement(self) -- proto#75 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=69-70
    return self.countForGunSchizo
end

function mod.setCategory(self, cat) -- proto#74 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=74-75
    self.category = cat
end

function mod.getCategory(self) -- proto#73 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=78-79
    return self.category
end

function mod.getCanShowInMenu(self, wep, thisCat) -- proto#72 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=84-85
    return true
end

function mod.getUseInIconRender(self) -- proto#71 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=88-89
    return self.useInIconRender
end

function mod.getHideCrosshair(self) -- proto#70 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=92-93
    return self.hideCrosshair
end

function mod.getPrice(self) -- proto#69 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=96-97
    return self.price
end

function mod.getPriceText(self) -- proto#68 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=100-101
    return self.priceText
end

function mod.isFree(self) -- proto#67 params=1 locals=1 upvalues=0 vararg=false source=30759 lines=104-105
    return type(self.price) == "number" and self.price == 0
end

function mod.getVisible(self) -- proto#66 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=108-109

end

function mod.getUnlockFact(self) -- proto#65 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=112-113
    return self.unlockFact
end

function mod.getCanPurchase(self) -- proto#64 params=1 locals=3 upvalues=0 vararg=false source=30759 lines=116-132
    if DEBUG_MODE then
        return true
    end
    if self.unlockFact and game.playthrough then
        if game.playthrough:getFact(self.unlockFact) then
            return true
        end
        return false
    end
    return type(self.price) == "number"
end

function mod.getUniversalUnlock(self) -- proto#63 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=135-136
    return self.universalUnlock
end

function mod.getIsUnlocked(self, wep, fallbackReturn) -- proto#62 params=3 locals=8 upvalues=0 vararg=false source=30759 lines=140-157
    if UNLOCK_WEAPON_MODS then
        return true
    end
    if game.playthrough then
        if DEBUG_MODE then
            return game.playthrough:getModUnlocked(self, wep)
        end
        if self.unlockFact and not game.playthrough:getFact(self.unlockFact) then
            return false
        end
        return game.playthrough:getModUnlocked(self, wep)
    end
    return fallbackReturn
end

function mod:getValueModsList() -- proto#61 params=1 locals=1 upvalues=0 vararg=false source=30759 lines=160-161
    return { self.valueMods }
end

function mod.onSelected(self) -- proto#60 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=164-165

end

function mod.buildText(self, wep, statAdjustMethod, output) -- proto#59 params=4 locals=41 upvalues=4 vararg=false source=30759 lines=171-246
    if self._valueModsList[1] or self.description then
        local list = self._valueModsList[1]
        local doneText
        if output then
            doneText = output
        else
            doneText = {}
        end
        self.valueModsText = doneText
        local negativeOffset = 1
        if list then
            for i = 1, #self._valueModsList do
                local list2 = self._valueModsList[i]
                for j = 1, #list2 do
                    local this = list2[j]
                    local statID = this[1]
                    if not wep or wep[statID] then
                        local statValue = this[2]
                        if wep then
                            statValue = (statAdjustMethod and wep[statAdjustMethod]
                                or wep.adjustModModifier)(wep, self.id, statID, statValue)
                        end
                        local formatData = mod.statDescriptions[statID]
                        if formatData and statValue ~= 0 then
                            local data = { formatData:formatMethod(statValue) }
                            if data[3] then
                                table.insert(positiveText, data)
                            else
                                table.insert(negativeText, data)
                            end
                        end
                    end
                end
            end
            table.sort(positiveText, _sortMethod)
            table.sort(negativeText, _sortMethod)
            negativeOffset = #positiveText + 1
            for k, v in ipairs(positiveText) do
                table.insert(self.valueModsText, { v[1], v[2].positiveColor, true })
                positiveText[k] = nil
            end
            for k2, v2 in ipairs(negativeText) do
                table.insert(self.valueModsText, { v2[1], v2[2].negativeColor, false })
                negativeText[k2] = nil
            end
        end
        if self.description then
            local positiveOffset = 1
            local r59_16 = #self.description
            local negativeOffset2 = negativeOffset
            for i2 = 1, r59_16 do
                local t = self.description[i2]
                if t[2] then
                    local r59_20 = table.insert
                    local r59_21 = self.valueModsText
                    local r59_22 = positiveOffset
                    local r59_23 = { nil, nil, true }
                    r59_23[1] = t[1]
                    local r59_24 = self.genericPositiveColor
                    r59_23[2] = r59_24
                    r59_24 = nil
                    r59_20(r59_21, r59_22, r59_23)
                    negativeOffset2 = negativeOffset2 + 1
                    positiveOffset = positiveOffset + 1
                else
                    local r59_25 = table.insert
                    local r59_26 = self.valueModsText
                    local r59_27 = negativeOffset2
                    local r59_28 = { nil, nil, false }
                    r59_28[1] = t[1]
                    local r59_29 = self.genericNegativeColor
                    r59_28[2] = r59_29
                    r59_29 = nil
                    r59_25(r59_26, r59_27, r59_28)
                    negativeOffset2 = negativeOffset2 + 1
                end
            end
        end
    end
    return output
end

function mod.getValueMods(self) -- proto#58 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=249-250
    return self.valueMods, self.valueModsMap
end

function mod.getDescription(self) -- proto#57 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=253-254
    return self.valueModsText
end

function mod:_grabIcon(cfg, field) -- proto#56 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=257-258
    return cfg and cfg[field]
end

function mod.getModIconData(self, wep) -- proto#55 params=2 locals=4 upvalues=0 vararg=false source=30759 lines=262-267
    if self.iconFallbackClass then
        return wep:getModIcon(self.id) or wep:getModIcon(self.iconFallbackClass)
    end
    return wep:getModIcon(self.id)
end

function mod.getIconHover(self, wep) -- proto#54 params=2 locals=7 upvalues=0 vararg=false source=30759 lines=270-275
    if self.iconFallbackClass then
        local r54_0 = self
        local r54_1 = r54_0._grabIcon
        local r54_2 = wep.getModIcon
        r54_2 = r54_2(wep, self.id) or wep:getModIcon(self.iconFallbackClass)
        return r54_1(r54_0, r54_2, "hover") or self.iconInactive
    end
    return self:_grabIcon(wep:getModIcon(self.id), "hover") or self.iconInactive
end

function mod.getIconInactive(self, wep) -- proto#53 params=2 locals=7 upvalues=0 vararg=false source=30759 lines=278-283
    if self.iconFallbackClass then
        local r53_0 = self
        local r53_1 = r53_0._grabIcon
        local r53_2 = wep.getModIcon
        r53_2 = r53_2(wep, self.id) or wep:getModIcon(self.iconFallbackClass)
        return r53_1(r53_0, r53_2, "idle") or self.iconInactive
    end
    return self:_grabIcon(wep:getModIcon(self.id), "idle") or self.iconInactive
end

function mod.getIcon(self, wep) -- proto#52 params=2 locals=7 upvalues=0 vararg=false source=30759 lines=286-291
    if self.iconFallbackClass then
        local r52_0 = self
        local r52_1 = r52_0._grabIcon
        local r52_2 = wep.getModIcon
        r52_2 = r52_2(wep, self.id) or wep:getModIcon(self.iconFallbackClass)
        return r52_1(r52_0, r52_2, "active") or self.icon
    end
    return self:_grabIcon(wep:getModIcon(self.id), "active") or self.icon
end

function mod.getDisplay(self) -- proto#51 params=1 locals=1 upvalues=0 vararg=false source=30759 lines=294-295
    local r51_0 = self.name
    return r51_0 or self.id
end

function mod.getDisplayFull(self) -- proto#50 params=1 locals=1 upvalues=0 vararg=false source=30759 lines=298-299
    local r50_0 = self.nameFull
    return r50_0 or self.name or self.id
end

function mod.getID(self) -- proto#49 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=302-303
    return self.id
end

function mod:getCanApplyValues(wep, valueList) -- proto#48 params=3 locals=4 upvalues=0 vararg=false source=30759 lines=306-311
    if valueList and valueList.getCanApplyValues then
        return valueList:getCanApplyValues(self, wep)
    end
    return true
end

function mod.onEnableNVG(self, wep) -- proto#47 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=314-315

end

function mod.onDisableNVG(self, wep) -- proto#46 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=318-319

end

local valueListIDCounter = 0

function mod.verifyValueModsID(self, valueList) -- proto#45 params=2 locals=0 upvalues=1 vararg=false source=30759 lines=324-328
    if not valueList._id then
        valueList._id = valueListIDCounter
        valueListIDCounter = valueListIDCounter + 1
    end
end

function mod:getValueModsApplied(valueList) -- proto#44 params=2 locals=1 upvalues=0 vararg=false source=30759 lines=331-334
    self:verifyValueModsID(valueList)
    return self.appliedValues[valueList._id]
end

function mod:setValueModsApplied(valueList, state) -- proto#43 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=337-340
    self:verifyValueModsID(valueList)
    self.appliedValues[valueList._id] = state
end

function mod:applyValues(wep, valueList) -- proto#42 params=3 locals=15 upvalues=0 vararg=false source=30759 lines=343-385
    valueList = valueList or self.valueMods
    if not self:getCanApplyValues(wep, valueList) then
        return
    end
    if valueList and not self:getValueModsApplied(valueList) then
        self:setValueModsApplied(valueList, true)
        local statCfg = self.statDescriptions
        local wepBase = wep:getBase()
        for i = 1, #valueList do
            local data = valueList[i]
            local var = data[1]
            local varData = statCfg[var]
            if wep[var] then
                local mod = wep:adjustModModifier(self.id, var, data[2])
                local operation = data[3]
                if operation then
                    if operation == "+" then
                        wep[var] = wep[var] + mod
                    elseif operation == "/" then
                        wep[var] = wep[var] + (wepBase[var] / mod - wepBase[var])
                    end
                else
                    local aff = 1 + mod
                    wep[var] = wep[var] + (wepBase[var] * aff - wepBase[var])
                end
                if varData then
                    varData:onChangeVariableCallback(wep)
                end
            end
        end
    end
end

function mod:removeValues(wep, valueList) -- proto#41 params=3 locals=15 upvalues=0 vararg=false source=30759 lines=388-426
    valueList = valueList or self.valueMods
    if valueList and self:getValueModsApplied(valueList) then
        self:setValueModsApplied(valueList, false)
        local statCfg = self.statDescriptions
        local wepBase = wep:getBase()
        for i = 1, #valueList do
            local data = valueList[i]
            local var = data[1]
            local varData = statCfg[var]
            if wep[var] then
                local mod = wep:adjustModModifier(self.id, var, data[2])
                local operation = data[3]
                if operation then
                    if operation == "+" then
                        wep[var] = wep[var] - mod
                    elseif operation == "/" then
                        wep[var] = wep[var] - (wepBase[var] / mod - wepBase[var])
                    end
                else
                    local aff = 1 + mod
                    wep[var] = wep[var] - (wepBase[var] * aff - wepBase[var])
                end
                if varData then
                    varData:onChangeVariableCallback(wep)
                end
            end
        end
    end
end

function mod.canInstall(self, wep) -- proto#40 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=429-430
    return true
end

function mod._onAdded(self, wep) -- proto#39 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=433-435
    self:onAdded(wep)
end

function mod:onAdded(wep) -- proto#38 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=438-439

end

function mod._onRemoved(self, wep) -- proto#37 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=442-444
    self:onRemoved(wep)
end

function mod:onRemoved(wep) -- proto#36 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=447-448

end

function mod.getTooltip(self) -- proto#35 params=1 locals=0 upvalues=0 vararg=false source=30759 lines=451-454
    return nil
end

function mod.onSkillChanged(self, wep, skillName) -- proto#34 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=457-458

end

function mod._apply(self, wep, initAdd) -- proto#33 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=461-487
    if self.UPDATE then
        wep:addUpdatedMod(self)
    end
    if self.EQUIP then
        wep:addEquipMod(self)
    end
    if self.FIRE then
        wep:addFireMod(self)
    end
    if self.PRONE then
        wep:addProneMod(self)
    end
    if self.TOOLTIP then
        wep:addTooltipMod(self)
    end
    if self.SKILL_NOTIFY then
        wep:addSkillNotifyMod(self)
    end
    self:applyValues(wep)
    self:apply(wep, initAdd)
end

function mod:apply(wep, initAdd) -- proto#32 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=490-491

end

function mod._remove(self, wep) -- proto#31 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=494-520
    if self.UPDATE then
        wep:removeUpdatedMod(self)
    end
    if self.EQUIP then
        wep:removeEquipMod(self)
    end
    if self.FIRE then
        wep:removeFireMod(self)
    end
    if self.PRONE then
        wep:removeProneMod(self)
    end
    if self.TOOLTIP then
        wep:removeTooltipMod(self)
    end
    if self.SKILL_NOTIFY then
        wep:removeSkillNotifyMod(self)
    end
    self:removeValues(wep)
    self:remove(wep)
end

function mod.onWeaponEquipped(self, wep) -- proto#30 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=523-524

end

function mod:remove(wep) -- proto#29 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=527-528

end

function mod.adjustSpread(self, wep) -- proto#28 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=531-532

end

function mod.onSwitchFiremode(self, wep) -- proto#27 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=535-536

end

function mod.onFire(self, wep) -- proto#26 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=539-540

end

function mod.onProne(self, wep) -- proto#25 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=543-544

end

function mod.onProneEnd(self, wep) -- proto#24 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=547-548

end

function mod.update(self, dt, wep) -- proto#23 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=551-552

end

function mod.save(self, wep) -- proto#22 params=2 locals=1 upvalues=0 vararg=false source=30759 lines=555-558
    return { id = self.id }
end

function mod.load(self, wep, data) -- proto#21 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=561-562

end

local function _doFormatText(text, value) -- proto#20 params=2 locals=4 upvalues=0 vararg=false source=30759 lines=565-566
    return _format2(text, "statFormat", value)
end

local function _formatStatRegular(formatData, modifier) -- proto#19 params=2 locals=8 upvalues=1 vararg=false source=30759 lines=576-583
    local abs = math.round(math.abs(modifier * formatData.valueMultiplier), 1)
    if modifier > 0 then
        return _doFormatText(formatData.formatTextPositive, abs), formatData, true
    end
    return _doFormatText(formatData.formatTextNegative, abs), formatData, false
end

local function _formatStatInverted(formatData, modifier) -- proto#18 params=2 locals=8 upvalues=1 vararg=false source=30759 lines=586-593
    local abs = math.round(math.abs(modifier * formatData.valueMultiplier), 1)
    if modifier > 0 then
        return _doFormatText(formatData.formatTextNegative, abs), formatData, false
    end
    return _doFormatText(formatData.formatTextPositive, abs), formatData, true
end

mod.genericPositiveColor = game.UI_COLORS.COMPARE_BETTER
mod.genericNegativeColor = game.UI_COLORS.COMPARE_WORSE

local function defaultStatFormatMethod(val, wepInst, isBase) -- proto#17 params=3 locals=2 upvalues=0 vararg=false source=30759 lines=599-600
    return math.round(val, 1)
end

local function genericMeterRadiusMethod(val, wepInst, isBase) -- proto#16 params=3 locals=5 upvalues=0 vararg=false source=30759 lines=603-604
    return _format2(_T("WEAPON_STAT_RADIUS_METERS", "${radius} M"), "radius",
        math.round(val / weapons.PIXEL_TO_MS))
end

local function genericMetersMethod(val, wepInst, isBase) -- proto#15 params=3 locals=5 upvalues=0 vararg=false source=30759 lines=607-608
    return _format2(_T("WEAPON_STAT_RADIUS_METERS_SECOND", "${speed} M/s"), "speed",
        math.round(val / weapons.PIXEL_TO_MS * 4))
end

local function genericPercentageMethod(val, wepInst, isBase) -- proto#14 params=3 locals=4 upvalues=0 vararg=false source=30759 lines=611-612
    return _format2(_T("WEAPON_STAT_PERCENTAGE", "+${value}%"), "value", math.round(val * 100, 1))
end

local function genericUnsignedPercentageMethod(val, wepInst, isBase) -- proto#13 params=3 locals=4 upvalues=0 vararg=false source=30759 lines=615-616
    return _format2(_T("WEAPON_STAT_PERCENTAGE_NO_SIGN", "${value}%"), "value",
        math.round(val * 100, 1))
end

local function genericDegreesMethod(val, wepInst, isBase) -- proto#12 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=619-620
    return _format2(_T("WEAPON_STAT_DEGREES", "${value}°"), "value", math.round(val, 2))
end

local function genericMultiplierMethod(val, wepInst, isBase) -- proto#11 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=623-624
    return _format2(_T("WEAPON_STAT_MULTIPLIER", "X${value}"), "value", math.round(val, 2))
end

local function dummy_onChangeVariableCallback(self, wep) -- proto#10 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=627-628

end

function mod.addStatDisplay(self, weight, statID, formatTextPositive, formatTextNegative,
    statDisplay, invertFormatting, positiveColor, negativeColor, valueMultiplier, formatMethod,
    onChangeVariableCallback) -- proto#9 params=12 locals=4 upvalues=4 vararg=false source=30759 lines=642-672
    if statDisplay and not statDisplay[2] then
        statDisplay[2] = defaultStatFormatMethod
    end
    local statData = {
        weight = weight, statID = statID, formatTextPositive = formatTextPositive,
        formatTextNegative = formatTextNegative, statDisplay = statDisplay,
        valueMultiplier = valueMultiplier or 100,
        formatMethod = formatMethod
            or invertFormatting and _formatStatInverted
            or _formatStatRegular,
        positiveColor = positiveColor or self.genericPositiveColor,
        negativeColor = negativeColor or self.genericNegativeColor,
        onChangeVariableCallback = onChangeVariableCallback or dummy_onChangeVariableCallback
    }
    self.statDescriptions[statID] = statData
    local insertIdx = 1
    for i = 1, #self.statsByWeight do
        local this = self.statsByWeight[i]
        if this.weight >= weight then
            insertIdx = i + 1
        end
    end
    table.insert(self.statsByWeight, insertIdx, statData)
end

local r0_17 = mod
local r0_18, r0_19, r0_20 = r0_17.addStatDisplay, 100, "damage"
local r0_21 = _T("WEAPON_MOD_DAMAGE_POSITIVE", "+${statFormat}% damage per shot")
local r0_22 = _T("WEAPON_MOD_DAMAGE_NEGATIVE", "-${statFormat}% damage per shot")
local r0_23 = { nil, nil, true }
local r0_24 = _T("STAT_TOTAL_DAMAGE", "Total damage")
r0_23[1] = r0_24

function r0_24(val, wepInst, isBase) -- proto#8 params=3 locals=3 upvalues=0 vararg=false source=30759 lines=685-685
    return math.round(val * (isBase and wepInst:getBase():getShots() or wepInst:getShots())
            * game.difficulty.damageMult,
        1)
end

r0_23[2] = r0_24
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_23)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 99.5
r0_20 = "armorPenetration"
r0_21 = _T
r0_23 = "WEAPON_MOD_PENETRATION_POSITIVE"
r0_24 = "+${statFormat} penetration rating"
r0_21 = r0_21(r0_23, r0_24)
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_PENETRATION_NEGATIVE", "-${statFormat} penetration rating")
local r0_25 = { nil, nil, true }
local r0_26 = _T("STAT_PENETRATION_RATING", "Penetration rating")
r0_25[1] = r0_26

function r0_26(val, wepInst, isBase) -- proto#7 params=3 locals=0 upvalues=0 vararg=false source=30759 lines=692-692
    return val
end

r0_25[2] = r0_26
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, nil, nil, nil, 1)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 99
r0_20 = "bulletSpeed"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_BULLET_SPEED_POSITIVE", "+${statFormat}% bullet speed")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_BULLET_SPEED_NEGATIVE", "-${statFormat}% bullet speed")
r0_25 = { nil, nil, true }
local r0_27 = _T("WEAPON_STAT_BULLET_SPEED", "Bullet speed")
r0_25[1] = r0_27
r0_25[2] = genericMetersMethod
r0_27 = nil
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 98
r0_20 = "shotDelay"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_RATE_OF_FIRE_POSITIVE", "+${statFormat}% rate of fire")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_RATE_OF_FIRE_NEGATIVE", "-${statFormat}% rate of fire")
r0_25 = { nil, nil, false }
local r0_28 = _T("STAT_RATE_OF_FIRE", "Rate of Fire")
r0_25[1] = r0_28

function r0_28(val) -- proto#6 params=1 locals=1 upvalues=0 vararg=false source=30759 lines=710-710
    return math.round(60 / val)
end

r0_25[2] = r0_28
r0_28 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_28, nil, nil, nil, nil,
    function(self, wep) -- proto#5 params=2 locals=0 upvalues=0 vararg=false source=30759 lines=716-717
        wep:doShotDelayToROF()
    end)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 97
r0_20 = "magSize"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_MAGAZINE_CAPACITY_POSITIVE", "+${statFormat} mag capacity")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_MAGAZINE_CAPACITY_NEGATIVE", "-${statFormat} mag capacity")
r0_25 = { nil, nil, true }
local r0_29 = _T("STAT_MAGAZINE_CAPACITY", "Magazine capacity")
r0_25[1] = r0_29
local r0_30, r0_31
r0_29 = nil
r0_30 = nil
r0_31 = nil
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_29, r0_30, r0_31, 1)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 96
r0_20 = "reloadSpeedMultiplier"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_RELOAD_SPEED_POSITIVE", "+${statFormat}% reload speed")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_RELOAD_SPEED_NEGATIVE", "-${statFormat}% reload speed")
r0_25 = { nil, nil, false }
local r0_32 = _T("STAT_RELOAD_SPEED", "Reload speed")
r0_25[1] = r0_32

function r0_32(val) -- proto#4 params=1 locals=4 upvalues=0 vararg=false source=30759 lines=736-736
    return _format2(_T("WEAPON_STAT_PERCENTAGE_SIMPLE", "${value}%"), "value",
        math.round((1 + (1 - val)) * 100, 1))
end

r0_25[2] = r0_32
r0_32 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_32)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 90
r0_20 = "spread"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_ACCURACY_POSITIVE", "+${statFormat}% max accuracy")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_ACCURACY_NEGATIVE", "-${statFormat}% max accuracy")
r0_25 = { nil, nil, false }
local r0_33 = _T("STAT_ACCURACY", "Accuracy")
r0_25[1] = r0_33
r0_25[2] = genericDegreesMethod
r0_33 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_33)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 89.9
r0_20 = "shotDeviation"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_SHOT_DEVIATION_POSITIVE", "-${statFormat}% shot deviation")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_SHOT_DEVIATION_NEGATIVE", "+${statFormat}% shot deviation")
r0_25 = { nil, nil, false }
local r0_34 = _T("STAT_SHOT_DEVIATION", "Shot deviation")
r0_25[1] = r0_34
r0_25[2] = genericDegreesMethod
r0_34 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_34)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 89.8
r0_20 = "spreadDecrease"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_ACCURACY_RECOVERY_POSITIVE", "+${statFormat}% accuracy recovery")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_ACCURACY_RECOVERY_NEGATIVE", "-${statFormat}% accuracy recovery")
r0_25 = { nil, nil, true }
local r0_35 = _T("STAT_ACCURACY_RECOVERY", "Accuracy recovery")
r0_25[1] = r0_35

function r0_35(val, wepInst, isBase) -- proto#3 params=3 locals=4 upvalues=0 vararg=false source=30759 lines=763-764
    return _format2(_T("WEAPON_STAT_ACCURACY_RECOVERY_DISPLAY", "${value}X"), "value",
        math.round(val / 20, 2))
end

r0_25[2] = r0_35
r0_35 = nil
r0_30 = nil
r0_31 = nil
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_35, r0_30, r0_31)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 89.5
r0_20 = "cameraZoomMultAim"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_ZOOM_POSITIVE", "+${statFormat}% aim zoom")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_ZOOM_NEGATIVE", "-${statFormat}% aim zoom")
r0_25 = { nil, nil, true }
local r0_36 = _T("STAT_ZOOM_RANGE", "Aim zoom range")
r0_25[1] = r0_36
r0_25[2] = genericUnsignedPercentageMethod
r0_36 = false
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_36)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 89
r0_20 = "clumpSpread"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_PELLET_GROUP_POSITIVE", "-${statFormat}% pellet group spread")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_PELLET_GROUP_NEGATIVE", "+${statFormat}% pellet group spread")
r0_25 = { nil, nil, false }
local r0_37 = _T("WEAPON_STAT_PELLET_GROUP", "Pellet group spread")
r0_25[1] = r0_37
r0_25[2] = genericDegreesMethod
r0_37 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_37)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 88
r0_20 = "spreadPerShot"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_SPS_POSITIVE", "-${statFormat}% spread-per-shot")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_SPS_NEGATIVE", "+${statFormat}% spread-per-shot")
r0_25 = { nil, nil, false }
local r0_38 = _T("STAT_SPREAD_PER_SHOT", "Spread-per-shot")
r0_25[1] = r0_38
r0_25[2] = genericDegreesMethod
r0_38 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_38)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 87
r0_20 = "spreadPerShotMultiplier"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_CONTROLLABILITY_POSITIVE", "+${statFormat}% controllability")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_CONTROLLABILITY_NEGATIVE", "-${statFormat}% controllability")
r0_25 = { nil, nil, false }
local r0_39 = _T("STAT_CONTROLLABILITY", "Controllability")
r0_25[1] = r0_39

function r0_39(val) -- proto#2 params=1 locals=4 upvalues=0 vararg=false source=30759 lines=799-799
    return _format2(_T("PERCENTAGE_VALUE", "${value}%"), "value", math.round(2.8 / val * 100))
end

r0_25[2] = r0_39
r0_39 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_39)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 86
r0_20 = "maxSpreadIncrease"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_MAX_SPREAD_INCREASE_POSITIVE", "-${statFormat}% max additive spread")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_MAX_SPREAD_INCREASE_NEGATIVE", "+${statFormat}% max additive spread")
r0_25 = {}
local r0_40 = _T("STAT_MAX_SPREAD_INCREASE", "Max additive spread")
r0_25[1] = r0_40
r0_25[2] = genericDegreesMethod
r0_40 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_40)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 85
r0_20 = "lookSpreadAngleMultiplier"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_TURN_ACCURACY_POSITIVE", "-${statFormat}% turn accuracy instability")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_TURN_ACCURACY_NEGATIVE", "+${statFormat}% turn accuracy instability")
r0_25 = { nil, nil, false }
local r0_41 = _T("STAT_TURN_ACCURACY_INSTABILITY", "Turn accuracy instability")
r0_25[1] = r0_41
r0_25[2] = genericMultiplierMethod
r0_41 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_41)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 84
r0_20 = "lookSpreadMax"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_TURN_PENALTY_POSITIVE", "-${statFormat}% max turn spread")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_TURN_PENALTY_NEGATIVE", "+${statFormat}% max turn spread")
r0_25 = { nil, nil, false }
local r0_42 = _T("STAT_MAX_TURN_SPREAD", "Max turn spread")
r0_25[1] = r0_42
r0_25[2] = genericDegreesMethod
r0_42 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25, r0_42)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 83
r0_20 = "spreadVelocityIncrease"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_MOBILITY_POSITIVE", "+${statFormat}% mobile accuracy")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_MOBILITY_NEGATIVE", "-${statFormat}% mobile accuracy")
r0_25 = { nil, nil, true }
local r0_43 = _T("STAT_MOBILE_ACCURACY", "Mobile accuracy")
r0_25[1] = r0_43

function r0_43(val, wep, isBase) -- proto#1 params=3 locals=5 upvalues=0 vararg=false source=30759 lines=831-831
    return _format2(_T("PERCENTAGE_VALUE", "${value}%"), "value",
        math.round(val / weapons.maxSpreadVelocityIncrease * 100, 1))
end

r0_25[2] = r0_43
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_25)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 82.5
r0_20 = "focusSpread"
r0_21 = _T
r0_25 = "WEAPON_MOD_FOCUS_ACCURACY_POSITIVE"
r0_43 = "+${statFormat}% focus accuracy"
r0_21 = r0_21(r0_25, r0_43)
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_FOCUS_ACCURACY_NEGATIVE", "-${statFormat}% focus accuracy")
local r0_44 = { nil, nil, true }
local r0_45 = _T("STAT_FOCUS_ACCURACY_BOOST", "Focus accuracy boost")
r0_44[1] = r0_45
r0_44[2] = genericDegreesMethod
r0_45 = false
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_44, r0_45)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 82
r0_20 = "focusSpreadSpeed"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_FOCUS_SPEED_POSITIVE", "${statFormat}% faster focus speed")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_FOCUS_SPEED_NEGATIVE", "${statFormat}% slower focus speed")
r0_44 = { nil, nil, true }
local r0_46 = _T("STAT_FOCUS_ACCURACY_SPEED", "Focus accuracy speed")
r0_44[1] = r0_46
r0_44[2] = genericMultiplierMethod
r0_46 = nil
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_44)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 80
r0_20 = "noiseRadius"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_SHOTNOISE_POSITIVE", "-${statFormat}% shot noise")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_SHOTNOISE_NEGATIVE", "+${statFormat}% shot noise")
r0_44 = { nil, nil, false }
local r0_47 = _T("STAT_NOISE_RADIUS", "Shot noise")
r0_44[1] = r0_47
r0_44[2] = genericMeterRadiusMethod
r0_47 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_44, r0_47)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 79
r0_20 = "noiseChange"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_MOVENOISE_POSITIVE", "-${statFormat}% movement noise")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_MOVENOISE_NEGATIVE", "+${statFormat}% movement noise")
r0_44 = { nil, nil, false }
local r0_48 = _T("STAT_NOISE_CHANGE_FULL", "Noise increase (holstered)")
r0_44[1] = r0_48
r0_44[2] = genericPercentageMethod
r0_48 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_44, r0_48)
r0_17 = mod
r0_18 = r0_17.addStatDisplay
r0_19 = 78
r0_20 = "slowdown"
r0_21 = _T
r0_21 = r0_21("WEAPON_MOD_SLOWDOWN_POSITIVE", "-${statFormat}% movement speed penalty")
r0_22 = _T
r0_22 = r0_22("WEAPON_MOD_SLOWDOWN_NEGATIVE", "+${statFormat}% movement speed penalty")
r0_44 = { nil, nil, false }
local r0_49 = _T("STAT_SLOWDOWN", "Slowdown")
r0_44[1] = r0_49
r0_44[2] = genericPercentageMethod
r0_49 = true
r0_18(r0_17, r0_19, r0_20, r0_21, r0_22, r0_44, r0_49)
weapons.registerWeaponMod(mod)
require("game/weapons/weapon_attachments/burst_trigger_group")
require("game/weapons/weapon_attachments/auto_trigger_group")
require("game/weapons/weapon_attachments/laser_pointer")
require("game/weapons/weapon_attachments/reflex_sight")
require("game/weapons/weapon_attachments/reflex_sight_pistol")
require("game/weapons/weapon_attachments/glow_sights")
require("game/weapons/weapon_attachments/match_barrel")
require("game/weapons/weapon_attachments/threaded_barrel")
require("game/weapons/weapon_attachments/threaded_match_barrel")
require("game/weapons/weapon_attachments/suppressor_pistol")
require("game/weapons/weapon_attachments/suppressor_pistol_manual")
require("game/weapons/weapon_attachments/suppressor_pistol_lp")
require("game/weapons/weapon_attachments/heavy_spring")
require("game/weapons/weapon_attachments/light_spring")
require("game/weapons/weapon_attachments/improved_trigger")
require("game/weapons/weapon_attachments/flared_magwell")
require("game/weapons/weapon_attachments/choke")
require("game/weapons/weapon_attachments/duckbill")
require("game/weapons/weapon_attachments/foregrip")
require("game/weapons/weapon_attachments/compensator")
require("game/weapons/weapon_attachments/extended_barrel")
require("game/weapons/weapon_attachments/customfit_stock")
require("game/weapons/weapon_attachments/lightweight_stock")
require("game/weapons/weapon_attachments/extended_magazine")
require("game/weapons/weapon_attachments/smaller_magazine")
require("game/weapons/weapon_attachments/suppressor_nonpistol")
require("game/weapons/weapon_attachments/comfort_grip")
require("game/weapons/weapon_attachments/scope_2x")
require("game/weapons/weapon_attachments/scope_4x")
require("game/weapons/weapon_attachments/drum_magazine")
require("game/weapons/weapon_attachments/laser_pointer_ir")
require("game/weapons/weapon_attachments/burst_trigger_group_var2")
require("game/weapons/weapon_attachments/burst_trigger_group_var3")
require("game/weapons/weapon_attachments/binary_trigger")
require("game/weapons/weapon_attachments/improved_barrel")
require("game/weapons/weapon_attachments/vp9_improved_barrel")
require("game/weapons/weapon_attachments/improved_bolt")
require("game/weapons/weapon_attachments/10mm_magazine")
require("game/weapons/weapon_attachments/9mm_magazine")
require("game/weapons/weapon_attachments/45acp_magazine")
require("game/weapons/weapon_attachments/doubleshot_trigger_group")
require("game/weapons/weapon_attachments/ml_rslug")
require("game/weapons/weapon_attachments/ml_gas")
require("game/weapons/weapon_attachments/ml_tazer")
require("game/weapons/weapon_attachments/ml_empslug")
r0_18 = weapons
r0_17 = {}
local r0_50 = { header = nil, mods = nil }
local r0_51 = weapons
r0_21 = "getModHeader"
local r0_52 = r0_51[r0_21]
r0_22 = "sight"
r0_52 = r0_52(r0_22)
r0_50.header = r0_52
r0_52 = { "glow_sights", "reflex_sight_pistol" }
r0_50.mods = r0_52
r0_17[1] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("barrel_type")
r0_50.header = r0_52
r0_52 = { "threaded_barrel", "match_barrel", "threaded_match_barrel" }
r0_50.mods = r0_52
r0_17[2] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("barrel")
r0_50.header = r0_52
r0_52 = { "compensator", "suppressor_pistol_lp", "suppressor_pistol", "suppressor_pistol_manual" }
r0_50.mods = r0_52
r0_17[3] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("trigger")
r0_50.header = r0_52
r0_52 = { "improved_trigger", "binary_trigger" }
r0_50.mods = r0_52
r0_17[4] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("trigger_group")
r0_50.header = r0_52
r0_52 = { "burst_trigger_group" }
r0_50.mods = r0_52
r0_17[5] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("magwell")
r0_50.header = r0_52
r0_52 = { "flared_magwell" }
r0_50.mods = r0_52
r0_17[6] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("magazine")
r0_50.header = r0_52
r0_52 = { "extended_magazine", "smaller_magazine" }
r0_50.mods = r0_52
r0_17[7] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("bottom_rail")
r0_50.header = r0_52
r0_52 = { "laser_pointer", "laser_pointer_ir" }
r0_50.mods = r0_52
r0_17[8] = r0_50
r0_50 = { header = nil, mods = nil }
r0_52 = weapons
r0_52 = r0_52.getModHeader
r0_52 = r0_52("grip")
r0_50.header = r0_52
r0_52 = { "comfort_grip" }
r0_50.mods = r0_52
r0_17[9] = r0_50
r0_18.genericPistolMods = r0_17
local genericBarrelRequirement = { { "threaded_barrel", "threaded_match_barrel" } }
local r0_54 = weapons
r0_17 = "genericPistolModRequirements"
r0_50 = {
    burst_trigger_group = nil, compensator = nil, suppressor_pistol = nil,
    suppressor_pistol_lp = nil, suppressor_pistol_manual = nil
}
r0_52 = "suppressor_pistol"
r0_50[r0_52] = genericBarrelRequirement
r0_50.suppressor_pistol_lp = genericBarrelRequirement
r0_50.suppressor_pistol_manual = genericBarrelRequirement
local r0_55 = { "improved_trigger" }
r0_50.burst_trigger_group = r0_55
r0_55 = "compensator"
r0_50[r0_55] = genericBarrelRequirement
r0_54[r0_17] = r0_50
local r0_56 = weapons
r0_17 = "genericPistolModConflicts"
r0_50 = { binary_trigger = nil, suppressor_pistol_manual = nil }
local r0_57 = { "burst_trigger_group", "suppressor_pistol_manual" }
r0_50.binary_trigger = r0_57
r0_57 = {
    "burst_trigger_group", "burst_trigger_group_var2", "burst_trigger_group_var3",
    "auto_trigger_group", "binary_trigger"
}
r0_50.suppressor_pistol_manual = r0_57
r0_56[r0_17] = r0_50
