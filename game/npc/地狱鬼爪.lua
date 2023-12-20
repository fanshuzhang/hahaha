---@class NpcHellishGhostClaw 地狱鬼爪
local NpcHellishGhostClaw = {}

NpcHellishGhostClaw.Name = "地狱鬼爪"
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
    varTb.Job = lualib:GetVar(player, VarCfg["角色职业"])
    return varTb
end

--获取等级
function NpcHellishGhostClaw.main(player)
    local varTb = NpcHellishGhostClaw.getVarTb(player)
    if varTb.mapLevel < NpcHellishGhostClawCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcHellishGhostClaw.Name,
        { data = varTb, version = NpcHellishGhostClawCfg.version })
end

--升级领取
function NpcHellishGhostClaw.MoveOk(player)
    local varTb = NpcHellishGhostClaw.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcHellishGhostClawCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcHellishGhostClawCfg.list[nextLevel]
    if varTb.mapLevel < se.needMapLevel then
        Message:Msg9(player, "当前大陆已升至满级，请前往下一大陆继续提升")
        return
    end
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "您的背包空间不足5格，无法提升！")
        return
    end
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "地狱鬼爪提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --拿
    if lualib:LinkBodyItem(player, NpcHellishGhostClawCfg.pos[2]) ~= '0' then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --给
    lualib:AddAndEquipItem(player, NpcHellishGhostClawCfg.pos[2],
        NpcHellishGhostClawCfg.clawNameCfg[lualib:Job(player)] .. '-' .. se.e, 311)
    varTb = NpcHellishGhostClaw.getVarTb(player)
    Message:Msg9(player, "提升成功！")
    lualib:DoClientUIMethodEx(player, NpcHellishGhostClaw.Name .. "_notifyWnd", 1, varTb)
    GameEvent.push(EventCfg.onChangeClawLevel, player, varTb.Job,varTb.level, Magic.ClawCount(player))
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcHellishGhostClaw.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcHellishGhostClaw.Name .. "_setNewData", 1, NpcHellishGhostClawCfg)
end

--Npc点击触发
function NpcHellishGhostClaw.onClickNpc(player, npcID, npcName)
    if not NpcHellishGhostClawCfg.index[npcID] then
        return
    end
    NpcHellishGhostClaw.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcHellishGhostClaw.onClickNpc, NpcHellishGhostClaw)

setFormAllowFunc(NpcHellishGhostClaw.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg(NpcHellishGhostClaw.Name, NpcHellishGhostClaw)



return NpcHellishGhostClaw
