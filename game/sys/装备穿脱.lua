-- 身上装备掉落触发
function checkdropuseitems(player, where, idx)
    -- 加星装备掉落要模拟脱装备
    local item = lualib:LinkBodyItem(player, where)
    if item ~= "0" and item ~= nil then
        local itemName = lualib:ItemName(player, item)
        GameEvent.push(EventCfg.onTakeOffEx, player, item, itemName, where)
    end
end

-- 角色穿戴之前回调
function takeonbeforeex(player, item)

    return true
end

-- 脱下装备之前回调
function takeoffbeforeex(player, item)
    local itemName = lualib:ItemName(player, item)
    if DisableTakeOffEquipDic[itemName] and lualib:GetFlagStatus(player,PlayerVarCfg["是否测试用户"])==0 then
        Message:Msg9(player, itemName.."不可被取下")
        return false
    end
    return true
end

-- 脱下装备进背包前触发
function takeoffexchange(player, item, where, makeIndex)

end


-- 穿触发
function takeonex(player, item, where, itemName, makeIndex)
    GameEvent.push(EventCfg.onTakeOnEx, player, item, itemName, where)
end

-- 脱触发
function takeoffex(player, item, where, itemName, makeIndex)
    GameEvent.push(EventCfg.onTakeOffEx, player, item, itemName, where)
end


