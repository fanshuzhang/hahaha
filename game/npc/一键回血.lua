---@class NpcEasyApp �򵥹���
local NpcEasyApp = {}

function NpcEasyApp.recover(player)
    local myHp, myMaxHp = lualib:Hp(player), lualib:Hp(player, 1)
    local myMp, myMaxMp = lualib:Mp(player), lualib:Mp(player, 1)
    if myHp == myMaxHp and myMp == myMaxMp then
        Message:Msg9(player, "���ⲻ�ǲ������Ĳ����ҿ�ҽ���ˣ�")
        return
    end
    if myHp ~= myMaxHp then
        lualib:SetHpEx(player, "=", 100)
    end
    if myMp ~= myMaxMp then
        lualib:SetMpEx(player, "=", 100)
    end
    Message:Msg9(player, "��ȫ�µ���̬Ͷ��ս���ɣ�����ն��������η�壡��")
end

-- npc�������
function NpcEasyApp.onClickNpc(player, npcId, npcName)
    if npcId == 20 then
        NpcEasyApp.recover(player)
        return
    elseif npcName == "�򵥹���2" then
    end
end

-- ��¼����
--function NpcEasyApp.onLogin(player)
--end

--GameEvent.add(EventCfg.onLogin, NpcEasyApp.onLogin, NpcEasyApp)
GameEvent.add(EventCfg.onClickNpc, NpcEasyApp.onClickNpc, NpcEasyApp)

return NpcEasyApp
