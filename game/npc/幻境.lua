---@class NpcMovaHuanJin 幻境
local NpcMovaHuanJin = {}
local NpcMovaHuanJinCfg = {
    index = {
        [21] = 1,
    },
    cost = { { "幻境凭证", 1, id = 10416 } },
}
function NpcMovaHuanJin.main(player)
    say(player, [[
        <Img|reset=1|esc=1|move=1|loadDelay=1|show=4|img=custom/UI/public/img_bk2.png|bg=1>
        <Layout|x=481.0|y=0.0|width=80|height=80|link=@exit>
        <Button|x=516.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
        <RText|x=243.0|y=66.0|color=70|outlinecolor=0|size=18|outline=2|text=<幻境传送/FCOLOR=70>>
        <Text|x=60.0|y=120.0|size=22|color=250|text=[散人福利地图]>
        <RText|x=61.0|y=157.0|width=430|size=18|color=254|text=幻境特色地图完全免费进入、只需一个<[幻境凭证]/FCOLOR=251>，每层刷新联盟怪物、福利怪物，散人打金的好地方，高爆率。>
        <Button|x=218.0|y=279.0|color=251|nimg=custom/UI/public/btn2.png|size=18|text=进入幻境|link=@npcmovahuanjinmoveok>
    ]])
end

--传送
function npcmovahuanjinmoveok(player)
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, NpcMovaHuanJinCfg.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, NpcMovaHuanJinCfg.cost, "九龙血玉提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --传送
    lualib:MapMove(player, "h001")
end

--Npc点击触发
function NpcMovaHuanJin.onClickNpc(player, npcID, npcName)
    if not NpcMovaHuanJinCfg.index[npcID] then
        return
    end
    NpcMovaHuanJin.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcMovaHuanJin.onClickNpc, NpcMovaHuanJin)
return NpcMovaHuanJin
