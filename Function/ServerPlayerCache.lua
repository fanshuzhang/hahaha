---@class ServerPlayerCache
--[[
    ��ǰ�����ڴ洢�������ڸ�����ҵ�����
    Ŀ���������Ż������������ݿ�Ľ�������
    �Լ��������ݿ��ѹ��
    �����������Ĵ����Ƿ������ڴ������
    ������������ǿ��Խ��ܵ�

    ע�⣺������������ʱ�ᵼ�����ݶ�ʧ
    �����ڷ��������غ��ٴε�������ʱ��Ҫ�ж������Ƿ����
    ����������Ҫ���´����ݿ��л�ȡ��Ȼ���ٴδ��뻺��
]]
local ServerPlayerCache = {}

--- ��ʼ���ṹ
---@param player userdata ���
function ServerPlayerCache.initStruct(player)
    ServerPlayerCache[player] = {}
    ServerPlayerCache[player].varList = {}
    ServerPlayerCache[player].equipList = {}
end

--- ����װ������
---@param player userdata ���
---@param where string װ��λ��
---@param equip userdata װ������
---@param equipName string װ������
---@return table װ������
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

--- ȡ���Ƴ�װ������
---@param player userdata ���
---@param where string װ��λ��
function ServerPlayerCache.unsetEquip(player, where)
    local myCache = ServerPlayerCache[player]
    if myCache.equipList[where] ~= nil then
        myCache.equipList[where] = nil
    end
end

--- ������ServerPlayerCache�еĲ����ڵ�ֵʱ���Ƚ�ֵ��ʼ�����󷵻�
--- �Ը�ServerPlayerCache����Ԫ��ķ���ʵ��
local meta = {
    __index = function(t, k)
        ServerPlayerCache.initStruct(k)
        return rawget(t, k)
    end
}
setmetatable(ServerPlayerCache, meta)

return ServerPlayerCache