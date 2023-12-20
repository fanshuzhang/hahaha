---------------------------------------------------------����----------------------------------------------------------
local skill_items = {
    [10197] = { 10197, "�������" },
    [10198] = { 10198, "ʮ��һɱ" },
    [10199] = { 10199, "��ɱ����" },
    [10200] = { 10200, "���޸���" },
    [10201] = { 10201, "��ɲ����" },
    [10202] = { 10202, "���޸���" },
    [10203] = { 10203, "������" },
    [10204] = { 10204, "����֮��" },
    [10205] = { 10205, "��������" },
    [10206] = { 10206, "��Ӱ����" },
    [10207] = { 10207, "��������" },
    [10208] = { 10208, "������" },
    [10209] = { 10209, "�����" },
    [10210] = { 10210, "���Ʒ���" },
    [10211] = { 10211, "ʥ���Ʋ�1111" },
    [10212] = { 10212, "�ػ�֮��" },
    [10213] = { 10213, "��ʿ֮��" },
    [10214] = { 10214, "ʥ���Ѫ" },
    [10215] = { 10215, "��Ӱ֮��" },
    [10216] = { 10216, "����ػ�" },
    [10217] = { 10217, "��������" },
    [10218] = { 10218, "������" },
    [10219] = { 10219, "�����֮��" },
    [10220] = { 10220, "����֮��" },
    [10221] = { 10221, "�׵���" },
    [10222] = { 10222, "Ⱥ���׵���" },
    [10223] = { 10223, "ħ����" },
    [10224] = { 10224, "���ܻ�" },
    [10225] = { 10225, "��˪ѩ��" },
    [10226] = { 10226, "��ʱ��Լ��" },
    [10227] = { 10227, "������Լ��" },
    [10228] = { 10228, "��Լ����" },
    [10229] = { 10229, "��Ӱ����" },
    [10230] = { 10230, "������" },
    [10231] = { 10231, "��˪Ⱥ��" },
    [10232] = { 10232, "������" },
    [10233] = { 10233, "�����̳" },
    [10234] = { 10234, "�����" },
    
}

local function addSkill(player, skillName)
    if SkillIDCfg[skillName] then
        lualib:AddSkill(player, SkillIDCfg[skillName], 3)

        Message:NoticeMsg(player, 151, 0, string.format("��ϲ��ϲ����%s���ɹ������ϳ˼��ܣ�%s", lualib:Name(player), skillName))
        Message:NoticeMsg(player, 151, 0, string.format("��ϲ��ϲ����%s���ɹ������ϳ˼��ܣ�%s", lualib:Name(player), skillName))
        Message:NoticeMsg(player, 151, 0, string.format("��ϲ��ϲ����%s���ɹ������ϳ˼��ܣ�%s", lualib:Name(player), skillName))
    end
end

for k, v in pairs(skill_items) do
    _G["stdmodefunc" .. k] = function(player)
        addSkill(player, v[2])
    end
end

---------------------------------------------------------��ֵ����----------------------------------------------------------
local recharge_items = {
    -- [14001] = {type=1, item_name = "10Ԫ�������", num=1},
    -- [14002] = {type=1, item_name = "20Ԫ�������", num=1},
    -- [14003] = {type=1, item_name = "40Ԫ�������", num=1},
    -- [14004] = {type=1, item_name = "60Ԫ�������", num=1},

}

