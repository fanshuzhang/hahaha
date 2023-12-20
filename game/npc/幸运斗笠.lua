---@class NpcBambooHat ���˶���

local NpcBambooHat = {}

NpcBambooHat.Name = "���˶���"
NpcBambooHatCfg = zsf_RequireNpcCfg(NpcBambooHat.Name)

function NpcBambooHat.getVarTb(player)
    local varTb = {}
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end
--��ȡ�ȼ�
function NpcBambooHat.main(player)
    local varTb = NpcBambooHat.getVarTb(player)
    if varTb.mapLevel < NpcBambooHatCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcBambooHat.Name, {data = varTb, version = NpcBambooHatCfg.version})
end

--������ȡ
function NpcBambooHat.MoveOk(player,equipIndex)
    if not equipIndex or tonumber(equipIndex)<1 or tonumber(equipIndex)>9 then
        return
    end
    equipIndex=tonumber(equipIndex)
    local varTb = NpcBambooHat.getVarTb(player)
    -- local nextLevel = varTb.level + 1
    if equipIndex > #NpcBambooHatCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcBambooHatCfg.list[equipIndex]
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "���˶�����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --��
    lualib:AddAndEquipItem(player, NpcBambooHatCfg.pos[2], se.e[1])
    varTb=NpcBambooHat.getVarTb(player)
    --Message:Msg9(player, "�����ɹ���")
    lualib:DoClientUIMethodEx(player, NpcBambooHat.Name.."_notifyWnd", 1, varTb)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcBambooHat.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcBambooHat.Name .. "_setNewData", 1, NpcBambooHatCfg)
end

--Npc�������
function NpcBambooHat.onClickNpc(player, npcID, npcName)
    if not NpcBambooHatCfg.index[npcID] then
        return
    end
    NpcBambooHat.main(player)
end
--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcBambooHat.onClickNpc, NpcBambooHat)

setFormAllowFunc(NpcBambooHat.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(NpcBambooHat.Name, NpcBambooHat)

return NpcBambooHat