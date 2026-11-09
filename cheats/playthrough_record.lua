-- Intravenous 2 cheat overlay (savedir override for game/playthrough_record.lua)
-- Recreated 2026-11-09. The game loads files from the save folder ahead of the
-- packed game, so this shadows the bundled playthrough_record.lua module.
-- playthrough_record_orig.lua beside this file is a byte-exact copy of the
-- game's own module (extracted from intravenous2.exe), loaded below and modified
-- in place - no game files are touched.
local CHEAT_MONEY = 9999999      -- balance is refilled to this after every spend
local BLOCK_ACHIEVEMENTS = true  -- set to false to allow Steam achievements again

-- Same flags the hidden launch option --allweaponsunlocked sets in main.lua.
rawset(_G, "UNLOCK_WEAPONS", true)
rawset(_G, "UNLOCK_WEAPON_MODS", true)

local playthroughRecord = require("game/playthrough_record_orig")

local origChangeMoney = playthroughRecord.changeMoney

-- Purchases always go through, and a spend refills the balance.
function playthroughRecord:changeMoney(amount)
	origChangeMoney(self, amount)
	if amount < 0 then
		self.money = math.max(self.money or 0, CHEAT_MONEY)
	end
end

function playthroughRecord:hasMoney(amount)
	return true
end

if BLOCK_ACHIEVEMENTS then
	if _G.achievements then
		_G.achievements.attemptSetAchievement = function() end
		-- Stat-progress pipeline can also grant achievements directly, so
		-- neutralize the whole platform bridge for this session.
		local platformAPI = _G.achievements.platformAPI
		if platformAPI then
			platformAPI.SetAchievement = function() end
			platformAPI.SetStat = function() end
			platformAPI.IndicateAchievementProgress = function() end
		end
	end
end

-- Hand the game's own (modified) class table back, so every consumer that
-- required "game/playthrough_record" before or after this chunk stays consistent.
return playthroughRecord
