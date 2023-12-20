local castleMonster = {
    ["����"] = 1,
    ["���ǽ"] = 1,
    ["�г�ǽ"] = 1,
    ["�ҳ�ǽ"] = 1,
}
--��������
-- ��ҹ���ǰ
function attackdamage(player, victim, attacker, skillId, damage)
    --�һ𽣷�����
    if lualib:GetFlagStatus(player, PlayerVarCfg["�һ𽣷�"]) == 1 then
        damage = damage * (1 + 0.1)
        lualib:SetFlagStatus(player, PlayerVarCfg["�һ𽣷�"], 0)
    end
    --���콣������
    if lualib:GetFlagStatus(player, PlayerVarCfg["���콣��"]) == 1 then
        damage = damage * (1 + 0.2)
        lualib:SetFlagStatus(player, PlayerVarCfg["���콣��"], 0)
    end
    --���ս�������
    if lualib:GetFlagStatus(player, PlayerVarCfg["���ս���"]) == 1 then
        damage = damage * (1 + 0.3)
        lualib:SetFlagStatus(player, PlayerVarCfg["���ս���"], 0)
    end
    --��ħ��ʦ������צǿ���ڶ���
    if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 6 and Magic.ClawCount(player) >= 1 then
        local num, ratio = 5, 1.2
        if Magic.ClawCount(player) >= 3 then
            num, ratio = 4, 1.5
        end
        if lualib:GetInt(player, "ħ����������") >= num then
            damage = damage * ratio
            lualib:SetInt(player, "ħ����������", 0)
            Message:SendClawmsg(player, "������צ:�˺�������")
        end
    end
    return damage
end

-- ��������ǰ
function attackdamagebb(player, victim, attacker, skillId, damage)
    return damage
end

-- ���ħ��������
function magicattack(player, victim, attacker, skillId)
    if not victim then
        return
    end
    --�����и�
    if ismon(victim) then
        local qgNum = getbaseinfo(player, 51, 207)
        lualib:SetHp(victim, '-', qgNum, 11, 0.05, attacker)
    end
    --��ħ��ʦ������צǿ���ڶ���
    if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 6 and Magic.ClawCount(player) >= 1 then
        lualib:SetInt(player, "ħ����������", lualib:GetInt(player, "ħ����������") + 1)
    end

    GameEvent.push(EventCfg.onMagicAttack, player, victim, attacker, skillId)
end

-- ��ҹ�����
function attack(player, victim, attacker, skillId)
    if not victim then
        return
    end
    --�����и�
    if ismon(victim) then
        local qgNum = getbaseinfo(player, 51, 207)
        lualib:SetHp(victim, '-', qgNum, 11, 0.05, attacker)
    end
    GameEvent.push(EventCfg.onAttack, player, victim, attacker, skillId)
end

-- ����ħ��������
function magicattackpet(player, victim, attacker, skillId)

end

-- ����������
function attackpet(player, victim, attacker, skillId)

end
