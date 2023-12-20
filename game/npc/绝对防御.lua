---@class Npcdefense 绝对防御

local Npcdefense = {}

Npcdefense.Name = "绝对防御"
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
--获取等级
function Npcdefense.main(player)
    local varTb = Npcdefense.getVarTb(player)
    if varTb.mapLevel < NpcdefenseCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. Npcdefense.Name, {data = varTb, version = NpcdefenseCfg.version})
end

--升级领取
function Npcdefense.MoveOk(player)
    local varTb = Npcdefense.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcdefenseCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcdefenseCfg.list[nextLevel]
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
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "绝对防御提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end

    --拿
    if varTb.level ~= 0 then
        lualib:FTakeItemEX(player, varTb.equip)
    end

    --给
    lualib:AddAndEquipItem(player, NpcdefenseCfg.pos[2], se.e[1])
    varTb=Npcdefense.getVarTb(player)
    --Message:Msg9(player, "提升成功！")
    lualib:DoClientUIMethodEx(player, Npcdefense.Name.."_notifyWnd", 1, varTb)
end

--版本不对，数据重载，重新发送配置表到客户端
function Npcdefense.reloadData(player)
    lualib:DoClientUIMethodEx(player, Npcdefense.Name .. "_setNewData", 1, NpcdefenseCfg)
end

--Npc点击触发
function Npcdefense.onClickNpc(player, npcID, npcName)
    if not NpcdefenseCfg.index[npcID] then
        return
    end
    Npcdefense.main(player)
end
--游戏事件
GameEvent.add(EventCfg.onClickNpc, Npcdefense.onClickNpc, Npcdefense)

setFormAllowFunc(Npcdefense.Name, {"main", "reloadData", "MoveOk"})
Message.RegisterClickMsg(Npcdefense.Name, Npcdefense)

return Npcdefense