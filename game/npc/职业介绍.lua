---@class NpcJobIntroduce ְҵ����
local NpcJobIntroduce = {}
local NpcJobIntroduceCfg = zsf_RequireNpcCfg("ְҵ����")
local basicRes = [[
    <Img|img=custom/UI/public/img_bk1.png|reset=1|bg=1|move=1|loadDelay=0|show=4|esc=1>
    <Layout|x=774.0|y=7.0|width=80|height=80|link=@exit>
    <Button|x=791.0|y=48.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=375.0|y=64.0|size=20|outline=2|outlinecolor=0|color=255|text=<ְҵ����/FCOLOR=251>>
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
        <Button|x=56.0|y=94.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=��սʿ|link=@click,ְҵ����_updateData,1>
        <Button|x=57.0|y=137.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=������|link=@click,ְҵ����_updateData,2>
        <Button|x=58.0|y=183.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=ʥ����ʿ|link=@click,ְҵ����_updateData,3>
        <Button|x=58.0|y=229.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=��Լʦ|link=@click,ְҵ����_updateData,4>
        <Button|x=59.0|y=278.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=���鷨ʦ|link=@click,ְҵ����_updateData,5>
        <Button|x=59.0|y=326.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=��ħ��ʦ|link=@click,ְҵ����_updateData,6>
        <Button|x=59.0|y=379.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=�׹ƶ�ʦ|link=@click,ְҵ����_updateData,7>
        <Button|x=61.0|y=425.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=��½����|link=@click,ְҵ����_updateData,8>
        <Button|x=61.0|y=475.0|width=113|height=34|size=18|color=255|nimg=custom/UI/public/btn2.png|text=����ʦ|link=@click,ְҵ����_updateData,9>
    ]]
    return str
end

--Npc�������
function NpcJobIntroduce.onClickNpc(player, npcID, npcName)
    if not NpcJobIntroduceCfg.index[npcID] then
        return
    end
    NpcJobIntroduce.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcJobIntroduce.onClickNpc, NpcJobIntroduce)
Message.RegisterClickMsg("ְҵ����", NpcJobIntroduce)
return NpcJobIntroduce
