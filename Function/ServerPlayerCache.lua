---@class ServerPlayerCache
--[[
    当前类用于存储服务器内各个玩家的数据
    目的是用于优化服务器和数据库的交互次数
    以及减少数据库的压力
    但是这样做的代价是服务器内存的消耗
    但是这个代价是可以接受的

    注意：服务器在重载时会导致数据丢失
    所以在服务器重载后再次调用数据时需要判断数据是否存在
    不存在则需要重新从数据库中获取，然后再次存入缓存
]]
local ServerPlayerCache = {}

--- 初始化结构
---@param player userdata 玩家
function ServerPlayerCache.initStruct(player)
    ServerPlayerCache[player] = {}
    ServerPlayerCache[player].varList = {}
    ServerPlayerCache[player].equipList = {}
end

--- 设置装备数据
---@param player userdata 玩家
---@param where string 装备位置
---@param equip userdata 装备对象
---@param equipName string 装备名称
---@return table 装备数据
function ServerPlayerCache.setEquip(player, where, equip, equipName)
    ServerPlayerCache.initStruct(player)
    if equipName then
        ServerPlayerCache[player].equipList[where] = {equip, equipName}
    else
        local equipId = lualib:GetItemInfo(player, equip, 2)
        local equipName = lualib:GetStdItemInfo(equipId, 1)
        ServerPlayerCache[player].equipList[where] = {equip, equipName}
    end
    return ServerPlayerCache[player].equipList[where]
end

--- 取消移除装备缓存
---@param player userdata 玩家
---@param where string 装备位置
function ServerPlayerCache.unsetEquip(player, where)
    local myCache = ServerPlayerCache[player]
    if myCache.equipList[where] ~= nil then
        myCache.equipList[where] = nil
    end
end

--- 当索引ServerPlayerCache中的不存在的值时，先将值初始化，后返回
--- 以给ServerPlayerCache设置元表的方法实现
local meta = {
    __index = function(t, k)
        ServerPlayerCache.initStruct(k)
        return rawget(t, k)
    end
}
setmetatable(ServerPlayerCache, meta)

return ServerPlayerCache