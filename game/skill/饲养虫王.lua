---@class sycwSkill ��������

local sycwSkill = {}
function sycwSkill.onSetVar(player, varName, varValue)
    if varName == VarCfg["�׼��Ƴ�����"] then
        local num = Magic.BBcountEX(player, SkillIDCfg["��������"])
        if num then
            if varValue >= (50 - num * 4) then
                if lualib:GetVar(player, VarCfg["��������"]) >= 2 then
                    return
                end
                local BBItem = recallmob(player, "����", 7, 1, 1)
                if BBItem then
                    changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 60)
                    changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 60)
                    changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 60)
                    changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 60)
                    changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) * 3, 60)
                    --����
                    local num = (100 + 5 * getskillinfo(player, SkillIDCfg["��������"], 2)) / 100
                    local attUp, attLow = Magic.GetPlayerAtt(player)
                    changemobability(player, BBItem, 5, '=', attLow * num, 60)
                    changemobability(player, BBItem, 6, '=', attUp * num, 60)
                    -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 60)
                    -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 60)
                    -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 60)
                    -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 60)
                    --������״̬
                    setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
                    --������צǿ��
                    if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 7 then
                        local ClawCount = Magic.ClawCount(player)
                        if ClawCount >= 1 then
                            local qhatt = 0.2
                            if ClawCount >= 2 then qhatt = 0.4 end
                            if ClawCount >= 3 then qhatt = 1 end
                            --���Ԫ������
                            if addbuff(BBItem, 50004, 65535, 1, player, {
                                    [21] = getbaseinfo(player, 51, 21) * qhatt,
                                    [25] = getbaseinfo(player, 51, 25) * qhatt,
                                    [28] = getbaseinfo(player, 51, 28) * qhatt,
                                }) then
                                Message:SendClawmsg(player, "������צ���������Ԫ����������")
                            end
                        end
                    end
                    --����
                    lualib:SetVar(player, VarCfg["��������"], lualib:GetVar(player, VarCfg["��������"]) + 1)
                    lualib:SetVar(player, VarCfg["�׼��Ƴ�����"], 0)
                end
            end
        end
    end
end

--��������
function sycwSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "����" then
        lualib:SetVar(player, VarCfg["��������"], lualib:GetVar(player, VarCfg["��������"]) - 1)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onSetVar, sycwSkill.onSetVar, sycwSkill)
GameEvent.add(EventCfg.onSelfKillSlave, sycwSkill.onSelfKillSlave, sycwSkill)
return sycwSkill
