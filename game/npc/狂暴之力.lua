---@class NpcRogePower ��֮��
local NpcRogePower = {}
function NpcRogePower.main(player)
    local basicRes = [[
        <Img|show=4|bg=1|loadDelay=1|move=0|reset=1|img=custom/UI/kbzl/img_bk.png|esc=1>
        <Layout|x=504.0|y=33.0|width=50|height=50|link=@exit>
        <Button|x=520.0|y=47.0|color=255|size=18|pimg=custom/new1/close1.png|nimg=custom/new1/close2.png|link=@exit>
        <RText|x=241.0|y=64.0|color=70|size=18|outline=2|outlinecolor=0|text=<��֮��/FCOLOR=70>>
        <RText|x=62.0|y=94.0|size=18|color=255|outline=2|outlinecolor=0|text=<��������Ҫ100����/FCOLOR=251>>
        <RText|x=60.0|y=116.0|color=255|size=18|outline=2|outlinecolor=0|text=<��ɱЯ��/FCOLOR=70><[��֮��]/FCOLOR=251><����ҽ����50����/FCOLOR=70>>
        <RText|x=62.0|y=138.0|size=14|color=255|outline=2|outlinecolor=0|text=<[ע:]/FCOLOR=250><��֮��/FCOLOR=251><���˻�ɱ����ʧ��/FCOLOR=249>>
        <Effect|x=145.0|y=260.0|scale=1|speed=1|effecttype=0|effectid=19998>
        <RText|x=338.0|y=167.0|size=18|color=255|outline=2|outlinecolor=0|text=<��ħ����/FCOLOR=250><10-10/FCOLOR=255>>
        <RText|x=338.0|y=196.0|size=18|color=255|outline=2|outlinecolor=0|text=<����������/FCOLOR=250><5%/FCOLOR=255>>
        <RText|x=338.0|y=227.0|size=18|color=255|outline=2|outlinecolor=0|text=<ħ��������/FCOLOR=250><5%/FCOLOR=255>>
        <RText|x=337.0|y=256.0|size=18|color=255|outline=2|outlinecolor=0|text=<�и/FCOLOR=250><50/FCOLOR=255>>
        <Button|x=336.0|y=293.0|color=70|size=18|nimg=custom/UI/kbzl/btn.png|link=@click,��֮��_MoveOk>
    ]]
    say(player, basicRes)
end

function NpcRogePower.MoveOk(player)
    --�Ƿ�ӵ�п�֮��
    if checktitle(player, "��֮��") then
        Message:Msg9(player, "���Ѽ���[��֮��]���޷��ظ�����")
        return
    end
    if lualib:GetMoney(player, 1) < 1000000 then
        Message:Msg9(player, "��Ľ�Ҳ���1000000")
        return
    end
    lualib:SetMoney(player, 1, '-', 1000000, "������֮������", true)
    lualib:AddTitleEx(player, "��֮��")
    TitleShow.RefreshTitleShow(player)
    Message:Msg9(player, "�ɹ�����[��֮��]")
    Message:SendMsgNew(player, "���[" .. lualib:Name(player) .. "]�����˿�֮��", 1, 1, 251)
end

--���NPC����
function NpcRogePower.onClickNpc(player, npcID, npcName)
    if npcID == 11 then
        NpcRogePower.main(player)
        return
    end
end

--��ɱ����
function NpcRogePower.onKillPlay(attacker, victim)
    if lualib:IsPlayer(attacker) and checktitle(victim, "��֮��") then
        lualib:SetMoney(attacker, 1, '+', 500000, "��ɱ��֮�����", true)
        lualib:DelTitle(victim, "��֮��")
        TitleShow.RefreshTitleShow(victim)
        Message:SendMsgNew(attacker, "���[" .. lualib:Name(attacker) .. "]��ɱЯ����֮������ң����50���ң�", 1, 1, 249)
        return
    end
end

GameEvent.add(EventCfg.onClickNpc, NpcRogePower.onClickNpc, NpcRogePower)
GameEvent.add(EventCfg.onKillPlay, NpcRogePower.onKillPlay, NpcRogePower)
Message.RegisterClickMsg("��֮��", NpcRogePower)
return NpcRogePower
