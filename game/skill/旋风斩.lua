---@class xfzSkill ����ն
local xfzSkill = {}

function xfzSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["����ն"] and maigicName == "����ն" then
        local att, job = 0, lualib:Job(player)
        if job == 0 then
            att = lualib:GetBaseInfo(player, 20)
        elseif job == 1 then
            att = lualib:GetBaseInfo(player, 22)
        elseif job == 2 then
            att = lualib:GetBaseInfo(player, 24)
        end
        if lualib:IsPlayer(player) then
            if lualib:Level(targetObject) <= lualib:Level(player) then --�ȼ�������С�Ķ���
                lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), 3, att, 10, 2000, 1, 0)
            else
                lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), 3, att, 0, 0, 0, 0)
            end
        else
            lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), 3, att, 10, 2000, 1, 0)
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onBeginmagic, xfzSkill.onBeginmagic, xfzSkill)
return xfzSkill
