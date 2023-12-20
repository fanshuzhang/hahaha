---@class Npcreincarnation �ֻ�ת��

local Npcreincarnation = {}

Npcreincarnation.Name = "�ֻ�ת��"
NpcreincarnationCfg = zsf_RequireNpcCfg(Npcreincarnation.Name)

function Npcreincarnation.getVarTb(player)
    local varTb = {}
    -- local level=lualib:ReLevel(player)
    local level = getbaseinfo(player, 39)
    if not level then
        varTb.level = 0
    else
        varTb.level = level
    end
    varTb.Opening = lualib:GetVar(player, VarCfg["��Фװ����������"])
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

--��ȡ�ȼ�
function Npcreincarnation.main(player)
    local varTb = Npcreincarnation.getVarTb(player)
    if varTb.mapLevel < NpcreincarnationCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. Npcreincarnation.Name,
        { data = varTb, version = NpcreincarnationCfg.version })
end

--������ȡ
function Npcreincarnation.MoveOk(player)
    local varTb = Npcreincarnation.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcreincarnationCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcreincarnationCfg.list[nextLevel]
    if varTb.mapLevel < se.needMapLevel then
        Message:Msg9(player, "��ǰ��½��������������ǰ����һ��½��������")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "�ֻ�ת����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --������
    lualib:SetReLevelEX(player, nextLevel)

    --���ƺ�
    if varTb.level > 0 then
        lualib:DelTitle(player, NpcreincarnationCfg.list[varTb.level].e[1])
    end
    lualib:AddTitle(player, NpcreincarnationCfg.list[nextLevel].e[1])

    --����
    lualib:SetVar(player, VarCfg["��Фװ����������"], (lualib:GetVar(player, VarCfg["��Фװ����������"]) + 1))
    varTb = Npcreincarnation.getVarTb(player)
    lualib:DoClientUIMethodEx(player, Npcreincarnation.Name .. "_notifyWnd", 1, varTb)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function Npcreincarnation.reloadData(player)
    lualib:DoClientUIMethodEx(player, Npcreincarnation.Name .. "_setNewData", 1, NpcreincarnationCfg)
end

--Npc�������
function Npcreincarnation.onClickNpc(player, npcID, npcName)
    if not NpcreincarnationCfg.index[npcID] then
        return
    end
    Npcreincarnation.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, Npcreincarnation.onClickNpc, Npcreincarnation)

setFormAllowFunc(Npcreincarnation.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg(Npcreincarnation.Name, Npcreincarnation)

return Npcreincarnation
