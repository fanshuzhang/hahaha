---@class dygzqhSkill 地狱鬼爪强化
local gwzSkill = {}
--每10秒执行--鬼武者
function ontimer104(player)
    if lualib:GetVar(player, EventCfg["角色职业"]) ~= 2 then --是否鬼武者职业
        setofftimer(player, 104)
        return
    end
    if Magic.ClawCount(player) < 1 then
        setofftimer(player, 104)
        return
    end
    local time = 2
    if Magic.ClawCount(player) >= 2 then
        time = 6
    end
    lualib:ChangeMode(player, 2, time)
    Message:SendClawmsg(player, "地狱鬼爪:获得隐身能力")
end

function gwzSkill.onChangeClawLevel(player, Job, Level, qhLevel)

end

--穿装备
function gwzSkill.onTakeOnEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["角色职业"]) == 2 and Magic.ClawCount(player) >= 1 then
            setofftimer(player, 104)
            setontimer(player, 104, 10)
            return
        end
    end
end

--脱装备
function gwzSkill.onTakeOffEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
            setofftimer(player, 104)
            return
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onTakeOnEx, gwzSkill.onTakeOnEx, gwzSkill)  --穿装备
GameEvent.add(EventCfg.onTakeOnEx, gwzSkill.onTakeOffEx, gwzSkill) --脱装备
GameEvent.add(EventCfg.onChangeClawLevel, gwzSkill.onChangeClawLevel, gwzSkill)
return gwzSkill
