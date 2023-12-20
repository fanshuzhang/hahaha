---@class NpcHellishGhostClaw ������צ
local NpcHellishGhostClaw = {}

NpcHellishGhostClaw.Name = "������צ"
NpcHellishGhostClawCfg = zsf_RequireNpcCfg(NpcHellishGhostClaw.Name)

function NpcHellishGhostClaw.getVarTb(player)
    local varTb = {}
    local equip = lualib:LinkBodyItem(player, NpcHellishGhostClawCfg.pos[2])
    if equip ~= "0" and equip then
        -- varTb.index=lualib:GetItemInfo(player, equip, 2)
        varTb.equipName = lualib:ItemName(player, equip)
        varTb.equip = equip
        varTb.level = NpcHellishGhostClawCfg.equipIndex[varTb.equipName]
    else
        varTb.equipName = ""
        varTb.equip = 0
        varTb.level = 0
    end
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    varTb.Job = lualib:GetVar(player, VarCfg["��ɫְҵ"])
    return varTb
end

--��ȡ�ȼ�
function NpcHellishGhostClaw.main(player)
    local varTb = NpcHellishGhostClaw.getVarTb(player)
    if varTb.mapLevel < NpcHellishGhostClawCfg.list[1].needMapLevel then
        Message:Box(player, "��ǰ��½��δ�����ù���")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcHellishGhostClaw.Name,
        { data = varTb, version = NpcHellishGhostClawCfg.version })
end

--������ȡ
function NpcHellishGhostClaw.MoveOk(player)
    local varTb = NpcHellishGhostClaw.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcHellishGhostClawCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcHellishGhostClawCfg.list[nextLevel]
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "������צ��������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --��
    if lualib:LinkBodyItem(player, NpcHellishGhostClawCfg.pos[2]) ~= '0' then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --��
    lualib:AddAndEquipItem(player, NpcHellishGhostClawCfg.pos[2],
        NpcHellishGhostClawCfg.clawNameCfg[lualib:Job(player)] .. '-' .. se.e, 311)
    varTb = NpcHellishGhostClaw.getVarTb(player)
    Message:Msg9(player, "�����ɹ���")
    lualib:DoClientUIMethodEx(player, NpcHellishGhostClaw.Name .. "_notifyWnd", 1, varTb)
    GameEvent.push(EventCfg.onChangeClawLevel, player, varTb.Job,varTb.level, Magic.ClawCount(player))
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcHellishGhostClaw.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcHellishGhostClaw.Name .. "_setNewData", 1, NpcHellishGhostClawCfg)
end

--Npc�������
function NpcHellishGhostClaw.onClickNpc(player, npcID, npcName)
    if not NpcHellishGhostClawCfg.index[npcID] then
        return
    end
    NpcHellishGhostClaw.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcHellishGhostClaw.onClickNpc, NpcHellishGhostClaw)

setFormAllowFunc(NpcHellishGhostClaw.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg(NpcHellishGhostClaw.Name, NpcHellishGhostClaw)



return NpcHellishGhostClaw
