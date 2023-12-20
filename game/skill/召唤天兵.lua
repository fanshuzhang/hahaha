---@class chtbSkill �ٻ����
local chtbSkill = {}

chtbSkill.bbName = {
    [0] = "һ�����",
    [1] = "һ�����",
    [2] = "һ�����",
    [3] = "�������",
    [4] = "�������",
    [5] = "�������",
    [6] = "�������",
    [7] = "�������",
    [8] = "�������",
    [9] = "�ļ����",
}

function magselffunc1011(player)
    --�ٻ����
    if lualib:GetInt(player, "�ٻ����") >= 1 then
        Message:Msg9(player, "ֻ���ٻ�һλ�����")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["�ٻ����"])
    if level then
        local BBItem = recallmob(player, chtbSkill.bbName[level], 7, 1440, 1)
        if BBItem then
            changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 86400)
            changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 86400)
            changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 86400)
            changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 86400)
            changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 4, 86400)
            --����
            local num = (100 + 5 * level) / 100
            local attUp, attLow = Magic.GetPlayerAtt(player)
            changemobability(player, BBItem, 5, '=', attLow * num, 86400)
            changemobability(player, BBItem, 6, '=', attUp * num, 86400)
            -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 86400)
            -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 86400)
            -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 86400)
            -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 86400)
            --������״̬
            setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
            --������צǿ��
            if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 8 then
                local ClawCount = Magic.ClawCount(player)
                if ClawCount >= 1 then
                    local qhatt = 0.25
                    if ClawCount >= 2 then qhatt = 0.45 end
                    if ClawCount >= 3 then qhatt = 0.8 end
                    --���Ԫ������
                    if addbuff(BBItem, 50004, 65535, 1, player, {
                            [21] = getbaseinfo(player, 51, 21) * qhatt,
                            [25] = getbaseinfo(player, 51, 25) * qhatt,
                            [28] = getbaseinfo(player, 51, 28) * qhatt,
                        }) then
                        Message:SendClawmsg(player, "������צ��������Ԫ����������")
                    end
                end
            end
            --����
            lualib:SetInt(player, "�ٻ����", 1)
        end
    end
end

--������������
function chtbSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "һ�����" or getbaseinfo(bbobj, 1, 1) == "�������" or getbaseinfo(bbobj, 1, 1) == "�������" or getbaseinfo(bbobj, 1, 1) == "�ļ����" then
        lualib:SetInt(player, "�ٻ����", 0)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onSelfKillSlave, chtbSkill.onSelfKillSlave, chtbSkill)
return chtbSkill
