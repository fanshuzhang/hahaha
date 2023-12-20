---@class NpcExplorerTitle 称号系统

local NpcExplorerTitle = {}

NpcExplorerTitle.Name = "称号系统"
NpcExplorerTitleCfg = zsf_RequireNpcCfg(NpcExplorerTitle.Name)

function NpcExplorerTitle.getVarTb(player)
    local varTb = {}
    local level = lualib:GetVar(player, VarCfg["探索者称号"])
    if level then
        varTb.level = level
    else
        varTb.level = 0
    end
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    --点亮称号处理
    local jsonStr = lualib:GetVar(player, VarCfg['探索者称号点亮装备'])
    local jsonTb = {}
    if jsonStr and jsonStr == '' then
        for i = 1, #NpcExplorerTitleCfg.list do
            table.insert(jsonTb, {})
            for j = 1, #NpcExplorerTitleCfg.list[i].equip do
                if NpcExplorerTitleCfg.list[i].equip[j] then
                    table.insert(jsonTb[i], 0)
                end
            end
        end
        lualib:SetVar(player, VarCfg['探索者称号点亮装备'], tbl2json(jsonTb))
        jsonStr=tbl2json(jsonTb)
    end
    jsonTb = json2tbl(jsonStr)
    varTb.jsonTb = jsonTb
    return varTb
end

--获取等级
function NpcExplorerTitle.main(player)
    local varTb = NpcExplorerTitle.getVarTb(player)
    if varTb.mapLevel < NpcExplorerTitleCfg.list[1].needMapLevel then
        Message:Box(player, "当前大陆尚未解锁该功能")
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcExplorerTitle.Name,
        { data = varTb, version = NpcExplorerTitleCfg.version })
end

--点亮
function NpcExplorerTitle.LightUp(player, TitleIndex, equipIndex)
    if not TitleIndex or not equipIndex or not NpcExplorerTitleCfg.list[TitleIndex] or not NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex] then
        return
    end
    TitleIndex, equipIndex = tonumber(TitleIndex), tonumber(equipIndex)
    --数据处理
    local varTb = NpcExplorerTitle.getVarTb(player)
    if not varTb.jsonTb[TitleIndex][equipIndex] then
        release_print("NpcExplorerTitle数据错误")
        return
    end
    if varTb.jsonTb[TitleIndex][equipIndex] ~= 0 then
        Message:Msg9(player, "已经点亮过该装备！")
        return
    end
    if getbagitemcount(player, NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex][1]) < 1 then
        Message:Msg9(player, "背包中该物品数量不足！")
        return
    end
    --数据更新
    if takeitem(player, NpcExplorerTitleCfg.list[TitleIndex].equip[equipIndex][1], 1) then
        varTb.jsonTb[TitleIndex][equipIndex] = 1
    end
    lualib:SetVar(player, VarCfg['探索者称号点亮装备'], tbl2json(varTb.jsonTb))
    Message:Msg9(player, "恭喜成功点亮")
    varTb = NpcExplorerTitle.getVarTb(player)
    lualib:DoClientUIMethodEx(player, NpcExplorerTitle.Name .. "_notifyWnd", 1, varTb, TitleIndex)
end

--升级领取
function NpcExplorerTitle.MoveOk(player, TitleIndex)
    if not TitleIndex or not NpcExplorerTitleCfg.list[TitleIndex] then
        return
    end
    local varTb = NpcExplorerTitle.getVarTb(player)
    if varTb.level < TitleIndex - 1 then
        Message:Msg9(player, "请按顺序领取！")
        return
    end
    if varTb.level == TitleIndex then
        Message:Msg9(player, "请勿重复领取")
        return
    end
    local isLight = false
    for i = 1, #NpcExplorerTitleCfg.list[TitleIndex].equip do
        if varTb.jsonTb[TitleIndex][i] == 0 then
            isLight = false
            break
        else
            isLight = true
        end
    end
    if not isLight then
        Message:Msg9(player, "装备还未全部点亮，无法领取")
        return
    end
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, NpcExplorerTitleCfg.list[TitleIndex].cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, NpcExplorerTitleCfg.list[TitleIndex].cost, "探索者称号提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --领取，给称号
    if varTb.level == 0 then
        lualib:AddTitleEx(player, NpcExplorerTitleCfg.list[TitleIndex].e[1])
    else
        lualib:DelTitle(player, NpcExplorerTitleCfg.list[TitleIndex - 1].e[1])
        lualib:AddTitleEx(player, NpcExplorerTitleCfg.list[TitleIndex].e[1])
    end
    lualib:SetVar(player, VarCfg['探索者称号'], lualib:GetVar(player, VarCfg["探索者称号"]) + 1)
    Message:Msg9(player, "领取成功！")
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcExplorerTitle.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcExplorerTitle.Name .. "_setNewData", 1, NpcExplorerTitleCfg)
end

--Npc点击触发
function NpcExplorerTitle.onClickNpc(player, npcID, npcName)
    if not NpcExplorerTitleCfg.index[npcID] then
        return
    end
    NpcExplorerTitle.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcExplorerTitle.onClickNpc, NpcExplorerTitle)

setFormAllowFunc(NpcExplorerTitle.Name, { "main", "reloadData", "MoveOk", "LightUp" })
Message.RegisterClickMsg(NpcExplorerTitle.Name, NpcExplorerTitle)

return NpcExplorerTitle
