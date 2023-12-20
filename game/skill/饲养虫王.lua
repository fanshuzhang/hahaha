---@class sycwSkill 饲养虫王

local sycwSkill = {}
function sycwSkill.onSetVar(player, varName, varValue)
    if varName == VarCfg["献祭蛊虫数量"] then
        local num = Magic.BBcountEX(player, SkillIDCfg["饲养虫王"])
        if num then
            if varValue >= (50 - num * 4) then
                if lualib:GetVar(player, VarCfg["虫王数量"]) >= 2 then
                    return
                end
                local BBItem = recallmob(player, "虫王", 7, 1, 1)
                if BBItem then
                    changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 60)
                    changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 60)
                    changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 60)
                    changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 60)
                    changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 3, 60)
                    --攻击
                    local num = (100 + 5 * getskillinfo(player, SkillIDCfg["饲养虫王"], 2)) / 100
                    local attUp, attLow = Magic.GetPlayerAtt(player)
                    changemobability(player, BBItem, 5, '=', attLow * num, 60)
                    changemobability(player, BBItem, 6, '=', attUp * num, 60)
                    -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 60)
                    -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 60)
                    -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 60)
                    -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 60)
                    --设置满状态
                    setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
                    --地狱鬼爪强化
                    if lualib:GetVar(player, VarCfg["角色职业"]) == 7 then
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
                                Message:SendClawmsg(player, "地狱鬼爪：虫王获得元素属性提升")
                            end
                        end
                    end
                    --数量
                    lualib:SetVar(player, VarCfg["虫王数量"], lualib:GetVar(player, VarCfg["虫王数量"]) + 1)
                    lualib:SetVar(player, VarCfg["献祭蛊虫数量"], 0)
                end
            end
        end
    end
end

--宝宝死亡
function sycwSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "虫王" then
        lualib:SetVar(player, VarCfg["虫王数量"], lualib:GetVar(player, VarCfg["虫王数量"]) - 1)
    end
end

--游戏事件
GameEvent.add(EventCfg.onSetVar, sycwSkill.onSetVar, sycwSkill)
GameEvent.add(EventCfg.onSelfKillSlave, sycwSkill.onSelfKillSlave, sycwSkill)
return sycwSkill
