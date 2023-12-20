NpcCastleData = require("Envir/Extension/DirectorDir/Config/NPC/cfg_剑指沙城.lua")
---@class NpcCastle 剑指沙城
local NpcCastle = {}
function NpcCastle.initJson(player)
    local jsonStr = lualib:GetVar(player, VarCfg["攻城奖励标记"])
    local jsonTb = {}
    if jsonStr == "" then
        jsonTb = {winFlag=false, defeatFlag=false, killFlag= false, ownerFlag=false}
        lualib:SetVar(player, VarCfg["攻城奖励"], tbl2json(jsonTb))
    else
        jsonTb = json2tbl(jsonStr)
    end
    return jsonTb
end

function NpcCastle.getVarTb(player)
    local varTb = {}
    varTb.flag = NpcCastle.initJson(player)
    local myGuild = lualib:GetMyGuild(player)
    if myGuild and myGuild ~= "0" then
        varTb.myGuild = lualib:GetGuildInfo(myGuild, 1)
    else
        varTb.myGuild = ""
    end
    varTb.castleGuildName = lualib:CastleInfo(2)
    varTb.castleOwner = lualib:CastleInfo(3)
    return varTb
end

function NpcCastle.main(player)
    local varTb = NpcCastle.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/剑指沙城", {data = varTb, version = NpcCastleData.version})
end

-- 提升
function NpcCastle.MoveOk(player, pos)
    pos = tonumber(pos)
    if pos < 1 or pos > 3 then
        Message:Msg9(player, "参数错误")
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["开区天数"])
    if G100 <= 0 then
        Message:Msg9(player, "当前还没有开始攻城呢！")
        return
    end
    if lualib:CastleInfo(5) then
        Message:Box(player, "当前正在攻城\\请攻城结束后再来！\\领取时间22:10-22:59")
        return
    end
    local nowTime = lualib:GetAllTime()
    local year, month, day, hour, min, sec = lualib:TimeDetail(nowTime)
    if hour < 22 or hour >= 23 or min < 10 or min > 59 then
        Message:Box(player, "当前不在领取时间内\\领取时间22:10-22:59")
        return
    end
    local varTb = NpcCastle.getVarTb(player)
    if varTb.myGuild == "" then
        Message:Box(player, "您当前没有行会\\无法领取奖励")
        return
    end
    if varTb.flag.ownerFlag or varTb.flag.winFlag or varTb.flag.defeatFlag then
        Message:Box(player, "您已经领取过其中一份的奖励了，无法再领取更多奖励")
        return
    end
    if pos == 1 then
        local myName = lualib:Name(player)
        if myName ~= varTb.castleOwner then
            Message:Box(player, "您不是城主\\无法领取奖励")
            return
        end
        if varTb.flag.ownerFlag then
            Message:Box(player, "您已经领取过行会老大奖励了")
            return
        end
        if varTb.myGuild ~= varTb.castleGuildName then
            Message:Box(player, "您的行会不是胜利行会\\无法领取奖励")
            return
        end
    elseif pos == 2 then
        local myName = lualib:Name(player)
        if myName == varTb.castleOwner then
            Message:Box(player, "您是城主\\请领取城主奖励！")
            return
        end
        if varTb.flag.winFlag then
            Message:Box(player, "您已经领取过沙巴克成员奖励了")
            return
        end
        if varTb.myGuild ~= varTb.castleGuildName then
            Message:Box(player, "您的行会不是胜利行会\\无法领取奖励")
            return
        end
    elseif pos == 3 then
        if varTb.flag.defeatFlag then
            Message:Box(player, "您已经领取过失败行会成员奖励了")
            return
        end
        if varTb.myGuild == varTb.castleGuildName then
            Message:Box(player, "您的行会是胜利行会，无法领取失败方奖励")
            return
        end
    else
        Message:Box(player, "参数异常")
        return
    end
    local killValue = lualib:GetPlayerInt(player, "沙城活跃度")
    if killValue < 100 then
        Message:Msg9(player, "你还未获得100点沙城活跃度，无法领取奖励")
        return
    end
    if lualib:GetBagFree(player) < 10 then
        Message:Msg9(player, "背包空间不足，请清理后再来领取")
        return
    end
    local rewardList
    if pos == 1 then
        varTb.flag.ownerFlag = true
        rewardList = NpcCastleData.rewardList[1]
    elseif pos == 2 then
        varTb.flag.winFlag = true
        rewardList = NpcCastleData.rewardList[2]
    elseif pos == 3 then
        varTb.flag.defeatFlag = true
        rewardList = NpcCastleData.rewardList[3]
    end
    if rewardList then
        lualib:SetVar(player, VarCfg["攻城奖励标记"], tbl2json(varTb.flag))
        local bindRule = lualib:CalItemRuleCountEx({2,6,7,9})
        lualib:AddBatchItem(player, rewardList, "攻城行会奖励"..pos, bindRule)
        lualib:ShowRewards(player, rewardList)
        lualib:DoClientUIMethodEx(player, "剑指沙城_notifyWnd", 1, varTb)
    end
end

function NpcCastle.portal(player, place)
    place = tonumber(place) or 1
    lualib:MapMoveXY(player, NpcCastleData.portal[place].mapId, NpcCastleData.portal[place].x, NpcCastleData.portal[place].y, 3)
    lualib:DoClientUIMethodEx(player, "剑指沙城_OnClose")
end

function NpcCastle.fly(player) --直飞皇宫
    if not lualib:CastleInfo(5) then
        Message:Msg9(player, "攻城尚未开始！")
        return
    end
    local nowTime = lualib:GetAllTime()
    local year, month, day, hour, min, sec = lualib:TimeDetail(nowTime)
    if not ((hour == 20) or (hour == 21 and min < 55)) then
        Message:Msg9(player, "直飞通道已经关闭")
        return
    end
    --消耗判断
    local costDesc = "直飞皇宫消耗"
    local costTb = NpcCastleData.flyCost
    for i=1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                Message:Msg9(player, "您的"..costSSS[1].."不足"..costSSS[2].."，无法领取该奖励！")
                return
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                Message:Msg9(player, "您的材料"..costSSS[1].."不足"..costSSS[2].."，无法领取该奖励！")
                return
            end
        end
    end
    for i=1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            lualib:SetMoneyEx(player, costSSS[1], "-", costSSS[2], costDesc.."领取消耗", true)
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, "直飞皇宫消耗") then
                Message:Msg9(player, "您的材料"..costSSS[1].."不足"..costSSS[2].."，无法领取该奖励！")
                return
            end
        end
    end
    local flyMap = NpcCastleData.flyMap
    lualib:MapMove(player, flyMap.mapId, flyMap.x, flyMap.y, 1)
    lualib:DoClientUIMethodEx(player, "剑指沙城_OnClose")
end

-- 版本不对，数据重载
function NpcCastle.reloadData(player)
    lualib:DoClientUIMethodEx(player, "剑指沙城_setNewData", 1, NpcCastleData)
end

-- npc点击触发
function NpcCastle.onClickNpc(player, npcId, npcName)
    if not NpcCastleData.index[npcId] then
        return
    end
    NpcCastle.main(player)
end

-- 登录触发
function NpcCastle.onLogin(player)
end

--GameEvent.add(EventCfg.onLogin, NpcCastle.onLogin, NpcCastle)
GameEvent.add(EventCfg.onClickNpc, NpcCastle.onClickNpc, NpcCastle)
setFormAllowFunc("剑指沙城", {"main", "reloadData", "MoveOk", "fly", "portal"})
Message.RegisterClickMsg("剑指沙城", NpcCastle)

return NpcCastle
