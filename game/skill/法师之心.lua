---@class fszxSkill 法师之心
local fszxSkill = {}
--添加技能时
function fszxSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["法师之心"] then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        lualib:SetInt(player, "法师之心", num)
        lualib:SetValue(player, 6, lualib:GetValue(player, 6) + num, 65535)
    end
end

--删除技能时
function fszxSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["法师之心"] then
        local num = lualib:GetInt(player, "法师之心")
        lualib:SetValue(player, 6, lualib:GetValue(player, 6) - num, 65535)
        lualib:SetInt(player, "法师之心", 0)
    end
end

--属性变化时
function fszxSkill.onSendability(player)
    if Magic.BBcountEX(player, SkillIDCfg["法师之心"]) then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        local _num = num - lualib:GetInt(player, "法师之心")
        if _num ~= 0 then
            lualib:SetInt(player, "法师之心", num)
            lualib:SetValue(player, 6, lualib:GetValue(player, 6) + _num, 65535)
        end
    end
end

--登录
function fszxSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["法师之心"]) then
        local num = math.modf(getbaseinfo(player, 12) / 100)
        local _num = num - lualib:GetInt(player, "法师之心")
        if _num ~= 0 then
            lualib:SetInt(player, "法师之心", num)
            lualib:SetValue(player, 6, lualib:GetValue(player, 6) + _num, 65535)
        end
    end
end

---游戏事件
GameEvent.add(EventCfg.onAddSkill, fszxSkill.onAddSkill, fszxSkill)
GameEvent.add(EventCfg.onDelSkill, fszxSkill.onDelSkill, fszxSkill)
GameEvent.add(EventCfg.onSendability, fszxSkill.onSendability, fszxSkill)
GameEvent.add(EventCfg.onLogin, fszxSkill.onLogin, fszxSkill)
return fszxSkill
