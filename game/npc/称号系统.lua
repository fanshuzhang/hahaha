---@class NpcExplorerTitle �ƺ�ϵͳ

local NpcExplorerTitle = {}

NpcExplorerTitle.Name = "�ƺ�ϵͳ"
NpcExplorerTitleCfg = zsf_RequireNpcCfg(NpcExplorerTitle.Name)

function NpcExplorerTitle.getVarTb(player)
    local varTb = {}
    local level = lualib:GetVar(player, VarCfg["̽���߳ƺ�"])
    if level then
        varTb.level = level
    else
        varTb.level = 0
    end
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    --�����ƺŴ���
    local jsonStr = lualib:GetVar(player, VarCfg['̽���߳ƺŵ���װ��'])
    local jsonTb = {}
    if jsonStr and jsonStr == '' then
        for i = 1, #NpcExplorerTitleCfg.list do
            table.insert(jsonTb, {})
            for j = 1, #NpcExplorerTitleCfg.list[i].equip do
                if NpcExplorerTitleCfg.list[i].equip[j] then
                    table.insert(jsonTb[i], 0)
                end
            end
        end
        lualib:SetVar(player, VarCfg['̽���߳ƺŵ���װ��'], tbl2json(jsonTb))
        jsonStr=tbl2json(jsonTb)
    end
    jsonTb = json2tbl(jsonStr)
    varTb.jsonTb = jsonTb
    return varTb
end

--��ȡ�ȼ�
function NpcExplorerTitle.main(player)
    local varTb = NpcExplorerTitle.getVarTb(player)
    if varTb.mapLevel < NpcExplorerTitleCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcExplorerTitle.Name,
        { data = varTb, version = NpcExplorerTitleCfg.version })
end

--����
function NpcExplorerTitle.LightUp(player, TitleIndex, equipIndex)
    if not TitleIndex or not equipIndex or not NpcExplorerTitleCfg.list[TitleIndex] or not NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex] then
        return
    end
    TitleIndex, equipIndex = tonumber(TitleIndex), tonumber(equipIndex)
    --���ݴ���
    local varTb = NpcExplorerTitle.getVarTb(player)
    if not varTb.jsonTb[TitleIndex][equipIndex] then
        release_print("NpcExplorerTitle���ݴ���")
        return
    end
    if varTb.jsonTb[TitleIndex][equipIndex] ~= 0 then
        Message:Msg9(player, "�Ѿ���������װ����")
        return
    end
    if getbagitemcount(player, NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex][1]) < 1 then
        Message:Msg9(player, "�����и���Ʒ�������㣡")
        return
    end
    --���ݸ���
    if takeitem(player, NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex][1], 1) then
        varTb.jsonTb[TitleIndex][equipIndex] = 1
    end
    lualib:SetVar(player, VarCfg['̽���߳ƺŵ���װ��'], tbl2json(varTb.jsonTb))
    Message:Msg9(player, "��ϲ�ɹ�����")
    varTb = NpcExplorerTitle.getVarTb(player)
    lualib:DoClientUIMethodEx(player, NpcExplorerTitle.Name .. "_notifyWnd", 1, varTb, TitleIndex)
end

--������ȡ
function NpcExplorerTitle.MoveOk(player, TitleIndex)
    if not TitleIndex or not NpcExplorerTitleCfg.list[TitleIndex] then
        return
    end
    local varTb = NpcExplorerTitle.getVarTb(player)
    if varTb.level < TitleIndex - 1 then
        Message:Msg9(player, "�밴˳����ȡ��")
        return
    end
    if varTb.level == TitleIndex then
        Message:Msg9(player, "�����ظ���ȡ")
        return
    end
    local isLight = false
    for i = 1, #NpcExplorerTitleCfg.list[TitleIndex].equip do
        if varTb.jsonTb[TitleIndex][i] == 0 then
            isLight = false
            break
        else
            isLight = true
        end
    end
    if not isLight then
        Message:Msg9(player, "װ����δȫ���������޷���ȡ")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, NpcExplorerTitleCfg.list[TitleIndex].cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, NpcExplorerTitleCfg.list[TitleIndex].cost, "̽���߳ƺ���������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --��ȡ�����ƺ�
    if varTb.level == 0 then
        lualib:AddTitleEx(player, NpcExplorerTitleCfg.list[TitleIndex].e[1])
    else
        lualib:DelTitle(player, NpcExplorerTitleCfg.list[TitleIndex - 1].e[1])
        lualib:AddTitleEx(player, NpcExplorerTitleCfg.list[TitleIndex].e[1])
    end
    lualib:SetVar(player, VarCfg['̽���߳ƺ�'], lualib:GetVar(player, VarCfg["̽���߳ƺ�"]) + 1)
    Message:Msg9(player, "��ȡ�ɹ���")
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcExplorerTitle.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcExplorerTitle.Name .. "_setNewData", 1, NpcExplorerTitleCfg)
end

--Npc�������
function NpcExplorerTitle.onClickNpc(player, npcID, npcName)
    if not NpcExplorerTitleCfg.index[npcID] then
        return
    end
    NpcExplorerTitle.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcExplorerTitle.onClickNpc, NpcExplorerTitle)

setFormAllowFunc(NpcExplorerTitle.Name, { "main", "reloadData", "MoveOk", "LightUp" })
Message.RegisterClickMsg(NpcExplorerTitle.Name, NpcExplorerTitle)

return NpcExplorerTitle
