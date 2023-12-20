---@class slzsSkill 死灵之手
local slzsSkill = {}
--玩家攻击后
-- function slzsSkill.onMagicAttack(player, victim, attacker, skillId)
--     --死灵之手附加减速效果
--     if skillId == SkillIDCfg["死灵之手"] then
--         rangeharm(player, getbaseinfo(player, 4), getbaseinfo(player, 5), 3, getbaseinfo(player, 22), 7, 10, 0, 0)
--     end
-- end

--游戏事件
-- GameEvent.add(EventCfg.onMagicAttack, slzsSkill.onMagicAttack, slzsSkill)
function magselffunc1009(player)
    rangeharm(player, getbaseinfo(player, 4), getbaseinfo(player, 5), 3, getbaseinfo(player, 22), 7, 10, 0, 0)
end

return slzsSkill
