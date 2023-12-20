---@class sqsSkill 地狱鬼爪-圣骑士
local sqsSkill = {}
--圣骑士等级改变
function sqsSkill.onChangeClawLevel(player, Job, Level, qhLevel)

end

function ontimer105(player)
    if lualib:GetVar(player, VarCfg["角色职业"]) ~= 3 then --是否圣骑士职业
        setofftimer(player, 105)
        return
    end
    if Magic.ClawCount(player) < 1 then
        setofftimer(player, 105)
        return
    end
    local range, effectID = 1, 53411
    if Magic.ClawCount(player) >= 3 then
        range = 3
        effectID = 53403
    end
    lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), range, lualib:GetBaseInfo(player, 20), 0, 0, 0, 0)
    playeffect(player, effectID, 0, 0, 1, 0, 0)
    -- Message:SendClawmsg(player,"地狱鬼爪:伤害靠近的敌人")
end

--穿装备
function sqsSkill.onTakeOnEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["角色职业"]) == 3 then
            local level = Magic.ClawCount(player)
            if level >= 1 then
                setofftimer(player, 105)
                setontimer(player, 105, 2)
            end
        end
    end
end

--脱装备
function sqsSkill.onTakeOffEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["角色职业"]) == 3 then
            setofftimer(player, 105)
            return
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onTakeOnEx, sqsSkill.onTakeOnEx, sqsSkill)  --穿装备
GameEvent.add(EventCfg.onTakeOnEx, sqsSkill.onTakeOffEx, sqsSkill) --脱装备
GameEvent.add(EventCfg.onChangeClawLevel, sqsSkill.onChangeClawLevel, sqsSkill)
return sqsSkill
