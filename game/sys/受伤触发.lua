-- ����ܻ�ǰ
function struckdamage(player, attacker, victim, skillId, damage)
    --��ħ��ʦ������צǿ���ڶ���
    if hasbuff(player, 50005) then
        damage = damage - damage * 0.2
    end
    --���Ʒ���
    local level = Magic.BBcountEX(player, SkillIDCfg["���Ʒ���"])
    if level then
        local shanghai = damage * (0.1 + 0.02 * level)
        local myXY = { x = lualib:X(player), y = lualib:Y(player) }
        if math.random(100) <= (20 + level * 2) or true then
            rangeharm(player, myXY.x, myXY.y, 1, shanghai, 6, shanghai, 0, 0, 20119)
            --�Ƿ�Զ�̾���
            if lualib:Distance(myXY, { x = lualib:X(attacker), y = lualib:Y(attacker) }) > 1 then
                if lualib:IsPlayer(attacker) then
                    lualib:SetHp(attacker, '-', shanghai, 1, 0.05, player)
                elseif lualib:IsMonster(attacker) then
                    lualib:SetHp(attacker, '-', shanghai * 2, 1, 0.05, player)
                end
                playeffect(attacker, 20119, 0, 0, 1, 0, 0)
            end
            --�Ƿ����
            local monTb = getmapmon(getbaseinfo(player, 3), '*', myXY.x, myXY.y, 1)
            for _, value in pairs(monTb) do
                lualib:SetHp(value, '-', shanghai, 1, 0.05, player)
                playeffect(attacker, 20119, 0, 0, 1, 0, 0)
            end
            -- Message:Msg9(player, "[���Ʒ���]:���������˺�")
        end
    end
    return damage
end

-- �����ܻ�ǰ
function struckdamagebb(player, attacker, victim, skillId, damage)
    return damage
end

-- �����ħ��������
function magicstruck(player, attacker, victim, skillId)
    GameEvent.push(EventCfg.onMagicStruck, player, attacker, victim, skillId)
end

-- �������������
function struck(player, attacker, victim, skillId)
    lualib:SetInt(player, "��սCD", 3)
    GameEvent.push(EventCfg.onStruck, player, attacker, victim, skillId)
end

-- ������ħ��������
function magicstruckpet(player, attacker, victim, skillId)

end

-- ��������������
function struckpet(player, attacker, victim, skillId)

end

--������������
function selfkillslave(player, bbObj)
    GameEvent.push(EventCfg.onSelfKillSlave, player, bbObj)
end
