---@class bzgcSkill ��ը�Ƴ�
local bzgcSkill = {}
--����
function magselffunc513(player)
    if lualib:GetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"]) == 0 then
        setontimer(player, 101, 2)
        lualib:SetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"], 1)
        Message:Msg9(player, "������ը�Ƴ�")
    elseif lualib:GetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"]) == 1 then
        setofftimer(player, 101)
        lualib:SetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"], 0)
        Message:Msg9(player, "�رձ�ը�Ƴ�")
    end
end

--��ʱ���ٻ�����--��ը�Ƴ�
function ontimer101(player)
    local count = lualib:GetVar(player, VarCfg["��ը�Ƴ�����"])
    if count >= 6 then
        return
    end
    for i = 1, 2 do
        local BBItem = recallmob(player, "��ը�Ƴ�", 7, 1440, 1)
        if BBItem then
            changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 86400)
            changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 86400)
            changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 86400)
            changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 86400)
            changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) / 10, 86400)
            --����
            local num = (80 + 4 * getskillinfo(player, SkillIDCfg["��ը�Ƴ�"], 2)) / 100
            local attUp, attLow = Magic.GetPlayerAtt(player)
            changemobability(player, BBItem, 5, '=', attLow * num, 86400)
            changemobability(player, BBItem, 6, '=', attUp * num, 86400)
            -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 86400)
            -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 86400)
            -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 86400)
            -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 86400)
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
                        Message:SendClawmsg(player, "������צ����ը�Ƴ���Ԫ����������")
                    end
                end
            end
            --����������
            lualib:SetVar(player, VarCfg["��ը�Ƴ�����"], lualib:GetVar(player, VarCfg["��ը�Ƴ�����"]) + 1)
        end
    end
end

--��������
function bzgcSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "��ը�Ƴ�" then
        lualib:SetVar(player, VarCfg["��ը�Ƴ�����"], lualib:GetVar(player, VarCfg["��ը�Ƴ�����"]) - 1)
        --������ը-��Χ�˺�
        rangeharm(player, getbaseinfo(bbobj, 4), getbaseinfo(bbobj, 5), 2, getbaseinfo(bbobj, 24), 0)
        if math.random(100) <= 100 then
            lualib:SetVar(player, VarCfg["�׼��Ƴ�����"], lualib:GetVar(player, VarCfg["�׼��Ƴ�����"]) + 1)
        end
    end
end

--ɾ������
function bzgcSkill.onDelSkill(player, skillID)
    if skillID == SkillIDCfg["��ը�Ƴ�"] then
        if lualib:GetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"]) == 1 then
            setofftimer(player, 101)
            lualib:SetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"], 0)
            Message:Msg9(player, "�رձ�ը�Ƴ�")
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onDelSkill, bzgcSkill.onDelSkill, bzgcSkill)
GameEvent.add(EventCfg.onSelfKillSlave, bzgcSkill.onSelfKillSlave, bzgcSkill)
return bzgcSkill
