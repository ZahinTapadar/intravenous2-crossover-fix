HERE = (arg[0] and string.match(arg[0], "(.-)[^/]+$") or "")
-- Offline harness: loads the shadowing cheat overlay + the game's own orig
-- bytecode under stubbed engine globals and asserts the cheat semantics.
local installed = {}
local calls = { ach = {} }

local function stubRequire(name)
	if name == "game/attack_record" then
		return {
			mtindex = { __index = {} }, init = function() end,
			STATS = {}, registeredStats = {}, save = function() end, load = function() end,
		}
	elseif name == "engine/bitser" then
		return { dumps = function() return "" end, loads = function() return {} end }
	elseif name == "game/playthrough_record_orig" then
		local f = assert(loadfile(HERE .. "cheats/playthrough_record_orig.lua"))
		installed.orig_chunk_executed = true
		return f()
	end
	error("stub require: " .. tostring(name))
end

events = { new = function(name) return {} end, fire = function(self) end }
attackRecord = { mtindex = { __index = {} }, init = function() end, STATS = {}, registeredStats = {}, save = function() end, load = function() end }
achievements = {
	ENUM = { MONEYLAUNDERER = true, BMA = true, KINGPIN = true },
	platformAPI = { SetAchievement = function(self, id) calls.ach[#calls.ach+1] = id end,
					SetStat = function() end, IndicateAchievementProgress = function() end },
	stats = {}, unlocked = {}, progress = {},
}
weapons = { registered = {}, registeredMods = {}, registeredByID = {} }
loadoutSelectionMenu = { presets = 3 }
playerActor = { playerTypes = {}, registeredSkills = {} }
game = {}
mapEditor = { isActive = function() return false end }
require = stubRequire
table.clearArray = function(t) t[#t] = nil end -- never called in exercised paths

local liveSetAch = achievements.platformAPI.SetAchievement
local liveAttempt = nil

local rec = assert(loadfile(HERE .. "cheats/playthrough_record.lua"))()

assert(installed.orig_chunk_executed, "orig module chunk did not execute")
assert(type(rec) == "table" and type(rec.new) == "function", "overlay did not return the class table")

-- 1) weapon unlock flags equal to what --allweaponsunlocked sets
assert(_G.UNLOCK_WEAPONS == true and _G.UNLOCK_WEAPON_MODS == true, "unlock flags missing")

-- 2) achievements bridge neutralized
assert(achievements.platformAPI.SetAchievement ~= liveSetAch, "SetAchievement not blocked")
achievements.platformAPI.SetAchievement(achievements, "SOME_ACH")
assert(#calls.ach == 0, "ach call leaked " .. tostring(#calls.ach))
rec.attemptSetAchievement = achievements.attemptSetAchievement -- (ach module has own)

-- 3) money flow on an instance
local inst = rec.new()
assert(inst.money == 0, "init money expected 0, got " .. tostring(inst.money))
assert(inst:hasMoney(1e15) == true, "hasMoney must always pass")
inst:changeMoney(-670)           -- e.g. buy a mod priced 670
assert(inst.money == 9999999, "spend refill expected 9999999, got " .. tostring(inst.money))
inst:changeMoney(25000.0)        -- pickups are added on top
assert(inst.money == 10024999, "pickup after refill expected 10024999, got " .. tostring(inst.money))
inst:changeMoney(-3)             -- next spend pulls back up, not lower
assert(inst.money >= 9999999, "second spend refill failed: " .. tostring(inst.money))

-- ensure achievements attempts from money milestones are no-ops
inst.money = 150000
rec.verifyMoneyAchievements(inst)
assert(#calls.ach == 0, "money achievement leaked")

print("ALL CHEAT HARNESS TESTS PASSED")
