---@class gwzftSkill �����߸���
-- local gwzftSkill = {}
--���޸���
function magselffunc1001(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["���޸���"])
    local gsNum = 1 --���ٻ���������
    if Magic.BBcountEX(player, SkillIDCfg["��������"]) then
        gsNum = gsNum + 1
    end
    --������צ
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "������") >= gsNum then
        Message:Msg9(player, "��ǰӵ�еĹ����Ѹ�����������")
        return
    end
    lualib:SetValue(player, 28, ((10 + level * 2) + lualib:GetValue(player, 28)), 10) --�Ʒ�
    lualib:SetInt(player, "������", lualib:GetInt(player, "������") + 1)
    Message:SendSkillmsg(player, "���޸���", "�Ʒ��������ӣ�")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--��ɲ����
function magselffunc1002(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["��ɲ����"])
    local gsNum = 1 --���ٻ���������
    if Magic.BBcountEX(player, SkillIDCfg["��������"]) then
        gsNum = gsNum + 1
    end
    --������צ
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "������") >= gsNum then
        Message:Msg9(player, "��ǰӵ�еĹ����Ѹ�����������")
        return
    end
    lualib:SetValue(player, 21, ((10 + level * 2) + lualib:GetValue(player, 21)), 10) --����
    lualib:SetInt(player, "������", lualib:GetInt(player, "������") + 1)
    -- setontimer(player, 102, 10, 1)
    Message:SendSkillmsg(player, "��ɲ����", "�����������ӣ�")
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--���޸���
function magselffunc1003(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["���޸���"])
    local gsNum = 1 --���ٻ���������
    if Magic.BBcountEX(player, SkillIDCfg["��������"]) then
        gsNum = gsNum + 1
    end
    --������צ
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "������") >= gsNum then
        Message:Msg9(player, "��ǰӵ�еĹ����Ѹ�����������")
        return
    end
    lualib:SetValue(player, 25, ((10 + level * 2) + lualib:GetValue(player, 25)), 10) --�˺�
    lualib:SetInt(player, "������", lualib:GetInt(player, "������") + 1)
    Message:SendSkillmsg(player, "���޸���", "�˺��������ӣ�")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--������
function magselffunc1004(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["������"])
    local gsNum = 1 --���ٻ���������
    if Magic.BBcountEX(player, SkillIDCfg["��������"]) then
        gsNum = gsNum + 1
    end
    --������צ
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "������") >= gsNum then
        Message:Msg9(player, "��ǰӵ�еĹ����Ѹ�����������")
        return
    end
    lualib:SetValue(player, 30, ((20 + level * 2) + lualib:GetValue(player, 30)), 10) --����
    lualib:SetInt(player, "������", lualib:GetInt(player, "������") + 1)
    Message:SendSkillmsg(player, "������", "�����������ӣ�")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--��ʱ��
function gwzftskill_ontimer(player)
    if lualib:GetInt(player, "������") > 0 then
        lualib:SetInt(player, "������", lualib:GetInt(player, "������") - 1)
    end
end

--��Ϸ�¼�
-- return gwzftSkill
