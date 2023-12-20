---------------------------------------------------------技能----------------------------------------------------------
local skill_items = {
    [10197] = { 10197, "恶鬼咆哮" },
    [10198] = { 10198, "十步一杀" },
    [10199] = { 10199, "刺杀剑法" },
    [10200] = { 10200, "修罗附体" },
    [10201] = { 10201, "罗刹附体" },
    [10202] = { 10202, "阎罗附体" },
    [10203] = { 10203, "死神附体" },
    [10204] = { 10204, "鬼神之力" },
    [10205] = { 10205, "神力共存" },
    [10206] = { 10206, "龙影剑法" },
    [10207] = { 10207, "雷霆剑法" },
    [10208] = { 10208, "擒龙手" },
    [10209] = { 10209, "护体盾" },
    [10210] = { 10210, "盾牌反击" },
    [10211] = { 10211, "圣光制裁1111" },
    [10212] = { 10212, "守护之心" },
    [10213] = { 10213, "骑士之躯" },
    [10214] = { 10214, "圣骑回血" },
    [10215] = { 10215, "幻影之盾" },
    [10216] = { 10216, "大地守护" },
    [10217] = { 10217, "嘲讽妖兽" },
    [10218] = { 10218, "火球术" },
    [10219] = { 10219, "大火球之术" },
    [10220] = { 10220, "火链之术" },
    [10221] = { 10221, "雷电术" },
    [10222] = { 10222, "群体雷电术" },
    [10223] = { 10223, "魔法盾" },
    [10224] = { 10224, "抗拒火环" },
    [10225] = { 10225, "冰霜雪雨" },
    [10226] = { 10226, "临时契约术" },
    [10227] = { 10227, "永久契约术" },
    [10228] = { 10228, "契约精神" },
    [10229] = { 10229, "暗影能量" },
    [10230] = { 10230, "冰咆哮" },
    [10231] = { 10231, "冰霜群雨" },
    [10232] = { 10232, "亡灵大军" },
    [10233] = { 10233, "亡灵祭坛" },
    [10234] = { 10234, "死灵大法" },
    
}

local function addSkill(player, skillName)
    if SkillIDCfg[skillName] then
        lualib:AddSkill(player, SkillIDCfg[skillName], 3)

        Message:NoticeMsg(player, 151, 0, string.format("恭喜恭喜，“%s”成功修炼上乘技能：%s", lualib:Name(player), skillName))
        Message:NoticeMsg(player, 151, 0, string.format("恭喜恭喜，“%s”成功修炼上乘技能：%s", lualib:Name(player), skillName))
        Message:NoticeMsg(player, 151, 0, string.format("恭喜恭喜，“%s”成功修炼上乘技能：%s", lualib:Name(player), skillName))
    end
end

for k, v in pairs(skill_items) do
    _G["stdmodefunc" .. k] = function(player)
        addSkill(player, v[2])
    end
end

---------------------------------------------------------充值货币----------------------------------------------------------
local recharge_items = {
    -- [14001] = {type=1, item_name = "10元回馈红包", num=1},
    -- [14002] = {type=1, item_name = "20元回馈红包", num=1},
    -- [14003] = {type=1, item_name = "40元回馈红包", num=1},
    -- [14004] = {type=1, item_name = "60元回馈红包", num=1},

}

