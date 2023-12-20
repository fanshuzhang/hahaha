module("zsfEX", package.seeall)

---��ȡ��Ʒ������
---@param item string ��Ʒ����
---@return string ����
function lualib:ItemName(player, item)
    local id = lualib:GetItemInfo(player, item, 2)
    if id then
        return lualib:GetStdItemInfo(id, 1)
    else
        return nil
    end
end

--����װ��
function lualib:TakeOffItem(player, equipPos)
    if not equipPos then
        return
    end
    local item = linkbodyitem(player, equipPos)
    if item and item ~= '0' then
        local onlyID = getiteminfo(player, item, 1)
        takeoffitem(player, equipPos, onlyID)
    end
end

---����㼣��Ч
---@param play string ��Ҷ���
---@param effectID int ��ЧID
---@param modle int ����ģʽ��0/nil �������� 1 ��������
function lualib:setmoveeff(player, effectID, modle)
    if not effectID or type(effectID) ~= 'number' then
        return
    end
    setmoveeff(player, effectID, modle)
end

---������װ���������Ч���Լ������˶��ɿ�����
---@param play string ��Ҷ���
---@param effectID int ��ЧID
---@param position int ��ʾλ�ã�0 ǰ�� 1 ����
function lualib:addEquipEffect(player, effectID, pos)
    if not effectID or type(effectID) ~= 'number' then
        return
    end
    pos = tonumber(pos) or 0
    updateequipeffect(player, effectID, pos)
end

---ɾ������װ���������Ч
---@param play string ��Ҷ���
---@param position int ��ʾλ�ã�0 ǰ�� 1 ����
function lualib:delEquipEffect(player, pos)
    pos = tonumber(pos) or 0
    updateequipeffect(player, 0, pos)
end

---�����ı��ļ���չ
---@param path string �ļ�·��
function lualib:IO_CreateFileEX(path)
    if getrandomtext(path, 0) == '' then
        createfile(path)
        addtextlist(path, "�½��ļ�-" .. Time2Str(GetNowTime()), 0)
        return true
    else
        return false
    end
end

---д��ָ���ı��ļ�
---@param path string �ļ�·��
---@param str string д���ı�
---@param line string д������(1~65535)
function lualib:IO_AddTextListEX(path, str, line)
    if line == 0 then
        return
    end
    addtextlist(path, str, line)
end

---�ƶ���ָ��NPC����
---@param player string ��Ҷ���
---@param NPCIndex int NPC����
---@param nRange int ��Χֵ
---@param nRange2 int ��Χֵ2
--[[
1. NPC���ڵ�ǰ��ͼʱ: nRange>0: ˲�ƴ��͵�NPC����; nRange=0: ������;
2. NPC�ڵ�ǰ��ͼʱ: nRange>0: ˲�ƴ��͵�NPC����; nRange=0: ������NPC����;
]]
--
function lualib:opennpcshowex(player, NPCIndex, nRange, nRange2)
    nRange2 = tonumber(nRange2) or 1
    opennpcshowex(player, NPCIndex, nRange, nRange2)
end

--��ȡTXT����
function lualib:GetConst(player, name)
    return getconst(player, name)
end

--��ȡ������Ʒ�б�
function lualib:GetBagItems(player, itenName, isbind)
    return getbagitems(player, itenName, isbind)
end

--������Ʒ��������Ʒ����
function lualib:nameByItem(player, item)
    if not item then
        return
    end
    local itemID = getiteminfo(player, item, 2)
    if itemID then
        return getstditeminfo(itemID, 1)
    end
end

--���������Ʒ�ͻ���
---@param player string ��Ҷ���
---@param costTb table �����б�
---@return boolean �Ƿ��㹻
---@return string ��ʾ
function lualib:BatchCheckItemEX(player, costTb)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = getbindmoney(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "����" .. costSSS[1] .. "����" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    return true
end

--�����۳���Ʒ�ͻ���
function lualib:BatchDelItemEX(player, costTb, costDesc)
    -- body
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = getbindmoney(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "����" .. costSSS[1] .. "����" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            consumebindmoney(player, costSSS[1], costSSS[2], costDesc .. "��ȡ����")
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, costDesc .. "����") then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    return true
end

---��ȡatt���е�����
function lualib:Getatt(player, att_id)
    if not player then
        return
    end
    return getbaseinfo(player, 51, att_id)
end

--����Ƿ����ָ����Ʒ
function lualib:CheckItemw(player, ItemName)
    return callcheckscriptex(player, "CHECKITEMW", ItemName, 1)
end

return zsfEX
