---@class NpcFengshenTower 封神塔
local NpcFengshenTower = {}
NpcFengshenTowerCfg = zsf_RequireNpcCfg("封神塔")
local basicRes = [[
    <Img|bg=1|img=custom/UI/fst/img_bk.png|loadDelay=1|show=4|reset=1|move=1|esc=1>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=616.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <ItemShow|x=370.0|y=328.0|width=70|height=70|itemid=10273|itemcount=1|showtips=1|bgtype=0>
    <ItemShow|x=456.0|y=328.0|width=70|height=70|itemid=10241|itemcount=1|showtips=1|bgtype=0>
    <ItemShow|x=545.0|y=328.0|width=70|height=70|itemid=10247|itemcount=1|showtips=1|bgtype=0>
    <ItemShow|x=370.0|y=384.0|width=70|height=70|itemid=10253|itemcount=1|showtips=1|bgtype=0>
    <ItemShow|x=457.0|y=385.0|width=70|height=70|itemid=10259|itemcount=1|showtips=1|bgtype=0>
    <ItemShow|x=545.0|y=384.0|width=70|height=70|itemid=10265|itemcount=1|showtips=1|bgtype=0>
    <RText|x=329.0|y=211.0|size=14|color=255|outline=2|outlinecolor=0|text=<[玩法说明]：/FCOLOR=251><清理完每层的怪物就可进入下一层/FCOLOR=253>>
    <RText|x=387.0|y=232.0|size=14|color=255|outline=2|outlinecolor=0|text=<第十层奖励：/FCOLOR=254><各种转生材料/FCOLOR=254>>
    <RText|x=379.0|y=254.0|size=14|color=252|outline=2|outlinecolor=0|text=<第二十层奖励：时装碎片1~4块/FCOLOR=252>>
    <RText|x=380.0|y=274.0|size=14|color=252|outline=2|outlinecolor=0|text=<第三十层奖励：时装碎片3~8块/FCOLOR=70>>
    <RText|x=48.0|y=181.0|size=18|color=251|outline=2|outlinecolor=0|text=<[封神塔共30层，每10层为一阶段]/FCOLOR=251>>
    <RText|x=55.0|y=215.0|width=260|size=16|color=255|outline=2|outlinecolor=0|text=<1-10层开服即可挑战、11-20层激活二大陆即可挑战、21-20层激活三大陆即可挑战/FCOLOR=250>>
    <RText|x=64.0|y=298.0|size=16|color=255|outline=2|outlinecolor=0|text=<时装碎片主要来源于挑战封神塔/FCOLOR=249>>
    <RText|x=46.0|y=378.0|size=18|color=255|outline=2|outlinecolor=0|text=<[进入收费]：/FCOLOR=250>100W金币加\<每日挑战次数*100W金币/FCOLOR=255>>
]]
function NpcFengshenTower.getVarTb(player)
    local varTb = {}
    local sortTb = { { name = "", num = 0 }, { name = "", num = 0 }, { name = "", num = 0 }, }
    local ranking = sorthumvar("封神塔层数", 0, 1, 3)
    local index = 0
    for i = 1, #ranking, 2 do
        index = index + 1
        if ranking[i] and ranking[i + 1] then
            sortTb[index].name = ranking[i]
            sortTb[index].num = ranking[i + 1]
        end
    end
    varTb.sortTb = sortTb
    varTb.dareNum = lualib:GetVar(player, VarCfg["封神塔挑战次数"])
    return varTb
end

function NpcFengshenTower.main(player)
    local varTb = NpcFengshenTower.getVarTb(player)
    local rank = { {}, {}, {} }
    for i = 1, 3, 1 do
        if varTb.sortTb[i].name ~= "" and varTb.sortTb[i].num ~= 0 then
            rank[i][1] = varTb.sortTb[i].name
            rank[i][2] = varTb.sortTb[i].num
        else
            rank[i][1] = "#无#"
            rank[i][2] = 0
        end
    end
    local str = ""
    str = str .. basicRes
    str = str .. "<Text|x=60.0|y=113.0|size=28|color=250|outline=2|outlinecolor=0|text=" .. varTb.dareNum .. ">"
    str = str ..
        "<RText|x=417.0|y=103.0|size=18|color=249|outline=2|outlinecolor=0|text=<" ..
        rank[1][1] .. "/FCOLOR=249><      #第" .. ConstCfg.CHINA_NUM[rank[1][2]] .. "层/FCOLOR=255>>"
    str = str ..
        "<RText|x=416.0|y=136.0|size=18|color=251|outline=2|outlinecolor=0|text=<" ..
        rank[2][1] .. "/FCOLOR=249><      #第" .. ConstCfg.CHINA_NUM[rank[2][2]] .. "层/FCOLOR=255>>"
    str = str ..
        "<RText|x=418.0|y=170.0|size=18|color=250|outline=2|outlinecolor=0|text=<" ..
        rank[3][1] .. "/FCOLOR=249><      #第" .. ConstCfg.CHINA_NUM[rank[3][2]] .. "层/FCOLOR=255>>"
    str = str ..
        "<Button|x=269.0|y=360.0|height=85|color=70|size=16|nimg=custom/UI/fst/btn1.png|link=@click,封神塔_MoveOk>"
    say(player, str)