local function dealRechargeItems(player, v)
    local coinCount = lualib:GetBagItemCount(player, v.item_name)
    --if lualib:GetBagItemCount(player, v.item_name) <= 0 then
    --    return
    --end
    if not lualib:DelItem(player, v.item_name, coinCount) then
        stop(player)
        return
    end

    if v.type == 1 then
        lualib:SetMoneyEx(player, "传奇币", "+", v.num * coinCount * 100000, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI币", "+", v.num * coinCount * 10000, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "未来币", "+", v.num * coinCount * 1000, "使用" .. v.item_name, true)
    elseif v.type == 2 then
        lualib:SetMoneyEx(player, "科技币", "+", v.num * coinCount * 100, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "未来币", "+", v.num * coinCount * 1000, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI币", "+", v.num * coinCount * 10000, "使用" .. v.item_name, true)
    elseif v.type == 3 then
        lualib:SetMoneyEx(player, "科技币", "+", v.num * coinCount * 100, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "未来币", "+", v.num * coinCount * 1000, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI币", "+", v.num * coinCount * 10000, "使用" .. v.item_name, true)
    elseif v.type == 4 then
        lualib:SetMoneyEx(player, "传奇币", "+", v.num * coinCount * 10000, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "未来币", "+", v.num * coinCount * 100, "使用" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI币", "+", v.num * coinCount * 1000, "使用" .. v.item_name, true)
    end
end

for k, v in pairs(recharge_items) do
    _G["stdmodefunc" .. k] = function(player)
        dealRechargeItems(player, v)
    end
end



---------------------------------------------------------红名清洗卷----------------------------------------------------------
-- function stdmodefunc10008(player)
--     if lualib:GetBagItemCount(player, "红名清洗卷") <= 0 then
--         stop(player)
--         return
--     end
--     lualib:SetPk(player, 0)
--     Message:Msg5(player, "你的PK罪恶值已经清除为0点！")
-- end



---------------------------------------------------------祝福油----------------------------------------------------------


---------------------------------------------------------超级祝福油----------------------------------------------------------
function stdmodefunc10051(player)
    if lualib:GetBagItemCount(player, "超级祝福油") <= 0 then
        stop(player)
        return
    end
    local equip = lualib:LinkBodyItem(player, 1)
    if equip == nil or equip == "0" or equip == "" then
        stop(player)
        return
    end
    local luck = lualib:GetItemAddValue(player, equip, 1, 5)
    if luck >= 8 then
        Message:Msg5(player, "[提示]:你的武器已经幸运值已经+8以上点了,系统无法给你增加了. ")
        stop(player)
        return
    end
    lualib:SetItemAddValue(player, equip, 1, 5, luck + 1)
    lualib:RefreshItem(player, equip)
    Message:Msg5(player, "[提示]:你的武器幸运值提升了，当前为" .. (luck + 1) .. "点. ")
end

---------------------------------------------------------超级祝福油----------------------------------------------------------
function stdmodefunc10005(player)
    if lualib:GetBagItemCount(player, "超级祝福油") <= 0 then
        stop(player)
        return
    end
    local equip = lualib:LinkBodyItem(player, 1)
    if equip == nil or equip == "0" or equip == "" then
        stop(player)
        return
    end
    local luck = lualib:GetItemAddValue(player, equip, 1, 5)
    if luck >= 8 then
        Message:Msg5(player, "[提示]:你的武器已经幸运值已经+8以上点了,系统无法给你增加了. ")
        stop(player)
        return
    end
    lualib:SetItemAddValue(player, equip, 1, 5, luck + 1)
    lualib:RefreshItem(player, equip)
    Message:Msg5(player, "[提示]:你的武器幸运值提升了，当前为" .. (luck + 1) .. "点. ")
end

---------------------------------------------------------金条----------------------------------------------------------
function stdmodefunc10059(player)
    if lualib:GetBagItemCount(player, "金条") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "金币", "+", 1000000, "金条", true)
end

function stdmodefunc10060(player)
    if lualib:GetBagItemCount(player, "金砖") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "金币", "+", 5000000, "金砖", true)
end

function stdmodefunc10061(player)
    if lualib:GetBagItemCount(player, "金盒") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "金币", "+", 10000000, "金盒", true)
end

function stdmodefunc10062(player)
    if lualib:GetBagItemCount(player, "金箱") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "金币", "+", 100000000, "金箱", true)
end

