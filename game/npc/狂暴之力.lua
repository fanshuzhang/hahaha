---@class NpcRogePower 狂暴之力
local NpcRogePower = {}
function NpcRogePower.main(player)
    local basicRes = [[
        <Img|show=4|bg=1|loadDelay=1|move=0|reset=1|img=custom/UI/kbzl/img_bk.png|esc=1>
        <Layout|x=504.0|y=33.0|width=50|height=50|link=@exit>
        <Button|x=520.0|y=47.0|color=255|size=18|pimg=custom/new1/close1.png|nimg=custom/new1/close2.png|link=@exit>
        <RText|x=241.0|y=64.0|color=70|size=18|outline=2|outlinecolor=0|text=<狂暴之力/FCOLOR=70>>
        <RText|x=62.0|y=94.0|size=18|color=255|outline=2|outlinecolor=0|text=<开启狂暴需要100万金币/FCOLOR=251>>
        <RText|x=60.0|y=116.0|color=255|size=18|outline=2|outlinecolor=0|text=<击杀携带/FCOLOR=70><[狂暴之力]/FCOLOR=251><的玩家将获得50万金币/FCOLOR=70>>
        <RText|x=62.0|y=138.0|size=14|color=255|outline=2|outlinecolor=0|text=<[注:]/FCOLOR=250><狂暴之力/FCOLOR=251><被人击杀后消失！/FCOLOR=249>>
        <Effect|x=145.0|y=260.0|scale=1|speed=1|effecttype=0|effectid=19998>
        <RText|x=338.0|y=167.0|size=18|color=255|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=250><10-10/FCOLOR=255>>
        <RText|x=338.0|y=196.0|size=18|color=255|outline=2|outlinecolor=0|text=<生命提升：/FCOLOR=250><5%/FCOLOR=255>>
        <RText|x=338.0|y=227.0|size=18|color=255|outline=2|outlinecolor=0|text=<魔法提升：/FCOLOR=250><5%/FCOLOR=255>>
        <RText|x=337.0|y=256.0|size=18|color=255|outline=2|outlinecolor=0|text=<切割：/FCOLOR=250><50/FCOLOR=255>>
        <Button|x=336.0|y=293.0|color=70|size=18|nimg=custom/UI/kbzl/btn.png|link=@click,狂暴之力_MoveOk>
    ]]
    say(player, basicRes)
end

function NpcRogePower.MoveOk(player)
    --是否拥有狂暴之力
    if checktitle(player, "狂暴之力") then
        Message:Msg9(player, "你已激活[狂暴之力]！无法重复激活")
        return
    end
    if lualib:GetMoney(player, 1) < 1000000 then
        Message:Msg9(player, "你的金币不足1000000")
        return
    end
    lualib:SetMoney(player, 1, '-', 1000000, "开启狂暴之力消耗", true)
    lualib:AddTitleEx(player, "狂暴之力")
    TitleShow.RefreshTitleShow(player)
    Message:Msg9(player, "成功激活[狂暴之力]")
    Message:SendMsgNew(player, "玩家[" .. lualib:Name(player) .. "]激活了狂暴之力", 1, 1, 251)
end

--点击NPC触发
function NpcRogePower.onClickNpc(player, npcID, npcName)
    if npcID == 11 then
        NpcRogePower.main(player)
        return
    end
end

--击杀触发
function NpcRogePower.onKillPlay(attacker, victim)
    if lualib:IsPlayer(attacker) and checktitle(victim, "狂暴之力") then
        lualib:SetMoney(attacker, 1, '+', 500000, "击杀狂暴之力玩家", true)
        lualib:DelTitle(victim, "狂暴之力")
        TitleShow.RefreshTitleShow(victim)
        Message:SendMsgNew(attacker, "玩家[" .. lualib:Name(attacker) .. "]击杀携带狂暴之力的玩家，获得50万金币！", 1, 1, 249)
        return
    end
end

GameEvent.add(EventCfg.onClickNpc, NpcRogePower.onClickNpc, NpcRogePower)
GameEvent.add(EventCfg.onKillPlay, NpcRogePower.onKillPlay, NpcRogePower)
Message.RegisterClickMsg("狂暴之力", NpcRogePower)
return NpcRogePower
