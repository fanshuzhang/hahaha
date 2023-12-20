---@class Npcdefense ���Է���

local Npcdefense = {}

Npcdefense.Name = "���Է���"
NpcdefenseCfg = zsf_RequireNpcCfg(Npcdefense.Name)

function Npcdefense.getVarTb(player)
    local varTb = {}
    local equip = lualib:LinkBodyItem(player, NpcdefenseCfg.pos[2])
    if equip ~= "0" and equip then
        -- varTb.index=lualib:GetItemInfo(player, equip, 2)
        varTb.equipName = lualib:ItemName(player, equip)
        varTb.equip = equip
        varTb.level = NpcdefenseCfg.equip[varTb.equipName]
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
function Npcdefense.main(player)
    local varTb = Npcdefense.getVarTb(player)
    if varTb.mapLevel < NpcdefenseCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. Npcdefense.Name, {data = varTb, version = NpcdefenseCfg.version})
end

--������ȡ
function Npcdefense.MoveOk(player)
    local varTb = Npcdefense.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcdefenseCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcdefenseCfg.list[nextLevel]
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "���Է�����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --��
    if varTb.level ~= 0 then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --��
    lualib:AddAndEquipItem(player, NpcdefenseCfg.pos[2], se.e[1])
    varTb=Npcdefense.getVarTb(player)
    --Message:Msg9(player, "�����ɹ���")
    lualib:DoClientUIMethodEx(player, Npcdefense.Name.."_notifyWnd", 1, varTb)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function Npcdefense.reloadData(player)
    lualib:DoClientUIMethodEx(player, Npcdefense.Name .. "_setNewData", 1, NpcdefenseCfg)
end

--Npc�������
function Npcdefense.onClickNpc(player, npcID, npcName)
    if not NpcdefenseCfg.index[npcID] then
        return
    end
    Npcdefense.main(player)
end
--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, Npcdefense.onClickNpc, Npcdefense)

setFormAllowFunc(Npcdefense.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(Npcdefense.Name, Npcdefense)

return Npcdefense