end

--进入
function NpcFengshenTower.MoveOk(player)
    local varTb = NpcFengshenTower.getVarTb(player)
    if lualib:Level(player) < 35 then
        Message:Msg9(player, "阁下的实力还有待提升！请先升至35级")
        return
    end
    --货币是否充足
    local costNum = 1000000 + 1000000 * varTb.dareNum
    if getbindmoney(player, "金币") < costNum then
        Message:Msg9(player, "尊敬的勇士：您身上的金币不足" .. costNum)
        return
    end
    consumebindmoney(player, "金币", costNum, "进入封神塔扣金币")

    --添加镜像地图
    addmirrormap("t118", lualib:Name(player), "封神塔一层", NpcFengshenTowerCfg.list.list[1].time * 60, "3", 0, 330, 330)
    --添加临时NPC
    delaygoto(player, 2000, "click,封神塔_createNpc,0", 0)
    for i = 1, #NpcFengshenTowerCfg.list.list[1].mon, 1 do
        genmonex(lualib:Name(player), 13, 16, NpcFengshenTowerCfg.list.list[1].mon[i][1], 5,
            NpcFengshenTowerCfg.list.list[1].mon[i][2], player, 161, "封神塔守护兽", 0)
    end
    lualib:MapMove(player, lualib:Name(player))
    lualib:SetVar(player, VarCfg["封神塔挑战次数"], lualib:GetVar(player, VarCfg["封神塔挑战次数"]) + 1)
end

function NpcFengshenTower.updataMain(player, index)
    if not index then
        return
    end
    local mainStr = [[
    <Img|x=0.0|y=0.0|move=0|show=4|img=custom/UI/public/img_bk2.png|reset=1|bg=1|loadDelay=1|esc=1>
    <Layout|x=490.0|y=2.0|width=80|height=80|link=@exit>
    <Button|x=518.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=232.0|y=65.0|size=18|color=255|text=<封神塔守卫/FCOLOR=255>>
    <RText|x=93.0|y=148.0|size=18|color=255|text=<[玩法说明]:/FCOLOR=250><清理完这层的怪物就可进入下一层/FCOLOR=254>>
    <Text|x=151.0|y=174.0|color=251|size=18|text=《第10层，20层，30层有奖励》>
    <Text|x=174.0|y=201.0|color=255|size=18|text=时装碎片主要来自于封神塔>
]]
    local str = '' .. mainStr
    str = str ..
        "<RText|x=159.0|y=105.0|size=18|color=70|text=恭喜勇士来到封神塔第<[" .. ConstCfg.CHINA_NUM[index] .. "]/FCOLOR=251>层>"
    str = str ..
        "<Button|x=228.0|y=288.0|nimg=custom/UI/public/btn2.png|size=18|color=255|text=挑战下层|link=@click,封神塔_updataDate,挑战," ..
        index .. ">"
    if index == 10 or index == 20 or index == 30 then
        str = str ..
            "<Button|x=227.0|y=244.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=领取奖励|link=@click,封神塔_updataDate,领取," ..
            index .. ">"
    end
    say(player, str)
end

