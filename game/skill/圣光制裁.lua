---@class sgzcSkill ʥ���Ʋ�
local sgzcSkill = {}
-- --ʥ���Ʋ�

function sgzcSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicID == SkillIDCfg["ʥ���Ʋ�"] and maigicName == "ʥ���Ʋ�" then
        if ismon(targetObject) then
            if getbaseinfo(targetObject, 9) / getbaseinfo(targetObject, 10) <= 0.1 then
                killmonbyobj(player, targetObject, true, true, true)
                Message:SendSkillmsg(player, "ʥ���Ʋ�", "����ʥ���Ʋã�˲����ɱ����!")
            end
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onBeginmagic, sgzcSkill.onBeginmagic, sgzcSkill)
return sgzcSkill
