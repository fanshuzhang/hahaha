---@class NpcMapMove 地图传送

local NpcMapMove = {}

NpcMapMove.Name = "地图传送"
NpcMapMoveCfg = zsf_RequireNpcCfg(NpcMapMove.Name)

function NpcMapMove.getVarTb(player)
    local varTb = {}
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    local jsonStr = lualib:GetVar(player, VarCfg["地图激活"])
    local jsonTb = {}
    if jsonStr and jsonStr == "" then
        jsonTb = {
            ["二大陆"] = 0,
            ["雷炎殿"] = 0,
            ["火龙神殿"] = 0,
            ["冰封王座"] = 0,
            ["狐月山谷"] = 0,
            ["神龙要塞"] = 0,
            ["三大陆"] = 0,
            ["神龙帝国"] = 0,
            ["诺玛宫殿"] = 0,
            ["半兽陵墓"] = 0,
            ["瘟疫沼泽"] = 0,
            ["亡灵葬墓"] = 0,
            ["泽国福地"] = 0,
            ["四大陆"] = 0,
        }
        lualib:SetVar(player, VarCfg['地图激活'], tbl2json(jsonTb))
        jsonStr = tbl2json(jsonTb)
    end
    jsonTb = json2tbl(jsonStr)
    varTb.jsonTb = jsonTb
    return varTb
end

--获取等级
function NpcMapMove.main(player)
    --审核
    local varTb = NpcMapMove.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/" .. NpcMapMove.Name, { data = varTb, version = NpcMapMoveCfg.version })
end

--升级领取
function NpcMapMove.MoveOk(player, mapIndex)
    if not mapIndex then
        return
    end
    mapIndex = tonumber(mapIndex)
    local varTb = NpcMapMove.getVarTb(player)
    if not NpcMapMoveCfg.list[varTb.mapLevel].childrenMap[mapIndex] then
        release_print("参数error！")
        return
    end
    local se = NpcMapMoveCfg.list[varTb.mapLevel].childrenMap
    --是否可进入--魔龙谷特殊判断
    local cost = se[mapIndex].cost
    if se[mapIndex][1] == "魔龙谷" then
        if varTb.jsonTb["二大陆"] == 0 then
            cost = se[mapIndex].cost2
        end
    end
    --是否激活
    if se[mapIndex].need then
        if varTb.jsonTb[se[mapIndex][1]] == 0 then
            if se[mapIndex].need.type == 1 then
                if getbagitemcount(player, se[mapIndex].need[1]) < se[mapIndex].need[2] then
                    Message:Msg9(player, string.format("当前地图需要激活，你的%s不足", se[mapIndex].need[1]))
                    return
                end
                if takeitem(player, se[mapIndex].need[1], se[mapIndex].need[2]) then
                    varTb.jsonTb[se[mapIndex][1]] = 1
                    lualib:SetVar(player, VarCfg['地图激活'], tbl2json(varTb.jsonTb))
                    Message:Msg9(player, "地图已激活！")
                end
            end
            if se[mapIndex].need.type == 2 then
                if lualib:GetVar(player, VarCfg["探索者称号"]) < se[mapIndex].need[2] then
                    Message:Msg9(player, string.format("当前地图需要激活，需要达到[%s]", se[mapIndex].need[1]))
                    return
                else
                    varTb.jsonTb[se[mapIndex][1]] = 1
                    lualib:SetVar(player, VarCfg['地图激活'], tbl2json(varTb.jsonTb))
                end
            end
        end
    end
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, cost, "传送地图消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    -- lualib:MapMove(player, se[mapIndex][2])
    lualib:MapMoveXY(player, se[mapIndex][2], se[mapIndex].move[1], se[mapIndex].move[2], 3)

    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_OnClose")
end

--激活进入
function NpcMapMove.Active(player, txtIndex)
    if not txtIndex or not txtIndex then
        return
    end
    local varTb = NpcMapMove.getVarTb(player)
    local maplevel = varTb.mapLevel + 1
    if txtIndex == "激活" then
        Message:Msg9(player, "激活成功！")
        varTb.jsonTb["二大陆"] = 1
        varTb.jsonTb["三大陆"] = 1
        lualib:SetVar(player, VarCfg['地图激活'], tbl2json(varTb.jsonTb))
    end
    if txtIndex == "进入" then
        if maplevel >= 3 then
            maplevel = 3
        end
        --是否激活
        lualib:MapMoveXY(player, NpcMapMoveCfg.list[maplevel].index, NpcMapMoveCfg.list[maplevel].range[1],
            NpcMapMoveCfg.list[maplevel].range[2], NpcMapMoveCfg.list[maplevel].range[3])
    end
    -- varTb = NpcMapMove.getVarTb(player)
    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_OnClose")
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcMapMove.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_setNewData", 1, NpcMapMoveCfg)
end

--Npc点击触发
function NpcMapMove.onClickNpc(player, npcID, npcName)
    if not NpcMapMoveCfg.index[npcID] then
        return
    end
    NpcMapMove.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcMapMove.onClickNpc, NpcMapMove)

setFormAllowFunc(NpcMapMove.Name, { "main", "reloadData", "MoveOk", "Active" })
Message.RegisterClickMsg(NpcMapMove.Name, NpcMapMove)

return NpcMapMove
