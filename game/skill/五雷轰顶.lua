---@class wlhdSkill 五雷轰顶
local wlhdSkill = {}

function wlhdSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["五雷轰顶"] and maigicName == "五雷轰顶" then
        local level = Magic.BBcountEX(player, SkillIDCfg["五雷轰顶"])
        rangeharm(player, x, y, 1, getbaseinfo(player, 22) * (1 + level / 10), 3, 3, 0, 0, 80913)
    end
end

--游戏事件
GameEvent.add(EventCfg.onBeginmagic, wlhdSkill.onBeginmagic, wlhdSkill)
return wlhdSkill
