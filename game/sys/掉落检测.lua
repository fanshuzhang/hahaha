--����ϡ��װ���������1
local tsItemDropLimit = {
    ["��ֵ���+1Ԫ"] = 10,
}
local tsItemDropLimitExcludeMob = {
    ["С�����ر���ֵ������BOSS"] = 1,
    ["����ұ���"] = 1,
    ["���������϶�����"] = 1,
    ["������˭֪��"] = 1,
}
-- �ռ����׼��
--local tsItemEquipMaxLimit = {
--    ["O�ٻ�����������"] = 1,
--    ["O�ٻ�����ס����"] = 1,
--}
-- ���������Ʒ����ֵû������Ҵ򵽵Ĳ��ϲ��ɽ��ײ��ɶ���
local tsItemMaterial = {
    ["��Դ��߱��"] = 1,
    ["��Դ���컯��"] = 1,
    ["��Դ�����嵤"] = 1,
    ["ת����(��ͨ)"] = 1,
    ["ת����(�߼�)"] = 1,
    ["ת����(����)"] = 1,
    ["ת����(�ռ�)"] = 1,
    ["ʱװˮ��(ǿ��)"] = 1,
    ["ħ����ʯ(����)"] = 1,
    ["����ʯ(ǿ��)"] = 1,
    ["�����һ���"] = 1,
    ["������ʯ"] = 1,
    ["����ͼֽ"] = 1,
    ["��ɫǧ·ʯ"] = 1,
    ["��ɫǧ·ʯ"] = 1,
    ["��ɫǧ·ʯ"] = 1,
    ["��ɫǧ·ʯ"] = 1,
    ["ʱװˮ��(ǿ��)"] = 1,

    ["10000Ԫ��"] = 1,
    ["20000Ԫ��"] = 1,
    ["50000Ԫ��"] = 1,
    ["100000Ԫ��"] = 1,
    ["1С����"] = 1,
    ["2С����"] = 1,
    ["5С����"] = 1,
    ["10С����"] = 1,
    ["1����"] = 1,
    ["10����"] = 1,
    ["50����"] = 1,
    ["100����"] = 1,
    ["20����"] = 1,
}

-- ���������Ʒ����
function mondropitemex(player, item, monster, x, y)
    local itemName = lualib:ItemName(player, item)

    --if tsItemMaterial[itemName] ~= nil then
    --    local U8 = lualib:GetVar(player, "U8")
    --    if U8 < GeneralGlobalConfig.tradeLimit then
    --        if lualib:GetBagFree(player) >= 15 then
    --            lualib:AddItem(player, itemName, 1, lualib:CalItemRuleCountEx({2,6,7,9}))
    --        end
    --        return false
    --    end
    --end
    --
    --
    --
    --local count = tsItemDropLimit[itemName]
    --if count then
    --    local mobName = lualib:GetBaseInfo(monster, 1, 1)
    --    local mobName2 = lualib:GetBaseInfo(monster, 1, 0)
    --    if tsItemDropLimitExcludeMob[mobName] ~= nil or tsItemDropLimitExcludeMob[mobName2] ~= nil then
    --        return true
    --    end
    --    local J4 = lualib:GetVar(player, "J4")
    --    if J4 < count then
    --        lualib:SetVar(player, "J4", J4 + 1)
    --        return false
    --    else
    --        lualib:SetVar(player, "J4", 0)
    --    end
    --end
    return true
end