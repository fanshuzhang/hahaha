HelperBox = require("Envir/Extension/HelperBox/HelperBox_Data.lua")
require("Envir/Extension/HelperBox/HelperBox.lua")
require("Envir/Extension/HelperBox/HelperBox_BaseAction.lua")
require("Envir/Extension/HelperBox/HelperBox_QuickAction.lua")
require("Envir/Extension/HelperBox/HelperBox_CoinAction.lua")
require("Envir/Extension/HelperBox/HelperBox_BaseInfo.lua")
require("Envir/Extension/HelperBox/HelperBox_FormAction.lua")
require("Envir/Extension/HelperBox/HelperBox_ItemAction.lua")

Message.RegisterClickMsg("HelperBox", HelperBox)

setFormAllowFunc("HelperBox", {
    "SetPlayer",
    "QuickAction",
    "BaseAction", "BaseActionEx",
    "CoinAction", "CoinActionEx",
    "RoleInfo", "RoleStatus", "GSInfo", "MapInfo", "MapInfoAction",
    "FormAction",
    "NpcInfo", "NpcInfoAction",
    "BuffInfo", "BuffInfoDeleteAction",
    "ItemInfo", "ItemCopy", "ItemDestroy",
    "MemoryInfo"
})