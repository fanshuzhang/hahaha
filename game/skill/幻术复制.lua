---@class hsfzSkill ��������
local hsfzSkill = {}
hsfzSkill.numCfg = {
    [0] = 1,
    [1] = 2,
    [2] = 2,
    [3] = 3,
    [4] = 3,
    [5] = 3,
    [6] = 4,
    [7] = 4,
    [8] = 4,
    [9] = 5,
}

function hsfzSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicName == "��������" then
        local level = Magic.BBcountEX(player, SkillIDCfg["��������"])
        if not level then
            return
        end
        local monAttNum = getbaseinfo(targetObject, 20)
        local selfAttNum = getbaseinfo(player, 24)
        if monAttNum - (selfAttNum + 50 * level) > 50 then
            Message:Msg9(player, "�˹���̫��ǿ���޷����ƣ�")
            return
        end
        local num = Magic.BBcountEX(player, SkillIDCfg["���޸���"])
        if num then
            num = hsfzSkill.numCfg[num]
        else
            num = 1
        end
        if lualib:GetInt(player, "��������") >= num then
            Message:Msg9(player, "�ɸ��ƵĹ��������Ѵ����ޣ�")
            return
        end
        local BBItem = recallmob(player, getbaseinfo(targetObject, 1, 1), 7, 1440, 1)
        --������צǿ��
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 9 then
            local ClawCount = Magic.ClawCount(player)
            if ClawCount >= 1 then
                local qhatt = 0.25
                if ClawCount >= 2 then qhatt = 0.45 end
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
        setcurrent(BBItem, 0, "��������")
        lualib:SetInt(player, "��������", lualib:GetInt(player, "��������") + 1)
    end
end

--��������
function hsfzSkill.onSelfKillSlave(player, bbobj)
    if getcurrent(bbobj, 0) == "��������" then
        lualib:SetInt(player, "��������", lualib:GetInt(player, "��������") - 1)
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onBeginmagic, hsfzSkill.onBeginmagic, hsfzSkill)
GameEvent.add(EventCfg.onSelfKillSlave, hsfzSkill.onSelfKillSlave, hsfzSkill)
return hsfzSkill