local function dealRechargeItems(player, v)
    local coinCount = lualib:GetBagItemCount(player, v.item_name)
    --if lualib:GetBagItemCount(player, v.item_name) <= 0 then
    --    return
    --end
    if not lualib:DelItem(player, v.item_name, coinCount) then
        stop(player)
        return
    end

    if v.type == 1 then
        lualib:SetMoneyEx(player, "�����", "+", v.num * coinCount * 100000, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI��", "+", v.num * coinCount * 10000, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "δ����", "+", v.num * coinCount * 1000, "ʹ��" .. v.item_name, true)
    elseif v.type == 2 then
        lualib:SetMoneyEx(player, "�Ƽ���", "+", v.num * coinCount * 100, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "δ����", "+", v.num * coinCount * 1000, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI��", "+", v.num * coinCount * 10000, "ʹ��" .. v.item_name, true)
    elseif v.type == 3 then
        lualib:SetMoneyEx(player, "�Ƽ���", "+", v.num * coinCount * 100, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "δ����", "+", v.num * coinCount * 1000, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI��", "+", v.num * coinCount * 10000, "ʹ��" .. v.item_name, true)
    elseif v.type == 4 then
        lualib:SetMoneyEx(player, "�����", "+", v.num * coinCount * 10000, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "δ����", "+", v.num * coinCount * 100, "ʹ��" .. v.item_name, true)
        lualib:SetMoneyEx(player, "AI��", "+", v.num * coinCount * 1000, "ʹ��" .. v.item_name, true)
    end
end

for k, v in pairs(recharge_items) do
    _G["stdmodefunc" .. k] = function(player)
        dealRechargeItems(player, v)
    end
end



---------------------------------------------------------������ϴ��----------------------------------------------------------
-- function stdmodefunc10008(player)
--     if lualib:GetBagItemCount(player, "������ϴ��") <= 0 then
--         stop(player)
--         return
--     end
--     lualib:SetPk(player, 0)
--     Message:Msg5(player, "���PK���ֵ�Ѿ����Ϊ0�㣡")
-- end



---------------------------------------------------------ף����----------------------------------------------------------


---------------------------------------------------------����ף����----------------------------------------------------------
function stdmodefunc10051(player)
    if lualib:GetBagItemCount(player, "����ף����") <= 0 then
        stop(player)
        return
    end
    local equip = lualib:LinkBodyItem(player, 1)
    if equip == nil or equip == "0" or equip == "" then
        stop(player)
        return
    end
    local luck = lualib:GetItemAddValue(player, equip, 1, 5)
    if luck >= 8 then
        Message:Msg5(player, "[��ʾ]:��������Ѿ�����ֵ�Ѿ�+8���ϵ���,ϵͳ�޷�����������. ")
        stop(player)
        return
    end
    lualib:SetItemAddValue(player, equip, 1, 5, luck + 1)
    lualib:RefreshItem(player, equip)
    Message:Msg5(player, "[��ʾ]:�����������ֵ�����ˣ���ǰΪ" .. (luck + 1) .. "��. ")
end

---------------------------------------------------------����ף����----------------------------------------------------------
function stdmodefunc10005(player)
    if lualib:GetBagItemCount(player, "����ף����") <= 0 then
        stop(player)
        return
    end
    local equip = lualib:LinkBodyItem(player, 1)
    if equip == nil or equip == "0" or equip == "" then
        stop(player)
        return
    end
    local luck = lualib:GetItemAddValue(player, equip, 1, 5)
    if luck >= 8 then
        Message:Msg5(player, "[��ʾ]:��������Ѿ�����ֵ�Ѿ�+8���ϵ���,ϵͳ�޷�����������. ")
        stop(player)
        return
    end
    lualib:SetItemAddValue(player, equip, 1, 5, luck + 1)
    lualib:RefreshItem(player, equip)
    Message:Msg5(player, "[��ʾ]:�����������ֵ�����ˣ���ǰΪ" .. (luck + 1) .. "��. ")
end

---------------------------------------------------------����----------------------------------------------------------
function stdmodefunc10059(player)
    if lualib:GetBagItemCount(player, "����") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "���", "+", 1000000, "����", true)
end

function stdmodefunc10060(player)
    if lualib:GetBagItemCount(player, "��ש") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "���", "+", 5000000, "��ש", true)
end

function stdmodefunc10061(player)
    if lualib:GetBagItemCount(player, "���") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "���", "+", 10000000, "���", true)
end

function stdmodefunc10062(player)
    if lualib:GetBagItemCount(player, "����") <= 0 then
        stop(player)
        return
    end
    lualib:SetMoneyEx(player, "���", "+", 100000000, "����", true)
end

