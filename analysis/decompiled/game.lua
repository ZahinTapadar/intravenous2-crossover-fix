-- file: 122029
-- dialect: luajit
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local bitser = require("engine/bitser")
local playthroughRecord = require("game/playthrough_record")
game.showingConsole = false
game.canInitHUD = true
game.timescale = 1
game.dynIter = 0
game.dynListIter = 0
game.modSupport = { weaponMods = true }
game.fogOfWar = false
game.DLCS = { { "supporter_pack", 3116710 }, { "iv1_campaign_remaster", 3391540 } }
game.rateLimitRange = nil
game.CREDITS_ACTIVE = false
game.PARTITION_SIZE = 256
game.PARTITION_SIZE_CUTOFF = math.huge
game.WORLD_GRID_WIDTH = 200
game.WORLD_GRID_HEIGHT = 100
game.WORLD_TILE_WIDTH = 16
game.WORLD_TILE_HEIGHT = 16
game.WORLD_TILE_WIDTH_HALF = 8
game.WORLD_TILE_HEIGHT_HALF = 8
game.BASE_CAMERA_BOUNDARY = 0
game.levelTime = 0
game.remainingSaves = -1
game.transferEntryTime = false
game.curDeaths = 0
game.quicksaves = 0
game.capturedMouseCoords = {}
game.gameOver = false
game.time = 0
game.desiredMutators = {}
game.dynamicObjects = {}
game.dynamicObjectLists = {}
game.activeBullets = {}
game.objectsByID = {}
game.npcs = {}
game.objectSpriteBatches = {}
game.enabledModules = {}
game.hudBlockers = {}
game.SAVE_DIRECTORY = "savegames/"
game.SAVE_FILE_NAME = "save_"
game.SAVE_FILE_FORMAT = ".gds"
game.QUICKSAVE_FILE_FORMAT = ".gdsq"
game.SAVE_FILE_FORMAT_PREVIEW = "_preview"
game.SAVE_FILE_FORMAT_PREVIEW_FULL = game.SAVE_FILE_FORMAT .. game.SAVE_FILE_FORMAT_PREVIEW
game.SAVESLOT_COUNT = 3
game.MAP_DIRECTORY = "maps/"
game.MAP_FILE_FORMAT = ".gdsmap"
game.MAP_COMPRESSION_ALGORITHM = "zlib"
game.MAP_COMPRESSION_LEVEL = 9
game.PREVIEW_SCREENSHOT_SCALER = 4
game.MAX_SHELL_CASINGS = 500
game.LEARNING_POINTS_PER_GAME_FINISH = 3000
game.GAME_OVER_TIPS = {}
game.GAME_DATA_FILE = "gamedata.iv"
game.GAME_DATA_FIELDS = {
    "completedLevels", "levelCompletion", "completedCampaigns", "completedCampaignTimesDifficulty",
    "unlockedWeapons", "unlockedMods", "unlockedAmmoTypes", "unlockedModBlueprints", "levelMoney",
    "money", "trust"
}
game.preLevelListDifficulty = nil
game.preLevelListCampaign = nil
game.BACKGROUND_RED = color(31, 32, 32, 255)
local r0_2 = game
local r0_3 = {
    AVAILABLE = nil, BACKGROUND_BLUR_COLOR = nil, BACKGROUND_BLUR_COLOR_NEW = nil, BLACK = nil,
    BUTTON_BACKGROUND = nil, BUTTON_BACKGROUND_SIDE = nil, BUTTON_ORANGE = nil,
    CATEGORY_SEPARATOR_COLOR = nil, COMPARE_BETTER = nil, COMPARE_NONE = nil, COMPARE_WORSE = nil,
    DARK_GREY = nil, DARK_LIGHT_BLUE = nil, DARK_RED = nil, DEEP_RED = nil, DESCBOX_BACKGROUND = nil,
    DESCBOX_BACKGROUND_TOP = nil, DESCBOX_NAMEPLATE = nil, DESCBOX_NAMEPLATE_TEXT = nil,
    DIALOGUE = nil, DIALOGUE_BACKGROUND = nil, DIALOGUE_DARK = nil, DIALOGUE_TEXT_COLOR = nil,
    EXPERIENCE_BAR = nil, EXPERIENCE_BAR_BRIGHTER = nil, EXPERIENCE_TEXT = nil,
    GENERIC_BLOCKED_TEXT_COLOR = nil, GENERIC_GREEN_COLOR = nil, GENERIC_MENU_TEXT_COLOR = nil,
    GENERIC_PANEL_COLOR = nil, GENERIC_PANEL_COLOR_2 = nil, GENERIC_RED = nil,
    GENERIC_RED_DARK = nil, GENERIC_RED_DARKER = nil, GENERIC_STAT_COLOR = nil,
    GENERIC_TEXT_COLOR = nil, GENERIC_TEXT_SHADOW = nil, GREEN = nil, GREEN_2 = nil, GREY = nil,
    IMPORTANT_1 = nil, IMPORTANT_2 = nil, IMPORTANT_3 = nil, IMPORTANT_BUTTON_COLOR = nil,
    IMPORTANT_BUTTON_COLOR_BLOCKED = nil, IMPORTANT_BUTTON_COLOR_HOVER = nil,
    IMPORTANT_BUTTON_COLOR_HOVER_2 = nil, IMPORTANT_BUTTON_COLOR_HOVER_DIMMER = nil,
    LEARNING_CAP_TEXT = nil, LEVEL_BAR_HOVER = nil, LEVEL_BAR_IDLE = nil, LIGHT_BLUE = nil,
    LIGHT_BLUE_TEXT = nil, LIGHT_GREEN = nil, LIGHT_GREY = nil, LIGHT_RED = nil,
    LINE_COLOR_ONE = nil, LINE_COLOR_TWO = nil, LOADOUT_DAMAGE_COLOR = nil, LOADOUT_STAT_COLOR = nil,
    MOD_BOTTOM_PANEL = nil, MOD_CATEGORY_PANEL = nil, MOD_FRONT_PANEL = nil, MOD_STATS_PANEL = nil,
    MOD_STATS_PANEL_SIDE = nil, MOD_STATS_STAT = nil, MOD_STAT_BASE = nil,
    MOD_STAT_CHANGE_NEGATIVE = nil, MOD_STAT_CHANGE_POSITIVE = nil, MOD_STAT_NEGATIVE = nil,
    MOD_STAT_POSITIVE = nil, NEGATIVE_STAT_COLOR = nil, NEW_HUD_OUTER = nil, ORANGE = nil,
    ORANGE_BRIGHT = nil, POSITIVE_STAT_COLOR = nil, PRICETAG = nil, PRICETAG_HOVER = nil,
    PRICETAG_LACKING = nil, PRICETAG_MISSING_REQUIREMENTS = nil, PROGRESS_CIRCLE = nil,
    PROGRESS_CIRCLE_DARKER = nil, RED = nil, RELOAD_INDICATOR = nil, SKILL_CATEGORY_HEADER = nil,
    SKILL_CATEGORY_HIGHLIGHT_HEADER = nil, SKILL_HOVER_TEXT_COLOR = nil, SKILL_PANEL = nil,
    SKILL_PANEL_HOVER = nil, STAT_LINE_COLOR_ONE = nil, STAT_LINE_COLOR_TWO = nil,
    STAT_POPUP_PANEL_COLOR = nil, VERY_DARK_LIGHT_BLUE = nil, WEAPON_CATEGORY_HEADER = nil,
    WHITE = nil, YELLOW = nil
}
local r0_4 = color
r0_4 = r0_4(255, 255, 255, 255)
r0_3.WHITE = r0_4
r0_4 = color
r0_4 = r0_4(247, 226, 190, 255)
r0_3.IMPORTANT_1 = r0_4
r0_4 = color
r0_4 = r0_4(238, 247, 190, 255)
r0_3.IMPORTANT_2 = r0_4
r0_4 = color
r0_4 = r0_4(217, 232, 185, 255)
r0_3.IMPORTANT_3 = r0_4
r0_4 = color
r0_4 = r0_4(188, 224, 166, 255)
r0_3.AVAILABLE = r0_4
r0_4 = color
r0_4 = r0_4(255, 225, 216, 255)
r0_3.LIGHT_RED = r0_4
r0_4 = color
r0_4 = r0_4(255, 138, 127, 255)
r0_3.RED = r0_4
r0_4 = color
r0_4 = r0_4(255, 81, 81, 255)
r0_3.DEEP_RED = r0_4
r0_4 = color
r0_4 = r0_4(188, 58, 56, 255)
r0_3.DARK_RED = r0_4
r0_4 = color
r0_4 = r0_4(217, 255, 191, 255)
r0_3.GREEN = r0_4
r0_4 = color
r0_4 = r0_4(215, 255, 204, 255)
r0_3.GREEN_2 = r0_4
r0_4 = color
r0_4 = r0_4(174, 204, 153, 255)
r0_3.LIGHT_GREEN = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 255)
r0_3.BLACK = r0_4
r0_4 = color
r0_4 = r0_4(200, 200, 200, 255)
r0_3.LIGHT_GREY = r0_4
r0_4 = color
r0_4 = r0_4(150, 150, 150, 255)
r0_3.GREY = r0_4
r0_4 = color
r0_4 = r0_4(100, 100, 100, 255)
r0_3.DARK_GREY = r0_4
r0_4 = color
r0_4 = r0_4(187, 211, 234, 255)
r0_3.LIGHT_BLUE = r0_4
r0_4 = color
r0_4 = r0_4(204, 230, 255, 255)
r0_3.LIGHT_BLUE_TEXT = r0_4
r0_4 = color
r0_4 = r0_4(155, 175, 193, 255)
r0_3.DARK_LIGHT_BLUE = r0_4
r0_4 = color
r0_4 = r0_4(82, 92, 102, 255)
r0_3.VERY_DARK_LIGHT_BLUE = r0_4
r0_4 = color
r0_4 = r0_4(201, 206, 171, 255)
r0_3.CATEGORY_SEPARATOR_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 75)
r0_3.LINE_COLOR_ONE = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 50)
r0_3.LINE_COLOR_TWO = r0_4
r0_4 = color
r0_4 = r0_4(252, 255, 196, 255)
r0_3.YELLOW = r0_4
r0_4 = color
r0_4 = r0_4(255, 123, 96, 255)
r0_3.RELOAD_INDICATOR = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 150)
r0_3.STAT_POPUP_PANEL_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 75)
r0_3.STAT_LINE_COLOR_ONE = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 50)
r0_3.STAT_LINE_COLOR_TWO = r0_4
r0_4 = color
r0_4 = r0_4(206, 224, 250, 255)
r0_3.NEW_HUD_OUTER = r0_4
r0_4 = color
r0_4 = r0_4(39, 75, 107, 255)
r0_3.PROGRESS_CIRCLE_DARKER = r0_4
r0_4 = color
r0_4 = r0_4(69, 172, 188, 255)
r0_3.PROGRESS_CIRCLE = r0_4
r0_4 = color
r0_4 = r0_4(183, 58, 58, 255)
r0_3.GENERIC_RED_DARKER = r0_4
r0_4 = color
r0_4 = r0_4(119, 34, 34, 255)
r0_3.GENERIC_RED_DARK = r0_4
r0_4 = color
r0_4 = r0_4(255, 76, 73, 255)
r0_3.GENERIC_RED = r0_4
r0_4 = color
r0_4 = r0_4(178, 184, 166, 255)
r0_3.LOADOUT_STAT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(208, 179, 89, 255)
r0_3.LOADOUT_DAMAGE_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(27, 43, 51, 255)
r0_3.GENERIC_PANEL_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(30, 32, 32, 255)
r0_3.GENERIC_PANEL_COLOR_2 = r0_4
r0_4 = color
r0_4 = r0_4(46, 68, 96, 255)
r0_3.DIALOGUE_DARK = r0_4
r0_4 = color
r0_4 = r0_4(64, 95, 135, 255)
r0_3.DIALOGUE = r0_4
r0_4 = color
r0_4 = r0_4(153, 198, 204, 255)
r0_3.POSITIVE_STAT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(204, 89, 89, 255)
r0_3.NEGATIVE_STAT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(235, 120, 44, 255)
r0_3.GENERIC_STAT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(137, 181, 85, 255)
r0_3.GENERIC_GREEN_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(190, 193, 184, 255)
r0_3.DIALOGUE_TEXT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(190, 193, 184, 255)
r0_3.GENERIC_TEXT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(20, 21, 21, 255)
r0_3.GENERIC_TEXT_SHADOW = r0_4
r0_4 = color
r0_4 = r0_4(193, 196, 186, 255)
r0_3.GENERIC_BLOCKED_TEXT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(112, 147, 152, 255)
r0_3.GENERIC_MENU_TEXT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(104, 135, 66, 255)
r0_3.PRICETAG = r0_4
r0_4 = color
r0_4 = r0_4(170, 138, 70, 255)
r0_3.PRICETAG_LACKING = r0_4
r0_4 = color
r0_4 = r0_4(139, 181, 88, 255)
r0_3.PRICETAG_HOVER = r0_4
r0_4 = color
r0_4 = r0_4(160, 80, 64, 255)
r0_3.PRICETAG_MISSING_REQUIREMENTS = r0_4
r0_4 = color
r0_4 = r0_4(122, 160, 78, 255)
r0_3.COMPARE_BETTER = r0_4
r0_4 = color
r0_4 = r0_4(160, 80, 64, 255)
r0_3.COMPARE_WORSE = r0_4
r0_4 = color
r0_4 = r0_4(0, 0, 0, 0)
r0_3.COMPARE_NONE = r0_4
r0_4 = color
r0_4 = r0_4(183, 38, 38, 255)
r0_3.IMPORTANT_BUTTON_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(229, 48, 48, 255)
r0_3.IMPORTANT_BUTTON_COLOR_HOVER = r0_4
r0_4 = color
r0_4 = r0_4(158, 33, 33, 255)
r0_3.IMPORTANT_BUTTON_COLOR_HOVER_DIMMER = r0_4
r0_4 = color
r0_4 = r0_4(181, 126, 38, 255)
r0_3.IMPORTANT_BUTTON_COLOR_HOVER_2 = r0_4
r0_4 = color
r0_4 = r0_4(127, 26, 26, 255)
r0_3.IMPORTANT_BUTTON_COLOR_BLOCKED = r0_4
r0_4 = color
r0_4 = r0_4(255, 102, 96, 255)
r0_3.BACKGROUND_BLUR_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(144, 174, 204, 255)
r0_3.BACKGROUND_BLUR_COLOR_NEW = r0_4
r0_4 = color
r0_4 = r0_4(20, 18, 29, 255)
r0_3.SKILL_PANEL = r0_4
r0_4 = color
r0_4 = r0_4(114, 80, 49, 255)
r0_3.SKILL_PANEL_HOVER = r0_4
r0_4 = color
r0_4 = r0_4(219, 223, 210, 255)
r0_3.SKILL_HOVER_TEXT_COLOR = r0_4
r0_4 = color
r0_4 = r0_4(41, 65, 68, 255)
r0_3.SKILL_CATEGORY_HEADER = r0_4
r0_4 = color
r0_4 = r0_4(100, 135, 140, 255)
r0_3.SKILL_CATEGORY_HIGHLIGHT_HEADER = r0_4
r0_4 = color
r0_4 = r0_4(41, 65, 68, 255)
r0_3.WEAPON_CATEGORY_HEADER = r0_4
r0_4 = color
r0_4 = r0_4(133, 185, 191, 255)
r0_3.LEARNING_CAP_TEXT = r0_4
r0_4 = color
r0_4 = r0_4(121, 168, 173, 255)
r0_3.EXPERIENCE_TEXT = r0_4
r0_4 = color
r0_4 = r0_4(5, 26, 31, 255)
r0_3.DESCBOX_BACKGROUND = r0_4
r0_4 = color
r0_4 = r0_4(17, 73, 100, 255)
r0_3.DESCBOX_BACKGROUND_TOP = r0_4
r0_4 = color
r0_4 = r0_4(7, 49, 70, 255)
r0_3.DESCBOX_NAMEPLATE = r0_4
r0_4 = color
r0_4 = r0_4(145, 197, 172, 255)
r0_3.DESCBOX_NAMEPLATE_TEXT = r0_4
r0_4 = color
r0_4 = r0_4(38, 59, 63, 255)
r0_3.BUTTON_BACKGROUND = r0_4
r0_4 = color
r0_4 = r0_4(20, 90, 119, 255)
r0_3.BUTTON_BACKGROUND_SIDE = r0_4
r0_4 = color
r0_4 = r0_4(28, 12, 14, 255)
r0_3.MOD_STATS_PANEL = r0_4
r0_4 = color
r0_4 = r0_4(135, 31, 46, 255)
r0_3.MOD_STATS_PANEL_SIDE = r0_4
r0_4 = color
r0_4 = r0_4(204, 77, 52, 255)
r0_3.MOD_STATS_STAT = r0_4
r0_4 = color
r0_4 = r0_4(144, 234, 138, 255)
r0_3.MOD_STAT_POSITIVE = r0_4
r0_4 = color
r0_4 = r0_4(239, 51, 47, 255)
r0_3.MOD_STAT_NEGATIVE = r0_4
r0_4 = color
r0_4 = r0_4(144, 218, 136, 255)
r0_3.MOD_STAT_CHANGE_POSITIVE = r0_4
r0_4 = color
r0_4 = r0_4(210, 70, 67, 255)
r0_3.MOD_STAT_CHANGE_NEGATIVE = r0_4
r0_4 = color
r0_4 = r0_4(6, 25, 31, 255)
r0_3.MOD_BOTTOM_PANEL = r0_4
r0_4 = color
r0_4 = r0_4(14, 56, 69, 255)
r0_3.MOD_FRONT_PANEL = r0_4
r0_4 = color
r0_4 = r0_4(7, 35, 44, 255)
r0_3.MOD_CATEGORY_PANEL = r0_4
r0_4 = color
r0_4 = r0_4(66, 55, 56, 255)
r0_3.MOD_STAT_BASE = r0_4
r0_4 = color
r0_4 = r0_4(175, 119, 34, 255)
r0_3.ORANGE = r0_4
r0_4 = color
r0_4 = r0_4(229, 156, 45, 255)
r0_3.ORANGE_BRIGHT = r0_4
r0_4 = color
r0_4 = r0_4(48, 106, 107, 255)
r0_3.EXPERIENCE_BAR = r0_4
r0_4 = color
r0_4 = r0_4(74, 164, 165, 255)
r0_3.EXPERIENCE_BAR_BRIGHTER = r0_4
r0_4 = color
r0_4 = r0_4(208, 124, 43, 255)
r0_3.LEVEL_BAR_HOVER = r0_4
r0_4 = color
r0_4 = r0_4(79, 49, 21, 255)
r0_3.LEVEL_BAR_IDLE = r0_4
r0_4 = color
r0_4 = r0_4(238, 125, 50, 255)
r0_3.BUTTON_ORANGE = r0_4
r0_4 = color
r0_4 = r0_4(22, 27, 51, 255)
r0_3.DIALOGUE_BACKGROUND = r0_4
r0_2.UI_COLORS_BASE = r0_3
local r0_5 = game.UI_COLORS_BASE
r0_3 = game
r0_3 = r0_3.UI_COLORS_BASE.GENERIC_TEXT_COLOR
local r0_6 = r0_3
r0_3 = r0_6.duplicate
r0_4 = nil
r0_3 = r0_3(r0_6)
r0_5.WEAPON_CATEGORY_HEADER_TEXT = r0_3
r0_5 = game.UI_COLORS_BASE
r0_3 = game
r0_3 = r0_3.UI_COLORS_BASE.GENERIC_TEXT_COLOR
r0_5.LOADOUT_TITLE_HEADER = r0_3
r0_5 = game.UI_COLORS_BASE
r0_3 = game
r0_3 = r0_3.UI_COLORS_BASE.SKILL_CATEGORY_HEADER
r0_5.LOADOUT_TITLE_PANEL = r0_3
r0_5 = game.UI_COLORS_BASE
r0_3 = game
r0_3 = r0_3.UI_COLORS_BASE.GENERIC_TEXT_COLOR
r0_6 = r0_3
r0_3 = r0_6.duplicate
r0_3 = r0_3(r0_6)
r0_5.SKILLS_TITLE_HEADER = r0_3
r0_5 = game.UI_COLORS_BASE
r0_3 = game
r0_3 = r0_3.UI_COLORS_BASE.DARK_RED
r0_6 = r0_3
r0_3 = r0_6.duplicate
r0_3 = r0_3(r0_6)
r0_5.UI_PENALTY_LINE = r0_3
r0_5 = game.UI_COLORS_BASE.UI_PENALTY_LINE
r0_3 = 100
r0_5.a = r0_3
r0_5 = game.UI_COLORS_BASE
local r0_7 = game.UI_COLORS_BASE.VERY_DARK_LIGHT_BLUE
r0_7 = r0_7:duplicate()
r0_5.BOOST_LINE = r0_7
r0_5 = game.UI_COLORS_BASE.BOOST_LINE
r0_7 = 50
r0_5.a = r0_7
game.UI_COLORS_BASE.DIALOGUE_ANSWER = game.UI_COLORS_BASE.DIALOGUE_DARK
game.UI_COLORS_BASE.DIALOGUE_ANSWER_HOVER = game.UI_COLORS_BASE.DIALOGUE
r0_5 = game
local r0_8 = {}
r0_5.UI_COLORS = r0_8
local r0_9 = setmetatable
r0_4 = game
r0_4 = r0_4.UI_COLORS
local r0_10 = { __index = nil }
local r0_11 = game.UI_COLORS_BASE
r0_10.__index = r0_11
r0_11 = nil
r0_9(r0_4, r0_10)
local r0_12 = game

