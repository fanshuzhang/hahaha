---@class NpcInstanceTeleport 副本传送
local NpcInstanceTeleportCfg = zsf_RequireNpcCfg("副本传送")
local tgfbjlCfg = zsf_RequireNpcCfg("通关副本奖励")
local NpcInstanceTeleport = {}

function NpcInstanceTeleport.getVarTb(player)
    local varTb = {}
    local jsonStr = lualib:GetVar(player, VarCfg["副本通关记录"])
    local record = {}
    if jsonStr ~= '' then
        record = json2tbl(jsonStr)
    else
        for i = 1, 18 do
            table.insert(record, { 0, 0, 0 }) --普通，困难，地狱
        end
        lualib:SetVar(player, VarCfg["通关副本记录"], tbl2json(record))
    end
    varTb.level = lualib:GetVar(player, VarCfg["副本等级"])
    varTb.record = record
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

function NpcInstanceTeleport.main(player)
    local varTb = NpcInstanceTeleport.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/副本传送", { data = varTb, version = NpcInstanceTeleportCfg.version })
end

--公共
function NpcInstanceTeleport.MoveOkGG(player, Tab, going)
    if not Tab or not going or not tonumber(Tab) or not tonumber(going) then
        return
    end
    local varTb = NpcInstanceTeleport.getVarTb(player)
    Tab, going = tonumber(Tab), tonumber(going)
    --材料是否充足
    local num = NpcInstanceTeleportCfg.list[Tab].cost[1][2]
    if varTb.level < Tab then
        num = num * 3
    end
    if getbindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[1][1]) < num then
        Message:Msg9(player, "您的金币不足！")
        return
    end
    consumebindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[1][1], num, "公共副本传送扣除货币")
    lualib:MapMove(player, NpcInstanceTeleportCfg.list[Tab].mapID[1])
    lualib:DoClientUIMethodEx(player, "副本传送_OnClose")
end

--个人
function NpcInstanceTeleport.MoveOkGR(player, Tab, going)
    if not Tab or not going or not tonumber(Tab) or not tonumber(going) then
        return
    end
    Tab, going = tonumber(Tab), tonumber(going)
    -- local varTb = NpcInstanceTeleport.getVarTb(player)
    -- if going > 1 and varTb.record[Tab][going - 1] ~= 1 then
    --     Message:Msg9(player, "请先通过之前的副本,一步一步来！")
    --     return
    -- end
    --
    if getbindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[2][1]) < NpcInstanceTeleportCfg.list[Tab].cost[2][2] then
        Message:Msg9(player, "您的金币不足！")
        return
    end
    consumebindmoney(player, NpcInstanceTeleportCfg.list[Tab].cost[2][1], NpcInstanceTeleportCfg.list[Tab].cost[2][2],
        "个人副本传送扣除货币")
    --创建镜像地图
    local mapID = lualib:Name(player) .. 'a'
    killmonsters(mapID, '*', 0, false)
    delmirrormap(lualib:Name(player))
    addmirrormap(NpcInstanceTeleportCfg.list[Tab].mapID[2], mapID, NpcInstanceTeleportCfg.list[Tab].name, 1800, '3',
        0, 330, 330)
    lualib:MapMove(player, mapID)
    Message:Msg9(player, "尊贵的勇士：挑战怪物即将刷新，请注意！")
    delaygoto(player, 1500, "click,副本传送_createNpcMon," .. Tab, 0)
    lualib:SetInt(player, "副本难度", going)
    lualib:SetInt(player, "副本层数", Tab)
    lualib:DoClientUIMethodEx(player, "副本传送_OnClose")
    --开启地图参数
    setmapmode(mapID, "NODROPITEMFILENAME", 1, "盟重回城石")
    mapkillmonexprate(player, mapID, going * 100) --杀怪经验
    --设置爆率
end

