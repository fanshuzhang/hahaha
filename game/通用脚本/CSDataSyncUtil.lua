local CSDataSyncUtil = {
    list = {
        -- "�ۺ�����",
        -- "��ͼ�ȼ�",

    },
    index = {
        -- [VarCfg["�ۺ�����"]] = "�ۺ�����",
        -- [VarCfg["��ͼ�ȼ�"]] = "��ͼ�ȼ�",

    },
    flagList = {
        -- "Ψһ���",
    },
    flagIndex = {
        -- [VarCfg["Ψһ���"]] = "Ψһ���",
    },
}
-- ִ������ͬ��
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
    syncData["�Ϸ�����"] = GeneralGlobalConfig.getHQCount()
    lualib:DoClientUIMethod(player, "CSDataSyncUtil_Sync", syncData)
end

---ִ�е�һ����ͬ��
function CSDataSyncUtil.setSyncVar(player, varName, varValue)
    local nickName = CSDataSyncUtil.index[varName]
    if nickName then
        local syncData = {[nickName]=varValue}
        lualib:DoClientUIMethod(player, "CSDataSyncUtil_SyncSingle", syncData)
    end
end

---ִ�е�һ���ͬ��
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