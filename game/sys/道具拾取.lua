-- 捡取触发
function pickupitemex(player, item)
    local itemId = lualib:GetItemInfo(player, item, 2)
    GameEvent.push(EventCfg.onPickItem, player, item, itemId)
    -- 首爆触发
    --local itemName = lualib:ItemName(player, item)

    -- 小刀之道
end

-- 拾取前触发
function pickupitemfrontex(player, item)
    return true
end