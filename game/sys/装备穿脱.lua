-- ����װ�����䴥��
function checkdropuseitems(player, where, idx)
    -- ����װ������Ҫģ����װ��
    local item = lualib:LinkBodyItem(player, where)
    if item ~= "0" and item ~= nil then
        local itemName = lualib:ItemName(player, item)
        GameEvent.push(EventCfg.onTakeOffEx, player, item, itemName, where)
    end
end

-- ��ɫ����֮ǰ�ص�
function takeonbeforeex(player, item)

    return true
end

-- ����װ��֮ǰ�ص�
function takeoffbeforeex(player, item)
    local itemName = lualib:ItemName(player, item)
    if DisableTakeOffEquipDic[itemName] and lualib:GetFlagStatus(player,PlayerVarCfg["�Ƿ�����û�"])==0 then
        Message:Msg9(player, itemName.."���ɱ�ȡ��")
        return false
    end
    return true
end

-- ����װ��������ǰ����
function takeoffexchange(player, item, where, makeIndex)

end


-- ������
function takeonex(player, item, where, itemName, makeIndex)
    GameEvent.push(EventCfg.onTakeOnEx, player, item, itemName, where)
end

-- �Ѵ���
function takeoffex(player, item, where, itemName, makeIndex)
    GameEvent.push(EventCfg.onTakeOffEx, player, item, itemName, where)
end


