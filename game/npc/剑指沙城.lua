NpcCastleData = require("Envir/Extension/DirectorDir/Config/NPC/cfg_剑指沙城.lua")
---@class NpcCastle 剑指沙城
local NpcCastle = {}
local basicRes = [[
    <Img|loadDelay=1|bg=1|show=4|reset=1|move=0|img=custom/UI/jzsc/img_bk1.png|esc=1>
    <Layout|x=767.0|y=6.0|width=80|height=80|link=@exit>
    <Button|x=791.0|y=50.0|color=255|size=18|nimg=custom/new1/close2.png|link=@exit>
    <RText|x=375.0|y=66.0|size=20|color=255|text=<剑指沙城/FCOLOR=255>>
    <Text|x=50.0|y=95.0|color=251|size=18|text=【攻城时间】>
    <RText|x=49.0|y=126.0|size=18|color=255|text=<RText/FCOLOR=255><RText/FCOLOR=254>>
    <Text|x=50.0|y=179.0|color=251|size=18|text=【奖励说明】>
    <RText|x=49.0|y=212.0|size=18|color=255|text=<RText/FCOLOR=255><RText/FCOLOR=254>>
    <Text|x=50.0|y=260.0|color=251|size=18|text=【新区领奖】>
    <RText|x=49.0|y=292.0|size=18|color=255|text=<RText/FCOLOR=255><RText/FCOLOR=254>>
    <Text|x=50.0|y=331.0|color=251|size=18|text=【老区领奖】>
    <RText|x=53.0|y=365.0|size=18|color=255|text=<RText/FCOLOR=255><RText/FCOLOR=254>>
]]

function NpcCastle.main(player)

end

function NpcCastle.onClickNpc(player,npcID,npcName)
    return
end


GameEvent.add(EventCfg.onClickNpc, NpcCastle.onClickNpc, NpcCastle)
return NpcCastle
