---@class mfyqSkill 魔法源泉
local mfyqSkill = {}
function mfyqSkill.onKillMon(player, monster, mobId, mapId)
    --魔法源泉
    if Magic.BBcountEX(player, SkillIDCfg["魔法源泉"]) then
        humanmp(player, '+', Magic.BBcountEX(player, SkillIDCfg["魔法源泉"]) * 10 + 30)
        Message:SendSkillmsg(player,"魔法源泉","回复魔法值")
    end
end
-----游戏事件
GameEvent.add(EventCfg.onKillMon, mfyqSkill.onKillMon, mfyqSkill)
return mfyqSkill
