---@class mfyqSkill ħ��ԴȪ
local mfyqSkill = {}
function mfyqSkill.onKillMon(player, monster, mobId, mapId)
    --ħ��ԴȪ
    if Magic.BBcountEX(player, SkillIDCfg["ħ��ԴȪ"]) then
        humanmp(player, '+', Magic.BBcountEX(player, SkillIDCfg["ħ��ԴȪ"]) * 10 + 30)
        Message:SendSkillmsg(player,"ħ��ԴȪ","�ظ�ħ��ֵ")
    end
end
-----��Ϸ�¼�
GameEvent.add(EventCfg.onKillMon, mfyqSkill.onKillMon, mfyqSkill)
return mfyqSkill
