---@class wlhdSkill ���׺䶥
local wlhdSkill = {}

function wlhdSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["���׺䶥"] and maigicName == "���׺䶥" then
        local level = Magic.BBcountEX(player, SkillIDCfg["���׺䶥"])
        rangeharm(player, x, y, 1, getbaseinfo(player, 22) * (1 + level / 10), 3, 3, 0, 0, 80913)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onBeginmagic, wlhdSkill.onBeginmagic, wlhdSkill)
return wlhdSkill
