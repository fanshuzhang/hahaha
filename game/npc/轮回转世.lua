---@class Npcreincarnation 轮回转世

local Npcreincarnation = {}

Npcreincarnation.Name = "轮回转世"
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
    varTb.Opening = lualib:GetVar(player, VarCfg["生肖装备开孔数量"])
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

--获取等级
function Npcreincarnation.main(player)
    local varTb = Npcreincarnation.getVarTb(player)
    if varTb.mapLevel < NpcreincarnationCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. Npcreincarnation.Name,
        { data = varTb, version = NpcreincarnationCfg.version })
end

--升级领取
function Npcreincarnation.MoveOk(player)
    local varTb = Npcreincarnation.getVarTb(player)
    local nextLevel = varTb.level + 1
    if nextLevel > #NpcreincarnationCfg.list then
        Message:Msg_zsfEX(player, ResponseCfg.get(ResponseCfg.full_level))
        return
    end
    local se = NpcreincarnationCfg.list[nextLevel]
    if varTb.mapLevel < se.needMapLevel then
        Message:Msg9(player, "当前大陆已升至满级，请前往下一大陆继续提升")
        return
    end
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "轮回转世提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --给提升
    lualib:SetReLevelEX(player, nextLevel)

    --给称号
    if varTb.level > 0 then
        lualib:DelTitle(player, NpcreincarnationCfg.list[varTb.level].e[1])
    end
    lualib:AddTitle(player, NpcreincarnationCfg.list[nextLevel].e[1])

    --开孔
    lualib:SetVar(player, VarCfg["生肖装备开孔数量"], (lualib:GetVar(player, VarCfg["生肖装备开孔数量"]) + 1))
    varTb = Npcreincarnation.getVarTb(player)
    lualib:DoClientUIMethodEx(player, Npcreincarnation.Name .. "_notifyWnd", 1, varTb)
end

--版本不对，数据重载，重新发送配置表到客户端
function Npcreincarnation.reloadData(player)
    lualib:DoClientUIMethodEx(player, Npcreincarnation.Name .. "_setNewData", 1, NpcreincarnationCfg)
end

--Npc点击触发
function Npcreincarnation.onClickNpc(player, npcID, npcName)
    if not NpcreincarnationCfg.index[npcID] then
        return
    end
    Npcreincarnation.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, Npcreincarnation.onClickNpc, Npcreincarnation)

setFormAllowFunc(Npcreincarnation.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg(Npcreincarnation.Name, Npcreincarnation)

return Npcreincarnation
