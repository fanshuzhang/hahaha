---@class AppGameGuide ��Ϸ����
AppGameGuide = {}
local AppGameGuideCfg = zsf_RequireAppCfg("��Ϸ����")
local basicRes = [[
    <Img|img=custom/UI/public/img_bk1.png|reset=1|bg=1|move=1|loadDelay=1|show=4|esc=1>
    <Layout|x=774.0|y=7.0|width=80|height=80|link=@exit>
    <Button|x=791.0|y=48.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=375.0|y=64.0|size=20|outline=2|outlinecolor=0|color=255|text=<��Ϸ����/FCOLOR=251>>
    <Img|x=185.0|y=83.0|img=custom/UI/public/img1.png|esc=0>
    <ListView|x=199.0|y=101.0|children={101,102,103,104,105,106,107,108,109,110}|width=580|height=400|direction=1|bounce=0|cantouch=1|margin=20>
]]
function AppGameGuide.main(player)
    AppGameGuide.updateData(player, 1)
end

function AppGameGuide.updateData(player, index)
    if not index then
        return
    end
    index = tonumber(index) or 1
    local str = ""
    for i, value in ipairs(AppGameGuideCfg[index]) do
        str = str .. "<RText|id=" .. (i + 100) .. "|x=25|y=20|size=20|outline=2|outlinecolor=0|color=255|width=560|text=" .. value .. ">"
    end
    say(player, AppGameGuide.showMain(player) .. str)
end

function AppGameGuide.showMain(player)
    local str = ""
    str = str .. basicRes
    str = str .. [[
    <Button|x=60.0|y=114.0|nimg=custom/UI/public/btn2.png|size=18|color=255|text=��Ҫ����|link=@click,��Ϸ����_updateData,1>
    <Button|x=60.0|y=170.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=��ҪԪ��|link=@click,��Ϸ����_updateData,2>
    <Button|x=60.0|y=229.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=��Ҫװ��|link=@click,��Ϸ����_updateData,3>
    <Button|x=60.0|y=294.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=װ������|link=@click,��Ϸ����_updateData,4>
    <Button|x=60.0|y=365.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=���ܽ���|link=@click,��Ϸ����_updateData,5>
    ]]
    return str
end

setFormAllowFunc("��Ϸ����", { "main", "updateData" })
Message.RegisterClickMsg("��Ϸ����", AppGameGuide)

return AppGameGuide
