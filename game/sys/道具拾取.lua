-- ��ȡ����
function pickupitemex(player, item)
    local itemId = lualib:GetItemInfo(player, item, 2)
    GameEvent.push(EventCfg.onPickItem, player, item, itemId)
    -- �ױ�����
    --local itemName = lualib:ItemName(player, item)

    -- С��֮��
end

-- ʰȡǰ����
function pickupitemfrontex(player, item)
    return true
end