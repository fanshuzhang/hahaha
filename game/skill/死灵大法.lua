---@class sldfSkill �����
local sldfSkill = {}
--�ͷż���ǰ����
function sldfSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicName == "�����" then
        if lualib:GetVar(player, VarCfg["����������"]) < 5 then
            Message:Msg9(player, "ӵ�е�[����]�����������׼�")
            return false
        end
        if lualib:GetVar(player, VarCfg["���������"]) >= 2 then
            Message:Msg9(player, "���ٻ��������Ѵ����ޣ�")
        end
        callscriptex(player, "KillCallMob", "����", 5, 1)
        local time = 10
        if getskillinfo(player, SkillIDCfg["�����̳"], 2) then --�����������ô���
            time = 1440
        end
        local BBItem = recallmob(player, "�����ʦ", 7, time, 1)
        changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), time * 60)
        changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), time * 60)
        changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), time * 60)
        changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), time * 60)
        changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 2, time * 60)
        --����
        local num = (80 + 5 * getskillinfo(player, SkillIDCfg["������"], 2)) / 100
        local attUp, attLow = Magic.GetPlayerAtt(player)
        changemobability(player, BBItem, 5, '=', attLow * num, time * 60)
        changemobability(player, BBItem, 6, '=', attUp * num, time * 60)
        -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, time * 60)
        -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, time * 60)
        -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, time * 60)
        -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, time * 60)
        --������״̬
        setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
        --���������
        lualib:SetVar(player, VarCfg["���������"], lualib:GetVar(player, VarCfg["���������"]) + 1)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onBeginmagic, sldfSkill.onBeginmagic, sldfSkill)
return sldfSkill
