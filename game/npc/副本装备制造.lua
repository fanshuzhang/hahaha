---@class NpcCopyEquipProduct 副本装备制造
local NpcCopyEquipProductCfg = zsf_RequireNpcCfg("副本装备制造")
local NpcCopyEquipProduct = {}
NpcCopyEquipProduct.Name = "副本装备制造"

function NpcCopyEquipProduct.getVarTb(player)
    local varTb = {}
    varTb.level = lualib:Level(player)
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

function NpcCopyEquipProduct.main(player)
    local varTb = NpcCopyEquipProduct.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/" .. NpcCopyEquipProduct.Name,
        { data = varTb, version = NpcCopyEquipProductCfg.version })
end

--选择
function NpcCopyEquipProduct.Choose(player, choose, tab, index)
    if not choose then
        return
    end
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    if choose == "分解" then
        Message:Box(player, "尊敬的玩家：该装备较为珍贵，请确认是否分解", "@click,副本装备制造_MoveOkFJ," .. tab .. ',' .. index, "@exit")
    elseif choose == "合成" then
        Message:Box(player, "尊敬的玩家：您已经做好选择合成该装备是吗？", "@click,副本装备制造_MoveOk," .. tab .. ',' .. index, "@exit")
    end
    return
end

function NpcCopyEquipProduct.MoveOk(player, tab, index) --合成
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    tab, index = tonumber(tab), tonumber(index)
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "您的背包空间不足5格，无法制造！")
        return
    end
    local se = NpcCopyEquipProductCfg.list[tab][index]
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "副本装备制造消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --给装备
    lualib:AddItem(player, se.e[1], 1, 0, "副本装备制造")
    --
    Message:Msg9(player, "制造成功！")
end

--

function NpcCopyEquipProduct.MoveOkFJ(player, tab, index) --分解
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    tab, index = tonumber(tab), tonumber(index)
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "您的背包空间不足5格，无法制造！")
        return
    end
    local se = NpcCopyEquipProductCfg.list[tab][index]
    --检测装备
    if getbagitemcount(player, se.e[1], 0) < 1 then
        Message:Msg9(player, "您的背包中没有[" .. se.e[1] .. "]")
        return
    end
    --拿
    lualib:DelItem(player, se.e[1], 1, 0, "副本装备熔炼")
    --给
    lualib:AddBatchItem(player, se.dismantle, "副本装备熔炼")
    --
    Message:Msg9(player, "熔炼成功！获得大量材料")
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcCopyEquipProduct.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcCopyEquipProduct.Name .. "_setNewData", 1, NpcCopyEquipProductCfg)
end

function NpcCopyEquipProduct.onClickNpc(player, NpcID, NpcIName)
    if not NpcCopyEquipProductCfg.index[NpcID] then
        return
    end
    NpcCopyEquipProduct.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcCopyEquipProduct.onClickNpc, NpcCopyEquipProduct)
setFormAllowFunc(NpcCopyEquipProduct.Name, { "reloadData", "Choose" })
Message.RegisterClickMsg("副本装备制造", NpcCopyEquipProduct)
return NpcCopyEquipProduct
