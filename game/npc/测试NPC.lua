---@class NpcCeshi 测试Npc
local NpcCeshi = {}

local basicRes = [[
    <Img|x=-2.0|y=0.0|height=480|bg=1|move=1|reset=1|esc=1|show=4|img=public/bg_npc_01.png|loadDelay=1>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Img|x=203.0|y=35.0|img=custom/h.png|esc=0>
    <Text|x=43.0|y=44.0|color=251|size=18|text=请输入你想要的:>
    <RText|x=20.0|y=79.0|size=18|color=255|text=<[注]:/FCOLOR=250>刷物品格式：木剑#100（物品名字#数量）其他的刷东西填\数字或者编号或者名字即可>
]]
local NpcCeshiCfg = zsf_RequireNpcCfg("测试Npc")
local equipCfg = {}
for i = 1, #NpcExplorerTitleCfg.list, 1 do
    table.insert(equipCfg, NpcExplorerTitleCfg.list[i].equip)
end
function NpcCeshi.main(player)
    lualib:SetFlagStatus(player, PlayerVarCfg["是否测试用户"], 1)
    local str = " "
    str = str .. basicRes
    str = str .. [[
        <Input|x=212.0|y=41.0|width=100|height=25|size=16|inputid=1|color=255|type=0>
        <Button|x=18.0|y=130.0|tips=上方输入充值金额|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=充值|link=@ceshinpcmoveok,1>
        <Button|x=149.0|y=129.0|tips=上方输入（物品名字#数量）|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=刷物品|link=@ceshinpcmoveok,2>
        <Button|x=285.0|y=127.0|tips=上方输入需要添加的称号|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=添加称号|link=@ceshinpcmoveok,3>
        <Button|x=411.0|y=128.0|tips=上方输入需要删除的称号|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=删除称号|link=@ceshinpcmoveok,4>
        <Button|x=19.0|y=184.0|tips=上方输入需要传送的地图名字|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=飞地图|link=@ceshinpcmoveok,5>
        <Button|x=151.0|y=183.0|tips={上方输入需要切换的职业前面的[数字]：/FCOLOR=250}^{1.狂暴战士}^{2.鬼武者}^{3.圣光骑士}^{4.雷电使者}^{5.玄冥法师}^{6.大魔导师}^{7.巫蛊毒师}^{8.大陆尊者}^{9.幻术师}|tipsx=70|tipsy=10|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=切换职业|link=@ceshinpcmoveok,6>
        <Button|x=285.0|y=182.0|tips=上方输入技能名字|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=删除技能|link=@ceshinpcmoveok,7>
        <Button|x=410.0|y=182.0|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=刷探索者称号材料|link=@ceshinpcmoveok,8>
        <Button|x=22.0|y=240.0|tips=上方输入金币数量|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=充金币|link=@ceshinpcmoveok,9>
        <Button|x=152.0|y=239.0|tips=上方输入数量|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=充元宝|link=@ceshinpcmoveok,10>
        <Button|x=286.0|y=237.0|tips=上方输入数量|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=充魔魂币|link=@ceshinpcmoveok,11>
        <Button|x=414.0|y=232.0|tips=上方输入数值|tipsx=70|tipsy=70|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=设置切割|link=@ceshinpcmoveok,12>
        <Button|x=23.0|y=296.0|width=115|height=42|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=转世轮回材料|link=@ceshinpcmoveok,13>
        <Button|x=153.0|y=296.0|tips=一键添加职业技能|tipsx=70|tipsy=70|width=115|height=42|nimg=custom/ann73.png|size=18|submitInput=1|color=250|text=一键添加职业技能|link=@ceshinpcmoveok,14>
        <Button|x=287.0|y=296.0|width=115|height=42|color=250|submitInput=1|size=18|nimg=custom/ann73.png|text=一键刷货币|link=@ceshinpcmoveok,15>
        <Button|x=415.0|y=296.0|width=115|height=42|color=250|submitInput=1|size=18|nimg=custom/ann73.png|text=清理背包|link=@ceshinpcmoveok,16>
        <Button|x=23.0|y=360.0|width=115|height=42|color=250|nimg=custom/ann73.png|size=18|submitInput=1|text=一键刷特殊材料|link=@ceshinpcmoveok,17>
        <Button|x=153.0|y=360.0|tips=联盟装备材料|tipsx=70|tipsy=70|width=115|height=42|nimg=custom/ann73.png|size=18|submitInput=1|color=250|text=联盟装备材料|link=@ceshinpcmoveok,18>
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
        lualib:SetMoney(player, 2, '+', input * 100, "测试用户充值元宝", true)
        lualib:SetMoney(player, 5, '+', input, "测试用户充值充值点", true)
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
            Message:Msg9(player, "不可直接传送！")
            return
                lualib:MapMove(player, NpcCeshiCfg.mapInfo[input])
        end
    elseif index == 6 then
        if input == '' then
            return
        end
        ChooseJob.ConfirmJob(player, input)
        --删除技能
        for _, value in pairs(SkillIDCfg) do
            if Magic.BBcountEX(player, value) then
                lualib:DelSkill(player, value)
            end
        end
        Message:Msg9(player, "切换职业成功")
    elseif index == 7 then
        if not SkillIDCfg[input] then
            Message:Msg9(player, "error!")
            return
        end
        lualib:DelSkill(player, SkillIDCfg[input])
    elseif index == 8 then
        NpcCeshi.openTSZCH(player)
    elseif index == 9 then
        lualib:SetMoney(player, 1, '+', input, "测试用户充金币", true)
    elseif index == 10 then
        lualib:SetMoney(player, 2, '+', input, "测试用户充元宝", true)
    elseif index == 11 then
        lualib:SetMoney(player, 19, '+', input, "测试用户充魔魂币", true)
    elseif index == 12 then
        lualib:SetValue(player, 207, input, 65535)
    elseif index == 13 then
        NpcCeshi.openZSLH(player)
    elseif index == 14 then
        local hh=lualib:GetVar(player,VarCfg["角色职业"])
        for _, value in pairs(ChooseJobCfg.list[hh].skill) do
            if not Magic.BBcountEX(player, value.skill.ID) then
                lualib:AddSkill(player, value.skill.ID)
            end
        end
        Message:Msg9(player,"添加成功")
    elseif index == 15 then
        lualib:SetMoney(player, 1, '+', 99999999, "测试用户充金币", true)
        lualib:SetMoney(player, 2, '+', 99999999, "测试用户充元宝", true)
        lualib:SetMoney(player, 19, '+', 99999999, "测试用户充魔魂币", true)
    elseif index == 16 then
        local itemTb = getbagitems(player)
        for _, value in pairs(itemTb) do
            takeitem(player, getiteminfo(player, value, 7), getbagitemcount(player, getiteminfo(player, value, 7)))
        end
    elseif index == 17 then
        lualib:AddBatchItem(player, NpcCeshiCfg.suit, "测试NPC刷材料")
    elseif index == 18 then
        lualib:AddBatchItem(player, NpcCeshiCfg.giveEquip, "测试NPC刷材料")
    end
end

function NpcCeshi.openTSZCH(player)
    say(player, [[
        <Img|loadDelay=1|reset=1|img=public/bg_npc_01.png|show=4|move=0|esc=1|bg=1>
        <Layout|x=545|y=0|width=80|height=80|link=@click,测试NPC_main>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@click,测试NPC_main>
        <RText|x=11.0|y=16.0|size=18|color=251|text=<【探索者称号材料】/FCOLOR=251>>
        <Text|x=13.0|y=52.0|size=18|color=255|text=沃玛探索者|link=@click,测试NPC_giveItem,1>
        <Text|x=112.0|y=52.0|size=18|color=255|text=石墓探索者|link=@click,测试NPC_giveItem,2>
        <Text|x=218.0|y=47.0|size=18|color=255|text=骨魔探索者|link=@click,测试NPC_giveItem,3>
        <Text|x=322.0|y=44.0|size=18|color=255|text=祖玛探索者|link=@click,测试NPC_giveItem,4>
        <Text|x=431.0|y=44.0|size=18|color=255|text=牛魔探索者|link=@click,测试NPC_giveItem,5>
        <Text|x=13.0|y=82.0|size=18|color=255|text=赤月探索者|link=@click,测试NPC_giveItem,6>
        <Text|x=116.0|y=83.0|size=18|color=255|text=魔龙探索者|link=@click,测试NPC_giveItem,7>
        <Text|x=218.0|y=81.0|size=18|color=255|text=雷炎探索者|link=@click,测试NPC_giveItem,8>
        <Text|x=324.0|y=78.0|size=18|color=255|text=火龙探索者|link=@click,测试NPC_giveItem,9>
        <Text|x=434.0|y=77.0|size=18|color=255|text=雪域探索者|link=@click,测试NPC_giveItem,10>
        <Text|x=13.0|y=117.0|size=18|color=255|text=狐月探索者|link=@click,测试NPC_giveItem,11>
        <Text|x=116.0|y=115.0|size=18|color=255|text=边境探索者|link=@click,测试NPC_giveItem,12>
        <Text|x=219.0|y=115.0|size=18|color=255|text=帝国探索者|link=@click,测试NPC_giveItem,13>
        <Text|x=332.0|y=115.0|size=18|color=255|text=诺玛探索者|link=@click,测试NPC_giveItem,14>
        <Text|x=439.0|y=114.0|size=18|color=255|text=半兽探索者|link=@click,测试NPC_giveItem,15>
        <Text|x=13.0|y=148.0|size=18|color=255|text=瘟疫探索者|link=@click,测试NPC_giveItem,16>
        <Text|x=120.0|y=149.0|size=18|color=255|text=亡灵探索者|link=@click,测试NPC_giveItem,17>
        <Text|x=226.0|y=146.0|size=18|color=255|text=泽国探索者|link=@click,测试NPC_giveItem,18>
    ]])
end

function NpcCeshi.openZSLH(player)
    say(player, [[
        <Img|loadDelay=1|reset=1|img=public/bg_npc_01.png|show=4|move=0|esc=1|bg=1>
        <Layout|x=545|y=0|width=80|height=80|link=@click,测试NPC_main>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@click,测试NPC_main>
        <RText|x=22.0|y=20.0|size=18|color=255|text=<【转世轮回材料】/FCOLOR=251>>
        <Text|x=32.0|y=52.0|size=18|color=255|text=一转材料|link=@click,测试NPC_giveZSItem,1>
        <Text|x=129.0|y=50.0|size=18|color=255|text=二转材料|link=@click,测试NPC_giveZSItem,2>
        <Text|x=223.0|y=50.0|size=18|color=255|text=三转材料|link=@click,测试NPC_giveZSItem,3>
        <Text|x=321.0|y=50.0|size=18|color=255|text=四转材料|link=@click,测试NPC_giveZSItem,4>
        <Text|x=440.0|y=48.0|size=18|color=255|text=五转材料|link=@click,测试NPC_giveZSItem,5>
        <Text|x=30.0|y=88.0|size=18|color=255|text=六转材料|link=@click,测试NPC_giveZSItem,6>
        <Text|x=127.0|y=90.0|size=18|color=255|text=七转材料|link=@click,测试NPC_giveZSItem,7>
        <Text|x=236.0|y=92.0|size=18|color=255|text=八转材料|link=@click,测试NPC_giveZSItem,8>
        <Text|x=334.0|y=90.0|size=18|color=255|text=九转材料|link=@click,测试NPC_giveZSItem,9>
        <Text|x=441.0|y=92.0|size=18|color=255|text=十转材料|link=@click,测试NPC_giveZSItem,10>
        <Text|x=32.0|y=129.0|size=18|color=255|text=十一转材料|link=@click,测试NPC_giveZSItem,11>
        <Text|x=133.0|y=129.0|size=18|color=255|text=十二转材料|link=@click,测试NPC_giveZSItem,12>
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
    lualib:AddBatchItem(player, NpcreincarnationCfg.list[input].cost, "测试NPC刷材料")
end

function NpcCeshi.onClickNpc(player, npcId, npcName)
    if npcId == 25 then
        NpcCeshi.main(player)
    end
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcCeshi.onClickNpc, NpcCeshi)

Message.RegisterClickMsg("测试NPC", NpcCeshi)
return NpcCeshi
