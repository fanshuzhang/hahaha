---@class qszqSkill 骑士之躯
local qszqSkill = {}
--添加技能触发
function qszqSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["骑士之躯"] then
        local level = Magic.BBcountEX(player, SkillIDCfg["骑士之躯"])
        lualib:SetInt(player, "骑士之躯", level)
        lualib:SetValue(player, 1, ((lualib:Level(player) * (5 + level)) + lualib:GetValue(player, 1)), 65535)
        Message:NoticeMsg(player, 250, 255, "骑士之躯开启成功", "self")
    end
end

--删除触发
function qszqSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["骑士之躯"] then
        local level = lualib:GetInt(player, "骑士之躯")
        lualib:SetValue(player, 30, (lualib:GetValue(player, 30) - (lualib:Level(player) * (5 + level))), 65535)
        Message:NoticeMsg(player, 249, 255, "骑士之躯已失效", "self")
        lualib:SetInt(player, "骑士之躯", 0)
    end
end

--登录触发
function qszqSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["骑士之躯"]) then
        local level = Magic.BBcountEX(player, SkillIDCfg["骑士之躯"])
        lualib:SetInt(player, "骑士之躯", level)
        lualib:SetValue(player, 1, ((lualib:Level(player) * (5 + level)) + lualib:GetValue(player, 1)), 65535)
        Message:NoticeMsg(player, 250, 255, "骑士之躯开启成功", "self")
    end
end

--设置强化技能触发
function qszqSkill.onSetSkillInfo(player, skillID, flag, point)
    if skillID == SkillIDCfg["骑士之躯"] then
        local level = lualib:GetInt(player, "骑士之躯")
        lualib:SetValue(player, 1, ((lualib:Level(player) * (point - level)) + lualib:GetValue(player, 1)), 65535)
        lualib:SetInt(player, "骑士之躯", point)
    end
end

--游戏事件
GameEvent.add(EventCfg.onAddSkill, qszqSkill.onAddSkill, qszqSkill)
GameEvent.add(EventCfg.onDelSkill, qszqSkill.onDelSkill, qszqSkill)
GameEvent.add(EventCfg.onLogin, qszqSkill.onLogin, qszqSkill)
GameEvent.add(EventCfg.onSetSkillInfo, qszqSkill.onSetSkillInfo, qszqSkill)
return qszqSkill
