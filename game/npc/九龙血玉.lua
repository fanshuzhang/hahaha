---@class NpcBloodJade ����Ѫ��

local NpcBloodJade = {}

NpcBloodJade.Name = "����Ѫ��"
NpcBloodJadeCfg = zsf_RequireNpcCfg(NpcBloodJade.Name)

function NpcBloodJade.getVarTb(player)
    local varTb = {}
    local equip = lualib:LinkBodyItem(player, NpcBloodJadeCfg.pos[2])
    if equip ~= "0" and equip then
        -- varTb.index=lualib:GetItemInfo(player, equip, 2)
        varTb.equipName = lualib:ItemName(player, equip)
        varTb.equip = equip
        varTb.level = NpcBloodJadeCfg.equip[varTb.equipName]
    else
        -- varTb.index=0
        varTb.equipName = ""
        varTb.equip = 0
        varTb.level = 0
    end
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end
--��ȡ�ȼ�
function NpcBloodJade.main(player)
    local varTb = NpcBloodJade.getVarTb(player)
    if varTb.mapLevel < NpcBloodJadeCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcBloodJade.Name, {data = varTb, version = NpcBloodJadeCfg.version})
end

--������ȡ
function NpcBloodJade.MoveOk(player)
    local varTb = NpcBloodJade.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcBloodJadeCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcBloodJadeCfg.list[nextLevel]
    if varTb.mapLevel < se.needMapLevel then
        Message:Msg9(player, "��ǰ��½��������������ǰ����һ��½��������")
        return
    end
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷�������")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "����Ѫ����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --��
    if varTb.level ~= 0 then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --��
    lualib:AddAndEquipItem(player, NpcBloodJadeCfg.pos[2], se.e[1])
    varTb=NpcBloodJade.getVarTb(player)
    --Message:Msg9(player, "�����ɹ���")
    lualib:DoClientUIMethodEx(player, NpcBloodJade.Name.."_notifyWnd", 1, varTb)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcBloodJade.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcBloodJade.Name .. "_setNewData", 1, NpcBloodJadeCfg)
end

--Npc�������
function NpcBloodJade.onClickNpc(player, npcID, npcName)
    if not NpcBloodJadeCfg.index[npcID] then
        return
    end
    NpcBloodJade.main(player)
end
--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcBloodJade.onClickNpc, NpcBloodJade)

setFormAllowFunc(NpcBloodJade.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(NpcBloodJade.Name, NpcBloodJade)

return NpcBloodJade