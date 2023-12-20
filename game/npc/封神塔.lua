---@class NpcFengshenTower ������
local NpcFengshenTower = {}
NpcFengshenTowerCfg = zsf_RequireNpcCfg("������")
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
    <RText|x=329.0|y=211.0|size=14|color=255|outline=2|outlinecolor=0|text=<[�淨˵��]��/FCOLOR=251><������ÿ��Ĺ���Ϳɽ�����һ��/FCOLOR=253>>
    <RText|x=387.0|y=232.0|size=14|color=255|outline=2|outlinecolor=0|text=<��ʮ�㽱����/FCOLOR=254><����ת������/FCOLOR=254>>
    <RText|x=379.0|y=254.0|size=14|color=252|outline=2|outlinecolor=0|text=<�ڶ�ʮ�㽱����ʱװ��Ƭ1~4��/FCOLOR=252>>
    <RText|x=380.0|y=274.0|size=14|color=252|outline=2|outlinecolor=0|text=<����ʮ�㽱����ʱװ��Ƭ3~8��/FCOLOR=70>>
    <RText|x=48.0|y=181.0|size=18|color=251|outline=2|outlinecolor=0|text=<[��������30�㣬ÿ10��Ϊһ�׶�]/FCOLOR=251>>
    <RText|x=55.0|y=215.0|width=260|size=16|color=255|outline=2|outlinecolor=0|text=<1-10�㿪��������ս��11-20�㼤�����½������ս��21-20�㼤������½������ս/FCOLOR=250>>
    <RText|x=64.0|y=298.0|size=16|color=255|outline=2|outlinecolor=0|text=<ʱװ��Ƭ��Ҫ��Դ����ս������/FCOLOR=249>>
    <RText|x=46.0|y=378.0|size=18|color=255|outline=2|outlinecolor=0|text=<[�����շ�]��/FCOLOR=250>100W��Ҽ�\<ÿ����ս����*100W���/FCOLOR=255>>
]]
function NpcFengshenTower.getVarTb(player)
    local varTb = {}
    local sortTb = { { name = "", num = 0 }, { name = "", num = 0 }, { name = "", num = 0 }, }
    local ranking = sorthumvar("����������", 0, 1, 3)
    local index = 0
    for i = 1, #ranking, 2 do
        index = index + 1
        if ranking[i] and ranking[i + 1] then
            sortTb[index].name = ranking[i]
            sortTb[index].num = ranking[i + 1]
        end
    end
    varTb.sortTb = sortTb
    varTb.dareNum = lualib:GetVar(player, VarCfg["��������ս����"])
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
            rank[i][1] = "#��#"
            rank[i][2] = 0
        end
    end
    local str = ""
    str = str .. basicRes
    str = str .. "<Text|x=60.0|y=113.0|size=28|color=250|outline=2|outlinecolor=0|text=" .. varTb.dareNum .. ">"
    str = str ..
        "<RText|x=417.0|y=103.0|size=18|color=249|outline=2|outlinecolor=0|text=<" ..
        rank[1][1] .. "/FCOLOR=249><      #��" .. ConstCfg.CHINA_NUM[rank[1][2]] .. "��/FCOLOR=255>>"
    str = str ..
        "<RText|x=416.0|y=136.0|size=18|color=251|outline=2|outlinecolor=0|text=<" ..
        rank[2][1] .. "/FCOLOR=249><      #��" .. ConstCfg.CHINA_NUM[rank[2][2]] .. "��/FCOLOR=255>>"
    str = str ..
        "<RText|x=418.0|y=170.0|size=18|color=250|outline=2|outlinecolor=0|text=<" ..
        rank[3][1] .. "/FCOLOR=249><      #��" .. ConstCfg.CHINA_NUM[rank[3][2]] .. "��/FCOLOR=255>>"
    str = str ..
        "<Button|x=269.0|y=360.0|height=85|color=70|size=16|nimg=custom/UI/fst/btn1.png|link=@click,������_MoveOk>"
    say(player, str)
