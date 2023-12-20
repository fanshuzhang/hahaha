---@class wldjSkill 亡灵大军
local wldjSkill = {}
--玩家攻击后
function wldjSkill.onAttack(player, victim, attacker, skillId)
    --亡灵大军
    if getskillinfo(player, SkillIDCfg["亡灵大军"], 2) then
        if getbaseinfo(victim, 0) then
            if lualib:GetVar(player, VarCfg["亡灵大军数量"]) < 10 then
                local time = 10
                if getskillinfo(player, SkillIDCfg["亡灵祭坛"], 2) then --让亡灵大军永久存在
                    time = 1440
                end
                local BBItem = recallmob(player, "死侍", 7, time, 1)
                changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), time * 60)
                changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), time * 60)
                changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), time * 60)
                changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), time * 60)
                changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10), time * 60)
                --攻击
                local num = (60 + 3 * getskillinfo(player, SkillIDCfg["亡灵大军"], 2)) / 100
                local attUP, attLow = Magic.GetPlayerAtt(player)
                changemobability(player, BBItem, 5, '=', attLow * num, time * 60)
                changemobability(player, BBItem, 6, '=', attUP * num, time * 60)
                -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, time * 60)
                -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, time * 60)
                -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, time * 60)
                -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, time * 60)
                --设置满状态
                setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
                --地狱鬼爪强化
                if lualib:GetVar(player, VarCfg["角色职业"]) == 5 then
                    local ClawCount = Magic.ClawCount(player)
                    if ClawCount >= 1 then
                        local qhatt = 0.2
                        if ClawCount >= 2 then qhatt = 0.4 end
                        if ClawCount >= 3 then qhatt = 1 end
                        --添加元素属性
                        if addbuff(BBItem, 50004, 65535, 1, player, {
                                [21] = getbaseinfo(player, 51, 21) * qhatt,
                                [25] = getbaseinfo(player, 51, 25) * qhatt,
                                [28] = getbaseinfo(player, 51, 28) * qhatt,
                            }) then
                            Message:SendClawmsg(player, "地狱鬼爪：亡灵大军获得元素属性提升")
                        end
                    end
                end
                --亡灵大军数量
                lualib:SetVar(player, VarCfg["亡灵大军数量"], lualib:GetVar(player, VarCfg["亡灵大军数量"]) + 1)
            end
        end
    end
end

function wldjSkill.onMagicAttack(player, victim, attacker, skillId)
    --亡灵大军
    if getskillinfo(player, SkillIDCfg["亡灵大军"], 2) then
        if getbaseinfo(victim, 0) then
            if lualib:GetVar(player, VarCfg["亡灵大军数量"]) < 10 then
                local time = 10
                if getskillinfo(player, SkillIDCfg["亡灵祭坛"], 2) then --让亡灵大军永久存在
                    time = 1440
                end
                local BBItem = recallmob(player, "死侍", 7, time, 1)
                changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), time * 60)
                changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), time * 60)
                changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), time * 60)
                changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), time * 60)
                changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10), time * 60)
                --攻击
                local num = (60 + 3 * getskillinfo(player, SkillIDCfg["亡灵大军"], 2)) / 100
                local attUP, attLow = Magic.GetPlayerAtt(player)
                changemobability(player, BBItem, 5, '=', attLow * num, time * 60)
                changemobability(player, BBItem, 6, '=', attUP * num, time * 60)
                -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, time * 60)
                -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, time * 60)
                -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, time * 60)
                -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, time * 60)
                --设置满状态
                setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
                --亡灵大军数量
                lualib:SetVar(player, VarCfg["亡灵大军数量"], lualib:GetVar(player, VarCfg["亡灵大军数量"]) + 1)
            end
        end
    end
end

--宝宝死亡
function wldjSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbObj, 1, 1) == "死侍" then
        if lualib:GetVar(player, VarCfg["亡灵大军数量"]) > 0 then
            lualib:SetVar(player, VarCfg["亡灵大军数量"], lualib:GetVar(player, VarCfg["亡灵大军数量"]) - 1)
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onAttack, wldjSkill.onAttack, wldjSkill)
GameEvent.add(EventCfg.onMagicAttack, wldjSkill.onMagicAttack, wldjSkill)
GameEvent.add(EventCfg.onSelfKillSlave, wldjSkill.onSelfKillSlave, wldjSkill)
return wldjSkill