--挑战或者领取
function NpcFengshenTower.updataDate(player, choose, index)
    if not index or not tonumber(index) then
        return
    end
    index = tonumber(index)
    local varTb = NpcMapMove.getVarTb(player)
    --判断怪物有没有清理完
    if getmoncount(lualib:Name(player), -1, true) > 0 then
        Message:Msg9(player, "注意查看规则，请先清理地图中所有怪物！")
        return
    end
    --设置挑战层数
    if index > lualib:GetPlayerInt(player, "封神塔层数") then
        lualib:SetPlayerInt(player, "封神塔层数", index)
    end
    if choose == "挑战" then
        if lualib:GetFlagStatus(player, PlayerVarCfg["是否领取封神塔奖励"]) == 1 and index % 10 == 0 then
            Message:Msg9(player, "请先领取奖励！")
            return
        end
        --判断是否激活
        if index == 10 and varTb.jsonTb["二大陆"] == 0 then
            Message:Msg9(player, "二大陆还未激活！无法进入下一层")
            return
        end
        if index == 20 and varTb.jsonTb["三大陆"] == 0 then
            Message:Msg9(player, "三大陆还未激活，无法进入下一层")
            return
        end
        if index == 30 and varTb.jsonTb["四大陆"] == 0 then
            Message:Msg9(player, "四大陆还未激活，无法进入下一层")
            return
        end
        --
        killmonsters(lualib:Name(player), '*', 0, false)
        delmirrormap(lualib:Name(player))
        delnpc("封神塔守卫", lualib:Name(player))
        addmirrormap("t118", lualib:Name(player), "封神塔" .. ConstCfg.CHINA_NUM[index + 1] .. "层", NpcFengshenTowerCfg.list.list[1].time * 60, "3", 0, 330, 330)
        for i = 1, #NpcFengshenTowerCfg.list.list[index + 1].mon, 1 do
            genmonex(lualib:Name(player), 13, 16, NpcFengshenTowerCfg.list.list[index + 1].mon[i][1], 5,
                NpcFengshenTowerCfg.list.list[index + 1].mon[i][2], player, 161, "封神塔守护兽", 0)
        end
        lualib:MapMove(player, lualib:Name(player))
        lualib:SetFlagStatus(player, PlayerVarCfg["是否领取封神塔奖励"], 1)
        delaygoto(player, 2000, "click,封神塔_createNpc," .. index, 0)
    end
    if choose == "领取" then
        if lualib:GetFlagStatus(player, PlayerVarCfg["是否领取封神塔奖励"]) == 0 then
            Message:Msg9(player, "勇士 你已领取过奖励！勿重复领取")
            return
        end
        if index == 10 then
            local zsLevel = getbaseinfo(player, 39)
            if zsLevel >= 12 then
                zsLevel = 11
            end
            local num = math.random(1, 3)
            for i = 1, num do
                local hh = math.random(105)
                if hh <= 50 then
                    giveitem(player, NpcreincarnationCfg.list[zsLevel + 1].cost[1][1], 1)
                elseif hh > 50 and hh < 100 then
                    giveitem(player, NpcreincarnationCfg.list[zsLevel + 1].cost[2][1], 1)
                elseif hh >= 100 then
                    giveitem(player, NpcreincarnationCfg.list[zsLevel + 1].cost[3][1], 1)
                end
            end
        elseif index == 20 then
            giveitem(player, "时装碎片", math.random(1, 4))
        elseif index == 30 then
            giveitem(player, "时装碎片", math.random(3, 8))
        end
        lualib:SetFlagStatus(player, PlayerVarCfg["是否领取封神塔奖励"], 0)
        Message:Msg9(player, "领取奖励成功！")
    end
end

--延时
function NpcFengshenTower.createNpc(player, index)
    if not index or not tonumber(index) then
        return
    end
    index = tonumber(index)
    --添加临时NPC
    local npcIdx = index + 1001
    local num = 0
    while true do
        if isnotnull(getnpcbyindex(npcIdx)) then
            npcIdx = npcIdx + 100
        else
            break
        end
        num = num + 1
        if num > 1000 then
            break
        end
    end
    local npcInfo = {
        ["Idx"] = npcIdx,
        ["npcname"] = "封神塔守卫",
        ["appr"] = 26,
        ["script"] = '封神塔NPC'
    }
    createnpc(lualib:Name(player), 17, 13, tbl2json(npcInfo))
    -- table.insert(NpcFengshenTowerCfg.miniNpc, npcIdx, 1)
end

function NpcFengshenTower.onClickNpc(player, npcID, npcName)
    if NpcFengshenTowerCfg.index[npcID] then
        NpcFengshenTower.main(player)
        return
    end
    --点击NPC领取奖励
    if npcID >= 1000 and npcID <= 10000 then
        local index = npcID % 100
        NpcFengshenTower.updataMain(player, index)
        return
    end
end

--镜像地图销毁时删除NPC
function mirrormapend(sysobj, mapId)
    delnpc("封神塔守卫", mapId)
end

--进入地图触发
function NpcFengshenTower.goEnterMap(player, mapId, mapName)
    if mapId == '3' then
        if checkmirrormap(lualib:Name(player)) then
            killmonsters(lualib:Name(player), '*', 0, false)
            delmirrormap(lualib:Name(player))
            delnpc("封神塔守卫", lualib:Name(player))
            return
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcFengshenTower.onClickNpc, NpcFengshenTower)
GameEvent.add(EventCfg.goEnterMap, NpcFengshenTower.goEnterMap, NpcFengshenTower)
Message.RegisterClickMsg("封神塔", NpcFengshenTower)
return NpcFengshenTower
