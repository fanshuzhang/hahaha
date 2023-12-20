local castleMonster = {
    ["城门"] = 1,
    ["左城墙"] = 1,
    ["中城墙"] = 1,
    ["右城墙"] = 1,
}
--攻击触发
-- 玩家攻击前
function attackdamage(player, victim, attacker, skillId, damage)
    --烈火剑法提升
    if lualib:GetFlagStatus(player, PlayerVarCfg["烈火剑法"]) == 1 then
        damage = damage * (1 + 0.1)
        lualib:SetFlagStatus(player, PlayerVarCfg["烈火剑法"], 0)
    end
    --开天剑法提升
    if lualib:GetFlagStatus(player, PlayerVarCfg["开天剑法"]) == 1 then
        damage = damage * (1 + 0.2)
        lualib:SetFlagStatus(player, PlayerVarCfg["开天剑法"], 0)
    end
    --逐日剑法提升
    if lualib:GetFlagStatus(player, PlayerVarCfg["逐日剑法"]) == 1 then
        damage = damage * (1 + 0.3)
        lualib:SetFlagStatus(player, PlayerVarCfg["逐日剑法"], 0)
    end
    --大魔导师地狱鬼爪强化第二重
    if lualib:GetVar(player, VarCfg["角色职业"]) == 6 and Magic.ClawCount(player) >= 1 then
        local num, ratio = 5, 1.2
        if Magic.ClawCount(player) >= 3 then
            num, ratio = 4, 1.5
        end
        if lualib:GetInt(player, "魔法攻击次数") >= num then
            damage = damage * ratio
            lualib:SetInt(player, "魔法攻击次数", 0)
            Message:SendClawmsg(player, "地狱鬼爪:伤害提升！")
        end
    end
    return damage
end

-- 宝宝攻击前
function attackdamagebb(player, victim, attacker, skillId, damage)
    return damage
end

-- 玩家魔法攻击后
function magicattack(player, victim, attacker, skillId)
    if not victim then
        return
    end
    --刀刀切割
    if ismon(victim) then
        local qgNum = getbaseinfo(player, 51, 207)
        lualib:SetHp(victim, '-', qgNum, 11, 0.05, attacker)
    end
    --大魔导师地狱鬼爪强化第二重
    if lualib:GetVar(player, VarCfg["角色职业"]) == 6 and Magic.ClawCount(player) >= 1 then
        lualib:SetInt(player, "魔法攻击次数", lualib:GetInt(player, "魔法攻击次数") + 1)
    end

    GameEvent.push(EventCfg.onMagicAttack, player, victim, attacker, skillId)
end

-- 玩家攻击后
function attack(player, victim, attacker, skillId)
    if not victim then
        return
    end
    --刀刀切割
    if ismon(victim) then
        local qgNum = getbaseinfo(player, 51, 207)
        lualib:SetHp(victim, '-', qgNum, 11, 0.05, attacker)
    end
    GameEvent.push(EventCfg.onAttack, player, victim, attacker, skillId)
end

-- 宝宝魔法攻击后
function magicattackpet(player, victim, attacker, skillId)

end

-- 宝宝攻击后
function attackpet(player, victim, attacker, skillId)

end
