module("zsfEX", package.seeall)

---获取物品的名字
---@param item string 物品对象
---@return string 名字
function lualib:ItemName(player, item)
    local id = lualib:GetItemInfo(player, item, 2)
    if id then
        return lualib:GetStdItemInfo(id, 1)
    else
        return nil
    end
end

--脱下装备
function lualib:TakeOffItem(player, equipPos)
    if not equipPos then
        return
    end
    local item = linkbodyitem(player, equipPos)
    if item and item ~= '0' then
        local onlyID = getiteminfo(player, item, 1)
        takeoffitem(player, equipPos, onlyID)
    end
end

---添加足迹特效
---@param play string 玩家对象
---@param effectID int 特效ID
---@param modle int 播放模式：0/nil 两步播放 1 单步播放
function lualib:setmoveeff(player, effectID, modle)
    if not effectID or type(effectID) ~= 'number' then
        return
    end
    setmoveeff(player, effectID, modle)
end

---给人物装备界面加特效（自己和他人都可看到）
---@param play string 玩家对象
---@param effectID int 特效ID
---@param position int 显示位置：0 前面 1 后面
function lualib:addEquipEffect(player, effectID, pos)
    if not effectID or type(effectID) ~= 'number' then
        return
    end
    pos = tonumber(pos) or 0
    updateequipeffect(player, effectID, pos)
end

---删除人物装备界面加特效
---@param play string 玩家对象
---@param position int 显示位置：0 前面 1 后面
function lualib:delEquipEffect(player, pos)
    pos = tonumber(pos) or 0
    updateequipeffect(player, 0, pos)
end

---创建文本文件扩展
---@param path string 文件路径
function lualib:IO_CreateFileEX(path)
    if getrandomtext(path, 0) == '' then
        createfile(path)
        addtextlist(path, "新建文件-" .. Time2Str(GetNowTime()), 0)
        return true
    else
        return false
    end
end

---写入指定文本文件
---@param path string 文件路径
---@param str string 写入文本
---@param line string 写入行数(1~65535)
function lualib:IO_AddTextListEX(path, str, line)
    if line == 0 then
        return
    end
    addtextlist(path, str, line)
end

---移动到指定NPC附近
---@param player string 玩家对象
---@param NPCIndex int NPC索引
---@param nRange int 范围值
---@param nRange2 int 范围值2
--[[
1. NPC不在当前地图时: nRange>0: 瞬移传送到NPC附近; nRange=0: 不传送;
2. NPC在当前地图时: nRange>0: 瞬移传送到NPC附近; nRange=0: 导航到NPC附近;
]]
--
function lualib:opennpcshowex(player, NPCIndex, nRange, nRange2)
    nRange2 = tonumber(nRange2) or 1
    opennpcshowex(player, NPCIndex, nRange, nRange2)
end

--获取TXT常量
function lualib:GetConst(player, name)
    return getconst(player, name)
end

--获取背包物品列表
function lualib:GetBagItems(player, itenName, isbind)
    return getbagitems(player, itenName, isbind)
end

--根据物品对象获得物品名字
function lualib:nameByItem(player, item)
    if not item then
        return
    end
    local itemID = getiteminfo(player, item, 2)
    if itemID then
        return getstditeminfo(itemID, 1)
    end
end

--批量检测物品和货币
---@param player string 玩家对象
---@param costTb table 消耗列表
---@return boolean 是否足够
---@return string 提示
function lualib:BatchCheckItemEX(player, costTb)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = getbindmoney(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "您的" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    return true
end

--批量扣除物品和货币
function lualib:BatchDelItemEX(player, costTb, costDesc)
    -- body
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = getbindmoney(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "您的" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            consumebindmoney(player, costSSS[1], costSSS[2], costDesc .. "领取消耗")
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, costDesc .. "消耗") then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    return true
end

---获取att表中的属性
function lualib:Getatt(player, att_id)
    if not player then
        return
    end
    return getbaseinfo(player, 51, att_id)
end

--检测是否佩戴指定物品
function lualib:CheckItemw(player, ItemName)
    return callcheckscriptex(player, "CHECKITEMW", ItemName, 1)
end

return zsfEX
