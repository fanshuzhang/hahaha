---@class NpcBambooHat 幸运斗笠

local NpcBambooHat = {}

NpcBambooHat.Name = "幸运斗笠"
NpcBambooHatCfg = zsf_RequireNpcCfg(NpcBambooHat.Name)

function NpcBambooHat.getVarTb(player)
    local varTb = {}
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end
--获取等级
function NpcBambooHat.main(player)
    local varTb = NpcBambooHat.getVarTb(player)
    if varTb.mapLevel < NpcBambooHatCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcBambooHat.Name, {data = varTb, version = NpcBambooHatCfg.version})
end

--升级领取
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "幸运斗笠提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --给
    lualib:AddAndEquipItem(player, NpcBambooHatCfg.pos[2], se.e[1])
    varTb=NpcBambooHat.getVarTb(player)
    --Message:Msg9(player, "提升成功！")
    lualib:DoClientUIMethodEx(player, NpcBambooHat.Name.."_notifyWnd", 1, varTb)
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcBambooHat.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcBambooHat.Name .. "_setNewData", 1, NpcBambooHatCfg)
end

--Npc点击触发
function NpcBambooHat.onClickNpc(player, npcID, npcName)
    if not NpcBambooHatCfg.index[npcID] then
        return
    end
    NpcBambooHat.main(player)
end
--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcBambooHat.onClickNpc, NpcBambooHat)

setFormAllowFunc(NpcBambooHat.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(NpcBambooHat.Name, NpcBambooHat)

return NpcBambooHat