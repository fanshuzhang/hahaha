---@class xlhjSkill 心灵幻境
local xlhjSkill = {}
function xlhjSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["心灵幻境"] and maigicName == "心灵幻境" then
        local level = Magic.BBcountEX(player, SkillIDCfg["心灵幻境"])
        lualib:SetValue(targetObject, 4,  0-getbaseinfo(player, 20) * (10 + level * 2) / 100, 8)
        lualib:SetValue(targetObject, 6,  0-getbaseinfo(player, 22) * (10 + level * 2) / 100, 8)
        lualib:SetValue(targetObject, 8,  0-getbaseinfo(player, 24) * (10 + level * 2) / 100, 8)
    end
end

--游戏事件
GameEvent.add(EventCfg.onBeginmagic, xlhjSkill.onBeginmagic, xlhjSkill)
return xlhjSkill
