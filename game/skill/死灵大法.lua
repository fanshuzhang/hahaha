---@class sldfSkill 死灵大法
local sldfSkill = {}
--释放技能前触发
function sldfSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicName == "死灵大法" then
        if lualib:GetVar(player, VarCfg["亡灵大军数量"]) < 5 then
            Message:Msg9(player, "拥有的[死侍]数量不足以献祭")
            return false
        end
        if lualib:GetVar(player, VarCfg["死灵大法数量"]) >= 2 then
            Message:Msg9(player, "可召唤的数量已达上限！")
        end
        callscriptex(player, "KillCallMob", "死侍", 5, 1)
        local time = 10
        if getskillinfo(player, SkillIDCfg["亡灵祭坛"], 2) then --让亡灵大军永久存在
            time = 1440
        end
        local BBItem = recallmob(player, "死灵大法师", 7, time, 1)
        changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), time * 60)
        changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), time * 60)
        changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), time * 60)
        changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), time * 60)
        changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 2, time * 60)
        --攻击
        local num = (80 + 5 * getskillinfo(player, SkillIDCfg["亡灵大军"], 2)) / 100
        local attUp, attLow = Magic.GetPlayerAtt(player)
        changemobability(player, BBItem, 5, '=', attLow * num, time * 60)
        changemobability(player, BBItem, 6, '=', attUp * num, time * 60)
        -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, time * 60)
        -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, time * 60)
        -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, time * 60)
        -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, time * 60)
        --设置满状态
        setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
        --死灵大法数量
        lualib:SetVar(player, VarCfg["死灵大法数量"], lualib:GetVar(player, VarCfg["死灵大法数量"]) + 1)
    end
end

--游戏事件
GameEvent.add(EventCfg.onBeginmagic, sldfSkill.onBeginmagic, sldfSkill)
return sldfSkill