function r0_8(data) -- proto#263 params=1 locals=3 upvalues=0 vararg=false source=122029 lines=244-253
    local dest = game.UI_COLORS
    table.clear(dest)
    if data then
        for key, clr in pairs(data) do
            dest[key] = clr
        end
    end
end

r0_12.setupActiveColorsUI = r0_8
local r0_13 = game
r0_8 = love
r0_8 = r0_8.thread.getChannel
r0_8 = r0_8("GAME_SAVER_IN")
r0_13.GAME_SAVE_IN_CHANNEL = r0_8
local r0_14 = game
r0_8 = love
r0_8 = r0_8.thread.newThread
r0_8 = r0_8("game/game_saver_thread.lua")
r0_14.GAME_SAVER_THREAD = r0_8
local r0_15 = game.GAME_SAVER_THREAD
r0_4 = r0_15
r0_15 = r0_4.start
r0_8 = nil
r0_15(r0_4)
r0_15 = game
r0_8 = {}
local r0_16 = { font = "pixellari22", lineSpace = 6, text = nil, wrapWidth = 400 }
r0_10 = _T("BUTTON_PUBLISH_LEVEL_ON_STEAM_WORKSHOP", "Publish/update/export level...")
r0_16.text = r0_10
r0_8[1] = r0_16
r0_16 = { font = "pixellari16", lineSpace = 8, text = nil, wrapWidth = 400 }
r0_10 = _T
r0_10 = r0_10("BUTTON_PUBLISH_LEVEL_ON_STEAM_WORKSHOP_DESC",
    [[Publishing/updating a level on Steam will save it before moving onward, so make sure that it doesn't have any in-progress changes done to it before choosing to upload.

You can also export levels in a mod-ready format in case you want to share it around outside of Steam Workshop using this option.]])
r0_16.text = r0_10
r0_8[2] = r0_16
r0_16 = { font = "pixellari16", text = nil, textColor = nil, wrapWidth = 400 }
r0_10 = _T
r0_10 = r0_10("BUTTON_PUBLISH_LEVEL_ON_STEAM_WORKSHOP_DESC2",
    "Only publish levels that are, per your understanding, a 'version 1.0' release. Refrain from uploading work-in-progress, or levels that don't work properly and/or crash the game.")
r0_16.text = r0_10
r0_10 = game
r0_10 = r0_10.UI_COLORS.GENERIC_STAT_COLOR
r0_16.textColor = r0_10
r0_8[3] = r0_16
r0_15.workshopPublishHoverText = r0_8
local r0_17 = game
r0_8 = true
r0_17.canOpenMainMenu = r0_8
game.sloMoAllowed = false
game.offlimitsPresent = false
game.residencePresent = false
local r0_18 = game
local r0_19 = {}
r0_16 = { keys = nil, x = 0, y = -800 }
r0_10 = { up = true, w = true }
r0_16.keys = r0_10
r0_19[1] = r0_16
r0_16 = { keys = nil, x = 800, y = 0 }
r0_10 = { d = true, right = true }
r0_16.keys = r0_10
r0_19[2] = r0_16
r0_16 = { keys = nil, x = 0, y = 800 }
r0_10 = { down = true, s = true }
r0_16.keys = r0_10
r0_19[3] = r0_16
r0_16 = { keys = nil, x = -800, y = 0 }
r0_10 = { a = true, left = true }
r0_16.keys = r0_10
r0_19[4] = r0_16
r0_18.CAMERA_MOVE_KEYS = r0_19
local r0_20 = game
r0_19 = { lshift = true, rshift = true }
r0_20.FASTER_CAMERA_KEYS = r0_19
local r0_21 = game
r0_19 = {
    CAMPAIGN_FINISH_FADED = nil, CAMPAIGN_SELECTED = nil, DIFFICULTY_CHANGED = nil,
    ENTRY_TIME_SELECTED = nil, FINISHED_LOAD = nil, GAME_SAVED = nil, GAME_UNLOADED = nil,
    LEVEL_FINISHED = nil, LEVEL_INTRO_DISPLAYER_STATE = nil, MAP_LOADED = nil, MAP_SELECTED = nil,
    MUTATOR_CHANGED = nil, NARRATION_FINISHED = nil, NEW_GAME_STARTED = nil, ON_START_FINISH = nil,
    PLAYER_REMOVED = nil, PLAYER_SET = nil, POST_MODS_LOADED = nil, PRE_CREATE_SAVE_INDICATOR = nil,
    PRE_REMOVE_GAME = nil, RESET_FINISHED = nil, RESET_INITIATED = nil, RESET_STARTED = nil,
    RESOLUTION_CHANGED = nil, RETURNED_TO_MAIN_MENU = nil, RETURNING_TO_MAIN_MENU = nil,
    SAVEGAME_DELETED = nil
}
r0_16 = events
local r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.FINISHED_LOAD = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.MAP_LOADED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RESOLUTION_CHANGED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.CAMPAIGN_SELECTED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.MAP_SELECTED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.NEW_GAME_STARTED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.SAVEGAME_DELETED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.DIFFICULTY_CHANGED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.GAME_UNLOADED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.PRE_REMOVE_GAME = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RETURNING_TO_MAIN_MENU = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RETURNED_TO_MAIN_MENU = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.ON_START_FINISH = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.POST_MODS_LOADED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RESET_STARTED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RESET_INITIATED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.RESET_FINISHED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.PRE_CREATE_SAVE_INDICATOR = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.LEVEL_FINISHED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.MUTATOR_CHANGED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22, "narrationFinished")
r0_19.NARRATION_FINISHED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.CAMPAIGN_FINISH_FADED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_10 = "PLAYER_SET"
r0_19[r0_10] = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.PLAYER_REMOVED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.ENTRY_TIME_SELECTED = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.LEVEL_INTRO_DISPLAYER_STATE = r0_16
r0_16 = events
r0_22 = r0_16
r0_16 = r0_22.new
r0_16 = r0_16(r0_22)
r0_19.GAME_SAVED = r0_16
r0_21.EVENTS = r0_19
local r0_23 = game
r0_19 = "LOAD_COMPONENTS"
r0_16 = {}
r0_23[r0_19] = r0_16
r0_16 = resolutionHandler
r0_16:setPreResolutionChanged(function() -- proto#262 params=0 locals=7 upvalues=0 vararg=false source=122029 lines=333-352
        local r262_0 = resolutionHandler
        local r262_1 = resolutionHandler
        local r262_2 = resolutionHandler
        local r262_3, r262_4 = r262_2:getRealScreenResolution()
        r262_1.oldH = r262_4
        r262_0.oldW = r262_3
        r262_3 = render
        local r262_5 = r262_3.preResolutionChanged
        r262_4 = nil
        r262_5(r262_3)
        if game.mainFrameBuffer then
            local r262_6 = priorityRenderer
            r262_6:remove(game.mainFrameBuffer)
            r262_5 = game.mainFrameBuffer
            r262_5:remove()
            game.mainFrameBuffer = nil
            game.mainFrameBufferObject = nil
        end
        if game.secondFrameBuffer then
            r262_5 = game.secondFrameBuffer
            r262_5:remove()
            game.secondFrameBuffer = nil
            game.secondFrameBufferObject = nil
        end
        game.postChangeSetup = false
    end)
local r0_24 = resolutionHandler
local r0_25 = "setOnScreenModeChanged"
r0_24:setOnScreenModeChanged(function() -- proto#261 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=355-356
        game.onScreenModeChanged()
    end)
local r0_26 = resolutionHandler
local r0_27 = "setOnResolutionChanged"
r0_26:setOnResolutionChanged(function(w, h) -- proto#260 params=2 locals=0 upvalues=0 vararg=false source=122029 lines=359-360
        game.onResolutionChanged(w, h)
    end)
local r0_28 = game
r0_19 = "nextFrameGameSaveState"
local r0_29 = {}
r0_28[r0_19] = r0_29
local r0_30 = game.nextFrameGameSaveState

function r0_29(self) -- proto#259 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=365-366
    self.timeout = 0.5
end

r0_30.onAdded = r0_29
r0_30 = game.nextFrameGameSaveState
local r0_31 = "update"

function r0_29(self, dt) -- proto#258 params=2 locals=8 upvalues=0 vararg=false source=122029 lines=369-392
    if not game.worldObject then
        return
    end
    if game.worldObject:getLevelFinished() then
        gameStateService:removeState(self)
        return
    end
    if game.worldObject:getIntroDisplaying() then
        return
    end
    self.timeout = self.timeout - dt
    if self.timeout > 0 then
        return
    end
    if not cutscene.state:getCutscene() then
        local baseMapName = game.worldObject:getSavePrefix()
        game.beginSaving(game.getSaveFileName(_format2(_T("CUTSCENE_SAVE_NAME", "${MAPNAME} - Start"),
                    "MAPNAME", baseMapName)),
            false, nil, true)
    end
    gameStateService:removeState(self)
end

r0_30[r0_31] = r0_29
r0_30 = game
r0_31 = "activeCameraKeys"
r0_29 = {}
r0_30[r0_31] = r0_29
local r0_32 = require
r0_29 = "game/credits"
r0_32(r0_29)
love.filesystem.createDirectory(game.SAVE_DIRECTORY)

function game.addGameOverTip(tip) -- proto#257 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=401-402
    table.insert(game.GAME_OVER_TIPS, tip)
end

function game.createDemoDisclaimer() -- proto#256 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=405-407
    local disc = gui.create("DemoDisclaimer")
    disc:bringUp()
end

function game.openConsole() -- proto#255 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=410-415
    if not game.showingConsole then
        love._openConsole()
        game.showingConsole = true
        game.saveUserPreferences()
    end
end

function game.hideConsole() -- proto#254 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=418-420
    game.showingConsole = false
    game.saveUserPreferences()
end

function game.pickRandomGameOverTip(notEpic) -- proto#253 params=1 locals=4 upvalues=0 vararg=false source=122029 lines=423-424
    return tipController.gameOverTips[math.random(1, #tipController.gameOverTips)]
end

game.BASE_LOAD_COMPONENT_PRIORITY = 1

local function sortLoadComponents(a, b) -- proto#252 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=429-430
    return a.priority > b.priority
end

function game.addLoadComponent(classObj, id, priority) -- proto#251 params=3 locals=0 upvalues=0 vararg=false source=122029 lines=436-438
    table.insert(game.LOAD_COMPONENTS, { obj = classObj, id = id, priority = priority })
    table.sort(classObj, game.LOAD_COMPONENTS)
end

function game.readMap(mapPath) -- proto#250 params=1 locals=3 upvalues=1 vararg=false source=122029 lines=441-444
    local decompressed = love.data.decompress("string", game.MAP_COMPRESSION_ALGORITHM,
        love.filesystem.read(mapPath))
    return bitser.loads(decompressed), decompressed
end

function game.getMapExists(mapPath) -- proto#249 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=447-450
    local info = love.filesystem.getInfo(mapPath)
    return info ~= nil
end

function game.removeGametype() -- proto#248 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=453-458
    if game.curGametype then
        game.curGametype:remove()
    end
    game.curGametype = nil
end

function game.saveGametype() -- proto#247 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=461-468
    local saved = {}
    saved.id = game.curGametype.id
    game.curGametype:saveStartTime(saved)
    game.curGametype:save(saved)
    return saved
end

function game.captureMousePosition(x, y, scalar) -- proto#246 params=3 locals=3 upvalues=0 vararg=false source=122029 lines=472-481
    local coords = game.capturedMouseCoords
    if coords[1] then
        return
    end
    coords[1], coords[2], coords[3] = x, y, scalar
end

function game.clearCapturedMousePosition() -- proto#245 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=484-488
    local coords = game.capturedMouseCoords
    coords[1], coords[2], coords[3] = nil, nil, nil
end

function game.getCapturedMousePosition() -- proto#244 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=491-492
    return game.capturedMouseCoords
end

function game.restoreMousePosition() -- proto#243 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=495-507
    local coords = game.capturedMouseCoords
    if coords[1] then
        if coords[3] then
            camera:setMousePosition(coords[1] * scrW, coords[2] * scrH)
        else
            camera:setMousePosition(coords[1], coords[2])
        end
        game.capturedMouseCoords[1] = nil
    end
end

function game.attemptRestoreMousePosition() -- proto#242 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=510-516
    if dialogueHandler:isInProgress() or frameController:getFrameCount() > 0 then
        return
    end
    game.restoreMousePosition()
end

function game.setResolution(width, height) -- proto#241 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=519-527
    if scrW == width and scrH == height then
        return
    end
    resolutionHandler:setDesiredResolution(width, height)
end

function game.loadDLCS() -- proto#240 params=0 locals=9 upvalues=0 vararg=false source=122029 lines=530-547
    local t = os.clock()
    for key, dlcData in ipairs(game.DLCS) do
        local dlcID = dlcData[2]
        if dlcID and (not love.platformAPI or love.platformAPI:getIsDLCOwned(dlcID)) or not dlcID then
            local dlcFolder = dlcData[1]
            local entryFile = "dlc/" .. dlcFolder .. "/" .. "main"
            local fileData = love.filesystem.getInfo(entryFile .. ".lua")
            if fileData and fileData.type == "file" then
                require(entryFile)
            end
        end
    end
    print("dlc loaded in", os.clock() - t)
end

function game.setPlayerActor(act) -- proto#239 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=550-553
    game.playerActor = act
    act:setInputState(true)
    events:fire(game.EVENTS.PLAYER_SET, act)
end

function game.removePlayerActor() -- proto#238 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=556-562
    if game.playerActor then
        game.playerActor:setInputState(false)
        game.playerActor:remove()
        game.playerActor = nil
        events:fire(game.EVENTS.PLAYER_REMOVED)
    end
end

function game.initPlayer(x, y) -- proto#237 params=2 locals=4 upvalues=0 vararg=false source=122029 lines=565-569
    local ply = playerActor.new()
    ply:setPos(ply:adjustSpawnPosition(x, y))
    return ply
end

function game.disablePlayerInput() -- proto#236 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=572-579
    if game.playerActor then
        local prevInput = game.playerActor:getInputState()
        game.playerActor:setInputState(false)
        return prevInput
    end
    return nil
end

function game.restorePlayerInput(state) -- proto#235 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=582-585
    if game.playerActor then
        game.playerActor:setInputState(state)
    end
end

function game.initHitbox(physWorld, w, h) -- proto#234 params=3 locals=6 upvalues=0 vararg=false source=122029 lines=588-593
    local body = love.physics.newBody(physWorld, 0, 0, "dynamic")
    local rect = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, rect, 1)
    return body, rect, fixture
end

function game.fillRectangleSides(dest, ...) -- proto#233 params=1 locals=0 upvalues=0 vararg=true source=122029 lines=599-600

end

local rectSidesFuncs = {}
local r0_35 = { __index = rectSidesFuncs }
rectSidesFuncs.mtindex = r0_35

function rectSidesFuncs.new() -- proto#232 params=0 locals=1 upvalues=1 vararg=false source=122029 lines=606-611
    local new = {}
    setmetatable(new, rectSidesFuncs.mtindex)
    new:init()
    return new
end

local r0_36 = "init"

function r0_35(self) -- proto#231 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=614-615
    self.coords = {}
end

rectSidesFuncs[r0_36] = r0_35
r0_36 = "fill"

function r0_35(self, ...) -- proto#230 params=1 locals=10 upvalues=0 vararg=true source=122029 lines=618-629
    local cnt = select("#", ...)
    local dest = self.coords
    for i = 1, cnt, 2 do
        local r230_3 = i + 1
        local r230_4 = select(i, ...)
        dest[r230_3] = select(i + 1, ...)
        dest[i] = r230_4
    end
    dest[cnt + 1], dest[cnt + 2] = dest[1], dest[2]
    self.coordCount = cnt + 2
end

rectSidesFuncs[r0_36] = r0_35
r0_36 = "intersects"

function r0_35(self, X1, Y1, X2, Y2) -- proto#229 params=5 locals=10 upvalues=0 vararg=false source=122029 lines=634-645
    local coords = self.coords
    for i = 1, self.coordCount - 2, 2 do
        local x1, y1, x2, y2 = coords[i], coords[i + 1], coords[i + 2], coords[i + 3]
        if math.lineSegmentIntersects(x1, y1, x2, y2, X1, Y1, X2, Y2) then
            return x1, y1, x2, y2
        end
    end
    return nil
end

rectSidesFuncs[r0_36] = r0_35
r0_36 = "getCoords"

function r0_35(self) -- proto#228 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=648-649
    return self.coords, self.coordCount
end

rectSidesFuncs[r0_36] = r0_35
local r0_37 = game
r0_35 = "setupRectangleSides"
r0_37[r0_35] = function(bodyObj, shapeObj) -- proto#227 params=2 locals=6 upvalues=1 vararg=false source=122029 lines=652-656
    local sides = rectSidesFuncs.new()
    sides:fill(bodyObj:getWorldPoints(shapeObj:getPoints()))
    return sides
end
local _verticeList = {}

function game.initPolygonShape(w, h, verticeList) -- proto#226 params=3 locals=7 upvalues=1 vararg=false source=122029 lines=665-682
    if verticeList then
        for i = 1, #verticeList, 2 do
            local x = verticeList[i]
            local y = verticeList[i + 1]
            _verticeList[i] = x * w
            _verticeList[i + 1] = y * h
        end
        local polygonShape = love.physics.newPolygonShape(_verticeList)
        table.clearArray(_verticeList)
        return polygonShape
    end
    return love.physics.newRectangleShape(w, h)
end

function game.initObstruction(physWorld, w, h, verticeList) -- proto#225 params=4 locals=6 upvalues=0 vararg=false source=122029 lines=685-690
    local body = love.physics.newBody(physWorld, 0, 0, "static")
    local rect = game.initPolygonShape(w, h, verticeList)
    local fixture = love.physics.newFixture(body, rect, 1)
    return body, rect, fixture
end

function game.initHitCircle(physWorld, radius) -- proto#224 params=2 locals=6 upvalues=0 vararg=false source=122029 lines=693-698
    local body = love.physics.newBody(physWorld, 0, 0, "dynamic")
    local rect = love.physics.newCircleShape(radius)
    local fixture = love.physics.newFixture(body, rect, 1)
    return body, rect, fixture
end

function game.initHitRectangle(physWorld, w, h) -- proto#223 params=3 locals=6 upvalues=0 vararg=false source=122029 lines=701-706
    local body = love.physics.newBody(physWorld, 0, 0, "dynamic")
    local rect = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, rect, 1)
    return body, rect, fixture
