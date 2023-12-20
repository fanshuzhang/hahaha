---@class NpcBloodJade 九龙血玉

local NpcBloodJade = {}

NpcBloodJade.Name = "九龙血玉"
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
--获取等级
function NpcBloodJade.main(player)
    local varTb = NpcBloodJade.getVarTb(player)
    if varTb.mapLevel < NpcBloodJadeCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcBloodJade.Name, {data = varTb, version = NpcBloodJadeCfg.version})
end

--升级领取
function NpcBloodJade.MoveOk(player)
    local varTb = NpcBloodJade.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcBloodJadeCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcBloodJadeCfg.list[nextLevel]
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "九龙血玉提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --拿
    if varTb.level ~= 0 then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --给
    lualib:AddAndEquipItem(player, NpcBloodJadeCfg.pos[2], se.e[1])
    varTb=NpcBloodJade.getVarTb(player)
    --Message:Msg9(player, "提升成功！")
    lualib:DoClientUIMethodEx(player, NpcBloodJade.Name.."_notifyWnd", 1, varTb)
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcBloodJade.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcBloodJade.Name .. "_setNewData", 1, NpcBloodJadeCfg)
end

--Npc点击触发
function NpcBloodJade.onClickNpc(player, npcID, npcName)
    if not NpcBloodJadeCfg.index[npcID] then
        return
    end
    NpcBloodJade.main(player)
end
--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcBloodJade.onClickNpc, NpcBloodJade)

setFormAllowFunc(NpcBloodJade.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(NpcBloodJade.Name, NpcBloodJade)

return NpcBloodJade