-- ÿ��ִ��
function ontimer1(player)
    if lualib:GetInt(player, "��սCD") > 0 then
        lualib:SetInt(player, "��սCD", lualib:GetInt(player, "��սCD") - 1)
    end
    --����
    
end

-- ÿ����ִ��
function ontimer2(player)
    -- ����ʱ��
    local onlineMin = lualib:GetVar(player, VarCfg["�ҵ�����ʱ��"])
    lualib:SetVar(player, VarCfg["�ҵ�����ʱ��"], onlineMin + 1)
    lualib:SetVar(player, VarCfg["�ҵ�������ʱ��"], lualib:GetVar(player, VarCfg["�ҵ�������ʱ��"]) + 1)
    if lualib:GetMoneyEx(player, "��ֵ") > 0 then
        if NpcFreeMonkey and NpcFreeMonkey.MoveOk then
            NpcFreeMonkey.MoveOk(player)
        end
    end
    if lualib:GetInt(player, "�Ƿ���") == 0 then
        lualib:DelayGoto(player, 333, "click,���ű�_main", false)
    end
    --������צ-��ħ��ʦ
    if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 6 and Magic.ClawCount(player) >= 2 then
        --���Buff-50005
        if addbuff(player, 50005, 20, 1, player, {}) then
            Message:SendClawmsg(player, "������צ���ͷ�ħ���ܣ�����20%�����˺�")
        end
    end
end

-- ÿ20��ִ�� ����
function ontimer3(player)
    -- ���մ���
    if lualib:GetVar(player, VarCfg["�Զ�����"]) == 1 then
        if lualib:GetBagFree(player) < 80 and AppEquipCycle.beginCycle then
            AppEquipCycle.beginCycle(player)
        end
    end
    --ˢ�±���
    local baolv = lualib:GetValueEx(player, 203) --��ٱ���
    local _baolv = baolv / 10
    callscriptex(player, "KILLMONBURSTRATE", 100 + _baolv, 65535)
end

function ontimer5(player)
    -- ���մ���
    if lualib:GetVar(player, VarCfg["�Զ��Ի���"]) == 1 then

    end
end

-- ÿ5��ִ��
function ontimer4(player)
    
end
