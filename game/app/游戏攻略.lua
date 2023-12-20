---@class AppGameGuide 游戏攻略
AppGameGuide = {}
local AppGameGuideCfg = zsf_RequireAppCfg("游戏攻略")
local basicRes = [[
    <Img|img=custom/UI/public/img_bk1.png|reset=1|bg=1|move=1|loadDelay=1|show=4|esc=1>
    <Layout|x=774.0|y=7.0|width=80|height=80|link=@exit>
    <Button|x=791.0|y=48.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=375.0|y=64.0|size=20|outline=2|outlinecolor=0|color=255|text=<游戏攻略/FCOLOR=251>>
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
    <Button|x=60.0|y=114.0|nimg=custom/UI/public/btn2.png|size=18|color=255|text=我要经验|link=@click,游戏攻略_updateData,1>
    <Button|x=60.0|y=170.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=我要元宝|link=@click,游戏攻略_updateData,2>
    <Button|x=60.0|y=229.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=我要装备|link=@click,游戏攻略_updateData,3>
    <Button|x=60.0|y=294.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=装备介绍|link=@click,游戏攻略_updateData,4>
    <Button|x=60.0|y=365.0|color=255|size=18|nimg=custom/UI/public/btn2.png|text=技能介绍|link=@click,游戏攻略_updateData,5>
    ]]
    return str
end

setFormAllowFunc("游戏攻略", { "main", "updateData" })
Message.RegisterClickMsg("游戏攻略", AppGameGuide)

return AppGameGuide
