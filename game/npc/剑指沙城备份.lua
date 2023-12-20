NpcCastleData = require("Envir/Extension/DirectorDir/Config/NPC/cfg_��ָɳ��.lua")
---@class NpcCastle ��ָɳ��
local NpcCastle = {}
function NpcCastle.initJson(player)
    local jsonStr = lualib:GetVar(player, VarCfg["���ǽ������"])
    local jsonTb = {}
    if jsonStr == "" then
        jsonTb = {winFlag=false, defeatFlag=false, killFlag= false, ownerFlag=false}
        lualib:SetVar(player, VarCfg["���ǽ���"], tbl2json(jsonTb))
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
    lualib:ShowFormWithContent(player, "npc/��ָɳ��", {data = varTb, version = NpcCastleData.version})
end

-- ����
function NpcCastle.MoveOk(player, pos)
    pos = tonumber(pos)
    if pos < 1 or pos > 3 then
        Message:Msg9(player, "��������")
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["��������"])
    if G100 <= 0 then
        Message:Msg9(player, "��ǰ��û�п�ʼ�����أ�")
        return
    end
    if lualib:CastleInfo(5) then
        Message:Box(player, "��ǰ���ڹ���\\�빥�ǽ�����������\\��ȡʱ��22:10-22:59")
        return
    end
    local nowTime = lualib:GetAllTime()
    local year, month, day, hour, min, sec = lualib:TimeDetail(nowTime)
    if hour < 22 or hour >= 23 or min < 10 or min > 59 then
        Message:Box(player, "��ǰ������ȡʱ����\\��ȡʱ��22:10-22:59")
        return
    end
    local varTb = NpcCastle.getVarTb(player)
    if varTb.myGuild == "" then
        Message:Box(player, "����ǰû���л�\\�޷���ȡ����")
        return
    end
    if varTb.flag.ownerFlag or varTb.flag.winFlag or varTb.flag.defeatFlag then
        Message:Box(player, "���Ѿ���ȡ������һ�ݵĽ����ˣ��޷�����ȡ���ཱ��")
        return
    end
    if pos == 1 then
        local myName = lualib:Name(player)
        if myName ~= varTb.castleOwner then
            Message:Box(player, "�����ǳ���\\�޷���ȡ����")
            return
        end
        if varTb.flag.ownerFlag then
            Message:Box(player, "���Ѿ���ȡ���л��ϴ�����")
            return
        end
        if varTb.myGuild ~= varTb.castleGuildName then
            Message:Box(player, "�����л᲻��ʤ���л�\\�޷���ȡ����")
            return
        end
    elseif pos == 2 then
        local myName = lualib:Name(player)
        if myName == varTb.castleOwner then
            Message:Box(player, "���ǳ���\\����ȡ����������")
            return
        end
        if varTb.flag.winFlag then
            Message:Box(player, "���Ѿ���ȡ��ɳ�Ϳ˳�Ա������")
            return
        end
        if varTb.myGuild ~= varTb.castleGuildName then
            Message:Box(player, "�����л᲻��ʤ���л�\\�޷���ȡ����")
            return
        end
    elseif pos == 3 then
        if varTb.flag.defeatFlag then
            Message:Box(player, "���Ѿ���ȡ��ʧ���л��Ա������")
            return
        end
        if varTb.myGuild == varTb.castleGuildName then
            Message:Box(player, "�����л���ʤ���лᣬ�޷���ȡʧ�ܷ�����")
            return
        end
    else
        Message:Box(player, "�����쳣")
        return
    end
    local killValue = lualib:GetPlayerInt(player, "ɳ�ǻ�Ծ��")
    if killValue < 100 then
        Message:Msg9(player, "�㻹δ���100��ɳ�ǻ�Ծ�ȣ��޷���ȡ����")
        return
    end
    if lualib:GetBagFree(player) < 10 then
        Message:Msg9(player, "�����ռ䲻�㣬�������������ȡ")
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
        lualib:SetVar(player, VarCfg["���ǽ������"], tbl2json(varTb.flag))
        local bindRule = lualib:CalItemRuleCountEx({2,6,7,9})
        lualib:AddBatchItem(player, rewardList, "�����лά��"..pos, bindRule)
        lualib:ShowRewards(player, rewardList)
        lualib:DoClientUIMethodEx(player, "��ָɳ��_notifyWnd", 1, varTb)
    end
end

function NpcCastle.portal(player, place)
    place = tonumber(place) or 1
    lualib:MapMoveXY(player, NpcCastleData.portal[place].mapId, NpcCastleData.portal[place].x, NpcCastleData.portal[place].y, 3)
    lualib:DoClientUIMethodEx(player, "��ָɳ��_OnClose")
end

function NpcCastle.fly(player) --ֱ�ɻʹ�
    if not lualib:CastleInfo(5) then
        Message:Msg9(player, "������δ��ʼ��")
        return
    end
    local nowTime = lualib:GetAllTime()
    local year, month, day, hour, min, sec = lualib:TimeDetail(nowTime)
    if not ((hour == 20) or (hour == 21 and min < 55)) then
        Message:Msg9(player, "ֱ��ͨ���Ѿ��ر�")
        return
    end
    --�����ж�
    local costDesc = "ֱ�ɻʹ�����"
    local costTb = NpcCastleData.flyCost
    for i=1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                Message:Msg9(player, "����"..costSSS[1].."����"..costSSS[2].."���޷���ȡ�ý�����")
                return
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                Message:Msg9(player, "���Ĳ���"..costSSS[1].."����"..costSSS[2].."���޷���ȡ�ý�����")
                return
            end
        end
    end
    for i=1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            lualib:SetMoneyEx(player, costSSS[1], "-", costSSS[2], costDesc.."��ȡ����", true)
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, "ֱ�ɻʹ�����") then
                Message:Msg9(player, "���Ĳ���"..costSSS[1].."����"..costSSS[2].."���޷���ȡ�ý�����")
                return
            end
        end
    end
    local flyMap = NpcCastleData.flyMap
    lualib:MapMove(player, flyMap.mapId, flyMap.x, flyMap.y, 1)
    lualib:DoClientUIMethodEx(player, "��ָɳ��_OnClose")
end

-- �汾���ԣ���������
function NpcCastle.reloadData(player)
    lualib:DoClientUIMethodEx(player, "��ָɳ��_setNewData", 1, NpcCastleData)
end

-- npc�������
function NpcCastle.onClickNpc(player, npcId, npcName)
    if not NpcCastleData.index[npcId] then
        return
    end
    NpcCastle.main(player)
end

-- ��¼����
function NpcCastle.onLogin(player)
end

--GameEvent.add(EventCfg.onLogin, NpcCastle.onLogin, NpcCastle)
GameEvent.add(EventCfg.onClickNpc, NpcCastle.onClickNpc, NpcCastle)
setFormAllowFunc("��ָɳ��", {"main", "reloadData", "MoveOk", "fly", "portal"})
Message.RegisterClickMsg("��ָɳ��", NpcCastle)

return NpcCastle