--刷新怪物和Npc
function NpcInstanceTeleport.createNpcMon(player, Tab)
    if not Tab or not tonumber(Tab) then
        return
    end
    Tab = tonumber(Tab)
    local going = lualib:GetInt(player, "副本难度")
    --刷新怪物
    local attNum = { { 10, 10 }, { 12, 12 }, { 16, 16 }, { 18, 18 }, { 19, 19 }, { 20, 20 } }
    local monTb = {}
    local mapID = lualib:Name(player) .. 'a'
    for _, value in ipairs(NpcInstanceTeleportCfg.mon[Tab]) do
        monTb = genmon(mapID, NpcInstanceTeleportCfg.list[Tab].npcPos[1], NpcInstanceTeleportCfg.list[Tab].npcPos[2],
            value.name, value.range, value.num, 251)
        if going > 1 then
            for __, vvalue in pairs(monTb) do
                for ___, v in ipairs(attNum) do
                    setbaseinfo(vvalue, v[2], getbaseinfo(vvalue, v[1]) * going)
                end
                setbaseinfo(vvalue, 9, getbaseinfo(vvalue, 10))
                setbaseinfo(vvalue, 11, getbaseinfo(vvalue, 12))
            end
        end
    end
    Message:Msg9(player, "尊敬的勇者：清理完怪物后不要着急，我们随后会将您传送回盟重土城")
    --开启定时器
    setofftimer(player, 106)
    setontimer(player, 106, 5, 360)
end

--检测地图中是否还有怪物
function ontimer106(player)
    local mapID = lualib:Name(player) .. 'a'
    local monNum = getmoncount(mapID, -1, true)
    if monNum <= 0 then
        lualib:MapMoveXY(player, '3', 330, 330, 7)
        NpcInstanceTeleport.give(player)
        setofftimer(player, 106)
        return
    end
    if monNum < 5 then
        Message:Msg9(player, "仅存" .. monNum .. "只怪物待清理，加油！")
    end
end

--给奖励
function NpcInstanceTeleport.give(player)
    local Tab, going = lualib:GetInt(player, "副本层数"), lualib:GetInt(player, "副本难度")
    Message:Msg9(player, "恭喜成功通关副本")
    local reward = tgfbjlCfg[Tab]
    local count = 0
    if going == 1 then
        count = math.random(1, 4)
    elseif going == 2 then
        count = math.random(2, 5)
    elseif going == 3 then
        count = math.random(3, 6)
    end
    --抽取奖励
    local results = {}
    for i = 1, count do
        local totalWeight = 0
        for _, value in ipairs(reward) do
            totalWeight = totalWeight + value[2] -- 第二个属性是权重
        end
        local randomValue = math.random() * totalWeight
        local cumulativeWeight = 0
        for _, value in ipairs(reward) do
            cumulativeWeight = cumulativeWeight + value[2]
            if randomValue <= cumulativeWeight then
                table.insert(results, { value[1], 1, id = value.id })
                break
            end
        end
    end
    lualib:AddBatchItem(player, results, "通关副本奖励", 0)
    lualib:ShowRewards(player, results)
    --设置副本通关
    local varTb = NpcInstanceTeleport.getVarTb(player)
    varTb.record[Tab][going] = 1
    lualib:SetVar(player, VarCfg["通关副本记录"], tbl2json(varTb.record))
    if going == 3 then
        if varTb.level < Tab then
            lualib:SetVar(player, VarCfg["副本等级"], Tab)
            Message:Msg9(player,"恭喜勇士成功通关地狱难度副本，已为你开启下一个关卡！")
        end
    end
end

--版本不对，数据重载，重新发送配置表到客户端
function NpcInstanceTeleport.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcInstanceTeleport.Name .. "_setNewData", 1, NpcInstanceTeleportCfg)
end

function NpcInstanceTeleport.onClickNpc(player, NpcID, NpcIName)
    if not NpcInstanceTeleportCfg.index[NpcID] then
        return
    end
    NpcInstanceTeleport.main(player)
end

--进入地图触发
function NpcInstanceTeleport.goEnterMap(player, mapId, mapName)
    if mapId == '3' then
        if checkmirrormap(lualib:Name(player) .. 'a') then
            setofftimer(player, 106)
            killmonsters(lualib:Name(player) .. 'a', '*', 0, false)
            delmirrormap(lualib:Name(player) .. 'a')
            return
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcInstanceTeleport.onClickNpc, NpcInstanceTeleport)
GameEvent.add(EventCfg.goEnterMap, NpcInstanceTeleport.goEnterMap, NpcInstanceTeleport)
setFormAllowFunc("副本传送", { "reloadData", "MoveOkGG", "MoveOkGR" })
Message.RegisterClickMsg("副本传送", NpcInstanceTeleport)
return NpcInstanceTeleport
