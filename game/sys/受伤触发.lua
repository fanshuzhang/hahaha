-- 玩家受击前
function struckdamage(player, attacker, victim, skillId, damage)
    --大魔导师地狱鬼爪强化第二重
    if hasbuff(player, 50005) then
        damage = damage - damage * 0.2
    end
    --盾牌反击
    local level = Magic.BBcountEX(player, SkillIDCfg["盾牌反击"])
    if level then
        local shanghai = damage * (0.1 + 0.02 * level)
        local myXY = { x = lualib:X(player), y = lualib:Y(player) }
        if math.random(100) <= (20 + level * 2) or true then
            rangeharm(player, myXY.x, myXY.y, 1, shanghai, 6, shanghai, 0, 0, 20119)
            --是否远程距离
            if lualib:Distance(myXY, { x = lualib:X(attacker), y = lualib:Y(attacker) }) > 1 then
                if lualib:IsPlayer(attacker) then
                    lualib:SetHp(attacker, '-', shanghai, 1, 0.05, player)
                elseif lualib:IsMonster(attacker) then
                    lualib:SetHp(attacker, '-', shanghai * 2, 1, 0.05, player)
                end
                playeffect(attacker, 20119, 0, 0, 1, 0, 0)
            end
            --是否怪物
            local monTb = getmapmon(getbaseinfo(player, 3), '*', myXY.x, myXY.y, 1)
            for _, value in pairs(monTb) do
                lualib:SetHp(value, '-', shanghai, 1, 0.05, player)
                playeffect(attacker, 20119, 0, 0, 1, 0, 0)
            end
            -- Message:Msg9(player, "[盾牌反击]:反弹部分伤害")
        end
    end
    return damage
end

-- 宝宝受击前
function struckdamagebb(player, attacker, victim, skillId, damage)
    return damage
end

-- 玩家受魔法攻击后
function magicstruck(player, attacker, victim, skillId)
    GameEvent.push(EventCfg.onMagicStruck, player, attacker, victim, skillId)
end

-- 玩家受物理攻击后
function struck(player, attacker, victim, skillId)
    lualib:SetInt(player, "脱战CD", 3)
    GameEvent.push(EventCfg.onStruck, player, attacker, victim, skillId)
end

-- 宝宝受魔法攻击后
function magicstruckpet(player, attacker, victim, skillId)

end

-- 宝宝受物理攻击后
function struckpet(player, attacker, victim, skillId)

end

--宝宝死亡触发
function selfkillslave(player, bbObj)
    GameEvent.push(EventCfg.onSelfKillSlave, player, bbObj)
end
