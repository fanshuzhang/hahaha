---@class chtbSkill 召唤天兵
local chtbSkill = {}

chtbSkill.bbName = {
    [0] = "一级天兵",
    [1] = "一级天兵",
    [2] = "一级天兵",
    [3] = "二级天兵",
    [4] = "二级天兵",
    [5] = "二级天兵",
    [6] = "三级天兵",
    [7] = "三级天兵",
    [8] = "三级天兵",
    [9] = "四级天兵",
}

function magselffunc1011(player)
    --召唤天兵
    if lualib:GetInt(player, "召唤天兵") >= 1 then
        Message:Msg9(player, "只能召唤一位天兵！")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["召唤天兵"])
    if level then
        local BBItem = recallmob(player, chtbSkill.bbName[level], 7, 1440, 1)
        if BBItem then
            changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 86400)
            changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 86400)
            changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 86400)
            changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 86400)
            changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 4, 86400)
            --攻击
            local num = (100 + 5 * level) / 100
            local attUp, attLow = Magic.GetPlayerAtt(player)
            changemobability(player, BBItem, 5, '=', attLow * num, 86400)
            changemobability(player, BBItem, 6, '=', attUp * num, 86400)
            -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 86400)
            -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 86400)
            -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 86400)
            -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 86400)
            --设置满状态
            setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
            --地狱鬼爪强化
            if lualib:GetVar(player, VarCfg["角色职业"]) == 8 then
                local ClawCount = Magic.ClawCount(player)
                if ClawCount >= 1 then
                    local qhatt = 0.25
                    if ClawCount >= 2 then qhatt = 0.45 end
                    if ClawCount >= 3 then qhatt = 0.8 end
                    --添加元素属性
                    if addbuff(BBItem, 50004, 65535, 1, player, {
                            [21] = getbaseinfo(player, 51, 21) * qhatt,
                            [25] = getbaseinfo(player, 51, 25) * qhatt,
                            [28] = getbaseinfo(player, 51, 28) * qhatt,
                        }) then
                        Message:SendClawmsg(player, "地狱鬼爪：天兵获得元素属性提升")
                    end
                end
            end
            --数量
            lualib:SetInt(player, "召唤天兵", 1)
        end
    end
end

--宝宝死亡触发
function chtbSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "一级天兵" or getbaseinfo(bbobj, 1, 1) == "二级天兵" or getbaseinfo(bbobj, 1, 1) == "三级天兵" or getbaseinfo(bbobj, 1, 1) == "四级天兵" then
        lualib:SetInt(player, "召唤天兵", 0)
    end
end

--游戏事件
GameEvent.add(EventCfg.onSelfKillSlave, chtbSkill.onSelfKillSlave, chtbSkill)
return chtbSkill
