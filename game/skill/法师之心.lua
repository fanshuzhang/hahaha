---@class fszxSkill ��ʦ֮��
local fszxSkill = {}
--��Ӽ���ʱ
function fszxSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["��ʦ֮��"] then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        lualib:SetInt(player, "��ʦ֮��", num)
        lualib:SetValue(player, 6, lualib:GetValue(player, 6) + num, 65535)
    end
end

--ɾ������ʱ
function fszxSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["��ʦ֮��"] then
        local num = lualib:GetInt(player, "��ʦ֮��")
        lualib:SetValue(player, 6, lualib:GetValue(player, 6) - num, 65535)
        lualib:SetInt(player, "��ʦ֮��", 0)
    end
end

--���Ա仯ʱ
function fszxSkill.onSendability(player)
    if Magic.BBcountEX(player, SkillIDCfg["��ʦ֮��"]) then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        local _num = num - lualib:GetInt(player, "��ʦ֮��")
        if _num ~= 0 then
            lualib:SetInt(player, "��ʦ֮��", num)
            lualib:SetValue(player, 6, lualib:GetValue(player, 6) + _num, 65535)
        end
    end
end

--��¼
function fszxSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["��ʦ֮��"]) then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        local _num = num - lualib:GetInt(player, "��ʦ֮��")
        if _num ~= 0 then
            lualib:SetInt(player, "��ʦ֮��", num)
            lualib:SetValue(player, 6, lualib:GetValue(player, 6) + _num, 65535)
        end
    end
end

---��Ϸ�¼�
GameEvent.add(EventCfg.onAddSkill, fszxSkill.onAddSkill, fszxSkill)
GameEvent.add(EventCfg.onDelSkill, fszxSkill.onDelSkill, fszxSkill)
GameEvent.add(EventCfg.onSendability, fszxSkill.onSendability, fszxSkill)
GameEvent.add(EventCfg.onLogin, fszxSkill.onLogin, fszxSkill)
return fszxSkill
