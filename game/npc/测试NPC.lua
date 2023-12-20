---@class NpcCeshi ����Npc
local NpcCeshi = {}

local basicRes = [[
    <Img|x=-2.0|y=0.0|height=480|bg=1|move=1|reset=1|esc=1|show=4|img=public/bg_npc_01.png|loadDelay=1>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Img|x=203.0|y=35.0|img=custom/h.png|esc=0>
    <Text|x=43.0|y=44.0|color=251|size=18|text=����������Ҫ��:>
    <RText|x=20.0|y=79.0|size=18|color=255|text=<[ע]:/FCOLOR=250>ˢ��Ʒ��ʽ��ľ��#100����Ʒ����#������������ˢ������\���ֻ��߱�Ż������ּ���>
]]
local NpcCeshiCfg = zsf_RequireNpcCfg("����Npc")
local equipCfg = {}
for i = 1, #NpcExplorerTitleCfg.list, 1 do
    table.insert(equipCfg, NpcExplorerTitleCfg.list[i].equip)
end
function NpcCeshi.main(player)
    lualib:SetFlagStatus(player, PlayerVarCfg["�Ƿ�����û�"], 1)
    local str = " "
    str = str .. basicRes
    str = str .. [[
        <Input|x=212.0|y=41.0|width=100|height=25|size=16|inputid=1|color=255|type=0>
        <Button|x=18.0|y=130.0|tips=�Ϸ������ֵ���|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=��ֵ|link=@ceshinpcmoveok,1>
        <Button|x=149.0|y=129.0|tips=�Ϸ����루��Ʒ����#������|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=ˢ��Ʒ|link=@ceshinpcmoveok,2>
        <Button|x=285.0|y=127.0|tips=�Ϸ�������Ҫ��ӵĳƺ�|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=��ӳƺ�|link=@ceshinpcmoveok,3>
        <Button|x=411.0|y=128.0|tips=�Ϸ�������Ҫɾ���ĳƺ�|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=ɾ���ƺ�|link=@ceshinpcmoveok,4>
        <Button|x=19.0|y=184.0|tips=�Ϸ�������Ҫ���͵ĵ�ͼ����|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=�ɵ�ͼ|link=@ceshinpcmoveok,5>
        <Button|x=151.0|y=183.0|tips={�Ϸ�������Ҫ�л���ְҵǰ���[����]��/FCOLOR=250}^{1.��սʿ}^{2.������}^{3.ʥ����ʿ}^{4.�׵�ʹ��}^{5.��ڤ��ʦ}^{6.��ħ��ʦ}^{7.�׹ƶ�ʦ}^{8.��½����}^{9.����ʦ}|tipsx=70|tipsy=10|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=�л�ְҵ|link=@ceshinpcmoveok,6>
        <Button|x=285.0|y=182.0|tips=�Ϸ����뼼������|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=ɾ������|link=@ceshinpcmoveok,7>
        <Button|x=410.0|y=182.0|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=ˢ̽���߳ƺŲ���|link=@ceshinpcmoveok,8>
        <Button|x=22.0|y=240.0|tips=�Ϸ�����������|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=����|link=@ceshinpcmoveok,9>
        <Button|x=152.0|y=239.0|tips=�Ϸ���������|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=��Ԫ��|link=@ceshinpcmoveok,10>
        <Button|x=286.0|y=237.0|tips=�Ϸ���������|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=��ħ���|link=@ceshinpcmoveok,11>
        <Button|x=414.0|y=232.0|tips=�Ϸ�������ֵ|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=�����и�|link=@ceshinpcmoveok,12>
        <Button|x=23.0|y=296.0|width=115|height=42|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=ת���ֻز���|link=@ceshinpcmoveok,13>
        <Button|x=153.0|y=296.0|tips=һ�����ְҵ����|tipsx=70|tipsy=70|width=115|height=42|nimg=custom/ann73.png|size=18|submitInput=1|color=250|text=һ�����ְҵ����|link=@ceshinpcmoveok,14>
        <Button|x=287.0|y=296.0|width=115|height=42|color=250|submitInput=1|size=18|nimg=custom/ann73.png|text=һ��ˢ����|link=@ceshinpcmoveok,15>
        <Button|x=415.0|y=296.0|width=115|height=42|color=250|submitInput=1|size=18|nimg=custom/ann73.png|text=������|link=@ceshinpcmoveok,16>
        <Button|x=23.0|y=360.0|width=115|height=42|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=һ��ˢ�������|link=@ceshinpcmoveok,17>
        <Button|x=153.0|y=360.0|tips=����װ������|tipsx=70|tipsy=70|width=115|height=42|nimg=custom/ann73.png|size=18|submitInput=1|color=250|text=����װ������|link=@ceshinpcmoveok,18>
    ]]
    say(player, str)
