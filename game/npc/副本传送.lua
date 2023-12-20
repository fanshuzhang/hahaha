---@class NpcInstanceTeleport ��������
local NpcInstanceTeleportCfg = zsf_RequireNpcCfg("��������")
local tgfbjlCfg = zsf_RequireNpcCfg("ͨ�ظ�������")
local NpcInstanceTeleport = {}

function NpcInstanceTeleport.getVarTb(player)
    local varTb = {}
    local jsonStr = lualib:GetVar(player, VarCfg["����ͨ�ؼ�¼"])
    local record = {}
    if jsonStr ~= '' then
        record = json2tbl(jsonStr)
    else
        for i = 1, 18 do
            table.insert(record, { 0, 0, 0 }) --��ͨ�����ѣ�����
        end
        lualib:SetVar(player, VarCfg["ͨ�ظ�����¼"], tbl2json(record))
    end
    varTb.level = lualib:GetVar(player, VarCfg["�����ȼ�"])
    varTb.record = record
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

function NpcInstanceTeleport.main(player)
    local varTb = NpcInstanceTeleport.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/��������", { data = varTb, version = NpcInstanceTeleportCfg.version })
end

--����
function NpcInstanceTeleport.MoveOkGG(player, Tab, going)
    if not Tab or not going or not tonumber(Tab) or not tonumber(going) then
        return
    end
    local varTb = NpcInstanceTeleport.getVarTb(player)
    Tab, going = tonumber(Tab), tonumber(going)
    --�����Ƿ����
    local num = NpcInstanceTeleportCfg.list[Tab].cost[1][2]
    if varTb.level < Tab then
        num = num * 3
    end
    if getbindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[1][1]) < num then
        Message:Msg9(player, "���Ľ�Ҳ��㣡")
        return
    end
    consumebindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[1][1], num, "�����������Ϳ۳�����")
    lualib:MapMove(player, NpcInstanceTeleportCfg.list[Tab].mapID[1])
    lualib:DoClientUIMethodEx(player, "��������_OnClose")
end

--����
function NpcInstanceTeleport.MoveOkGR(player, Tab, going)
    if not Tab or not going or not tonumber(Tab) or not tonumber(going) then
        return
    end
    Tab, going = tonumber(Tab), tonumber(going)
    -- local varTb = NpcInstanceTeleport.getVarTb(player)
    -- if going > 1 and varTb.record[Tab][going - 1] ~= 1 then
    --     Message:Msg9(player, "����ͨ��֮ǰ�ĸ���,һ��һ������")
    --     return
    -- end
    --
    if getbindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[2][1]) < NpcInstanceTeleportCfg.list[Tab].cost[2][2] then
        Message:Msg9(player, "���Ľ�Ҳ��㣡")
        return
    end
    consumebindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[2][1], NpcInstanceTeleportCfg.list[Tab].cost[2][2],
        "���˸������Ϳ۳�����")
    --���������ͼ
    local mapID = lualib:Name(player) .. 'a'
    killmonsters(mapID, '*', 0, false)
    delmirrormap(lualib:Name(player))
    addmirrormap(NpcInstanceTeleportCfg.list[Tab].mapID[2], mapID, NpcInstanceTeleportCfg.list[Tab].name, 1800, '3',
        0, 330, 330)
    lualib:MapMove(player, mapID)
    Message:Msg9(player, "������ʿ����ս���Ｔ��ˢ�£���ע�⣡")
    delaygoto(player, 1500, "click,��������_createNpcMon," .. Tab, 0)
    lualib:SetInt(player, "�����Ѷ�", going)
    lualib:SetInt(player, "��������", Tab)
    lualib:DoClientUIMethodEx(player, "��������_OnClose")
    --������ͼ����
    setmapmode(mapID, "NODROPITEMFILENAME", 1, "���ػس�ʯ")
    mapkillmonexprate(player, mapID, going * 100) --ɱ�־���
    --���ñ���
end