---------------------------------------------------------盟重传送石-------------------------------------------------------
function stdmodefunc10001(player)
    if lualib:GetBagItemCount(player, "盟重回城石") <= 0 then
        stop(player)
        return
    end
    if lualib:GetInt(player, "脱战CD") > 0 then
        Message:Msg9(player, "战斗状态无法回城，请先脱离战斗3秒后再试！")
        stop(player)
        return
    end
    lualib:MapMoveXY(player, "3", 330, 330, 10)
    lualib:RemovePoison(player, 1)
    lualib:SetHpEx(player, "=", 100)
    lualib:SetMpEx(player, "=", 100)
    lualib:RepairAll(player)
    lualib:DelMirrorMap(lualib:Name(player))
end

---------------------------------------------------------随机传送石-------------------------------------------------------
local limit10001 = {
    ["HDDT-TCPK"] = 1,
    ["137"] = 1,
}
function stdmodefunc10002(player)
    local mapId = lualib:GetMapId(player)
    if limit10001[mapId] then
        Message:Msg9(player, "当前地图禁止使用该道具")
        stop(player)
        return
    end
    if lualib:GetBagItemCount(player, "随机传送石") <= 0 then
        stop(player)
        return
    end
    if lualib:GetInt(player, "脱战CD") > 0 then
        Message:Msg9(player, "战斗状态无法回城，请先脱离战斗3秒后再试！")
        stop(player)
        return
    end
    lualib:MapMove(player, lualib:GetMapId(player))
    delaygoto(player, 500, "click,挂机设置_beginFight", 1)
end

---------------------------------------------------------货币道具----------------------------------------------------------
local coinItemList = {
    -- [10009] = {name="100传奇币", count=100, coinId=33},
    -- [10010] = {name="150传奇币", count=150, coinId=33},
    -- [10011] = {name="200传奇币", count=200, coinId=33},
    -- [10012] = {name="250传奇币", count=250, coinId=33},,
}

local function dealCoinItem(player, v)
    local coinCount = lualib:GetBagItemCount(player, v.name)
    --if lualib:GetBagItemCount(player, v.item_name) <= 0 then
    --    return
    --end
    --print("使用"..v.name.."*"..coinCount)

    if not lualib:DelItem(player, v.name, coinCount, false, "双击货币道具使用", 10003) then
        stop(player)
        return
    end
    lualib:SetMoney(player, v.coinId, "+", v.count * coinCount, "使用" .. v.name .. "*" .. coinCount, true)
end

for k, v in pairs(coinItemList) do
    _G["stdmodefunc" .. k] = function(player)
        dealCoinItem(player, v)
    end
end

---------------------------------------------------------无用道具（展示用的，单个物品使用后直接删除）----------------------------------------------------------
local unuseful_item = {
    [10404] = { name = "在线仓库" },
    [10389] = { name = "在线回收" },
    -- [14303] = {name="随身仓库"},
    -- [14305] = {name="复活次数+1"},

}

local function dealUseTitleItem(player, v)
    if v.name then
        lualib:SetVar(player, VarCfg[v.name], 1)
        Message:Msg9(player, "成功激活" .. v.name)
    end
end

for k, v in pairs(unuseful_item) do
    _G["stdmodefunc" .. k] = function(player)
        dealUseTitleItem(player, v)
    end
end

---------------------------------------------------------等级直升道具----------------------------------------------------------
local level_equal_item = {
    --[14201] = {name="等级直升30000级", v=30000},
}

local function dealUseLevelEqualItem(player, v)
    local coinCount = 1
    if lualib:GetBagItemCount(player, v.name) < coinCount then
        stop(player)
        return false
    end
    local level = lualib:Level(player)
    if level >= v.v then
        Message:Msg9(player, "您的等级已经超过" .. v.v .. "级，无法使用该道具！")
        return true
    end
    lualib:SetLevel(player, v.v)
    Message:Msg9(player, string.format("恭喜您成功直升%s级！", v.v))
end

for k, v in pairs(level_equal_item) do
    _G["stdmodefunc" .. k] = function(player)
        dealUseLevelEqualItem(player, v)
    end
end
