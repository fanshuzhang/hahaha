---@class slzsSkill ����֮��
local slzsSkill = {}
--��ҹ�����
-- function slzsSkill.onMagicAttack(player, victim, attacker, skillId)
--     --����֮�ָ��Ӽ���Ч��
--     if skillId == SkillIDCfg["����֮��"] then
--         rangeharm(player, getbaseinfo(player, 4), getbaseinfo(player, 5), 3, getbaseinfo(player, 22), 7, 10, 0, 0)
--     end
-- end

--��Ϸ�¼�
-- GameEvent.add(EventCfg.onMagicAttack, slzsSkill.onMagicAttack, slzsSkill)
function magselffunc1009(player)
    rangeharm(player, getbaseinfo(player, 4), getbaseinfo(player, 5), 3, getbaseinfo(player, 22), 7, 10, 0, 0)
end

return slzsSkill