---------------------------------------------------------���ش���ʯ-------------------------------------------------------
function stdmodefunc10001(player)
    if lualib:GetBagItemCount(player, "���ػس�ʯ") <= 0 then
        stop(player)
        return
    end
    if lualib:GetInt(player, "��սCD") > 0 then
        Message:Msg9(player, "ս��״̬�޷��سǣ���������ս��3������ԣ�")
        stop(player)
        return
    end
    lualib:MapMoveXY(player, "3", 330, 330, 10)
    lualib:RemovePoison(player, 1)
    lualib:SetHpEx(player, "=", 100)
    lualib:SetMpEx(player, "=", 100)
    lualib:RepairAll(player)
    lualib:DelMirrorMap(lualib:Name(player))
end

---------------------------------------------------------�������ʯ-------------------------------------------------------
local limit10001 = {
    ["HDDT-TCPK"] = 1,
    ["137"] = 1,
}
function stdmodefunc10002(player)
    local mapId = lualib:GetMapId(player)
    if limit10001[mapId] then
        Message:Msg9(player, "��ǰ��ͼ��ֹʹ�øõ���")
        stop(player)
        return
    end
    if lualib:GetBagItemCount(player, "�������ʯ") <= 0 then
        stop(player)
        return
    end
    if lualib:GetInt(player, "��սCD") > 0 then
        Message:Msg9(player, "ս��״̬�޷��سǣ���������ս��3������ԣ�")
        stop(player)
        return
    end
    lualib:MapMove(player, lualib:GetMapId(player))
    delaygoto(player, 500, "click,�һ�����_beginFight", 1)
end

---------------------------------------------------------���ҵ���----------------------------------------------------------
local coinItemList = {
    -- [10009] = {name="100�����", count=100, coinId=33},
    -- [10010] = {name="150�����", count=150, coinId=33},
    -- [10011] = {name="200�����", count=200, coinId=33},
    -- [10012] = {name="250�����", count=250, coinId=33},,
}

local function dealCoinItem(player, v)
    local coinCount = lualib:GetBagItemCount(player, v.name)
    --if lualib:GetBagItemCount(player, v.item_name) <= 0 then
    --    return
    --end
    --print("ʹ��"..v.name.."*"..coinCount)

    if not lualib:DelItem(player, v.name, coinCount, false, "˫�����ҵ���ʹ��", 10003) then
        stop(player)
        return
    end
    lualib:SetMoney(player, v.coinId, "+", v.count * coinCount, "ʹ��" .. v.name .. "*" .. coinCount, true)
end

for k, v in pairs(coinItemList) do
    _G["stdmodefunc" .. k] = function(player)
        dealCoinItem(player, v)
    end
end

---------------------------------------------------------���õ��ߣ�չʾ�õģ�������Ʒʹ�ú�ֱ��ɾ����----------------------------------------------------------
local unuseful_item = {
    [10404] = { name = "���ֿ߲�" },
    [10389] = { name = "���߻���" },
    -- [14303] = {name="����ֿ�"},
    -- [14305] = {name="�������+1"},

}

local function dealUseTitleItem(player, v)
    if v.name then
        lualib:SetVar(player, VarCfg[v.name], 1)
        Message:Msg9(player, "�ɹ�����" .. v.name)
    end
end

for k, v in pairs(unuseful_item) do
    _G["stdmodefunc" .. k] = function(player)
        dealUseTitleItem(player, v)
    end
end

---------------------------------------------------------�ȼ�ֱ������----------------------------------------------------------
local level_equal_item = {
    --[14201] = {name="�ȼ�ֱ��30000��", v=30000},
}

local function dealUseLevelEqualItem(player, v)
    local coinCount = 1
    if lualib:GetBagItemCount(player, v.name) < coinCount then
        stop(player)
        return false
    end
    local level = lualib:Level(player)
    if level >= v.v then
        Message:Msg9(player, "���ĵȼ��Ѿ�����" .. v.v .. "�����޷�ʹ�øõ��ߣ�")
        return true
    end
    lualib:SetLevel(player, v.v)
    Message:Msg9(player, string.format("��ϲ���ɹ�ֱ��%s����", v.v))
end

for k, v in pairs(level_equal_item) do
    _G["stdmodefunc" .. k] = function(player)
        dealUseLevelEqualItem(player, v)
    end
end
