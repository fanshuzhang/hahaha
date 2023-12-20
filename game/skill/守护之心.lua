---@class shzxSkill 守护之心
local shzxSkill = {}
--添加技能触发
function shzxSkill.onAddSkill(player, skill, lv)
    if skill == SkillIDCfg["守护之心"] then
        local level = Magic.BBcountEX(player, SkillIDCfg["守护之心"])
        local att, attMagic = 1, 1
        for i = 1, level do --基数判断
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        lualib:SetInt(player, "守护之心_物", att)
        lualib:SetInt(player, "守护之心_魔", attMagic)
        lualib:SetInt(player, "守护之心_等级", lualib:Level(player))
        lualib:SetValue(player, 12, ((lualib:Level(player) * attMagic) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((lualib:Level(player) * att) + lualib:GetValue(player, 10)), 65535)
        Message:NoticeMsg(player, 250, 255, "守护之心开启成功", "self")
    end
end

--删除触发
function shzxSkill.onDelSkill(player, skill)
    if skill == SkillIDCfg["守护之心"] then
        local att, attMagic, mylevel = lualib:GetInt(player, "守护之心_物"), lualib:GetInt(player, "守护之心_魔"),
            lualib:GetInt(player, "守护之心_等级")
        lualib:SetValue(player, 12, (lualib:GetValue(player, 12) - (mylevel * attMagic)), 65535)
        lualib:SetValue(player, 10, (lualib:GetValue(player, 10) - (mylevel * att)), 65535)
        Message:NoticeMsg(player, 249, 255, "守护之心已失效", "self")
        lualib:SetInt(player, "守护之心_物", 0)
        lualib:SetInt(player, "守护之心_魔", 0)
        lualib:SetInt(player, "守护之心_等级", 0)
    end
end

--登录触发
function shzxSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["守护之心"]) then
        local level = Magic.BBcountEX(player, SkillIDCfg["守护之心"])
        local att, attMagic = 1, 1
        for i = 1, level do --基数判断
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        lualib:SetInt(player, "守护之心_物", att)
        lualib:SetInt(player, "守护之心_魔", attMagic)
        lualib:SetInt(player, "守护之心_等级", lualib:Level(player))
        lualib:SetValue(player, 12, ((lualib:Level(player) * attMagic) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((lualib:Level(player) * att) + lualib:GetValue(player, 10)), 65535)
        Message:NoticeMsg(player, 250, 255, "守护之心开启成功", "self")
    end
end

--设置强化技能触发
function shzxSkill.onSetSkillInfo(player, skillID, flag, point)
    if skillID == SkillIDCfg["守护之心"] then
        local att, attMagic = 1, 1
        for i = 1, point do --基数判断
            if i % 2 == 0 then
                att = att + 1
            else
                attMagic = attMagic + 1
            end
        end
        local _att, _attMagic, mylevel = lualib:GetInt(player, "守护之心_物"), lualib:GetInt(player, "守护之心_魔"),
            lualib:GetInt(player, "守护之心_等级")
        lualib:SetValue(player, 12, ((mylevel * (att - _attMagic)) + lualib:GetValue(player, 12)), 65535)
        lualib:SetValue(player, 10, ((mylevel * (att - _att)) + lualib:GetValue(player, 10)), 65535)
        lualib:SetInt(player, "守护之心_物", att)
        lualib:SetInt(player, "守护之心_魔", attMagic)
        lualib:SetInt(player, "守护之心_等级", lualib:Level(player))
    end
end

--游戏事件
GameEvent.add(EventCfg.onAddSkill, shzxSkill.onAddSkill, shzxSkill)
GameEvent.add(EventCfg.onDelSkill, shzxSkill.onDelSkill, shzxSkill)
GameEvent.add(EventCfg.onLogin, shzxSkill.onLogin, shzxSkill)
GameEvent.add(EventCfg.onSetSkillInfo, shzxSkill.onSetSkillInfo, shzxSkill)
return shzxSkill
