---@class sqhxSkill ʥ���Ѫ

--ʥ���Ѫ
function magselffunc1013(player)
    --BUFF 50002 ʥ���Ѫ
    local level = Magic.BBcountEX(player, SkillIDCfg["ʥ���Ѫ"])
    if addbuff(player, 50002, (5 + level), 1, player, { [1] = 0 }) then
        -- Message:SendSkillmsg(player, "ʥ���Ѫ", "ÿ��ָ�1%Ѫ��")
    end
end

--����ػ�
function magselffunc1006(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["����ػ�"])
    -- changemode(player, 11, 10, 1) --�����Լ�
    if addbuff(player, 50003, 10, 1, player, { [36] = (10 + (2 * level) + lualib:GetValue(player, 36)) * 100, [37] = (10 + (2 * level) + lualib:GetValue(player, 37)) * 100 }) then
        -- Message:SendSkillmsg(player, "ʥ���Ѫ", "ÿ��ָ�1%Ѫ��")
        Message:SendSkillmsg(player, "����ػ�", "��ֹ�ƶ������������������")
    end
    -- lualib:SetValue(player, 36, (10 + (2 * level) + lualib:GetValue(player, 36)) * 100, 10)
    -- lualib:SetValue(player, 37, (10 + (2 * level) + lualib:GetValue(player, 37)) * 100, 10)
    --72023
    playeffect(player, 72023, 0, 0, 0, 0, 0)
    setontimer(player, 103, 10, 1)
end

function ontimer103(player)
    clearplayeffect(player, 72023)
end

--��˪֮��
function magselffunc114(player)
    -- local level = Magic.BBcountEX(player, SkillIDCfg["��˪֮��"])
    -- local att, job = 0, lualib:Job(player)
    -- if job == 0 then
    --     att = lualib:GetBaseInfo(player, 20)
    -- elseif job == 1 then
    --     att = lualib:GetBaseInfo(player, 22)
    -- elseif job == 2 then
    --     att = lualib:GetBaseInfo(player, 24)
    -- end
    -- rangeharm(player, lualib:X(player), lualib:Y(player), 7, att * (1 + (0.1 * level)), 0, 0, 0, 0)
end

--�־����
function magselffunc1015(player)
    local att, job = 0, lualib:Job(player)
    if job == 0 then
        att = lualib:GetBaseInfo(player, 20)
    elseif job == 1 then
        att = lualib:GetBaseInfo(player, 22)
    elseif job == 2 then
        att = lualib:GetBaseInfo(player, 24)
    end
    rangeharm(player, lualib:X(player), lualib:Y(player), 3, att, 1, 3, 0, 0)
end

--�ٻ�����
function magselffunc1012(player)
    --�ٻ�����
    callscriptex(player, "KillCallMob", "����", 2, 1)
    local level = Magic.BBcountEX(player, SkillIDCfg["�ٻ�����"])
    if level then
        for i = 1, 2, 1 do
            local BBItem = recallmob(player, "����", 7, 1440, 1)
            if BBItem then
                changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 86400)
                changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 86400)
                changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 86400)
                changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 86400)
                changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 2, 86400)
                --����
                local num = (80 + 4 * level) / 100
                local attUP, attLow = Magic.GetPlayerAtt(player)
                changemobability(player, BBItem, 5, '=', attLow * num, 86400)
                changemobability(player, BBItem, 6, '=', attUP * num, 86400)
                -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 86400)
                -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 86400)
                -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 86400)
                -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 86400)
                --������״̬
                setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
                --������צǿ��
                if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 8 then
                    local ClawCount = Magic.ClawCount(player)
                    if ClawCount >= 1 then
                        local qhatt = 0.25
                        if ClawCount >= 2 then qhatt = 0.45 end
                        if ClawCount >= 3 then qhatt = 0.8 end
                        --���Ԫ������
                        if addbuff(BBItem, 50004, 65535, 1, player, {
                                [21] = getbaseinfo(player, 51, 21) * qhatt,
                                [25] = getbaseinfo(player, 51, 25) * qhatt,
                                [28] = getbaseinfo(player, 51, 28) * qhatt,
                            }) then
                            Message:SendClawmsg(player, "������צ�����޻��Ԫ����������")
                        end
                    end
                end
                --����
            end
        end
    end
end