end

--����
function NpcFengshenTower.MoveOk(player)
    local varTb = NpcFengshenTower.getVarTb(player)
    if lualib:Level(player) < 35 then
        Message:Msg9(player, "���µ�ʵ�����д���������������35��")
        return
    end
    --�����Ƿ����
    local costNum = 1000000 + 1000000 * varTb.dareNum
    if getbindmoney(player, "���") < costNum then
        Message:Msg9(player, "�𾴵���ʿ�������ϵĽ�Ҳ���" .. costNum)
        return
    end
    consumebindmoney(player, "���", costNum, "����������۽��")

    --��Ӿ����ͼ
    addmirrormap("t118", lualib:Name(player), "������һ��", NpcFengshenTowerCfg.list.list[1].time * 60, "3", 0, 330, 330)
    --�����ʱNPC
    delaygoto(player, 2000, "click,������_createNpc,0", 0)
    for i = 1, #NpcFengshenTowerCfg.list.list[1].mon, 1 do
        genmonex(lualib:Name(player), 13, 16, NpcFengshenTowerCfg.list.list[1].mon[i][1], 5,
            NpcFengshenTowerCfg.list.list[1].mon[i][2], player, 161, "�������ػ���", 0)
    end
    lualib:MapMove(player, lualib:Name(player))
    lualib:SetVar(player, VarCfg["��������ս����"], lualib:GetVar(player, VarCfg["��������ս����"]) + 1)
end

function NpcFengshenTower.updataMain(player, index)
    if not index then
        return
    end
    local mainStr = [[
    <Img|x=0.0|y=0.0|move=0|show=4|img=custom/UI/public/img_bk2.png|reset=1|bg=1|loadDelay=1|esc=1>
    <Layout|x=490.0|y=2.0|width=80|height=80|link=@exit>
    <Button|x=518.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=232.0|y=65.0|size=18|color=255|text=<����������/FCOLOR=255>>
    <RText|x=93.0|y=148.0|size=18|color=255|text=<[�淨˵��]:/FCOLOR=250><���������Ĺ���Ϳɽ�����һ��/FCOLOR=254>>
    <Text|x=151.0|y=174.0|color=251|size=18|text=����10�㣬20�㣬30���н�����>
    <Text|x=174.0|y=201.0|color=255|size=18|text=ʱװ��Ƭ��Ҫ�����ڷ�����>
]]
    local str = '' .. mainStr
    str = str ..
        "<RText|x=159.0|y=105.0|size=18|color=70|text=��ϲ��ʿ������������<[" .. ConstCfg.CHINA_NUM[index] .. "]/FCOLOR=251>��>"
    str = str ..
        "<Button|x=228.0|y=288.0|nimg=custom/UI/public/btn2.png|size=18|color=255|text=��ս�²�|link=@click,������_updataDate,��ս," ..
        index .. ">"
    if index == 10 or index == 20 or index == 30 then
        str = str ..
            "<Button|x=227.0|y=244.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=��ȡ����|link=@click,������_updataDate,��ȡ," ..
            index .. ">"
    end
    say(player, str)
end