end

function game.addDroppedMag(mag) -- proto#222 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=709-710
    table.insert(game.droppedMags, mag)
end

function game.removeDroppedMag(mag) -- proto#221 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=713-714
    table.removeObject(game.droppedMags, mag)
end

function game.addObjectIDLink(id, object) -- proto#220 params=2 locals=0 upvalues=0 vararg=false source=122029 lines=717-718
    game.objectsByID[id] = object
end

function game.removeObjectIDLink(id) -- proto#219 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=721-722
    game.objectsByID[id] = nil
end

function game.getObjectByID(id) -- proto#218 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=725-726
    return game.objectsByID[id]
end

function game.enableModule(mod) -- proto#217 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=729-730
    table.insert(game.enabledModules, mod)
end

function game.removeModule(mod) -- proto#216 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=733-734
    table.removeObject(game.enabledModules, mod)
end

function game.removeModules() -- proto#215 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=737-741
    for key, mod in ipairs(game.enabledModules) do
        mod:remove()
        game.enabledModules[key] = nil
    end
end

function game.changeDeaths(change) -- proto#214 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=745-746
    game.curDeaths = game.curDeaths + change
end

function game.getDeaths() -- proto#213 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=749-750
    return game.curDeaths
end

function game.onScreenModeChanged() -- proto#212 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=753-754
    game.onResolutionChanged(nil, nil)
end

function game.getTargetTimescale() -- proto#211 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=757-762
    if game.playerActor then
        return game.playerActor:getTargetTimescale()
    end
    return 1
end

function game.saveGameData() -- proto#210 params=0 locals=0 upvalues=1 vararg=false source=122029 lines=765-766
    love.filesystem.write(game.GAME_DATA_FILE, bitser.dumps(game.gameData))
end

function game.loadGameData() -- proto#209 params=0 locals=3 upvalues=1 vararg=false source=122029 lines=769-788
    local read = love.filesystem.read(game.GAME_DATA_FILE)
    if read and read ~= "" then
        game.gameData = bitser.loads(read)
        local gd = game.gameData
        if gd and type(gd) ~= "number" then
            game._initGameData(gd)
        else
            game.initGameData()
        end
    else
        game.initGameData()
        game.saveGameData()
    end
end

function game.hasCompletedCampaign(id) -- proto#208 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=791-802
    local list = game.gameData.completedCampaigns
    if #list > 0 then
        for i = 1, #list do
            if list[i] == id then
                return true
            end
        end
    end
    return false
end

function game.initGameData() -- proto#207 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=805-807
    game.gameData = {}
    game._initGameData(game.gameData)
end

function game._initGameData(dest) -- proto#206 params=1 locals=14 upvalues=0 vararg=false source=122029 lines=810-846
    for key, field in ipairs(game.GAME_DATA_FIELDS) do
        local val = dest[field]
        if not val or type(val) == "number" then
            dest[field] = {}
        end
    end
    local campaignCompletion = game.gameData.completedCampaignTimesDifficulty
    for campaignID, field2 in pairs(campaignCompletion) do
        for diffID, data in pairs(field2) do
            if diffID == false then
                local dest2 = campaignCompletion[campaignID].easy
                if not dest2 then
                    dest2 = {}
                    campaignCompletion[campaignID].easy = dest2
                end
                for key2, playthroughHash in ipairs(data) do
                    if not table.find(dest2, playthroughHash) then
                        table.insert(dest2, playthroughHash)
                    end
                end
                campaignCompletion[campaignID][diffID] = nil
            end
        end
    end
end

function game.getMaxLevelMoney(levelID) -- proto#205 params=1 locals=9 upvalues=0 vararg=false source=122029 lines=849-857
    local mapData = maps:getData(levelID)
    local maxMoney = math.max(game.worldObject:getStartMoney(),
        game.gameData.levelMoney[levelID] or 0)
    if mapData then
        return math.max(mapData:getStartMoney(), maxMoney)
    end
    return maxMoney
end

function game.storeMaxLevelMoney(levelID, playthroughRecordInst) -- proto#204 params=2 locals=4 upvalues=0 vararg=false source=122029 lines=860-864
    local plyMoney = playthroughRecordInst:getMoney()
    game.gameData.levelMoney[levelID] = math.max(game.gameData.levelMoney[levelID] or 0, plyMoney)
    game.saveGameData()
end

function game.storeLevelCompletion(mapID, attackRecordInst) -- proto#203 params=2 locals=3 upvalues=0 vararg=false source=122029 lines=867-870
    game.gameData.levelCompletion[mapID] = {
        attackRecordInst:save(), game.levelTime, game.curDeaths
    }
    game.saveGameData()
end

function game.getLevelCompletion(mapID) -- proto#202 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=873-874
    return game.gameData.levelCompletion[mapID]
end

function game.createMoneyPickupElement(money, name, icon, sound) -- proto#201 params=4 locals=1 upvalues=0 vararg=false source=122029 lines=877-886
    game.hudPickupController:displayMoneyPickup(money, name, icon, sound)
end

function game.createSchematicPickupElement(name, icon, sound) -- proto#200 params=3 locals=1 upvalues=0 vararg=false source=122029 lines=889-898
    game.hudPickupController:displaySchematicPickup(name, icon, sound)
end

function game.createSkillLevelUpElement(ply, skillData) -- proto#199 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=901-911
    game.hudPickupController:displayLevelUpElement(ply, skillData)
end

function game.goToGameOverState(text, cameraObject) -- proto#198 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=914-917
    if game.playerActor then
        game.playerActor:onGameOver(text, cameraObject)
    end
end

function game.createTrustElement(reason, change) -- proto#197 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=920-925
    if change == 0 then
        return
    end
    game.hudPickupController:displayTrustChange(reason, change)
end

function game.createHUDEventNotifier(displayTop, displayBottom, icon, playSound) -- proto#196 params=4 locals=1 upvalues=0 vararg=false source=122029 lines=928-936
    game.hudPickupController:displayGenericNotifier(displayTop, displayBottom, icon, playSound)
end

function game.showLevelCompletion(mapID) -- proto#195 params=1 locals=5 upvalues=0 vararg=false source=122029 lines=940-947
    local inst = attackRecord.new()
    local completionData = game.gameData.levelCompletion[mapID]
    inst:load(completionData[1])
    inst:createScoreboard(true, mapID, completionData[2], completionData[3])
    mainMenu:hideMenuElements()
    mainMenu:hideBackgroundElements()
    frameController:hide()
end

function game._verifyCampaignGamedata(campaignID, dest) -- proto#194 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=950-953
    if not game.gameData[dest][campaignID] then
        game.gameData[dest][campaignID] = {}
    end
end

function game.getLevelTrustValue(campaignID, difficultyID) -- proto#193 params=2 locals=2 upvalues=0 vararg=false source=122029 lines=956-963
    local field = game.gameData.trust[campaignID]
    if field then
        return field[difficultyID] or 0
    end
    return 0
end

function game._writeCampaignDifficultyData(campaignID, difficultyID, data, dest) -- proto#192 params=4 locals=6 upvalues=0 vararg=false source=122029 lines=967-987
    local gdata = game.gameData
    local writtenData = gdata[dest][campaignID]
    if not writtenData then
        writtenData = { [difficultyID] = {} }
        gdata[dest][campaignID] = writtenData
    end
    local dataWriteDest = gdata[dest][campaignID][difficultyID]
    if dataWriteDest then
        if not table.find(dataWriteDest, data) then
            table.insert(dataWriteDest, data)
        end
    else
        writtenData[difficultyID] = { data }
    end
end

function game.attemptLogUnlockedWeapons() -- proto#191 params=0 locals=14 upvalues=0 vararg=false source=122029 lines=990-1017
    if game.campaign then
        local campaignID = game.campaign:getID()
        local wepList = game.playerActor:getWeapons()
        local diffID = game.difficulty:getUnlockID()
        for i = 1, #wepList do
            local wep = wepList[i]
            local wepID = wep:getID()
            if not game.getWeaponUnlocked(wepID) then
                game.playthrough:addUnlockedWeapon(wepID)
            end
            local mods = wep:getMods()
            if mods then
                for key, modInst in ipairs(mods) do
                    if not modInst:getUniversalUnlock()
                        and not game.playthrough:getModUnlocked(modInst, wep) then
                        game.playthrough:unlockMod(modInst, wep)
                    end
                end
            end
        end
    end
end

function game.attemptLogMiscUnlocks() -- proto#190 params=0 locals=15 upvalues=0 vararg=false source=122029 lines=1020-1042
    if game.campaign then
        local campaignID = game.campaign:getID()
        local diffID = game.difficulty:getUnlockID()
        diffID = diffID or game.FALLBACK_DIFFICULTY_UNLOCK_WEAPONS
        for key, unlockWep in ipairs(game.playthrough:getUnlockedWeapons()) do
            game.logUnlockedWeapon(campaignID, diffID, unlockWep)
        end
        game.logUnlockedWeaponMods(campaignID, diffID, game.playthrough:saveUnlockedMods())
        game.logUnlockedAmmoTypes(campaignID, diffID, game.playthrough:saveUnlockedAmmoTypes())
        game.logMoney(campaignID, diffID, game.playthrough:getMoney())
        game.playthrough:verifyModBlueprintFacts()
        game.logUnlockedModBlueprints(campaignID, diffID, game.playthrough:getModBlueprintFacts())
    end
end

function game.logCompletedCampaignDifficulty(campaignID, difficultyID, playthroughHash) -- proto#189 params=3 locals=3 upvalues=0 vararg=false source=122029 lines=1045-1057
    game._verifyCampaignGamedata(campaignID, "completedCampaignTimesDifficulty")
    local dest = game.gameData.completedCampaignTimesDifficulty[campaignID][difficultyID]
    if not dest or type(dest) ~= "table" then
        dest = {}
        game.gameData.completedCampaignTimesDifficulty[campaignID][difficultyID] = dest
    end
    if not table.find(dest, playthroughHash) then
        table.insert(dest, playthroughHash)
    end
end

