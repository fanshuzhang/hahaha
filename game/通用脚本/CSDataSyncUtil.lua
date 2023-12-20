local CSDataSyncUtil = {
    list = {
        -- "综合属性",
        -- "地图等级",

    },
    index = {
        -- [VarCfg["综合属性"]] = "综合属性",
        -- [VarCfg["地图等级"]] = "地图等级",

    },
    flagList = {
        -- "唯一礼包",
    },
    flagIndex = {
        -- [VarCfg["唯一礼包"]] = "唯一礼包",
    },
}
-- 执行数据同步
function CSDataSyncUtil.Sync(player)
    local syncData = {}
    for i=1, #CSDataSyncUtil.list do
        local name = CSDataSyncUtil.list[i]
        if name and VarCfg[name] then
            local val = lualib:GetVar(player, VarCfg[name])
            syncData[name] = val
        end
    end
    for i=1, #CSDataSyncUtil.flagList do
        local name = CSDataSyncUtil.flagList[i]
        if name and VarCfg[name] then
            local val = lualib:GetFlagStatus(player, VarCfg[name])
            syncData[name] = val
        end
    end
    syncData["合服次数"] = GeneralGlobalConfig.getHQCount()
    lualib:DoClientUIMethod(player, "CSDataSyncUtil_Sync", syncData)
end

---执行单一数据同步
function CSDataSyncUtil.setSyncVar(player, varName, varValue)
    local nickName = CSDataSyncUtil.index[varName]
    if nickName then
        local syncData = {[nickName]=varValue}
        lualib:DoClientUIMethod(player, "CSDataSyncUtil_SyncSingle", syncData)
    end
end

---执行单一标记同步
function CSDataSyncUtil.setSyncFlag(player, varName, varValue)
    local nickName = CSDataSyncUtil.flagIndex[varName]
    if nickName then
        local syncData = {[nickName]=varValue}
        lualib:DoClientUIMethod(player, "CSDataSyncUtil_SyncSingle", syncData)
    end
end

Message.RegisterClickMsg("CSDataSyncUtil", CSDataSyncUtil)
setFormAllowFunc("CSDataSyncUtil", {"Sync"})
return CSDataSyncUtil