--��ս������ȡ
function NpcFengshenTower.updataDate(player, choose, index)
    if not index or not tonumber(index) then
        return
    end
    index = tonumber(index)
    local varTb = NpcMapMove.getVarTb(player)
    --�жϹ�����û��������
    if getmoncount(lualib:Name(player), -1, true) > 0 then
        Message:Msg9(player, "ע��鿴�������������ͼ�����й��")
        return
    end
    --������ս����
    if index > lualib:GetPlayerInt(player, "����������") then
        lualib:SetPlayerInt(player, "����������", index)
    end
    if choose == "��ս" then
        if lualib:GetFlagStatus(player, PlayerVarCfg["�Ƿ���ȡ����������"]) == 1 and index % 10 == 0 then
            Message:Msg9(player, "������ȡ������")
            return
        end
        --�ж��Ƿ񼤻�
        if index == 10 and varTb.jsonTb["����½"] == 0 then
            Message:Msg9(player, "����½��δ����޷�������һ��")
            return
        end
        if index == 20 and varTb.jsonTb["����½"] == 0 then
            Message:Msg9(player, "����½��δ����޷�������һ��")
            return
        end
        if index == 30 and varTb.jsonTb["�Ĵ�½"] == 0 then
            Message:Msg9(player, "�Ĵ�½��δ����޷�������һ��")
            return
        end
        --
        killmonsters(lualib:Name(player), '*', 0, false)
        delmirrormap(lualib:Name(player))
        delnpc("����������", lualib:Name(player))
        addmirrormap("t118", lualib:Name(player), "������" .. ConstCfg.CHINA_NUM[index + 1] .. "��", NpcFengshenTowerCfg.list.list[1].time * 60, "3", 0, 330, 330)
        for i = 1, #NpcFengshenTowerCfg.list.list[index + 1].mon, 1 do
            genmonex(lualib:Name(player), 13, 16, NpcFengshenTowerCfg.list.list[index + 1].mon[i][1], 5,
                NpcFengshenTowerCfg.list.list[index + 1].mon[i][2], player, 161, "�������ػ���", 0)
        end
        lualib:MapMove(player, lualib:Name(player))
        lualib:SetFlagStatus(player, PlayerVarCfg["�Ƿ���ȡ����������"], 1)
        delaygoto(player, 2000, "click,������_createNpc," .. index, 0)
    end
    if choose == "��ȡ" then
        if lualib:GetFlagStatus(player, PlayerVarCfg["�Ƿ���ȡ����������"]) == 0 then
            Message:Msg9(player, "��ʿ ������ȡ�����������ظ���ȡ")
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
            giveitem(player, "ʱװ��Ƭ", math.random(1, 4))
        elseif index == 30 then
            giveitem(player, "ʱװ��Ƭ", math.random(3, 8))
        end
        lualib:SetFlagStatus(player, PlayerVarCfg["�Ƿ���ȡ����������"], 0)
        Message:Msg9(player, "��ȡ�����ɹ���")
    end
end

--��ʱ
function NpcFengshenTower.createNpc(player, index)
    if not index or not tonumber(index) then
        return
    end
    index = tonumber(index)
    --�����ʱNPC
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
        ["npcname"] = "����������",
        ["appr"] = 26,
        ["script"] = '������NPC'
    }
    createnpc(lualib:Name(player), 17, 13, tbl2json(npcInfo))
    -- table.insert(NpcFengshenTowerCfg.miniNpc, npcIdx, 1)
end

function NpcFengshenTower.onClickNpc(player, npcID, npcName)
    if NpcFengshenTowerCfg.index[npcID] then
        NpcFengshenTower.main(player)
        return
    end
    --���NPC��ȡ����
    if npcID >= 1000 and npcID <= 10000 then
        local index = npcID % 100
        NpcFengshenTower.updataMain(player, index)
        return
    end
end

--�����ͼ����ʱɾ��NPC
function mirrormapend(sysobj, mapId)
    delnpc("����������", mapId)
end

--�����ͼ����
function NpcFengshenTower.goEnterMap(player, mapId, mapName)
    if mapId == '3' then
        if checkmirrormap(lualib:Name(player)) then
            killmonsters(lualib:Name(player), '*', 0, false)
            delmirrormap(lualib:Name(player))
            delnpc("����������", lualib:Name(player))
            return
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcFengshenTower.onClickNpc, NpcFengshenTower)
GameEvent.add(EventCfg.goEnterMap, NpcFengshenTower.goEnterMap, NpcFengshenTower)
Message.RegisterClickMsg("������", NpcFengshenTower)
return NpcFengshenTower