function game.getCompletedCampaignTimes(campaignID, difficultyID) -- proto#188 params=2 locals=7 upvalues=0 vararg=false source=122029 lines=1060-1079
    local mostTimes = 0
    local thisWeight = game.DIFFICULTY_SETTINGS_BY_ID[difficultyID].weight
    local campaignCompletionTimesData = game.gameData.completedCampaignTimesDifficulty[campaignID]
    if campaignCompletionTimesData then
        for i = 1, #game.DIFFICULTY_SETTINGS do
            local dif = game.DIFFICULTY_SETTINGS[i]
            if thisWeight <= dif.weight then
                local completionTimes = campaignCompletionTimesData[difficultyID]
                if completionTimes then
                    mostTimes = math.max(mostTimes, #completionTimes)
                end
            end
        end
    end
    return mostTimes
end

function game.logUnlockedWeapon(campaignID, difficultyID, weaponID) -- proto#187 params=3 locals=0 upvalues=0 vararg=false source=122029 lines=1083-1084
    game._writeCampaignDifficultyData(campaignID, difficultyID, weaponID, "unlockedWeapons")
end

function game.logLevelTrustLevel(campaignID, difficultyID, trustLevel) -- proto#186 params=3 locals=1 upvalues=0 vararg=false source=122029 lines=1088-1091
    game._verifyCampaignGamedata(campaignID, "trust")
    game.gameData.trust[campaignID][difficultyID] = trustLevel
end

function game.logUnlockedWeaponMods(campaignID, difficultyID, data) -- proto#185 params=3 locals=10 upvalues=0 vararg=false source=122029 lines=1094-1130
    game._verifyCampaignGamedata(campaignID, "unlockedMods")
    local dest = game.gameData.unlockedMods[campaignID][difficultyID]
    if not dest then
        dest = {}
        game.gameData.unlockedMods[campaignID][difficultyID] = dest
    end
    for key2, value in ipairs(data) do
        if type(value) == "table" then
            local found = false
            for a, b in ipairs(dest) do
                if type(b) == "table" and b.id == value.id then
                    found = b
                    break
                end
            end
            if found then
                for key, wepID in ipairs(value.weapons) do
                    if not table.find(found.weapons, wepID) then
                        table.insert(found.weapons, wepID)
                    end
                end
            else
                table.insert(dest, value)
            end
        elseif not table.find(dest, value) then
            table.insert(dest, value)
        end
    end
end

function game.logUnlockedAmmoTypes(campaignID, difficultyID, data) -- proto#184 params=3 locals=5 upvalues=0 vararg=false source=122029 lines=1133-1147
    game._verifyCampaignGamedata(campaignID, "unlockedAmmoTypes")
    local dest = game.gameData.unlockedAmmoTypes[campaignID][difficultyID]
    if not dest then
        dest = {}
        game.gameData.unlockedAmmoTypes[campaignID][difficultyID] = dest
    end
    for key, value in ipairs(data) do
        if not table.find(dest, value) then
            table.insert(dest, value)
        end
    end
end

function game.logUnlockedModBlueprints(campaignID, diffID, factList) -- proto#183 params=3 locals=5 upvalues=0 vararg=false source=122029 lines=1150-1164
    game._verifyCampaignGamedata(campaignID, "unlockedModBlueprints")
    local dest = game.gameData.unlockedModBlueprints[campaignID][diffID]
    if not dest then
        dest = {}
        game.gameData.unlockedModBlueprints[campaignID][diffID] = dest
    end
    for key, value in ipairs(factList) do
        if not table.find(dest, value) then
            table.insert(dest, value)
        end
    end
end

function game.logMoney(campaignID, difficultyID, money) -- proto#182 params=3 locals=1 upvalues=0 vararg=false source=122029 lines=1167-1170
    game._verifyCampaignGamedata(campaignID, "money")
    game.gameData.money[campaignID][difficultyID] = money
end

function game.handleUnlockMask(unlockMask, unlockBitValue) -- proto#181 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=1173-1174
    return not unlockMask or bit.band(unlockMask, unlockBitValue) == unlockBitValue
end

function game.transferNewGameData(campaignID, difficultyID, playthroughObject, unlockMask) -- proto#180 params=4 locals=15 upvalues=0 vararg=false source=122029 lines=1179-1224
    local unlockedWeapons, unlockedMods, unlockedAmmo, unlockedMoney, unlockedModBlueprints, unlockedLearningPoints = game.getNewGamePlusUnlocks(campaignID,
        difficultyID)
    if not unlockedWeapons and not unlockedMods and not unlockedAmmo and not finishedMoney then
        return
    end
    local unlockMods, unlockAmmo, unlockMoney, unlockWeapons, unlockLearningPoints = game.handleUnlockMask(unlockMask,
        playthroughObject.UNLOCKS_BITVALUES.MODS), game.handleUnlockMask(unlockMask,
        playthroughObject.UNLOCKS_BITVALUES.AMMO), game.handleUnlockMask(unlockMask,
        playthroughObject.UNLOCKS_BITVALUES.MONEY), game.handleUnlockMask(unlockMask,
        playthroughObject.UNLOCKS_BITVALUES.WEAPONS), game.handleUnlockMask(unlockMask,
        playthroughObject.UNLOCKS_BITVALUES.LEARNINGPOINTS)
    if unlockMods then
        playthroughObject:resetUnlockedMods()
    end
    if unlockAmmo then
        playthroughObject:resetUnlockedAmmo()
    end
    if unlockWeapons then
        for j = 1, #unlockedWeapons do
            playthroughObject:addUnlockedWeapon(unlockedWeapons[j])
        end
    end
    if unlockMods then
        playthroughObject:loadUnlockedMods(unlockedMods, true)
        playthroughObject:loadUnlockedModBlueprints(unlockedModBlueprints, true)
    end
    if unlockedAmmo then
        playthroughObject:loadUnlockedAmmoTypes(unlockedAmmo, true)
    end
    if unlockMoney then
        playthroughObject:initMoney(unlockedMoney, true)
    end
    if unlockLearningPoints then
        for key, plyType in ipairs(playerActor.playerTypes) do
            playthroughObject:changeLearningCapacity(plyType.id, unlockedLearningPoints)
        end
    end
    game.campaign:onModUnlocked()
end

function game.getNewGamePlusUnlocks(campaignID, difficultyID) -- proto#179 params=2 locals=46 upvalues=0 vararg=false source=122029 lines=1228-1352
    game._verifyCampaignGamedata(campaignID, "completedCampaignTimesDifficulty")
    difficultyID = difficultyID or game.FALLBACK_DIFFICULTY_UNLOCK_WEAPONS
    local thisWeight = game.DIFFICULTY_SETTINGS_BY_ID[difficultyID].weight
    local campaignData = game.getCampaignData(campaignID)
    local unlockedWeapons = game.gameData.unlockedWeapons[campaignID]
    local unlockedMods = game.gameData.unlockedMods[campaignID]
    local unlockedAmmo = game.gameData.unlockedAmmoTypes[campaignID]
    local unlockedModBlueprints = game.gameData.unlockedModBlueprints[campaignID]
    local finishedMoney = game.gameData.money[campaignID]
    local campaignCompletionTimesData = game.gameData.completedCampaignTimesDifficulty[campaignID]
    if not unlockedWeapons
        and not unlockedMods
        and not unlockedAmmo
        and not finishedMoney
        and not unlockedModBlueprints then
        return nil, nil, nil, 0
    end
    local wepList, modList, ammoList, modBlueprints = {}, {}, {}, {}
    local maxMoney = campaignData:getStartingMoney()
    local mostTimes = 0
    for i = 1, #game.DIFFICULTY_SETTINGS do
        local dif = game.DIFFICULTY_SETTINGS[i]
        if thisWeight <= dif.weight then
            local diffID = dif:getID()
            local list = unlockedWeapons[diffID]
            if list then
                for j = 1, #list do
                    local weaponID = list[j]
                    if not table.find(wepList, weaponID) then
                        local wepData = weapons.registeredByID[weaponID]
                        if wepData and campaignData:getWeaponLocked(weaponID) then
                            table.insert(wepList, list[j])
                        end
                    end
                end
            end
            if unlockedMods then
                local unlockedModsList = unlockedMods[diffID]
                if unlockedModsList then
                    for key, data in ipairs(unlockedModsList) do
                        if type(data) == "table" then
                            local insertDest = nil
                            for k, v in ipairs(modList) do
                                if type(v) == "table" and v.id == data.id then
                                    insertDest = v
                                    break
                                end
                            end
                            if not insertDest then
                                insertDest = { id = data.id, weapons = {} }
                                table.insert(modList, insertDest)
                            end
                            for k2, v2 in ipairs(data.weapons) do
                                if not table.find(insertDest.weapons, v2) then
                                    table.insert(insertDest.weapons, v2)
                                end
                            end
                        elseif not table.find(modList, data) then
                            table.insert(modList, data)
                        end
                    end
                end
            end
            if unlockedAmmo then
                local unlockedAmmoList = unlockedAmmo[diffID]
                if unlockedAmmoList then
                    for key2, data2 in ipairs(unlockedAmmoList) do
                        if not table.find(ammoList, data2) then
                            table.insert(ammoList, data2)
                        end
                    end
                end
            end
            if unlockedModBlueprints then
                local unlockedModBlueprintList = unlockedModBlueprints[diffID]
                if unlockedModBlueprintList then
                    for key3, data3 in ipairs(unlockedModBlueprintList) do
                        if not table.find(modBlueprints, data3) then
                            table.insert(modBlueprints, data3)
                        end
                    end
                end
            end
            if finishedMoney then
                local finishedWithMoney = finishedMoney[diffID]
                if finishedWithMoney then
                    maxMoney = math.max(finishedWithMoney, maxMoney)
                end
            end
            local completionTimes = campaignCompletionTimesData[diffID]
            if completionTimes then
                mostTimes = math.max(mostTimes, #completionTimes)
            end
        end
    end
    return wepList, modList, ammoList, maxMoney, modBlueprints, mostTimes
        * game.LEARNING_POINTS_PER_GAME_FINISH
end

function game.logFinishedLevel(level) -- proto#178 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=1355-1359
    if not game.getHasFinishedLevel(level) then
        table.insert(game.gameData.completedLevels, level)
        game.saveGameData()
    end
end

function game.getHasFinishedLevel(level) -- proto#177 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=1362-1371
    local list = game.gameData.completedLevels
    for i = 1, #list do
        if list[i] == level then
            return true
        end
    end
    return false
end

function game.logFinishedCampaign(id, hash) -- proto#176 params=2 locals=4 upvalues=0 vararg=false source=122029 lines=1374-1381
    game.logCompletedCampaignDifficulty(id, game.difficulty:getUnlockID(), hash)
    if not game.getHasFinishedCampaign(id) then
        table.insert(game.gameData.completedCampaigns, id)
    end
    game.saveGameData()
end

function game.getHasFinishedCampaign(id) -- proto#175 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=1384-1393
    local list = game.gameData.completedCampaigns
    for i = 1, #list do
        if list[i] == id then
            return true
        end
    end
    return false
end

function game.setCanInitHUD(can) -- proto#174 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=1396-1397
    game.canInitHUD = can
end

function game.confirmRestartLevelCallback(self) -- proto#173 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=1400-1401
    game.loadMap(self.mapID, true)
end

local r0_39 = game
local r0_40 = "saveJoyControls"
local r0_41 = {
    a = function(self, button) -- proto#172 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=1405-1407
        self.confirmButton:onJoyClick(gui.mouseKeys.LEFT)
        return true
    end,
    b = function(self) -- proto#171 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=1410-1412
        self:kill()
        return true
    end
}
r0_39[r0_40] = r0_41
local r0_42 = game
r0_40 = "createRestartLevelConfirmationPopup"

function r0_41(mapID) -- proto#170 params=1 locals=13 upvalues=0 vararg=false source=122029 lines=1416-1445
    local popup = game.createPopup(350, _T("POPUP_RESTART_LEVEL", "Restart Level?"),
        _T("POPUP_RESTART_LEVEL_CONTENTS", "Are you sure you want to restart the level?"),
        "pixellari24", "pixellari20", true, nil)
    popup:setAnimated(false)
    popup:setAlphaTarget(1)
    popup:wrapKeyPressMethod(game.saveJoyControls)
    popup:bringUp(1000)
    local confirmButt = popup:addButton("pixellari20", _T("YES", "Yes"),
        game.confirmRestartLevelCallback)
    confirmButt.mapID = mapID
    popup.confirmButton = confirmButt
    local noButt = popup:addButton("pixellari20", _T("NO", "No"), nil)
    popup:center()
    local viewResultKey = gui.create("HUDKeyPrompt")
    viewResultKey:setBinding("a")
    viewResultKey:setJoyOnly(true)
    viewResultKey:positionToElement(confirmButt, gui.SIDES.LEFT, 7)
    viewResultKey:tieVisibilityTo(confirmButt)
    local cancelKey = gui.create("HUDKeyPrompt")
    cancelKey:setBinding("b")
    cancelKey:setJoyOnly(true)
    cancelKey:positionToElement(noButt, gui.SIDES.LEFT, 7)
    cancelKey:tieVisibilityTo(noButt)
    frameController:push(popup)
end

r0_42[r0_40] = r0_41
local r0_43 = game
r0_40 = "MAIN_FRAMEBUFFER_PRIORITY"
r0_41 = render
r0_41 = r0_41.MAIN_FRAMEBUFFER_PRIORITY
r0_43[r0_40] = r0_41

local function mainFrameBufferDraw(self) -- proto#169 params=1 locals=11 upvalues=0 vararg=false source=122029 lines=1450-1541
    love.graphics.setBlendMode("replace", "premultiplied")
    camera:unset()
    self:applyZoom()
    love.graphics.setCanvas(render.MAIN_MRT)
    if self.shader then
        render:updatePluginShaders(self.shader)
        love.graphics.setShader(self.shader)
        love.graphics.draw(self.buffer, 0, 0, 0, self.xScale, self.yScale)
        love.graphics.setShader()
    else
        love.graphics.draw(self.buffer)
    end
    game.secondFrameBufferObject:generateMipmaps()
    render:setupExposure()
    render:renderPostEffects()
    if game.playerActor and game.playerActor:getDrawShadowOutline() and radiosity.radiosityState then
        love.graphics.setBlendMode("alpha", "alphamultiply")
        camera:set()
        love.graphics.setColor(37, 61, 76, 255)
        love.graphics.setCanvas(game.secondFrameBufferObject)
        love.graphics.setShader(shaders.writeUnlitColor)
        game.playerActor:drawOutline()
        camera:unset()
    end
    local finalShader = render:getFinalShader()
    love.graphics.setBlendMode("replace", "premultiplied")
    love.graphics.setColor(255, 255, 255, 255)
    if render.shouldMirrorBuffer then
        love.graphics.setCanvas(game.mainFrameBufferObject)
        love.graphics.setShader(finalShader)
        love.graphics.draw(game.secondFrameBufferObject)
        love.graphics.setShader()
        love.graphics.setCanvas()
        love.graphics.draw(game.mainFrameBufferObject, 0, 0)
    else
        love.graphics.setCanvas()
        love.graphics.setShader(finalShader)
        love.graphics.draw(game.secondFrameBufferObject)
        love.graphics.setShader()
    end
    love.graphics.setBlendMode("alpha", "alphamultiply")
    self:clearZoom()
    camera:set()
end

local r0_45 = game
r0_41 = "setMainFrameBuffer"
r0_45[r0_41] = function() -- proto#168 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=1544-1545
    love.graphics.setCanvas(game.mainFrameBufferObject)
end

function game.initMainFrameBuffer(newW, newH) -- proto#167 params=2 locals=23 upvalues=1 vararg=false source=122029 lines=1548-1573
    if game.mainFrameBuffer then
        priorityRenderer:remove(game.mainFrameBuffer)
        game.mainFrameBuffer:remove()
        game.skipLightBuffer:release()
        game.skipLightBuffer = nil
    end
    game.mainFrameBuffer = frameBuffer.new(newW, newH, false, render:getBufferFormat(), true)
    game.mainFrameBuffer:setDrawPosition(0, 0)
    game.mainFrameBuffer.draw = mainFrameBufferDraw
    priorityRenderer:add(game.mainFrameBuffer, game.MAIN_FRAMEBUFFER_PRIORITY)
    game.mainFrameBufferObject = game.mainFrameBuffer:getBuffer()
    game.mainFrameBufferObject:setFilter("nearest", "linear")
    local settings = { mipmaps = "manual", format = render:getBufferFormat() }
    game.secondFrameBuffer = frameBuffer.new(newW, newH, false, nil, true, settings)
    game.secondFrameBuffer:setDrawPosition(0, 0)
    game.secondFrameBufferObject = game.secondFrameBuffer:getBuffer()
    game.secondFrameBufferObject:setFilter("nearest", "linear")
    game.setupFinalSampleLevel()
    game.secondFrameBufferDims = { newW, newH }
    game.skipLightBuffer = love.graphics.newCanvas(newW, newH, { format = "r8" })
end

function game.setupFinalSampleLevel() -- proto#166 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=1576-1581
    if render.pixelization then
        game.secondFrameBufferObject:setMipmapFilter("nearest", -2)
    else
        game.secondFrameBufferObject:setMipmapFilter("linear", 0)
    end
end

function game.onResolutionChanged(w, h) -- proto#165 params=2 locals=41 upvalues=0 vararg=false source=122029 lines=1584-1672
    if game.postChangeSetup then
        return
    end
    do
        frameController:_stopRenderingBlur()
        game.postChangeSetup = true
        local newW, newH = resolutionHandler:getRealScreenResolution()
        if resolutionHandler.oldW and game.worldObject then
            local deltaX, deltaY = newW - resolutionHandler.oldW, newH - resolutionHandler.oldH
            local r165_4 = resolutionHandler
            resolutionHandler.oldH = nil
            r165_4.oldW = nil
            local r165_5 = camera
            local r165_6 = r165_5.setPosition
            local r165_7 = camera.x
            local r165_8 = deltaX * 0.5
            local r165_9 = camera.scaleX
            r165_7 = r165_7 - r165_8 / r165_9
            r165_8 = camera.y
            r165_9 = deltaY * 0.5
            local r165_10 = camera.scaleY
            r165_8 = r165_8 - r165_9 / r165_10
            r165_9 = true
            r165_10 = nil
            r165_6(r165_5, r165_7, r165_8, r165_9, r165_10)
        end
        love.window.setScreenSizeVariables()
        if game.secondFrameBuffer then
            game.secondFrameBuffer:remove()
        end
        game.initMainFrameBuffer(newW, newH)
        camera:setZoomLevel(camera:inferZoomLevel(), true)
        camera:updateScaledScreen()
        radiosity:onResolutionChanged()
        render:onResolutionChanged()
        shadowMapping:onResolutionChanged()
        wallHighlightShader:onResolutionChanged()
        outlineShader:onResolutionChanged()
        actor:rebuildFonts()
        talkText.renderer:onResolutionChanged()
        fakeShadows:onResolutionChanged()
        cullingTester:setupRenderBounds()
        mapEditor:updateWorldFont()
        game.clearHUDElements()
        gui.removeAllUIElements()
        objectSelector:onResolutionChanged()
        objectiveHandler:onResolutionChanged()
        love.capFPSLimit()
        mainMenu:onResolutionChanged()
        if game.worldObject then
            game.worldObject:setCameraLimits()
        end
        if not configLoader:isReading() then
            game.saveUserPreferences()
        end
        if game.worldObject then
            game.worldObject:queueQuadtreeUpdate()
        end
        collectgarbage("collect")
        collectgarbage("collect")
        if game.isFirstLaunch then
            game.isFirstLaunch = false
        end
        events:fire(game.EVENTS.RESOLUTION_CHANGED)
        return
    end
end

function game.onFirstLaunch() -- proto#164 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1675-1677
    game.isFirstLaunch = true
    render:setBloom(GET_BUILD_VALUE("bloom", true))
end

function game.onStarted() -- proto#163 params=0 locals=16 upvalues=0 vararg=false source=122029 lines=1681-1755
    game.loadGameData()
    game.loadUserPreferences()
    musicPlayback:_init()
    inputService:setInputType(inputService.INPUT_TYPES.KEYBOARD)
    if not keyBinding:getWasLoaded() then
        local maxSliderFPS, maxFPS = render:getMaxFPS()
        love.setFPSLimit(maxFPS)
        keyBinding:initDefaultKeys()
        game.saveUserPreferences()
    end
    cutscene:onGameStarted()
    game.initFinished = true
    cache.processSourceLoadCache()
    love.filesystem.loadMods()
    if steam then
        steam.LoadMods()
    end
    maps:registerModMaps("maps/autoload/")
    game.loadModPreferences()
    game.loadDLCS()
    actor.onObjectsInit()
    attackRecord:onGameStarted()
    events:fire(game.EVENTS.POST_MODS_LOADED)
    game.buildMutatorsExclusions()
    game.initMainState()
    events:fire(game.EVENTS.ON_START_FINISH)
    weapons:setupModCategoryMaps()
    for key, camp in ipairs(game.campaigns) do
        camp:onGameStartup()
    end
    ammo.sortListedAmmo()
    ammo.buildStatText()
    weapons:buildWeaponStatLists()
    cache.processSourceLoadCache()
    if INSTANT_CONTINUE then
        return
    end
end

function game.openMainMenu() -- proto#162 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1758-1764
    if SHOW_SPLASH_SCREEN then
        game.initSplashScreen()
    else
        game.initMainState()
        mainMenu:create()
    end
end

function game.attemptLoadMostRecentSavefile() -- proto#161 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1767-1775
    local mostRecent = game.getMostRecentSavedGame()
    if mostRecent then
        game.load(game.getSaveFileName(mostRecent))
        return true
    end
    return false
end

local r0_46 = game
local r0_47 = "backgroundColor"
local r0_48 = color(0, 19, 28, 255)
r0_46[r0_47] = r0_48
local r0_49 = game
r0_47 = "badCPUModels"
r0_48 = {
    "13100", "13400", "13500", "13600", "13700", "13420", "13900", "14100", "14400", "14490",
    "14500", "14600", "14700", "14790", "14900"
}
r0_49[r0_47] = r0_48
local r0_50 = game
r0_47 = "initSplashScreen"

function r0_48() -- proto#158 params=0 locals=31 upvalues=0 vararg=false source=122029 lines=1801-1864
    local lineCount, textList, r158_2, r158_3
    splash:insertNew("textures/logo_ht.png", 0, nil, nil, game.backgroundColor)
    splash:insertNew("textures/logo_ht.png", 1.5, nil, nil, game.backgroundColor)
    splash:insertNew("textures/logo_esg.png", 1.5, nil, nil, game.backgroundColor)
    if PC_BUILD then
        splash:insertNew(nil, 3, nil, nil, game.backgroundColor,
            function(data) -- proto#160 params=1 locals=21 upvalues=0 vararg=false source=122029 lines=1807-1823
                local text, font = _T("OPTIMAL_PLAY_KEYBOARD_MOUSE",
                    "OPTIMAL PLAY USING KEYBOARD & MOUSE"), fonts.get("pixellari28")
                love.graphics.setFont(font)
                local textW = font:getWidth(text)
                local fontH = font:getHeight()
                local r, g, b = game.UI_COLORS.GENERIC_TEXT_COLOR:unpack()
                love.graphics.setColor(r, g, b, data.alpha)
                love.graphics.print(text, scrW * 0.5 - textW * 0.5, scrH * 0.5 - fontH * 0.5)
                local quadData = quadLoader:getQuadStructure("keyboard_mouse")
                local r160_8 = _S(quadData.w)
                local w = r160_8 * 2
                r160_8 = nil
                local r160_10 = _S(quadData.h)
                local h = r160_10 * 2
                r160_10 = nil
                local scaleW = w / quadData.w
                local scaleH = h / quadData.h
                love.graphics.setColor(255, 255, 255, data.alpha)
                love.graphics.draw(quadData.texture, quadData.quad, scrW * 0.5 - w * 0.5,
                    scrH * 0.5 + fontH * 2, 0, scaleW, scaleH)
            end)
    end
    local cpuModel = CPU_MODEL
    if cpuModel then
        local r158_5 = cpuModel:lower()
        cpuModel = r158_5
        r158_5 = cpuModel.find
        if r158_5(cpuModel, "intel") then
            for key, modelID in ipairs(game.badCPUModels) do
                if cpuModel:find(modelID) then
                    local text = _T("INTEL_DEFECTIVE_MODELS_DISCLAIMER",
                        [[Intravenous 2 has detected that you have an Intel processor of either 13th or 14th generation.

Please be informed that there are increasing cases of Intel 13th and 14th generation CPUs being defective.
Defective CPU samples are unstable and Intravenous 2 is very sensitive to CPU instability.

Due to this the game might crash with CPUs of these generations for no good reason.
Unfortunately, I am unable to do anything about this.

Owners of Intel 13th and 14th generation processors can work around this by reducing the processor's clockrate (generally called 'ratio' in Intel software) to avoid these crashes.
Please find a guide on how to do this if you are experiencing issues.]])
                    local font = fonts.get("pixellari20")
                    local r158_10 = string.wrap
                    local r158_11 = _S
                    local wrappedText, textH, textW
                    wrappedText, lineCount, textH, textList, textW = r158_10(text, font,
                        r158_11(800))
                    local fontH = font:getHeight()
                    local r158_16 = splash
                    local r158_17 = r158_16.insertNew
                    r158_2 = nil
                    r158_3 = nil
                    r158_17(r158_16, nil, 30, r158_2, r158_3, game.backgroundColor,
                        function(data) -- proto#159 params=1 locals=16 upvalues=5 vararg=false source=122029 lines=1840-1854
                            love.graphics.setFont(font)
                            local r, g, b = game.UI_COLORS.GENERIC_TEXT_COLOR:unpack()
                            love.graphics.setColor(r, g, b, data.alpha)
                            local textY = scrH * 0.5
                            love.graphics.print(wrappedText, scrW * 0.5 - textW * 0.5,
                                textY - textH * 0.5)
                            local r2, g2, b2 = game.UI_COLORS.GENERIC_STAT_COLOR:unpack()
                            love.graphics.setColor(r2, g2, b2, data.alpha)
                            local skipText = _T("PRESS_ANYTHING_TO_SKIP",
                                "Press any button/key to skip this.")
                            local skipW = font:getWidth(skipText)
                            love.graphics.print(skipText, scrW * 0.5 - skipW * 0.5,
                                textY + textH * 0.5 + fontH * 2)
                        end)
                end
            end
        end
    end
    splash:show()
    game.stopInputHandler()
    game.stopMainStates()
end

r0_50[r0_47] = r0_48
local r0_51 = game
r0_47 = "initMainState"

function r0_48() -- proto#157 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1867-1877
    game.mainInputHandler = require("game/input_handler")
    game.mainRenderer = require("game/main_renderer")
    game.mainMenuRenderer = require("game/main_menu_renderer")
    game.mainState = require("game/main_state")
    game.levelIntroState = require("game/level_intro_state")
end

r0_51[r0_47] = r0_48
local r0_52 = game
r0_47 = "getSaveFileName"

function r0_48(baseFileName, quicksave) -- proto#156 params=2 locals=9 upvalues=0 vararg=false source=122029 lines=1880-1887
    local r156_0
    if baseFileName then
        r156_0 = baseFileName
    else
        r156_0 = game.SAVE_FILE_NAME
        local r156_1 = love.filesystem.getDirectoryItems(game.SAVE_DIRECTORY)
        r156_1 = #r156_1
        r156_1 = r156_1 + 1
        r156_0 = r156_0 .. r156_1
    end
    local r156_2 = quicksave and game.QUICKSAVE_FILE_FORMAT or game.SAVE_FILE_FORMAT
    local finalString = r156_0 .. r156_2
    if game.campaign then
        r156_2 = game.SAVE_DIRECTORY
        local r156_4 = game.campaign
        r156_4 = r156_4:formatFinalSaveName(finalString)
        return r156_2 .. r156_4
    end
    r156_2 = game.SAVE_DIRECTORY
    local r156_5 = finalString
    return r156_2 .. r156_5
end

r0_52[r0_47] = r0_48
local r0_53 = game
r0_47 = "applySavefileDirectory"

function r0_48(savefile) -- proto#155 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=1890-1891
    return game.SAVE_DIRECTORY .. savefile
end

r0_53[r0_47] = r0_48
local r0_54 = game
r0_47 = "getPreviewFile"

function r0_48(savePath) -- proto#154 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=1894-1895
    return savePath .. game.SAVE_FILE_FORMAT_PREVIEW
end

r0_54[r0_47] = r0_48
local r0_55 = game
r0_47 = "beginSaving"

function r0_48(path, skipSaveGameStringUpdate, quitOnSave, quietSave) -- proto#153 params=4 locals=6 upvalues=0 vararg=false source=122029 lines=1898-1914
    if mapEditor:isActive() then
        return
    end
    if SAVESLOT_MODE and game.campaign then
        local r153_0 = game.getSaveFileName
        local r153_1 = game.campaign
        path = r153_0(r153_1:getSaveslot())
    end
    game.savingGame = true
    inputService:removeHandler(game.mainInputHandler)
    game.savePath = path
    game.skipSaveGameStringUpdate = skipSaveGameStringUpdate
    game.quitOnSave = quitOnSave
    game.quietSave = quietSave
    render:requestFrameBufferMirror(game)
end

r0_55[r0_47] = r0_48
local r0_56 = game
r0_47 = "finishSaving"

function r0_48() -- proto#152 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1917-1927
    game.save(game.savePath, game.skipSaveGameStringUpdate)
    render:unrequestFrameBufferMirror(game)
end

r0_56[r0_47] = r0_48
local r0_57 = game
r0_47 = "canHaveInput"

function r0_48() -- proto#151 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1930-1931
    return not game.savingGame
end

r0_57[r0_47] = r0_48
local r0_58 = game
r0_47 = "validateSavefile"

function r0_48(saveData) -- proto#150 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=1934-1937
    for a, b in pairs(saveData) do
        game._validateSavefile(a, b, "")
    end
end

r0_58[r0_47] = r0_48
local r0_59 = game
r0_47 = "_validateSavefile"

function r0_48(key, value, root) -- proto#149 params=3 locals=14 upvalues=0 vararg=false source=122029 lines=1940-1955
    local r149_0 = nil
    if type(key) == "number" then
        r149_0 = root
        local r149_1 = key
        root = r149_0 .. "[" .. r149_1 .. "]"
    else
        r149_0 = root
        root = r149_0 .. "." .. tostring(key)
    end
    local r149_2 = type
    r149_0 = nil
    r149_0 = nil
    if r149_2(key) == "function" or type(value) == "function" then
        local r149_3 = error
        local r149_4 = tostring(root)
        local r149_5 = tostring(value)
        local r149_6 = "function found in save file, key: '" .. r149_4 .. "' value: '" .. r149_5
            .. "'"
        r149_4 = nil
        r149_5 = nil
        r149_3(r149_6)
    end
    if type(value) == "table" then
        for a, b in pairs(value) do
            game._validateSavefile(a, b, root)
        end
    end
end

r0_59[r0_47] = r0_48
local r0_60 = game
r0_47 = "deduceSaveCount"

function r0_48() -- proto#148 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=1958-1968
    if game.remainingSaves <= 0 then
        return
    end
    game.remainingSaves = game.remainingSaves - 1
    if game.playerActor then
        game.playerActor:onSaveCountDeduced()
    end
end

r0_60[r0_47] = r0_48
local r0_61 = game
r0_47 = "addSaveCount"

function r0_48(change) -- proto#147 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=1971-1974
    if game.remainingSaves ~= -1 then
        game.remainingSaves = game.remainingSaves + change
    end
end

r0_61[r0_47] = r0_48
local r0_62 = game
r0_47 = "grantExplorationSaves"

function r0_48() -- proto#146 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=1978-1986
    if game.difficulty and game.remainingSaves ~= -1 then
        local saveCount = game.difficulty:getExplorationSaves()
        game.remainingSaves = game.remainingSaves + saveCount
        if saveCount > 0 then
            game.createSavefilesGrantUIElement()
        end
    end
end

r0_62[r0_47] = r0_48
local r0_63 = game
r0_47 = "grantTravelSaves"

function r0_48() -- proto#145 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=1989-1997
    if game.difficulty and game.remainingSaves ~= -1 then
        local saveCount = game.difficulty:getTravelSaves()
        game.remainingSaves = game.remainingSaves + saveCount
        if saveCount > 0 then
            game.createSavefilesGrantUIElement()
        end
    end
end

r0_63[r0_47] = r0_48
local r0_64 = game
r0_47 = "grantMoneyPickupSaves"

function r0_48() -- proto#144 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=2000-2008
    if game.difficulty and game.remainingSaves ~= -1 then
        local saveCount = game.difficulty:getMoneyPickupSaves()
        game.remainingSaves = game.remainingSaves + saveCount
        if saveCount > 0 then
            game.createSavefilesGrantUIElement()
        end
    end
end

r0_64[r0_47] = r0_48
local r0_65 = game
r0_47 = "grantUniqueWeaponSaves"

function r0_48() -- proto#143 params=0 locals=4 upvalues=0 vararg=false source=122029 lines=2011-2020
    if not game.uniqueWeaponSaveGranted and game.difficulty and game.remainingSaves ~= -1 then
        local saveCount = game.difficulty:getUniqueWeaponSaves()
        game.remainingSaves = game.remainingSaves + saveCount
        game.uniqueWeaponSaveGranted = true
        if saveCount > 0 then
            game.createSavefilesGrantUIElement()
        end
    end
end

r0_65[r0_47] = r0_48
local r0_66 = game
r0_47 = "createSavefilesGrantUIElement"

function r0_48() -- proto#142 params=0 locals=6 upvalues=0 vararg=false source=122029 lines=2023-2027
    local elem = gui.create("SavefilesGrantedIcon")
    elem:setSize(63, 43.5)
    elem:setPos(scrW - _S(100) - elem.w, _S(100))
    game.addHUDElement(elem)
end

r0_66[r0_47] = r0_48
local r0_67 = game
r0_47 = "getKeyName"

function r0_48(keyID) -- proto#141 params=1 locals=5 upvalues=0 vararg=false source=122029 lines=2031-2042
    local keycardNames = objects.getClassData("keycard").GENERIC_KEY_NAMES
    local keychainNames = objects.getClassData("keychain").GENERIC_KEY_NAMES
    local validKeyName = false
    if keycardNames[keyID] and keycardNames[keyID][1] then
        return keycardNames[keyID][1], true
    end
    if keychainNames[keyID] and keychainNames[keyID][1] then
        return keychainNames[keyID][1], true
    end
    return keyID, false
end

r0_67[r0_47] = r0_48
local r0_68 = game
r0_47 = "save"

function r0_48(path, skipSaveGameStringUpdate) -- proto#140 params=2 locals=28 upvalues=1 vararg=false source=122029 lines=2045-2160
    inputService:removeHandler(game.mainInputHandler)
    local data = {}
    data.achievements = achievements:save()
    if game.difficulty then
        if game.difficulty.CUSTOM then
            data.difficulty = game.difficulty:save()
        else
            data.difficulty = game.difficulty.id
        end
    end
    local mutatorsIDs = {}
    if game.playthrough then
        data.playthrough = game.playthrough:save()
        game.playthrough:fillMutatorsList(mutatorsIDs)
    else
        print("WARNING: saving a savefile without playthrough data!")
    end
    if game.campaign then
        data.campaign = game.campaign:save()
    end
    game.savefileSaves = game.remainingSaves
    data.curDeaths = game.curDeaths
    data.quicksaves = game.quicksaves
    data.lowestDifficultyID = game.lowestDifficultyID
    data.world = game.worldObject:save()
    data.remainingSaves = game.remainingSaves
    data.levelTime = game.levelTime
    data.levelStartData = game.levelStartData
    data.playerInterLevelData = game.playerInterLevelData
    local r140_2, r140_3 = game.worldObject:getGridSize()
    data.WORLD_HEIGHT = r140_3
    data.WORLD_WIDTH = r140_2
    r140_2 = game
    r140_2 = r140_2.WORLD_HEIGHT
    data.WORLD_HEIGHT = r140_2
    local components = {}
    data.loadComponents = components
    r140_3 = ipairs
    local r140_5, r140_6, r140_7 = r140_3(game.LOAD_COMPONENTS)
    for key, component in r140_5, r140_6, r140_7 do
        local r140_10 = component.id
        local r140_11 = component:save(data)
        components[r140_10] = r140_11
    end
    local path2
    if path and string.gsub(path, "%s+", "") ~= "" then
        path2 = path
    else
        path2 = game.getSaveFileName()
    end
    path = path2
    hook.call("saveGame", data)
    local r140_13 = game.mainFrameBufferObject
    local screenshot = r140_13:newImageData()
    local sendData = {
        campaign = nil, difficulty = nil, health = nil, levelID = nil, mutators = nil,
        playtime = nil, playtimeTotal = nil, previewPath = nil, quicksaves = nil, saveData = nil,
        saveDate = nil, savePath = nil, screenH = nil, screenW = nil, screenshot = nil,
        screenshotScale = nil
    }
    local r140_16 = tostring(bitser.dumps(data))
    sendData.saveData = r140_16
    sendData.savePath = path
    r140_16 = os
    r140_16 = r140_16.time
    r140_16 = r140_16()
    sendData.saveDate = r140_16
    r140_16 = game
    r140_16 = r140_16.worldObject
    local r140_17 = r140_16
    r140_16 = r140_17.getMapID
    r140_16 = r140_16(r140_17)
    sendData.levelID = r140_16
    sendData.mutators = mutatorsIDs
    r140_16 = game
    r140_16 = r140_16.quicksaves
    sendData.quicksaves = r140_16
    sendData.screenshot = screenshot
    r140_16 = scrW
    sendData.screenW = r140_16
    r140_16 = scrH
    sendData.screenH = r140_16
    r140_16 = game
    r140_16 = r140_16.playerActor
    r140_16 = r140_16 and game.playerActor:getHealth()
    sendData.health = r140_16
    r140_16 = game
    r140_16 = r140_16.difficulty.id
    sendData.difficulty = r140_16
    r140_16 = game
    r140_16 = r140_16.levelTime
    sendData.playtime = r140_16
    r140_16 = game
    r140_16 = r140_16.playthrough
    r140_17 = r140_16
    r140_16 = r140_17.getPlaythroughTime
    r140_16 = r140_16(r140_17)
    sendData.playtimeTotal = r140_16
    r140_16 = game
    r140_16 = r140_16.PREVIEW_SCREENSHOT_SCALER
    sendData.screenshotScale = r140_16
    r140_16 = path
    r140_16 = r140_16 .. game.SAVE_FILE_FORMAT_PREVIEW
    sendData.previewPath = r140_16
    r140_16 = game
    r140_16 = r140_16.campaign
    r140_16 = r140_16 and game.campaign.id
    sendData.campaign = r140_16
    r140_16 = game
    r140_16 = r140_16.GAME_SAVE_IN_CHANNEL
    r140_17 = r140_16
    r140_16 = r140_17.push
    r140_16(r140_17, sendData)
    r140_16 = nil
    sendData.screenshot = r140_16
    if not skipSaveGameStringUpdate then
        game.currentLoadedSaveFile = path
    end
    if game.quitOnSave then
        game.quitToMainMenu()
    end
    game.quitOnSave = false
    game.savingGame = false
    if not game.quietSave then
        game.createGameSavedHeader()
    end
    game.quietSave = false
    local r140_18 = mainMenu
    if not r140_18:getIngameMenuCreated() then
        local r140_19 = inputService
        r140_19:addHandler(game.mainInputHandler)
    end
    local r140_20 = events
    r140_20:fire(game.EVENTS.GAME_SAVED)
end

r0_68[r0_47] = r0_48
local r0_69 = game
r0_47 = "createGameSavedHeader"

function r0_48() -- proto#139 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=2163-2165
    events:fire(game.EVENTS.PRE_CREATE_SAVE_INDICATOR)
    local elem = gui.create("GameSavedIndicator")
end

r0_69[r0_47] = r0_48
local r0_70 = game
r0_47 = "addBullet"

function r0_48(bullet) -- proto#138 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=2168-2174
    if bullet.IN_BULLET_LIST then
        return
    end
    table.insert(game.activeBullets, bullet)
    bullet.IN_BULLET_LIST = true
end

r0_70[r0_47] = r0_48
local r0_71 = game
r0_47 = "removeBullet"

function r0_48(bullet) -- proto#137 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=2177-2179
    table.removeObject(game.activeBullets, bullet)
    bullet.IN_BULLET_LIST = false
end

r0_71[r0_47] = r0_48
local r0_72 = require
r0_48 = "game/update_list"
local updateList = r0_72(r0_48)

function game.initDynamicObjectList(dtOverride) -- proto#136 params=1 locals=2 upvalues=1 vararg=false source=122029 lines=2184-2192
    local list = game.dynamicObjectLists[dtOverride]
    if not list then
        list = updateList.new(dtOverride)
        game.dynamicObjectLists[dtOverride] = list
    end
    return list
end

game.initDynamicObjectList(0)

function game.addDynamicObject(object) -- proto#135 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2197-2210
    if object.IN_DYNAMIC_LIST then
        return false
    end
    do
        object.IN_DYNAMIC_LIST = true
        local list = object.DYNAMIC_LIST_DEST
        if list:insertObject(object) then
            table.insert(game.dynamicObjects, list)
        end
        return true
    end
end

function game.removeDynamicObject(object) -- proto#134 params=1 locals=3 upvalues=0 vararg=false source=122029 lines=2213-2241
    if object.IN_DYNAMIC_LIST then
        local list = object.DYNAMIC_LIST_DEST
        object.IN_DYNAMIC_LIST = false
        local active, wasRemoved = list:removeObject(object)
        if wasRemoved then
            if not active then
                table.removeObject(game.dynamicObjects, list)
                game.dynListIter = game.dynListIter - 1
            end
            game.dynIter = game.dynIter - 1
        end
        return true
    end
    return false
end

function game.getDynamicObject(object) -- proto#133 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2244-2251
    for key, otherObject in ipairs(object.DYNAMIC_LIST_DEST) do
        if object == otherObject then
            return key
        end
    end
    return nil, nil
end

function game.updateDynamicObjects(dt) -- proto#132 params=1 locals=9 upvalues=0 vararg=false source=122029 lines=2254-2301
    local rListIdx = 1
    local l = game.dynamicObjects
    game.dynListIter = #l
    while game.dynListIter > 0 do
        local list = l[rListIdx]
        local updList, interval = list:update(dt)
        if updList then
            local elemList = updList:getObjects()
            game.dynIter = #elemList
            local rIdx = 1
            while game.dynIter > 0 do
                local obj = elemList[rIdx]
                obj:setUpdated(false)
                if obj:update(interval) then
                    rIdx = rIdx + 1
                elseif obj.IN_DYNAMIC_LIST then
                    obj.IN_DYNAMIC_LIST = false
                    table.remove(elemList, rIdx)
                end
                game.dynIter = game.dynIter - 1
            end
            if #elemList > 0 then
                rListIdx = rListIdx + 1
            elseif updList.active then
                updList.active = false
                table.remove(l, rListIdx)
            else
                rListIdx = rListIdx + 1
            end
        else
            rListIdx = rListIdx + 1
        end
        game.dynListIter = game.dynListIter - 1
    end
end

function game.createEffect(effectName, x, y, depth) -- proto#131 params=4 locals=2 upvalues=0 vararg=false source=122029 lines=2306-2314
    local obj = objects.create("effect")
    obj:setPos(x, y)
    obj:assignID()
    obj:setEffect(effectName)
    obj:setDepth(depth)
    obj:onPlacedIntoMap()
    return obj
end

function game.createFlash(maxSize, duration, colorObj, x, y) -- proto#130 params=5 locals=2 upvalues=0 vararg=false source=122029 lines=2318-2330
    local obj = objects.create("flash")
    obj:assignID()
    obj:setCanSave(false)
    obj:setPos(x, y)
    obj:setQuad("lens_flare")
    obj:setMaxSize(maxSize)
    obj:setDuration(duration)
    obj:setColor(colorObj)
    obj:setDepth(100)
    obj:onPlacedIntoMap()
    return obj
end

function game.createAmbientNoise(x, y, radius, noiseLevel) -- proto#129 params=4 locals=3 upvalues=0 vararg=false source=122029 lines=2334-2345
    local halfRadius = radius * 0.5
    local src = objects.create("environment_noise")
    src:setSize(radius, radius)
    src:setNoise(noiseLevel)
    src:setPos(x - halfRadius, y - halfRadius)
    src:setCanSave(false)
    src:setCanReset(false)
    src:onPlacedIntoMap()
    return src
end

local r0_74 = game
local r0_75 = "_fallbackShrapnelConfig"
local r0_76 = { amount = 30, armorPenetration = 7, damage = 30, height = nil, speed = nil }
local r0_77 = { 900, 1500 }
r0_76.speed = r0_77
r0_77 = { 100, 140 }
r0_76.height = r0_77
r0_74[r0_75] = r0_76
local r0_78 = game
r0_75 = "createShrapnel"

function r0_76(cfg, x, y, attacker) -- proto#128 params=4 locals=15 upvalues=0 vararg=false source=122029 lines=2356-2392
    cfg = cfg or game._fallbackShrapnelConfig
    local dt = frameTime
    local buffer = game.worldObject:getShrapnelBuffer()
    local shrapSpeedMin, shrapSpeedMax = cfg.speed[1], cfg.speed[2]
    local shrapDamage = cfg.damage
    local shrapPen = cfg.armorPenetration
    local shrapHeightMin, shrapHeightMax = cfg.height[1], cfg.height[2]
    local flammableSeq = cfg.flammableSequence
    for i = 1, cfg.amount do
        local shrap = buffer:retrieve()
        shrap:setPos(x, y)
        shrap:setBulletHeight(math.random(shrapHeightMin, shrapHeightMax))
        shrap:setBulletVerticalAng(0)
        shrap:setShootPos(x, y)
        shrap:setSpeed(math.random(shrapSpeedMin, shrapSpeedMax))
        shrap:setDamage(shrapDamage, shrapDamage)
        shrap:setArmorPenetration(shrapPen)
        shrap:setAngle(math.randomf(-180, 180))
        shrap:setFirer(attacker)
        shrap:setFlybyEmit(true)
        shrap:setFlammable((i - 1) % flammableSeq + 1 == 7)
        shrap:update(dt)
        if not shrap:getStored() then
            shrap:makeActive()
            game.addBullet(shrap)
        end
    end
end

r0_78[r0_75] = r0_76
local r0_79 = game
r0_75 = "dealExplosionDamage"

function r0_76(range, exploder, objList) -- proto#127 params=3 locals=10 upvalues=0 vararg=false source=122029 lines=2395-2415
    local exX, exY = exploder:getCenter()
    local blastMask = exploder:getBlastMask()
    local blastHeight = exploder:getBlastHeight()
    for key, obj in ipairs(objList) do
        if exploder:getCanBlastObject(obj) then
            local objX, objY = obj:getPos()
            local dist = math.magnitude(objX - exX, objY - exY)
            if dist <= range then
                local hd = exploder:runGenericRaycastNoObject(exX, exY, objX, objY, blastHeight, 0,
                    blastMask, exploder)
                if not hd.fixture or hd.fixture == obj:getFixture() or hd.fraction == 1 then
                    exploder:onBlast(obj, dist)
                end
            end
        end
        objList[key] = nil
    end
end

r0_79[r0_75] = r0_76
local r0_80 = game
r0_75 = "createScorchMark"

function r0_76(x, y, markList) -- proto#126 params=3 locals=7 upvalues=0 vararg=false source=122029 lines=2418-2426
    local randomQuad = markList[math.random(1, #markList)]
    local mark = objects.create("grenade_scorch")
    mark:setDepth(15)
    mark:setAngle(math.randomf(-math.pi, math.pi))
    mark:setQuad(randomQuad)
    mark:setPos(x - mark.width * 0.5, y - mark.height * 0.5)
    mark:assignID()
    mark:onPlacedIntoMap()
end

r0_80[r0_75] = r0_76
local r0_81 = game
r0_75 = "disableSaving"

function r0_76() -- proto#125 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=2429-2430
    game.savingDisabled = true
end

r0_81[r0_75] = r0_76
local r0_82 = game
r0_75 = "enableSaving"

function r0_76() -- proto#124 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=2433-2434
    game.savingDisabled = false
end

r0_82[r0_75] = r0_76
local r0_83 = game
r0_75 = "getSavingDisabled"

function r0_76() -- proto#123 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=2437-2438
    return game.savingDisabled
end

r0_83[r0_75] = r0_76
local seentables = nil
local prevResults = {}
local theseResults = {}

local function __countRecursive(tbl, key) -- proto#122 params=2 locals=3 upvalues=3 vararg=false source=122029 lines=2445-2456
    local items = table.count(tbl)
    prevResults[key] = items
    for a, b in pairs(tbl) do
        if type(b) == "table" and not seentables[b] then
            seentables[b] = true
            items = items + __countRecursive(b, a)
        end
    end
    return items
end

local function _countTables() -- proto#121 params=0 locals=8 upvalues=4 vararg=false source=122029 lines=2459-2487
    local total = 0
    seentables = {}
    for a, b in pairs(_G) do
        if type(b) == "table" then
            total = total + __countRecursive(b, a)
        end
    end
    for a2, b2 in pairs(prevResults) do
        if theseResults[a2] and theseResults[a2] < b2 then
            print("INCREASED", a2, b2)
        end
        theseResults[a2] = b2
    end
    for a3, b3 in pairs(theseResults) do
        if not prevResults[a3] then
            prevResults[a3] = nil
        end
    end
    print("oh boyo!", total)
    seentables = nil
end

function game.removeActiveBullets() -- proto#120 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=2490-2494
    for key, object in ipairs(game.activeBullets) do
        game.activeBullets[key] = nil
        object:remove()
    end
end

function game.resetDynamicObjectLists() -- proto#119 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=2497-2501
    for i, list in ipairs(game.dynamicObjects) do
        list:clear()
        game.dynamicObjects[i] = nil
    end
end

function game.remove() -- proto#118 params=0 locals=26 upvalues=0 vararg=false source=122029 lines=2504-2602
    love.clearGameDTBlockers()
    events:fire(game.EVENTS.PRE_REMOVE_GAME)
    if game.mainFrameBuffer then
        game.mainFrameBuffer:setShader()
    end
    game._removing = true
    pathComputeQueue:cancelSearches()
    game.clearSavePreviews()
    game.setTimescale(1)
    sound.manager:clearAll()
    mainMenu:clearAll()
    gui.removeAllUIElements()
    game.clearHUDElements()
    game.canOpenMainMenu = true
    game.uniqueWeaponSaveGranted = false
    game.lowestDifficultyID = nil
    game.ingameDifficulty = nil
    game.preLevelListDifficulty = nil
    game.preLevelListCampaign = nil
    frameController:clearMouseResetCoords()
    inputService:removeHandler(game.mainInputHandler)
    camera:onLevelRemoved()
    game.removeMainPathfinder()
    game.gameOver = false
    cutscene.state:remove()
    objects.clearUIDCounter()
    game.quicksaves = 0
    love.setClearColor(0, 0, 0, 0)
    actor.getClassData("goon").resetSwearStrings()
    game.clearCapturedMousePosition()
    radiosity:setSkipFinalPass(false)
    loadoutSelectionMenu:remove()
    if game.worldObject then
        if game.playerActor then
            game.removePlayerActor()
        end
        game.resetDynamicObjectLists()
        game.removeActiveBullets()
        envController:removeRoofObstructors()
        game.worldObject:remove()
        game.worldObject = nil
        hitData.resetAll()
        game.sendToPathfinderThreads(pathfinderThread.MESSAGE_TYPE.CLEAR_GRID)
        game.removeModules()
        musicPlayback:reset()
        radiosity:remove()
        sceneHandler:remove()
        cutscene:removeAll()
        cutscene:clearRuntime()
        scene:removeAll()
        cutscene.state:removeStateStarter()
        game.canSendGridUpdateToThreads = false
        achievements:remove()
        objectSelector:remove()
        pathComputeQueue:remove()
        dialogueHandler:remove()
        floors:reset()
        game.stopMainStates()
        game.clearFixtureMap()
    end
    spriteBatchController:removeEmptySpritebatches()
    game.finishRemoving()
end

function game.createMainMenuFader(fadeColor) -- proto#117 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2605-2612
    local fader = gui.create("ScreenFader")
    fader:setSize(scrW, scrH)
    fader:setFadeOutState()
    fader:setAlpha(1)
    fader:setTargetAlpha(0)
    local r117_1 = fader
    r117_1:setFadeColor(fadeColor or game.BACKGROUND_RED)
    r117_1 = fader
    r117_1:addDepth(1000)
end

function game.quitToMainMenu() -- proto#116 params=0 locals=14 upvalues=0 vararg=false source=122029 lines=2615-2645
    game.setupActiveColorsUI()
    game.remove()
    game.resetDifficulty()
    game.removeCampaign()
    game.removePlaythrough()
    game.flushInterLevelData()
    loadoutSelectionMenu:reset()
    talkText.renderer:remove()
    events:fire(game.EVENTS.RETURNING_TO_MAIN_MENU)
    if game.mainFrameBuffer then
        game.mainFrameBuffer:setShader()
    end
    game.transferEntryTime = nil
    game.transferDaytime = nil
    game.levelStartData = nil
    game.stopMainStates()
    mainMenu:create()
    events:fire(game.EVENTS.RETURNED_TO_MAIN_MENU)
    collectgarbage("collect")
    collectgarbage("collect")
end

function game.stopMainStates() -- proto#115 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=2648-2650
    game.stopMainRenderer()
    game.stopMainState()
end

function game.startMainStates() -- proto#114 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=2653-2655
    game.startMainRenderer()
    game.startMainState()
end

function game.startMainState() -- proto#113 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=2658-2660
    gameStateService:addState(game.mainState)
    frameController:clearMouseResetCoords()
end

function game.startMainRenderer() -- proto#112 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2663-2664
    layerRenderer:addLayer(game.mainRenderer)
end

function game.stopMainRenderer() -- proto#111 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2667-2668
    layerRenderer:removeLayer(game.mainRenderer)
end

function game.stopMainState() -- proto#110 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2671-2672
    gameStateService:removeState(game.mainState)
end

function game.stopLevelIntroStates() -- proto#109 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=2675-2678
    layerRenderer:removeLayer(game.levelIntroState)
    gameStateService:removeState(game.levelIntroState)
    game.levelIntroState:removeEventHandler()
end

function game.startLevelIntroStates() -- proto#108 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=2681-2684
    layerRenderer:addLayer(game.levelIntroState)
    gameStateService:addState(game.levelIntroState)
    game.levelIntroState:initEventHandler()
end

function game.startInputHandler() -- proto#107 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2687-2688
    inputService:addHandler(game.mainInputHandler)
end

function game.stopInputHandler() -- proto#106 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2691-2692
    inputService:removeHandler(game.mainInputHandler)
end

function game.finishRemoving() -- proto#105 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2695-2700
    game.currentLoadedSaveFile = nil
    game._removing = false
    events:fire(game.EVENTS.GAME_UNLOADED)
    jit.flush()
end

function game.quit() -- proto#104 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=2703-2710
    if love.platformAPI then
        love.platformAPI:release()
    end
    love.event.quit()
end

function game.sortSavefilesByDate(a, b) -- proto#103 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=2713-2714
    return a[3] > b[3]
end

function game.getMaps() -- proto#102 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=2717-2726
    local list = {}
    for key, mapFile in ipairs(love.filesystem.getDirectoryItems(game.MAP_DIRECTORY)) do
        if not mapFile:find(".bak$") and mapFile:find(game.MAP_FILE_FORMAT .. "$") then
            table.insert(list, mapFile)
        end
    end
    return list
end

game.savefilePreviewPattern = "gds+q?_preview+$"
game.savefilePattern = "%.gds+q?$"

function game.isSavegamePreview(path) -- proto#101 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2732-2733
    return path:find(game.savefilePreviewPattern)
end

function game.isSavedGame(path) -- proto#100 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=2736-2737
    return path:find(game.savefilePattern) and not path:find(game.savefilePreviewPattern)
end

local r0_89 = game
local r0_90 = "validSavefilePreviewsList"
local r0_91 = {}
r0_89[r0_90] = r0_91
local r0_92 = game
r0_90 = "validSavefilePreviews"
r0_91 = {}
r0_92[r0_90] = r0_91
local r0_93 = game
r0_90 = "mostRecentSaveCheckRange"
r0_91 = 20
r0_93[r0_90] = r0_91
local readData = nil

local function readSavePreview() -- proto#99 params=0 locals=0 upvalues=2 vararg=false source=122029 lines=2746-2747
    readData = bitser.loads(love.data.decompress("string", "lz4", readData))
end

function game.readSavePreview(previewPath) -- proto#98 params=1 locals=2 upvalues=2 vararg=false source=122029 lines=2750-2770
    local data = love.filesystem.read(previewPath)
    if data then
        readData = data
        if pcall(readSavePreview) then
            local data2 = readData
            readData = nil
            if data2.playtimeTotal then
                return data2
            end
            return nil, _T("PREVIEW_FILE_CORRUPT", "Preview file corrupt!")
        end
        return nil, _T("PREVIEW_FILE_CORRUPT", "Preview file corrupt!")
    end
    return nil
end

function game.clearSavePreviews() -- proto#97 params=0 locals=4 upvalues=0 vararg=false source=122029 lines=2773-2780
    local list = game.validSavefilePreviewsList
    local map = game.validSavefilePreviews
    for key, struct in ipairs(game.validSavefilePreviewsList) do
        list[key] = nil
        map[struct] = nil
    end
end

function game.removeSavePreview(previewPath) -- proto#96 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2783-2789
    for key, data in ipairs(game.validSavefilePreviewsList) do
        if data[4] == previewPath then
            table.remove(game.validSavefilePreviewsList, key)
            game.validSavefilePreviews[previewPath] = nil
        end
    end
end

function game.storeSavePreview(previewInfo, previewData, failReason, previewPath) -- proto#95 params=4 locals=2 upvalues=0 vararg=false source=122029 lines=2792-2801
    local struct = { previewInfo, previewData, failReason, previewPath }
    table.insert(game.validSavefilePreviewsList, struct)
    game.validSavefilePreviews[previewPath] = struct
    if #game.validSavefilePreviewsList >= 50 then
        local removed = table.remove(game.validSavefilePreviewsList, 1)
        game.validSavefilePreviews[removed[4]] = nil
    end
end

function game.updateSavePreviewPosition(previewPath) -- proto#94 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=2804-2809
    local struct = game.validSavefilePreviews[previewPath]
    if table.removeObject(game.validSavefilePreviewsList, struct) then
        table.insert(game.validSavefilePreviewsList, struct)
    end
end

function game.getSavePreview(previewPath, fast, forceUpdate) -- proto#93 params=3 locals=16 upvalues=0 vararg=false source=122029 lines=2812-2858
    if forceUpdate then
        game.removeSavePreview(previewPath)
    else
        local previewState = game.validSavefilePreviews[previewPath]
        if previewState ~= nil then
            game.updateSavePreviewPosition(previewPath)
            local data = game.validSavefilePreviews[previewPath]
            return data[1], data[2], data[3]
        end
    end
    local previewInfo = love.filesystem.getInfo(previewPath)
    if fast then
        if previewInfo then
            return previewInfo
        end
        return true
    end
    if previewInfo then
        if previewInfo.type == "file" then
            local previewData, failReason = game.readSavePreview(previewPath)
            if failReason then
                return nil, nil, failReason
            end
            if previewData then
                game.storeSavePreview(previewInfo, previewData, failReason, previewPath)
                return previewInfo, previewData
            end
            game.storeSavePreview(true, nil, nil, previewPath)
            return true
        end
        game.storeSavePreview(false, nil, nil, previewPath)
        return false, nil, "Incorrect preview file type!"
    end
    game.storeSavePreview(true, nil, nil, previewPath)
    return true
end

function game.getSortedSavefiles() -- proto#92 params=0 locals=11 upvalues=0 vararg=false source=122029 lines=2861-2877
    local files = love.filesystem.getDirectoryItems(game.SAVE_DIRECTORY)
    local list = {}
    for key, path in ipairs(files) do
        if game.isSavedGame(path) then
            local info = love.filesystem.getInfo(game.SAVE_DIRECTORY .. path)
            local res = path:gsub(game.savefilePattern, "")
            table.insert(list, { res, path, info.modtime })
        end
    end
    table.sort(list, game.sortSavefilesByDate)
    return list
end

function game.getSavedGames() -- proto#91 params=0 locals=17 upvalues=0 vararg=false source=122029 lines=2881-2923
    local list = game.getSortedSavefiles()
    local validList = {}
    for i = 1, #list do
        local data = list[i]
        local path = data[2]
        local previewInfo = game.getSavePreview(game.SAVE_DIRECTORY .. path
                .. game.SAVE_FILE_FORMAT_PREVIEW,
            true)
        if previewInfo then
            if type(previewInfo) == "boolean" then
                previewInfo = data
            end
            local res = path:gsub(game.savefilePattern, "")
            table.insert(validList, { res, path, previewInfo.modtime })
        end
    end
    return validList
end

function game.getMostRecentSavedGame() -- proto#90 params=0 locals=15 upvalues=0 vararg=false source=122029 lines=2927-2977
    local list = game.getSortedSavefiles()
    local bestTime = -math.huge
    local bestPath, bestPreview = nil, nil
    for i = 1, math.min(#list, game.mostRecentSaveCheckRange) do
        local data = list[i]
        local path = data[2]
        local r90_7 = game.SAVE_DIRECTORY
        local r90_8 = path
        local r90_9 = game.SAVE_FILE_FORMAT_PREVIEW
        local previewPath = r90_7 .. r90_8 .. r90_9
        r90_8 = game
        local r90_11 = r90_8.getSavePreview
        r90_9 = nil
        local previewInfo = r90_11(previewPath)
        if previewInfo then
            local r90_13 = type(previewInfo)
            if r90_13 == "boolean" then
                previewInfo = data
            end
            r90_13 = previewInfo.modtime
            r90_13 = r90_13 or previewInfo[3]
            if bestTime < r90_13 then
                bestTime = previewInfo.modtime
                bestPath = path:gsub(game.savefilePattern, "")
                bestPreview = previewPath
                break
            end
        end
    end
    return bestPath, bestPreview
end

function game.trimSavefileName(path) -- proto#89 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=2981-2982
    local r89_0 = path:gsub("^savegames/?", "")
    return r89_0:gsub("%.gds+q?$", "")
end

function game.countSavedGames() -- proto#88 params=0 locals=4 upvalues=0 vararg=false source=122029 lines=2985-2995
    local files = love.filesystem.getDirectoryItems(game.SAVE_DIRECTORY)
    local counter = 0
    for key, path in ipairs(files) do
        if path:find(game.savefilePattern) and not path:find(game.savefilePreviewPattern) then
            counter = counter + 1
        end
    end
    return counter
end

function game.getNewSavefileName() -- proto#87 params=0 locals=6 upvalues=0 vararg=false source=122029 lines=2998-3007
    if game.currentLoadedSaveFile then
        local str = game.trimSavefileName(game.currentLoadedSaveFile)
        if game.campaign then
            return game.campaign:stripSaveFileName(str)
        end
    end
    return "Save" .. game.countSavedGames()
end

function game.initHUDControllers() -- proto#86 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3010-3011
    game.hudController = hudController.new()
end

function game.initBaseSystems() -- proto#85 params=0 locals=31 upvalues=0 vararg=false source=122029 lines=3014-3053
    game.shellCasings = {}
    game.activeObjects = {}
    game.droppedMags = {}
    game.idlePatrolController = patrolController.new()
    game.alertPatrolController = patrolController.new()
    game.hudPickupController = require("game/player/hud_pickup_controller").new()
    talkText.renderer:preFillTextObjects()
    playerActor.hudAmmoHandler:init()
    radiosity:init()
    fakeShadows:init()
    loadoutSelectionMenu:init()
    shadowMapping:init()
    patrolController:init()
    game.initMainPathfinder()
    objectSelector:init()
    npcAlertnessStates:init()
    mouseVisibilityHandler:init()
    musicPlayback:_init()
    envController:init()
    pathComputeQueue:init()
    dialogueHandler:init()
    radioController:init()
    sceneHandler:init()
    objectiveHandler:init()
    ventShaftController:init()
    outlineShader:init()
    wallHighlightShader:init()
    movePosIndicator:init()
    tipController:init()
    weapons:init()
    statusEffects:init()
    scripts:init()
    noise:setRecipientQuadTree(game.worldObject:getActorQuadTree())
    envController:setQuadTree(game.worldObject:getEnvironmentQuadTree())
end

function game.attemptStartNarration() -- proto#84 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3056-3065
    local campaign = game.campaign
    if campaign and campaign:attemptStartNarration() then
        return true
    end
    return false
end

function game.finishLevel(returnToLevel, isExtraction, nextLevel) -- proto#83 params=3 locals=4 upvalues=0 vararg=false source=122029 lines=3070-3079
    if mapEditor:isActive() then
        print("INFO: level finished, preventing level change due to map editor being active")
        return
    end
    game.worldObject:setNextLevel(nextLevel)
    game.worldObject:onFinishLevel(returnToLevel, isExtraction)
    events:fire(game.EVENTS.LEVEL_FINISHED)
end

function game.onPreLoadSavefile() -- proto#82 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=3082-3083
    local r82_0 = game
    local r82_1 = game
    r82_1.transferDaytime = nil
    r82_0.transferEntryTime = false
end

function game.load(path, skipSaveFileNameSet) -- proto#80 params=2 locals=4 upvalues=1 vararg=false source=122029 lines=3087-3211
    local time = os.clock()
    game.onPreLoadSavefile()
    mainMenu:remove()
    game.remove()
    game.resetDifficulty()
    game.removeCampaign()
    game.removePlaythrough()
    game._removing = false
    game.initHUDControllers()
    inputService:removeHandler(game.mainInputHandler)
    path = path
        or game.SAVE_DIRECTORY .. game.SAVE_FILE_NAME
            .. #love.filesystem.getDirectoryItems(game.SAVE_DIRECTORY) .. game.SAVE_FILE_FORMAT
    loadingScreen:start(0,
        function() -- proto#81 params=0 locals=31 upvalues=4 vararg=false source=122029 lines=3110-3210
            achievements:init()
            loadingScreen:updateProgress(0, _T("LOADING_READING_SAVEFILE", "Reading savefile"))
            local decoded = bitser.loads(love.data.decompress("string", "lz4",
                    love.filesystem.read(path)))
            if type(decoded.difficulty) == "table" then
                local customDiff = game.DIFFICULTY_CLASS_CUSTOM:new()
                customDiff:load(decoded.difficulty)
                game.applyDifficulty(customDiff)
            else
                game.applyDifficulty(decoded.difficulty or "easy")
            end
            game.saveData = decoded
            game.savefileSaves = decoded.remainingSaves
            local r81_2 = game
            local r81_3 = decoded.remainingSaves
            r81_2.remainingSaves = r81_3 or game.difficulty.savesPerLevel
            local r81_4 = game
            r81_3 = decoded.lowestDifficultyID
            r81_4.lowestDifficultyID = r81_3
            local r81_5 = game
            r81_3 = decoded.playthroughStartTime
            r81_5.playthroughStartTime = r81_3
            local r81_6 = game
            r81_3 = decoded.levelTime
            r81_6.levelTime = r81_3 or game.levelTime
            local r81_7 = game
            r81_3 = decoded.levelStartData
            r81_7.levelStartData = r81_3
            local r81_8 = game
            r81_3 = decoded.playerInterLevelData
            r81_8.playerInterLevelData = r81_3
            local r81_9 = game
            r81_3 = decoded.WORLD_WIDTH
            r81_9.WORLD_WIDTH = r81_3
            local r81_10 = game
            r81_3 = decoded.WORLD_HEIGHT
            r81_10.WORLD_HEIGHT = r81_3
            local r81_11 = loadingScreen
            local r81_12 = r81_11.updateProgress
            r81_12(r81_11, 0.1, _T("LOADING_INITIALIZING_WORLD", "Initializing world"))
            r81_12 = game
            local r81_13 = r81_12.initWorld
            r81_13(true)
            r81_13 = game
            r81_3 = decoded.curDeaths
            r81_13.curDeaths = r81_3 or game.curDeaths
            game.quicksaves = decoded.quicksaves or game.quicksaves
            local r81_14 = loadingScreen
            local r81_15 = r81_14.updateProgress
            r81_15(r81_14, 0.4, _T("LOADING_INITIALIZING_WORLD", "Initializing world"))
            r81_15 = game
            local r81_16 = r81_15.loadPlaythrough
            r81_16(decoded.playthrough)
            r81_16 = loadingScreen
            r81_14 = r81_16
            local r81_17 = r81_14.updateProgress
            r81_17(r81_14, 0.5, _T("LOADING_INITIALIZING_WORLD", "Initializing world"))
            r81_17 = game
            local r81_18 = r81_17.loadCampaign
            r81_18(decoded.campaign)
            r81_18 = loadingScreen
            r81_14 = r81_18
            local r81_19 = r81_14.updateProgress
            r81_19(r81_14, 0.6, _T("LOADING_WORLD", "Loading the world"))
            r81_19 = game
            local r81_20 = r81_19.worldObject
            r81_14 = r81_20
            r81_20 = r81_14.load
            r81_20(r81_14, decoded.world)
            r81_20 = loadingScreen
            r81_14 = r81_20
            local r81_21 = r81_14.updateProgress
            r81_21(r81_14, 0.8, _T("LOADING_MISC_SYSTEMS_DATA", "Loading miscellaneous systems"))
            r81_21 = game
            local r81_22 = r81_21.worldObject
            r81_14 = r81_22
            r81_22 = r81_14.postLoad
            r81_22(r81_14)
            r81_22 = loadingScreen
            r81_14 = r81_22
            local r81_23 = r81_14.updateProgress
            r81_23(r81_14, 0.95, _T("LOADING_FINALIZING", "Finalizing"))
            r81_23 = game
            r81_23.postInitWorld()
            local components = decoded.loadComponents
            if components then
                local r81_25, r81_26, r81_27 = ipairs(game.LOAD_COMPONENTS)
                for key, component in r81_25, r81_26, r81_27 do
                    local savedData = decoded.loadComponents[component.id]
                    if savedData then
                        component:load(savedData)
                    end
                end
            end
            local r81_31 = events
            local r81_32 = r81_31.fire
            r81_32(r81_31, game.EVENTS.FINISHED_LOAD)
            r81_32 = skipSaveFileNameSet
            if not r81_32 then
                game.currentLoadedSaveFile = path
            end
            local r81_33 = game.worldObject
            r81_31 = r81_33
            r81_33 = r81_31.onFinishLoad
            r81_33(r81_31)
            r81_33 = game
            r81_33.saveData = nil
            local r81_34 = game.finalizeWorld
            r81_34()
            r81_34 = print
            r81_34("loading took", os.clock() - time, "seconds")
            local r81_35 = loadingScreen
            local r81_36 = r81_35.finish
            r81_36(r81_35, true)
            r81_36 = collectgarbage
            r81_36("collect")
            collectgarbage("collect")
        end)
end

function game.onLoadingFinished(wasLoad) -- proto#79 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=3214-3216
    game.worldObject:onLoadingFinished(wasLoad, game.transferEntryTime, game.transferDaytime)
    musicPlayback:onLoadingFinished()
end

function game.startGameLogic() -- proto#78 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3219-3222
    inputService:addHandler(game.mainInputHandler)
    game.startMainStates()
end

function game.stopGameLogic() -- proto#77 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3225-3227
    inputService:removeHandler(game.mainInputHandler)
    game.stopMainStates()
end

function game.deleteSavefile(pathToFile) -- proto#76 params=1 locals=3 upvalues=0 vararg=false source=122029 lines=3230-3233
    love.filesystem.remove(pathToFile)
    love.filesystem.remove(pathToFile .. game.SAVE_FILE_FORMAT_PREVIEW)
end

function game.setDesiredMap(id) -- proto#75 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=3236-3238
    game.desiredMap = id
    events:fire(game.EVENTS.MAP_SELECTED, id)
end

function game.getDesiredMap() -- proto#74 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3241-3242
    return game.desiredMap
end

function game.setDesiredCampaign(id) -- proto#73 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=3245-3247
    game.desiredCampaign = id
    events:fire(game.EVENTS.CAMPAIGN_SELECTED, id)
end

function game.getDesiredCampaign() -- proto#72 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3250-3251
    return game.desiredCampaign
end

function game.setDesiredDifficulty(id) -- proto#71 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=3254-3256
    game.desiredDifficulty = id
    events:fire(game.EVENTS.DIFFICULTY_CHANGED, id)
end

function game.getDesiredDifficulty() -- proto#70 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3259-3260
    return game.desiredDifficulty
end

function game.setIngameDifficulty(diff) -- proto#69 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=3263-3266
    if game.difficulty ~= diff then
        game.ingameDifficulty = diff
    end
end

function game.grantDifficultyAchievements() -- proto#68 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=3269-3282
    local achvDiff = game.difficulty
    if game.lowestDifficultyID then
        local thisDiff = game.DIFFICULTY_SETTINGS_BY_ID[game.lowestDifficultyID]
        if thisDiff then
            achvDiff = thisDiff
        end
    end
    if achvDiff then
        achvDiff:onFinishMainCampaign()
    end
end

function game.applyIngameDifficulty() -- proto#67 params=0 locals=8 upvalues=0 vararg=false source=122029 lines=3286-3310
    if not (game.ingameDifficulty and game.difficulty and game.difficulty:getID()) then
        return
    end
    do
        if not game.lowestDifficultyID then
            game.lowestDifficultyID = game.difficulty:getID()
        end
        local lastLoggedDifficulty = game.DIFFICULTY_SETTINGS_BY_ID[game.lowestDifficultyID]
        local ourDiffWeight = game.difficulty.weight
        local newDiffWeight = lastLoggedDifficulty.weight
        if newDiffWeight < ourDiffWeight then
            game.lowestDifficultyID = game.difficulty:getID()
        end
        game.difficulty = game.ingameDifficulty
        game.difficulty:applyIngame()
        game.ingameDifficulty = nil
        events:fire(game.EVENTS.DIFFICULTY_CHANGED, id)
        return
    end
end

function game.addDesiredDifficultyMutator(mutator) -- proto#66 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=3313-3320
    if game.hasDesiredDifficultyMutator(mutator) then
        return false
    end
    table.insert(game.desiredMutators, mutator)
    events:fire(game.EVENTS.MUTATOR_CHANGED, mutator)
    return true
end

function game.hasDesiredDifficultyMutator(mutator) -- proto#65 params=1 locals=3 upvalues=0 vararg=false source=122029 lines=3323-3324
    return table.find(game.desiredMutators, mutator)
end

function game.getDesiredDifficultyMutators() -- proto#64 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3327-3328
    return game.desiredMutators
end

function game.removeDesiredDifficultyMutator(mutator) -- proto#63 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=3331-3335
    if game.hasDesiredDifficultyMutator(mutator) then
        table.removeObject(game.desiredMutators, mutator)
        events:fire(game.EVENTS.MUTATOR_CHANGED, mutator)
    end
end

function game.duplicateDifficultyMutators() -- proto#62 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=3338-3345
    local muts = {}
    for i = 1, #game.desiredMutators do
        muts[i] = game.desiredMutators[i]
    end
    return muts
end

function game.clearDesiredDifficulty() -- proto#61 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3348-3354
    if not game.baseCustomDifficulty then
        game.baseCustomDifficulty = game.DIFFICULTY_CLASS_CUSTOM:new()
    end
    game.desiredDifficulty = nil
    table.clearArray(game.desiredMutators)
end

function game.startNewGame(newGamePlus) -- proto#60 params=1 locals=4 upvalues=1 vararg=false source=122029 lines=3357-3363
    game.playthrough = playthroughRecord.new()
    game.playthrough:setStartTime(os.time())
    game.playthrough:setNewGamePlus(newGamePlus)
    game.playthrough:unlockStartingMods()
    game.applyDesiredMutators()
end

function game.transferDesiredDifficultyNewGameData() -- proto#59 params=0 locals=6 upvalues=0 vararg=false source=122029 lines=3366-3371
    if type(game.desiredDifficulty) == "string" then
        game.transferNewGameData(game.campaign:getID(), game.desiredDifficulty, game.playthrough)
    else
        game.transferNewGameData(game.campaign:getID(),
            game.DIFFICULTY_CLASS_CUSTOM.WEAPON_TRANSFER_DIFFICULTY, game.playthrough)
    end
end

function game.applyDesiredMutators() -- proto#58 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=3374-3378
    for key, mutator in ipairs(game.desiredMutators) do
        game.playthrough:addDifficultyMutator(mutator)
        game.desiredMutators[key] = nil
    end
end

function game.attemptTransferNewGameData(campaignID, difficultyID, playthroughInst) -- proto#57 params=3 locals=0 upvalues=0 vararg=false source=122029 lines=3381-3384
    if campaignID then
        game.transferNewGameData(campaignID, difficultyID, playthroughInst)
    end
end

function game.savePlayerPersistentData(plyTypeID) -- proto#56 params=1 locals=3 upvalues=0 vararg=false source=122029 lines=3387-3406
    movePosIndicator:clearPositions()
    plyTypeID = plyTypeID or game.playerActor:getPlayerType()
    if not game.playerInterLevelData then
        game.playerInterLevelData = {}
    end
    local dest = game.playerInterLevelData[plyTypeID]
    if not dest then
        dest = {}
        game.playerInterLevelData[plyTypeID] = dest
    end
    game.playerActor:saveInterLevelData(dest)
end

function game.loadPlayerPersistentData() -- proto#55 params=0 locals=4 upvalues=0 vararg=false source=122029 lines=3409-3418
    if game.playerInterLevelData then
        local plyTypeID = game.playerActor:getPlayerType()
        local data = game.playerInterLevelData[plyTypeID]
        if data then
            game.playerActor:loadInterLevelData(data)
            game.playerInterLevelData[plyTypeID] = nil
        end
    end
end

function game.flushInterLevelData() -- proto#54 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3421-3422
    game.playerInterLevelData = nil
end

function game.getRemainingSaves() -- proto#53 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3425-3426
    return game.remainingSaves
end

function game.attemptQuicksave() -- proto#52 params=0 locals=7 upvalues=0 vararg=false source=122029 lines=3429-3450
    if game.canSave() and not game.savingGame then
        local quicksaveName = nil
        local mapCfg = game.worldObject:getMapConfig()
        if mapCfg then
            quicksaveName = mapCfg:getName()
        else
            quicksaveName = game.worldObject:getMapID()
        end
        game.quicksaves = game.quicksaves + 1
        game.deduceSaveCount()
        local filename = _format2(_T("QUICKSAVE_FILE_FORMAT_NEW", "${MAPNAME} - Quicksave ${NUMBER}"),
            "MAPNAME", quicksaveName, "NUMBER", game.quicksaves)
        game.beginSaving(game.getSaveFileName(filename, false), false, nil)
        return
    end
    gui.create("QuicksaveBlockedIndicator")
end

function game.attemptQuickload() -- proto#51 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=3453-3470
    if game.worldObject and not cutscene.state:getCutscene() then
        game.worldObject:beginReset()
    end
end

function game.canSave() -- proto#50 params=0 locals=3 upvalues=0 vararg=false source=122029 lines=3473-3482
    local r50_0 = cutscene.state
    local r50_1 = r50_0
    r50_0 = r50_1.getCutscene
    if not r50_0(r50_1)
        and not mapEditor:isActive()
        and game.worldObject
        and (not game.playerActor or not game.playerActor:isDead())
        and not gameOver
        and not dialogueHandler:isActive() then
        if game.remainingSaves == -1 then
            return true
        end
        return game.remainingSaves > 0
    end
    return false
end

function game.getSaveCountText() -- proto#49 params=0 locals=6 upvalues=0 vararg=false source=122029 lines=3485-3492
    if game.remainingSaves < 0 then
        local r49_0 = _T("REMAINING_SAVEGAMES_INFINITE", "Remaining save files: infinite")
        return r49_0:upper()
    end
    if game.remainingSaves == 0 then
        local r49_1 = _T("REMAINING_SAVEGAMES_NONE", "No remaining save files left!")
        return r49_1:upper()
    end
    local r49_2 = _format2(_T("REMAINING_SAVEGAMES_COUNT", "Remaining save files: ${SAVEGAMES}"),
        "SAVEGAMES", game.remainingSaves)
    return r49_2:upper()
end

function game.createDroppedMag(x, y, prefab, magID, thrower) -- proto#48 params=5 locals=2 upvalues=0 vararg=false source=122029 lines=3495-3506
    local mag = objects.create("dropped_mag")
    mag:setPos(x, y)
    mag:setThrowPosition(mag.x, mag.y)
    mag:assignID()
    mag:onPlacedIntoMap()
    mag:setPrefab(prefab)
    mag:setVirtualHeight(6)
    mag:setThrower(thrower)
    mag:setMagID(magID)
    return mag
end

local _desiredMap, _isNewGamePlus = nil, nil

function game.onLoadMapNewFinish() -- proto#47 params=0 locals=13 upvalues=2 vararg=false source=122029 lines=3512-3527
    if _isNewGamePlus then
        game.attemptTransferNewGameData(maps:getCampaign(_desiredMap), game.difficulty:getUnlockID(),
            game.playthrough)
    end
    game.playthrough:applyStartDifficultyMutators()
    game.playthrough:initMoney(game.getMaxLevelMoney(_desiredMap), true)
    game.playthrough:setTrust(game.getLevelTrustValue(game.campaign:getID(),
            game.difficulty:getUnlockID()),
        true)
    _desiredMap = nil
    _isNewGamePlus = nil
end

function game.onLoadMapFinish() -- proto#46 params=0 locals=5 upvalues=0 vararg=false source=122029 lines=3531-3533
    game.logLevelTrustLevel(game.campaign:getID(), game.difficulty:getUnlockID(),
        game.playthrough:getTrust())
    game.saveGameData()
end

function game.loadMapNew(isNewGamePlus) -- proto#45 params=1 locals=1 upvalues=2 vararg=false source=122029 lines=3537-3542
    local desiredMap = game.getDesiredMap()
    _desiredMap = desiredMap
    _isNewGamePlus = isNewGamePlus
    game.loadMap(desiredMap, nil, game.getDesiredDifficulty(), nil, game.onLoadMapNewFinish)
    game.setDesiredMap()
end

function game.loadMap(mapID, isRestarting, desiredDifficulty, isReturning, onFinishCallback) -- proto#43 params=5 locals=15 upvalues=0 vararg=false source=122029 lines=3549-3816
    onFinishCallback = onFinishCallback or game.onLoadMapFinish
    mapID = mapID:gsub(game.MAP_FILE_FORMAT, "")
    if game.worldObject then
        if game.worldObject:getTransferEntryTime() then
            game.transferEntryTime = true
            game.transferDaytime = game.worldObject:getDaytime()
        else
            game.transferEntryTime = false
            game.transferDaytime = nil
        end
    else
        game.transferEntryTime = false
        game.transferDaytime = nil
    end
    mainMenu:closeInGameMenu()
    game.setDesiredCampaign()
    inputService:removeHandler(game.mainInputHandler)
    game.canSendGridUpdateToThreads = false
    game.remove()
    game.initHUDControllers()
    game.hideHUD()
    game.playthroughStartTime = os.time()
    if desiredDifficulty then
        game.desiredDifficulty = desiredDifficulty
    end
    if game.difficulty then
        game.applyDifficulty(game.difficulty)
    elseif type(game.desiredDifficulty) == "table" then
        local customDiff = game.DIFFICULTY_CLASS_CUSTOM:new()
        customDiff:transferData(game.desiredDifficulty)
        game.applyDifficulty(customDiff)
    else
        game.applyDifficulty(game.desiredDifficulty or "normal")
    end
    game.levelTime = 0
    mainMenu:remove()
    local mapCfg = maps:getData(mapID)
    if not game.campaign then
        local campaignID = nil
        if mapCfg then
            campaignID = mapCfg:getCampaignID()
        else
            campaignID = maps.FALLBACK_CAMPAIGN
        end
        game.loadCampaign(nil, campaignID)
        game.campaign:beginLevel()
    end
    game.canSendGridUpdateToThreads = true
    if game.playthrough then
        game.storeMaxLevelMoney(mapID, game.playthrough)
    end
    loadingScreen:start(0,
        function() -- proto#44 params=0 locals=41 upvalues=5 vararg=false source=122029 lines=3637-3815
            game.startingNewGame = true
            loadingScreen:updateProgress(0.1, _T("LOADING_INITIALIZING_WORLD", "Initializing world"))
            game.remainingSaves = game.difficulty.savesPerLevel
            game.savefileSaves = game.remainingSaves
            game.initWorld(nil, mapID, isReturning)
            local r44_0 = isReturning
            if r44_0 and maps:getMapExists(mapID) then
                local r44_1 = loadingScreen
                r44_1:updateProgress(0.5, _T("LOADING_INITIALIZING_WORLD", "Initializing world"))
                local r44_2 = game.worldObject
                local r44_3 = r44_2
                r44_2 = r44_3.load
                local r44_4 = game.playthrough
                local r44_5 = r44_4
                r44_4 = r44_5.getPersistentMapData
                local r44_6 = mapCfg and mapCfg:getID() or mapID
                r44_2(r44_3, r44_4(r44_5, r44_6), isReturning)
                r44_3 = objectiveHandler
                r44_3:clearActiveObjectives()
                r44_2 = objectiveHandler
                r44_2:fillObjectives()
                local r44_7 = game.playerActor
                r44_7:positionOnSpawn(true)
                local r44_8 = game.worldObject
                r44_8:onReturn()
            end
            local r44_9 = loadingScreen
            local r44_10 = r44_9.updateProgress
            r44_10(r44_9, 0.95, _T("LOADING_FINALIZING", "Finalizing"))
            r44_10 = game
            local r44_11 = r44_10.postInitWorld
            r44_11(not isReturning)
            r44_11 = events
            r44_9 = r44_11
            local r44_12 = r44_9.fire
            r44_12(r44_9, game.EVENTS.NEW_GAME_STARTED)
            r44_12 = game
            if r44_12.campaign then
                local r44_13 = game.campaign
                r44_9 = r44_13
                r44_13 = r44_9.setupLevel
                local r44_14 = game.worldObject
                r44_13(r44_9, r44_14:getMapConfig())
            end
            if isRestarting and game.levelStartData then
                if mapID == game.levelStartData.mapID then
                    local r44_15 = game.campaign
                    r44_15:load(game.levelStartData.campaign)
                    local r44_16 = game.playthrough
                    r44_16:load(game.levelStartData.playthrough)
                    local r44_17 = game.playerActor
                    r44_17:loadInterLevelData(game.levelStartData.playerData)
                    if game.levelStartData.loadout then
                        local r44_18 = loadoutSelectionMenu
                        r44_18:initLoadoutSlots(game.levelStartData.loadout)
                    end
                end
                game.levelStartData = nil
            end
            local r44_19 = objectiveHandler
            local r44_20 = r44_19.attemptSetupMapObjectives
            r44_20(r44_19)
            r44_20 = game
            local r44_21 = r44_20.finalizeWorld
            r44_21(not isReturning)
            r44_21 = game
            local r44_22 = r44_21.applyDesiredMutators
            r44_22()
            r44_22 = game
            local r44_23 = r44_22.clearDesiredDifficulty
            r44_23()
            r44_23 = isReturning
            if r44_23 then
                local r44_24 = game.beginSaving
                r44_19 = game.getSaveFileName
                local r44_25 = _format2
                local r44_26 = _T("SAVEFILE_RETURNING_FROM_PREVIOUS_LEVEL", "${MAPNAME} - Returning")
                local r44_27 = game.worldObject
                r44_24(r44_19(r44_25(r44_26, "MAPNAME", r44_27:getMapName()), false), false, nil)
            end
            if game.campaign then
                local r44_28 = game.campaign
                r44_28:onLevelFirstLoadFinish(isRestarting)
            end
            if onFinishCallback then
                onFinishCallback()
            end
            local r44_29 = game.storeLevelStartData
            r44_29()
            r44_29 = collectgarbage
            r44_29("collect")
            collectgarbage("collect")
            game.startingNewGame = false
            local r44_30 = loadingScreen
            r44_30:finish(isReturning)
        end)
end

function game.storeLevelStartData() -- proto#42 params=0 locals=5 upvalues=0 vararg=false source=122029 lines=3819-3833
    if game.campaign and game.playthrough then
        local playerData = {}
        game.playerActor:saveInterLevelData(playerData)
        game.levelStartData = {
            mapID = game.worldObject:getMapID(), daytime = game.worldObject:getDaytime(),
            campaign = game.campaign:save(), playthrough = game.playthrough:save(),
            playerData = playerData, loadout = loadoutSelectionMenu:saveLoadout()
        }
    end
end

function game.postInitWorld(initialWorld) -- proto#41 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=3836-3845
    game.cameraPanState = true
    game.worldObject:postInit(initialWorld)
    render:verifyShaderData()
end

function game.getHUD() -- proto#40 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3848-3849
    return game.officeStatsDisplay
end

function game.createEntryTimeSelection() -- proto#39 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3852-3855
    print("game.createEntryTimeSelection() called")
    gui.create("EntryTimeBG")
end

function game.onEntryTimeSelected(daytime) -- proto#38 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=3858-3860
    game.worldObject:onEntryTimeSelected(daytime)
    events:fire(game.EVENTS.ENTRY_TIME_SELECTED)
end

function game.setAttackRecord(attackRecordInst) -- proto#37 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=3863-3864
    game.attackRecord = attackRecordInst
end

function game.finalizeWorld(initialLoad) -- proto#36 params=1 locals=8 upvalues=0 vararg=false source=122029 lines=3868-3885
    game.worldObject:startRenderers()
    game.worldObject:finalize(initialLoad)
    game.worldObject:onMapLoaded()
    game.loadPlayerPersistentData()
    render:attemptRecompileShader()
    radiosity:onMapLoaded()
    camera:onLoadFinish()
    game.playthrough:postLoadDifficultyMutators()
    events:fire(game.EVENTS.MAP_LOADED, initialLoad)
end

function game.initWorld(wasSaveLoad, mapID, skipMapLoadProcedure) -- proto#35 params=3 locals=26 upvalues=0 vararg=false source=122029 lines=3888-3948
    game.curDeaths = 0
    game.quicksaves = 0
    local worldWidth, worldHeight, readData, decompressedMapData = nil, nil, nil, nil
    if wasSaveLoad then
        local r35_4 = game.WORLD_WIDTH
        worldHeight = game.WORLD_HEIGHT
        worldWidth = r35_4
    else
        mapID = mapID:gsub(game.MAP_FILE_FORMAT, "")
        readData, decompressedMapData = maps:readMap(mapID)
        worldWidth, worldHeight = readData.width, readData.height
    end
    game.worldObject = world.new(worldWidth, worldHeight, game.WORLD_TILE_WIDTH,
        game.WORLD_TILE_HEIGHT)
    game.worldObject:setPartitionSize(game.PARTITION_SIZE)
    game.worldObject:setupPathfindingThreads()
    loadingScreen:updateProgress(0.15, _T("LOADING_INIT_SYSTEMS", "Initializing systems"))
    game.initBaseSystems()
    if game.playthrough then
        game.playthrough:applyDifficultyMutators()
    end
    if not wasSaveLoad and not skipMapLoadProcedure then
        loadingScreen:updateProgress(0.25, _T("LOADING_LOAD_MAP", "Loading map"))
        game.worldObject:loadMap(mapID, readData, decompressedMapData)
        game.worldObject:setupPlayer()
        game.playerActor:positionOnSpawn()
        game.worldObject:onMapStarted()
        loadingScreen:updateProgress(0.4,
            _T("LOADING_OBJECTIVE_SETUP", "Setting up objectives & savefiles"))
        local mapCfg = game.worldObject:getMapConfig()
        if mapCfg then
            local mapSaves = mapCfg:getSaveCount()
            if mapSaves then
                game.remainingSaves = mapSaves
                game.savefileSaves = mapSaves
            end
        end
    end
    game.initialGameStarted = true
    collectgarbage("collect")
    collectgarbage("collect")
end

function game.getWorld() -- proto#34 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=3951-3952
    return game.worldObject
end

function game.runBulletLogic(dt) -- proto#33 params=1 locals=5 upvalues=0 vararg=false source=122029 lines=3955-3980
    local bullets = game.activeBullets
    local cnt = #bullets
    if cnt > 0 then
        local k = 1
        for i = 1, cnt do
            local obj = bullets[k]
            if not obj then
                return
            end
            obj:update(dt)
            if obj.stored then
                obj.IN_BULLET_LIST = false
            else
                k = k + 1
            end
        end
    end
end

game.FASTER_CAMERA_SPEED = 2
game.BASE_CAMERA_SPEED = 1

function game.attemptMoveCamera(dt) -- proto#32 params=1 locals=6 upvalues=0 vararg=false source=122029 lines=3986-3995
    if game.cameraPanState then
        local r32_0 = game.fasterCameraSpeed and game.FASTER_CAMERA_SPEED or game.BASE_CAMERA_SPEED
        dt = dt * r32_0
        for key, index in ipairs(game.activeCameraKeys) do
            do
                local data = game.CAMERA_MOVE_KEYS[index]
                local r32_4 = camera
                r32_4:resetVelocities()
                local r32_5 = camera
                r32_5:scroll(data.x * dt, data.y * dt)
            end
        end
    end
end

function game.setCameraPanState(state) -- proto#31 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=3998-3999
    game.cameraPanState = state
end

function game.clearActiveCameraKeys() -- proto#30 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=4002-4005
    for key, state in ipairs(game.activeCameraKeys) do
        game.activeCameraKeys[key] = nil
    end
end

function game.attemptSetCameraKey(key, state) -- proto#29 params=2 locals=3 upvalues=0 vararg=false source=122029 lines=4008-4025
    if camera:isInputAvailable() then
        if game.FASTER_CAMERA_KEYS[key] then
            game.fasterCameraSpeed = state
        else
            for index, list in ipairs(game.CAMERA_MOVE_KEYS) do
                if list.keys[key] then
                    if state then
                        if not table.find(game.activeCameraKeys, index) then
                            game.activeCameraKeys[#game.activeCameraKeys + 1] = index
                        end
                    else
                        table.removeObject(game.activeCameraKeys, index)
                    end
                end
            end
        end
    end
end

function game.setCurrentWindow(window) -- proto#28 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=4028-4035
    game.window = window
    if window and window:getCanBlockCamera() then
        game.setCameraPanState(false)
    else
        game.setCameraPanState(true)
    end
end

function game.getCurrentWindow() -- proto#27 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4038-4039
    return game.window
end

function game.setCanOpenMainMenu(can) -- proto#26 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=4042-4043
    game.canOpenMainMenu = can
end

function game.getPreventsIngameMenu() -- proto#25 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4046-4051
    if game.window and game.window:getPreventsIngameMenu() then
        return true
    end
    return false
end

function game.attemptCloseViaEscape(key) -- proto#24 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=4054-4067
    if game.window
        and game.window:isValid()
        and game.window:canCloseViaEscape()
        and game.window:getVisible() then
        inputService:setPreventPropagation(true)
        game.window:kill()
        return true
    end
    return false
end

function game.handleKeyPress(key, isrepeat) -- proto#23 params=2 locals=2 upvalues=0 vararg=false source=122029 lines=4070-4081
    if game.playerActor then
        local result = game.playerActor:handleKeyPress(key)
        if result then
            return result
        end
    end
    if game.handleDebugKeys(key) then
        return
    end
end

function game.handleEscapeMenu(key) -- proto#22 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4084-4094
    if game.canOpenMainMenu and key == "escape" then
        if not game.attemptCloseViaEscape(key) and frameController:getFrameCount() == 0 then
            mainMenu:handleIngameMenu()
            return true
        end
        return true
    end
    return false
end

function game.onFrameRenderFinish() -- proto#21 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4097-4102

end

function game.handleDebugKeys(key) -- proto#20 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4105-4120
    if key == "l" then
        mapEditor:toggleNPCLogic()
    end
    return false
end

function game.setTimescale(scale) -- proto#19 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4123-4125
    game.timescale = scale
    sound.manager:setPitch(scale)
end

function game.handleKeyRelease(key) -- proto#18 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4128-4131
    if game.playerActor then
        game.playerActor:handleKeyRelease(key)
    end
end

function game.createScroller(parent, width, height, adjustElementPosition) -- proto#17 params=4 locals=1 upvalues=0 vararg=false source=122029 lines=4134-4143
    if adjustElementPosition == nil then
        adjustElementPosition = true
    end
    local scrollBarPanel = gui.create("ScrollbarPanel", parent)
    scrollBarPanel:setSize(width, height)
    scrollBarPanel:setAdjustElementPosition(true)
    return scrollBarPanel
end

function game.createPopup(width, title, text, titleFont, textFont, skipButton, popupClass) -- proto#16 params=7 locals=2 upvalues=0 vararg=false source=122029 lines=4146-4172
    titleFont = titleFont or fonts.get("pix24")
    textFont = textFont or fonts.get("pix20")
    local popup = gui.create(popupClass or "Popup")
    popup:setWidth(width or 600)
    popup:setTextFont(textFont)
    popup:setFont(titleFont)
    if title then
        popup:setTitle(title)
    end
    if text then
        popup:setText(text)
    end
    popup:setDepth(105)
    if not skipButton then
        popup:addButton(fonts.get("pix20"), "OK")
    end
    popup:performLayout()
    popup:center()
    return popup
end

function game.genericClearFrameControllerCallback(self) -- proto#15 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4175-4176
    frameController:clearAll()
end

function game.removeHUD() -- proto#14 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=4179-4182
    if game.hudController then
        game.hudController:removeElements()
    end
end

function game.clearHUDElements() -- proto#13 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=4185-4187
    game.removeHUD()
    frameController:clearAll()
end

function game.addHUDElement(elem, forceShow) -- proto#12 params=2 locals=1 upvalues=0 vararg=false source=122029 lines=4190-4195
    if game.hudHidden and not forceShow then
        elem:hide()
    end
    game.hudController:addElement(elem)
end

game.addButton = game.addHUDElement

function game.removeHUDElement(elem) -- proto#11 params=1 locals=1 upvalues=0 vararg=false source=122029 lines=4200-4201
    game.hudController:removeElement(elem)
end

function game.initHUD() -- proto#10 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4204-4204

end

function game.addHUDBlocker(blocker) -- proto#9 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=4207-4212
    if #game.hudBlockers == 0 then
        game.hideHUD()
    end
    table.insert(game.hudBlockers, blocker)
end

function game.removeHUDBlocker(blocker) -- proto#8 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=4215-4220
    table.removeObject(game.hudBlockers, blocker)
    if #game.hudBlockers == 0 then
        game.showHUD()
    end
end

function game.showHUD(firstTimeShow) -- proto#7 params=1 locals=2 upvalues=0 vararg=false source=122029 lines=4223-4245
    if game._removing then
        return
    end
    if game.worldObject and game.worldObject:getLevelFinished() then
        return
    end
    if #game.hudBlockers > 0 then
        return
    end
    if game.hudController then
        game.hudController:show()
    end
    if game.hudPickupController then
        game.hudPickupController:show()
    end
    game.hudHidden = false
end

function game.hideHUD() -- proto#6 params=0 locals=2 upvalues=0 vararg=false source=122029 lines=4248-4258
    if game.hudController then
        game.hudController:hide()
    end
    if game.hudPickupController then
        game.hudPickupController:hide()
    end
    game.hudHidden = true
end

function game.showAimLine() -- proto#5 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=4261-4262
    playerActor.aimLineRenderer:attemptShow()
end

function game.hideAimLine() -- proto#4 params=0 locals=1 upvalues=0 vararg=false source=122029 lines=4265-4266
    playerActor.aimLineRenderer:hide()
end

function game.resetMouseOver() -- proto#3 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4269-4270
    game._mouseOverDeveloper = nil
end

function game.getMouseOverObject() -- proto#2 params=0 locals=0 upvalues=0 vararg=false source=122029 lines=4273-4274
    return game._mouseOverDeveloper
end

function game.setMouseOverObject(object) -- proto#1 params=1 locals=0 upvalues=0 vararg=false source=122029 lines=4277-4278
    game._mouseOverDeveloper = object
end
