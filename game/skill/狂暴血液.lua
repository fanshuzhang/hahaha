---@class kbxySkill ��ѪҺ

function magselffunc1000(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["��ѪҺ"])
    lualib:SetValue(player, 28, ((5 + level) + lualib:GetValue(player, 28)), 10) --�Ʒ�
    lualib:SetValue(player, 21, ((5 + level) + lualib:GetValue(player, 21)), 10) --����
    lualib:SetValue(player, 25, ((5 + level) + lualib:GetValue(player, 25)), 10) --�˺��ӳ�
    Message:SendSkillmsg(player, "��ѪҺ", "����Ʒ����������˺�����")
end
