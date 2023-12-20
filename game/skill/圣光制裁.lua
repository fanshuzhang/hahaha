---@class sgzcSkill 圣光制裁
local sgzcSkill = {}
-- --圣光制裁

function sgzcSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["圣光制裁"] and maigicName == "圣光制裁" then
        if ismon(targetObject) then
            if getbaseinfo(targetObject, 9) / getbaseinfo(targetObject, 10) <= 0.1 then
                killmonbyobj(player, targetObject, true, true, true)
                Message:SendSkillmsg(player, "圣光制裁", "触发圣光制裁，瞬间秒杀怪物!")
            end
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onBeginmagic, sgzcSkill.onBeginmagic, sgzcSkill)
return sgzcSkill
