---@class qszqSkill ��ʿ֮��
local qszqSkill = {}
--��Ӽ��ܴ���
function qszqSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["��ʿ֮��"] then
        local level = Magic.BBcountEX(player, SkillIDCfg["��ʿ֮��"])
        lualib:SetInt(player, "��ʿ֮��", level)
        lualib:SetValue(player, 1, ((lualib:Level(player) * (5 + level)) + lualib:GetValue(player, 1)), 65535)
        Message:NoticeMsg(player, 250, 255, "��ʿ֮�������ɹ�", "self")
    end
end

--ɾ������
function qszqSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["��ʿ֮��"] then
        local level = lualib:GetInt(player, "��ʿ֮��")
        lualib:SetValue(player, 30, (lualib:GetValue(player, 30) - (lualib:Level(player) * (5 + level))), 65535)
        Message:NoticeMsg(player, 249, 255, "��ʿ֮����ʧЧ", "self")
        lualib:SetInt(player, "��ʿ֮��", 0)
    end
end

--��¼����
function qszqSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["��ʿ֮��"]) then
        local level = Magic.BBcountEX(player, SkillIDCfg["��ʿ֮��"])
        lualib:SetInt(player, "��ʿ֮��", level)
        lualib:SetValue(player, 1, ((lualib:Level(player) * (5 + level)) + lualib:GetValue(player, 1)), 65535)
        Message:NoticeMsg(player, 250, 255, "��ʿ֮�������ɹ�", "self")
    end
end

--����ǿ�����ܴ���
function qszqSkill.onSetSkillInfo(player, skillID, flag, point)
    if skillID == SkillIDCfg["��ʿ֮��"] then
        local level = lualib:GetInt(player, "��ʿ֮��")
        lualib:SetValue(player, 1, ((lualib:Level(player) * (point - level)) + lualib:GetValue(player, 1)), 65535)
        lualib:SetInt(player, "��ʿ֮��", point)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onAddSkill, qszqSkill.onAddSkill, qszqSkill)
GameEvent.add(EventCfg.onDelSkill, qszqSkill.onDelSkill, qszqSkill)
GameEvent.add(EventCfg.onLogin, qszqSkill.onLogin, qszqSkill)
GameEvent.add(EventCfg.onSetSkillInfo, qszqSkill.onSetSkillInfo, qszqSkill)
return qszqSkill
