---magselffunc(X) ����ʹ�ü��ܴ���
---magtagfunc(X) ��Ŀ������ʹ�ü���ʱ������
---magmonfunc(X) ��Ŀ�����ʹ�ü���ʱ������
---magtagfuncex(X) ��Ŀ�������ͷż���ʱ�Է�������������--��ң��������֣�����ID
---beginmagic()

Magic = {}

--��ü���ǿ���ȼ�
function Magic.BBcountEX(player, skillID)
    return getskillinfo(player, skillID, 2)
end

--��ȡ��צǿ���ڼ���
function Magic.ClawCount(player)
    local level = NpcHellishGhostClaw.getVarTb(player).level
    if level >= 9 then
        return 3
    elseif level >= 6 then
        return 2
    elseif level >= 3 then
        return 1
    else
        return 0
    end
end

--��ȡ����������
function Magic.GetPlayerAtt(player)
    local attUp, attLow
    local Job = lualib:Job(player)
    if Job == 0 then
        attUp = getbaseinfo(player, 20)
        attLow = getbaseinfo(player, 19)
    elseif Job == 1 then
        attUp = getbaseinfo(player, 22)
        attLow = getbaseinfo(player, 21)
    elseif Job == 2 then
        attUp = getbaseinfo(player, 24)
        attLow = getbaseinfo(player, 23)
    end
    return attUp, attLow
end

--�����ѱ�ɱ������
function heromobtreachery(player, hero, mon)
    killmonbyobj(player, mon, false, false, false)
end

---����ʹ�����⼼��ǰ����   ����ֵ��true/nil=����ʩ��  false=��ֹʩ��
function beginmagic(player, maigicID, maigicName, targetObject, x, y)
    release_print(maigicName)
    local mapID = lualib:GetMapId(player)
    GameEvent.push(EventCfg.onBeginmagic, player, maigicID, maigicName, targetObject, x, y, mapID)
end

--��սʿ
function magselffunc26(player) --�һ�
    if Magic.ClawCount(player) >= 1 then
        lualib:SetFlagStatus(player, PlayerVarCfg["�һ𽣷�"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>������צ��ʹ���һ�,�´ι����˺�����10%</font>")
    end
end

function magselffunc66(player) --����
    if Magic.ClawCount(player) >= 2 then
        lualib:SetFlagStatus(player, PlayerVarCfg["���콣��"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>������צ��ʹ�ÿ���,�´ι����˺�����20%</font>")
    end
end

function magselffunc66(player) --����
    if Magic.ClawCount(player) >= 3 then
        lualib:SetFlagStatus(player, PlayerVarCfg["���ս���"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>������צ��ʹ������,�´ι����˺�����30%</font>")
    end
end

return Magic
