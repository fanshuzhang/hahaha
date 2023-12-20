--爆出稀有装备条件检测1
local tsItemDropLimit = {
    ["充值金额+1元"] = 10,
}
local tsItemDropLimitExcludeMob = {
    ["小刀【必爆充值】福利BOSS"] = 1,
    ["你给我爆！"] = 1,
    ["爆不爆？肯定爆！"] = 1,
    ["爆不爆谁知道"] = 1,
}
-- 终极剑甲检测
--local tsItemEquipMaxLimit = {
--    ["O临火霸王剑★★★★"] = 1,
--    ["O临火霸王甲★★★★"] = 1,
--}
-- 特殊材料物品，充值没到的玩家打到的材料不可交易不可丢弃
local tsItemMaterial = {
    ["本源·弑神丹"] = 1,
    ["本源·造化丹"] = 1,
    ["本源·炼体丹"] = 1,
    ["转生丹(普通)"] = 1,
    ["转生丹(高级)"] = 1,
    ["转生丹(超级)"] = 1,
    ["转生丹(终级)"] = 1,
    ["时装水晶(强化)"] = 1,
    ["魔法神石(进阶)"] = 1,
    ["神技陨石(强化)"] = 1,
    ["冠名兑换卡"] = 1,
    ["最终神石"] = 1,
    ["神器图纸"] = 1,
    ["绿色千路石"] = 1,
    ["蓝色千路石"] = 1,
    ["紫色千路石"] = 1,
    ["金色千路石"] = 1,
    ["时装水晶(强化)"] = 1,

    ["10000元宝"] = 1,
    ["20000元宝"] = 1,
    ["50000元宝"] = 1,
    ["100000元宝"] = 1,
    ["1小刀币"] = 1,
    ["2小刀币"] = 1,
    ["5小刀币"] = 1,
    ["10小刀币"] = 1,
    ["1积分"] = 1,
    ["10积分"] = 1,
    ["50积分"] = 1,
    ["100积分"] = 1,
    ["20积分"] = 1,
}

-- 怪物掉落物品触发
function mondropitemex(player, item, monster, x, y)
    local itemName = lualib:ItemName(player, item)

    --if tsItemMaterial[itemName] ~= nil then
    --    local U8 = lualib:GetVar(player, "U8")
    --    if U8 < GeneralGlobalConfig.tradeLimit then
    --        if lualib:GetBagFree(player) >= 15 then
    --            lualib:AddItem(player, itemName, 1, lualib:CalItemRuleCountEx({2,6,7,9}))
    --        end
    --        return false
    --    end
    --end
    --
    --
    --
    --local count = tsItemDropLimit[itemName]
    --if count then
    --    local mobName = lualib:GetBaseInfo(monster, 1, 1)
    --    local mobName2 = lualib:GetBaseInfo(monster, 1, 0)
    --    if tsItemDropLimitExcludeMob[mobName] ~= nil or tsItemDropLimitExcludeMob[mobName2] ~= nil then
    --        return true
    --    end
    --    local J4 = lualib:GetVar(player, "J4")
    --    if J4 < count then
    --        lualib:SetVar(player, "J4", J4 + 1)
    --        return false
    --    else
    --        lualib:SetVar(player, "J4", 0)
    --    end
    --end
    return true
end