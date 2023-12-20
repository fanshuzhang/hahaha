---@class NpcJobIntroduce 职业介绍
local NpcJobIntroduce = {}
local NpcJobIntroduceCfg = zsf_RequireNpcCfg("职业介绍")
local basicRes = [[
    <Img|img=custom/UI/public/img_bk1.png|reset=1|bg=1|move=1|loadDelay=0|show=4|esc=1>
    <Layout|x=774.0|y=7.0|width=80|height=80|link=@exit>
    <Button|x=791.0|y=48.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=375.0|y=64.0|size=20|outline=2|outlinecolor=0|color=255|text=<职业介绍/FCOLOR=251>>
    <Img|x=185.0|y=83.0|img=custom/UI/public/img1.png|esc=0>
    <ListView|x=199.0|y=101.0|children={101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117}|width=580|height=400|direction=1|bounce=0|cantouch=1|margin=20>
    <Effect|x=745.0|y=221.0|scale=1|speed=1|dir=5|effecttype=0|effectid=70074|act=0>
]]
function NpcJobIntroduce.main(player)
    NpcJobIntroduce.updateData(player, 1)
end

function NpcJobIntroduce.updateData(player, index)
    if not index then
        return
    end
    index = tonumber(index) or 1
    local str = ""
    for i, value in ipairs(NpcJobIntroduceCfg.list[index]) do
        str = str ..
            "<RText|id=" .. (i + 100) .. "|x=25|y=20|size=20|outline=2|outlinecolor=0|color=255|width=560|text=" .. value .. ">"
    end
    say(player, NpcJobIntroduce.showMain(player) .. str)
end

function NpcJobIntroduce.showMain(player)
    local str = ""
    str = str .. basicRes
    str = str .. [[
        <Button|x=56.0|y=94.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=狂暴战士|link=@click,职业介绍_updateData,1>
        <Button|x=57.0|y=137.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=鬼武者|link=@click,职业介绍_updateData,2>
        <Button|x=58.0|y=183.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=圣光骑士|link=@click,职业介绍_updateData,3>
        <Button|x=58.0|y=229.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=契约师|link=@click,职业介绍_updateData,4>
        <Button|x=59.0|y=278.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=死灵法师|link=@click,职业介绍_updateData,5>
        <Button|x=59.0|y=326.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=大魔导师|link=@click,职业介绍_updateData,6>
        <Button|x=59.0|y=379.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=巫蛊毒师|link=@click,职业介绍_updateData,7>
        <Button|x=61.0|y=425.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=大陆尊者|link=@click,职业介绍_updateData,8>
        <Button|x=61.0|y=475.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=幻术师|link=@click,职业介绍_updateData,9>
    ]]
    return str
end

--Npc点击触发
function NpcJobIntroduce.onClickNpc(player, npcID, npcName)
    if not NpcJobIntroduceCfg.index[npcID] then
        return
    end
    NpcJobIntroduce.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcJobIntroduce.onClickNpc, NpcJobIntroduce)
Message.RegisterClickMsg("职业介绍", NpcJobIntroduce)
return NpcJobIntroduce