--ˢ�¹����Npc
function NpcInstanceTeleport.createNpcMon(player, Tab)
    if not Tab or not tonumber(Tab) then
        return
    end
    Tab = tonumber(Tab)
    local going = lualib:GetInt(player, "�����Ѷ�")
    --ˢ�¹���
    local attNum = { { 10, 10 }, { 12, 12 }, { 16, 16 }, { 18, 18 }, { 19, 19 }, { 20, 20 } }
    local monTb = {}
    local mapID = lualib:Name(player) .. 'a'
    for _, value in ipairs(NpcInstanceTeleportCfg.mon[Tab]) do
        monTb = genmon(mapID, NpcInstanceTeleportCfg.list[Tab].npcPos[1], NpcInstanceTeleportCfg.list[Tab].npcPos[2],
            value.name, value.range, value.num, 251)
        if going > 1 then
            for __, vvalue in pairs(monTb) do
                for ___, v in ipairs(attNum) do
                    setbaseinfo(vvalue, v[2], getbaseinfo(vvalue, v[1]) * going)
                end
                setbaseinfo(vvalue, 9, getbaseinfo(vvalue, 10))
                setbaseinfo(vvalue, 11, getbaseinfo(vvalue, 12))
            end
        end
    end
    Message:Msg9(player, "�𾴵����ߣ�����������Ҫ�ż����������Ὣ�����ͻ���������")
    --������ʱ��
    setofftimer(player, 106)
    setontimer(player, 106, 5, 360)
end

--����ͼ���Ƿ��й���
function ontimer106(player)
    local mapID = lualib:Name(player) .. 'a'
    local monNum = getmoncount(mapID, -1, true)
    if monNum <= 0 then
        lualib:MapMoveXY(player, '3', 330, 330, 7)
        NpcInstanceTeleport.give(player)
        setofftimer(player, 106)
        return
    end
    if monNum < 5 then
        Message:Msg9(player, "����" .. monNum .. "ֻ������������ͣ�")
    end
end

--������
function NpcInstanceTeleport.give(player)
    local Tab, going = lualib:GetInt(player, "��������"), lualib:GetInt(player, "�����Ѷ�")
    Message:Msg9(player, "��ϲ�ɹ�ͨ�ظ���")
    local reward = tgfbjlCfg[Tab]
    local count = 0
    if going == 1 then
        count = math.random(1, 4)
    elseif going == 2 then
        count = math.random(2, 5)
    elseif going == 3 then
        count = math.random(3, 6)
    end
    --��ȡ����
    local results = {}
    for i = 1, count do
        local totalWeight = 0
        for _, value in ipairs(reward) do
            totalWeight = totalWeight + value[2] -- �ڶ���������Ȩ��
        end
        local randomValue = math.random() * totalWeight
        local cumulativeWeight = 0
        for _, value in ipairs(reward) do
            cumulativeWeight = cumulativeWeight + value[2]
            if randomValue <= cumulativeWeight then
                table.insert(results, { value[1], 1, id = value.id })
                break
            end
        end
    end
    lualib:AddBatchItem(player, results, "ͨ�ظ�������", 0)
    lualib:ShowRewards(player, results)
    --���ø���ͨ��
    local varTb = NpcInstanceTeleport.getVarTb(player)
    varTb.record[Tab][going] = 1
    lualib:SetVar(player, VarCfg["ͨ�ظ�����¼"], tbl2json(varTb.record))
    if going == 3 then
        if varTb.level < Tab then
            lualib:SetVar(player, VarCfg["�����ȼ�"], Tab)
            Message:Msg9(player,"��ϲ��ʿ�ɹ�ͨ�ص����Ѷȸ�������Ϊ�㿪����һ���ؿ���")
        end
    end
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcInstanceTeleport.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcInstanceTeleport.Name .. "_setNewData", 1, NpcInstanceTeleportCfg)
end

function NpcInstanceTeleport.onClickNpc(player, NpcID, NpcIName)
    if not NpcInstanceTeleportCfg.index[NpcID] then
        return
    end
    NpcInstanceTeleport.main(player)
end

--�����ͼ����
function NpcInstanceTeleport.goEnterMap(player, mapId, mapName)
    if mapId == '3' then
        if checkmirrormap(lualib:Name(player) .. 'a') then
            setofftimer(player, 106)
            killmonsters(lualib:Name(player) .. 'a', '*', 0, false)
            delmirrormap(lualib:Name(player) .. 'a')
            return
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcInstanceTeleport.onClickNpc, NpcInstanceTeleport)
GameEvent.add(EventCfg.goEnterMap, NpcInstanceTeleport.goEnterMap, NpcInstanceTeleport)
setFormAllowFunc("��������", { "reloadData", "MoveOkGG", "MoveOkGR" })
Message.RegisterClickMsg("��������", NpcInstanceTeleport)
return NpcInstanceTeleport
