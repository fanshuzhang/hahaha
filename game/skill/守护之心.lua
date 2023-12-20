---@class shzxSkill �ػ�֮��
local shzxSkill = {}
--��Ӽ��ܴ���
function shzxSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["�ػ�֮��"] then
        local level = Magic.BBcountEX(player, SkillIDCfg["�ػ�֮��"])
        local att, attMagic = 1, 1
        for i = 1, level do --�����ж�
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        lualib:SetInt(player, "�ػ�֮��_��", att)
        lualib:SetInt(player, "�ػ�֮��_ħ", attMagic)
        lualib:SetInt(player, "�ػ�֮��_�ȼ�", lualib:Level(player))
        lualib:SetValue(player, 12, ((lualib:Level(player) * attMagic) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((lualib:Level(player) * att) + lualib:GetValue(player, 10)), 65535)
        Message:NoticeMsg(player, 250, 255, "�ػ�֮�Ŀ����ɹ�", "self")
    end
end

--ɾ������
function shzxSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["�ػ�֮��"] then
        local att, attMagic, mylevel = lualib:GetInt(player, "�ػ�֮��_��"), lualib:GetInt(player, "�ػ�֮��_ħ"),
            lualib:GetInt(player, "�ػ�֮��_�ȼ�")
        lualib:SetValue(player, 12, (lualib:GetValue(player, 12) - (mylevel * attMagic)), 65535)
        lualib:SetValue(player, 10, (lualib:GetValue(player, 10) - (mylevel * att)), 65535)
        Message:NoticeMsg(player, 249, 255, "�ػ�֮����ʧЧ", "self")
        lualib:SetInt(player, "�ػ�֮��_��", 0)
        lualib:SetInt(player, "�ػ�֮��_ħ", 0)
        lualib:SetInt(player, "�ػ�֮��_�ȼ�", 0)
    end
end

--��¼����
function shzxSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["�ػ�֮��"]) then
        local level = Magic.BBcountEX(player, SkillIDCfg["�ػ�֮��"])
        local att, attMagic = 1, 1
        for i = 1, level do --�����ж�
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        lualib:SetInt(player, "�ػ�֮��_��", att)
        lualib:SetInt(player, "�ػ�֮��_ħ", attMagic)
        lualib:SetInt(player, "�ػ�֮��_�ȼ�", lualib:Level(player))
        lualib:SetValue(player, 12, ((lualib:Level(player) * attMagic) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((lualib:Level(player) * att) + lualib:GetValue(player, 10)), 65535)
        Message:NoticeMsg(player, 250, 255, "�ػ�֮�Ŀ����ɹ�", "self")
    end
end

--����ǿ�����ܴ���
function shzxSkill.onSetSkillInfo(player, skillID, flag, point)
    if skillID == SkillIDCfg["�ػ�֮��"] then
        local att, attMagic = 1, 1
        for i = 1, point do --�����ж�
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        local _att, _attMagic, mylevel = lualib:GetInt(player, "�ػ�֮��_��"), lualib:GetInt(player, "�ػ�֮��_ħ"),
            lualib:GetInt(player, "�ػ�֮��_�ȼ�")
        lualib:SetValue(player, 12, ((mylevel * (att - _attMagic)) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((mylevel * (att - _att)) + lualib:GetValue(player, 10)), 65535)
        lualib:SetInt(player, "�ػ�֮��_��", att)
        lualib:SetInt(player, "�ػ�֮��_ħ", attMagic)
        lualib:SetInt(player, "�ػ�֮��_�ȼ�", lualib:Level(player))
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onAddSkill, shzxSkill.onAddSkill, shzxSkill)
GameEvent.add(EventCfg.onDelSkill, shzxSkill.onDelSkill, shzxSkill)
GameEvent.add(EventCfg.onLogin, shzxSkill.onLogin, shzxSkill)
GameEvent.add(EventCfg.onSetSkillInfo, shzxSkill.onSetSkillInfo, shzxSkill)
return shzxSkill