end

function ceshinpcmoveok(player, index)
    if not index then
        return
    end
    index = tonumber(index)
    local txt = getconst(player, "<$NPCINPUT(1)>")

    local found, position = string.find(txt, "#")
    local itemName, itemNum, input
    if found then
        itemName, itemNum = string.match(txt, "([^#]+)#([^#]+)")
    else
        input = tonumber(txt)
        if not input then
            input = txt
        end
    end
    itemName = itemName or ''
    itemNum = itemNum or 0
    input = input or ''
    if index == 1 then
        lualib:SetMoney(player, 2, '+', input * 100, "�����û���ֵԪ��", true)
        lualib:SetMoney(player, 5, '+', input, "�����û���ֵ��ֵ��", true)
    elseif index == 2 then
        if not lualib:FGiveItem(player, itemName, itemNum) then
            lualib:FGiveItem(player, input, 1)
        end
    elseif index == 3 then
        lualib:AddTitleEx(player, input)
    elseif index == 4 then
        lualib:DelTitle(player, input)
    elseif index == 5 then
        if not NpcCeshiCfg.mapInfo[input] then
            Message:Msg9(player, "����ֱ�Ӵ��ͣ�")
            return
                lualib:MapMove(player, NpcCeshiCfg.mapInfo[input])
        end
    elseif index == 6 then
        if input == '' then
            return
        end
        ChooseJob.ConfirmJob(player, input)
        --ɾ������
        for _, value in pairs(SkillIDCfg) do
            if Magic.BBcountEX(player, value) then
                lualib:DelSkill(player, value)
            end
        end
        Message:Msg9(player, "�л�ְҵ�ɹ�")
    elseif index == 7 then
        if not SkillIDCfg[input] then
            Message:Msg9(player, "error!")
            return
        end
        lualib:DelSkill(player, SkillIDCfg[input])
    elseif index == 8 then
        NpcCeshi.openTSZCH(player)
    elseif index == 9 then
        lualib:SetMoney(player, 1, '+', input, "�����û�����", true)
    elseif index == 10 then
        lualib:SetMoney(player, 2, '+', input, "�����û���Ԫ��", true)
    elseif index == 11 then
        lualib:SetMoney(player, 19, '+', input, "�����û���ħ���", true)
    elseif index == 12 then
        lualib:SetValue(player, 207, input, 65535)
    elseif index == 13 then
        NpcCeshi.openZSLH(player)
    elseif index == 14 then
        local hh=lualib:GetVar(player,VarCfg["��ɫְҵ"])
        for _, value in pairs(ChooseJobCfg.list[hh].skill) do
            if not Magic.BBcountEX(player, value.skill.ID) then
                lualib:AddSkill(player, value.skill.ID)
            end
        end
        Message:Msg9(player,"��ӳɹ�")
    elseif index == 15 then
        lualib:SetMoney(player, 1, '+', 99999999, "�����û�����", true)
        lualib:SetMoney(player, 2, '+', 99999999, "�����û���Ԫ��", true)
        lualib:SetMoney(player, 19, '+', 99999999, "�����û���ħ���", true)
    elseif index == 16 then
        local itemTb = getbagitems(player)
        for _, value in pairs(itemTb) do
            takeitem(player, getiteminfo(player, value, 7), getbagitemcount(player, getiteminfo(player, value, 7)))
        end
    elseif index == 17 then
        lualib:AddBatchItem(player, NpcCeshiCfg.suit, "����NPCˢ����")
    elseif index == 18 then
        lualib:AddBatchItem(player, NpcCeshiCfg.giveEquip, "����NPCˢ����")
    end
end

