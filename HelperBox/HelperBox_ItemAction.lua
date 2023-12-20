function HelperBox.ItemInfo(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local allEquip = lualib:GetEquipList(target)
    local bagList = getbagitems(target)
    local tempTb = {}
    for i=1, #allEquip do
        local temp = {}
        local makeIndex = lualib:GetItemInfo(target, allEquip[i], 1)
        local itemId = lualib:GetItemInfo(target, allEquip[i], 2)
        temp.makeIndex = makeIndex
        temp.tag = 1
        temp.item = allEquip[i]
        temp.itemId = itemId
        temp.count = lualib:GetItemInfo(target, allEquip[i], 5)
        table.insert(tempTb, temp)
    end
    for i=1, #bagList do
        local temp = {}
        local makeIndex = lualib:GetItemInfo(target, bagList[i], 1)
        local itemId = lualib:GetItemInfo(target, bagList[i], 2)
        temp.makeIndex = makeIndex
        temp.tag = 2
        temp.item = bagList[i]
        temp.itemId = itemId
        temp.count = lualib:GetItemInfo(target, bagList[i], 5)
        table.insert(tempTb, temp)
    end
    --lualib:DoClientUIMethod(player, "HelperBox_ItemInfoConvertToItemData", tempTb, player)
    lualib:DoClientUIMethod(player, "HelperBox_ItemInfo", tempTb)
end

--function HelperBox.ItemInfoConvertToItemData(myObj, convertTb, actionPlayer)
--    if not HelperBox:CheckPermission(actionPlayer) then return end
--
--    lualib:DoClientUIMethod(actionPlayer, "HelperBox_ItemInfo", convertTb)
--end

function HelperBox.ItemCopy(player, targetName, item)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local itemJson = lualib:GetItemJson(item)
    if itemJson == "" then
        Message:Msg9(player, "该物品不存在！")
        return
    end
    local newItem = giveitembyjson(player, itemJson)
end

function HelperBox.ItemDestroy(player, targetName, item)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    item = tostring(item)
    if not lualib:HasItem(target, item) then
        Message:Msg9(player, "目标没有该装备")
        return
    end
    local tName = lualib:ItemName(target, item)
    --local tName = lualib:ItemName(target, item)
    local uuid = lualib:GetItemInfo(target, item, 1)
    lualib:DestroyItem(target, uuid)
    Message:Msg9(player, "成功销毁道具"..tostring(tName))
end