function NpcCeshi.openTSZCH(player)
    say(player, [[
        <Img|loadDelay=1|reset=1|img=public/bg_npc_01.png|show=4|move=0|esc=1|bg=1>
        <Layout|x=545|y=0|width=80|height=80|link=@click,����NPC_main>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@click,����NPC_main>
        <RText|x=11.0|y=16.0|size=18|color=251|text=<��̽���߳ƺŲ��ϡ�/FCOLOR=251>>
        <Text|x=13.0|y=52.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,1>
        <Text|x=112.0|y=52.0|size=18|color=255|text=ʯĹ̽����|link=@click,����NPC_giveItem,2>
        <Text|x=218.0|y=47.0|size=18|color=255|text=��ħ̽����|link=@click,����NPC_giveItem,3>
        <Text|x=322.0|y=44.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,4>
        <Text|x=431.0|y=44.0|size=18|color=255|text=ţħ̽����|link=@click,����NPC_giveItem,5>
        <Text|x=13.0|y=82.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,6>
        <Text|x=116.0|y=83.0|size=18|color=255|text=ħ��̽����|link=@click,����NPC_giveItem,7>
        <Text|x=218.0|y=81.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,8>
        <Text|x=324.0|y=78.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,9>
        <Text|x=434.0|y=77.0|size=18|color=255|text=ѩ��̽����|link=@click,����NPC_giveItem,10>
        <Text|x=13.0|y=117.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,11>
        <Text|x=116.0|y=115.0|size=18|color=255|text=�߾�̽����|link=@click,����NPC_giveItem,12>
        <Text|x=219.0|y=115.0|size=18|color=255|text=�۹�̽����|link=@click,����NPC_giveItem,13>
        <Text|x=332.0|y=115.0|size=18|color=255|text=ŵ��̽����|link=@click,����NPC_giveItem,14>
        <Text|x=439.0|y=114.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,15>
        <Text|x=13.0|y=148.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,16>
        <Text|x=120.0|y=149.0|size=18|color=255|text=����̽����|link=@click,����NPC_giveItem,17>
        <Text|x=226.0|y=146.0|size=18|color=255|text=���̽����|link=@click,����NPC_giveItem,18>
    ]])
end

function NpcCeshi.openZSLH(player)
    say(player, [[
        <Img|loadDelay=1|reset=1|img=public/bg_npc_01.png|show=4|move=0|esc=1|bg=1>
        <Layout|x=545|y=0|width=80|height=80|link=@click,����NPC_main>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@click,����NPC_main>
        <RText|x=22.0|y=20.0|size=18|color=255|text=<��ת���ֻز��ϡ�/FCOLOR=251>>
        <Text|x=32.0|y=52.0|size=18|color=255|text=һת����|link=@click,����NPC_giveZSItem,1>
        <Text|x=129.0|y=50.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,2>
        <Text|x=223.0|y=50.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,3>
        <Text|x=321.0|y=50.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,4>
        <Text|x=440.0|y=48.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,5>
        <Text|x=30.0|y=88.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,6>
        <Text|x=127.0|y=90.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,7>
        <Text|x=236.0|y=92.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,8>
        <Text|x=334.0|y=90.0|size=18|color=255|text=��ת����|link=@click,����NPC_giveZSItem,9>
        <Text|x=441.0|y=92.0|size=18|color=255|text=ʮת����|link=@click,����NPC_giveZSItem,10>
        <Text|x=32.0|y=129.0|size=18|color=255|text=ʮһת����|link=@click,����NPC_giveZSItem,11>
        <Text|x=133.0|y=129.0|size=18|color=255|text=ʮ��ת����|link=@click,����NPC_giveZSItem,12>
    ]])
end

function NpcCeshi.giveItem(player, input)
    if not input then
        return
    end
    input = tonumber(input)
    for _, value in ipairs(equipCfg[input]) do
        lualib:FGiveItem(player, value[1], 1)
    end
end

function NpcCeshi.giveZSItem(player, input)
    if not input then
        return
    end
    input = tonumber(input)
    lualib:AddBatchItem(player, NpcreincarnationCfg.list[input].cost, "����NPCˢ����")
end

function NpcCeshi.onClickNpc(player, npcId, npcName)
    if npcId == 25 then
        NpcCeshi.main(player)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcCeshi.onClickNpc, NpcCeshi)

Message.RegisterClickMsg("����NPC", NpcCeshi)
return NpcCeshi
