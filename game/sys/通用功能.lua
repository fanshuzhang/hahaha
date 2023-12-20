-- �򿪱���GM���
function GeneralGlobalConfig.openGMBoxPre(player)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if not GeneralGlobalConfig.adminList[tostring(userAccount)] then
        return
    end
    local str = ""
    str = str .. "<Button|x=-105|y=-260|nimg=custom/00232.png|size=18|text=GMBOX|link=@click,HelperBox_OpenUI>"
    str = str .. "<Button|x=55|y=-260|nimg=custom/00232.png|size=18|text=���ܲ���|link=@click,ͨ�ù���_openManageWnd>"
    addbutton(player, 108, 666, str)
end

-- �Զ���calllua
-- ���ط�װ���������
function lua_call_global_func(player, str, ...)
    click(player, str, ...)
end

-- �ж��Ƿ����°汾
function GeneralGlobalConfig.isNewVersion()
    --local severName = lualib:GlobalInfo(10)
    --if severName ~= "" then
    --    return false
    --end
    return true
end

function GeneralGlobalConfig.openManageWnd(player)
    NpcCeshi.main(player)
end

function GeneralGlobalConfig.addskill(player, data)
    data = tonumber(data)
    local name = getconst(player, "<$NPCINPUT(1)>")
    release_print(name,SkillIDCfg[name])
    if not SkillIDCfg[name] then
        Message:Msg9(player, "error!")
        return
    end
    if data == 1 then
        lualib:AddSkill(player, SkillIDCfg[name])
        Message:Msg9(player,"��ӳɹ���")
    end
    if data == 2 then
        lualib:DelSkill(player, SkillIDCfg[name])
        Message:Msg9(player,"ɾ���ɹ���")
    end
end

local equipLevelLimit = {
    [1] = "����",
    [0] = "����",
    [4] = "ͷ��",
    [3] = "����",
    [6] = "����",
    [5] = "����",
    [8] = "���",
    [7] = "�ҽ�",
    [10] = "����",
    [11] = "Ь��",
}
---��ȡ��ҵ���װװ���ȼ�
---@param player string ��Ҷ���
---@return number ��װװ���ȼ�
function GeneralGlobalConfig.GetSuitEquipLevel(player)
    local equipLevel = 0
    for where, name in pairs(equipLevelLimit) do
        local item = lualib:LinkBodyItem(player, where)
        if item ~= "0" and item ~= nil then
            local itemName = lualib:ItemName(player, item)
            local needLevel = lualib:GetStdItemInfo(itemName, 10)
            if tonumber(needLevel) then
                equipLevel = equipLevel + needLevel
            end
        end
    end
    return equipLevel
end

function GeneralGlobalConfig.onAddBag(player, item, itemId)
    if not GeneralGlobalConfig.autoUse[itemId] then
        return
    end
    local itemName = lualib:ItemName(player, item)
    lualib:EatItem(player, itemName, 1)
end

function GeneralGlobalConfig.getHQCount()
    local hqCount = lualib:GetVar(nil, VarCfg["��������"])
    if hqCount <= 0 then
        return lualib:GlobalInfo(3)
    else
        return hqCount
    end
end

function GeneralGlobalConfig.getReward(player)
    Message:Msg9(player, "��ȡ����")
end

---��ȡ��ǰ�����һ������������½�Լ���ǰ��½�͵�ǰ��½��Ҫ�ĳ�ֵ���
---@param player string ��Ҷ���
---@return number maxLand ����½
---@return number curLand ��ǰ��½
---@return number curLandNeedCharge ��ǰ��½��Ҫ�ĳ�ֵ���
function GeneralGlobalConfig.getMaxUpLand(player)
    local platCharge = lualib:GetMoneyEx(player, "��ֵ")
    local maxLand = 0
    for i = 1, #GeneralGlobalConfig.instanceFullLevelDic do
        local sss = GeneralGlobalConfig.instanceFullLevelDic[i]
        if platCharge >= sss.chargeMin then
            maxLand = sss.landMax
        end
    end
    local curLand = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    local curLandNeedCharge = 0
    if curLand then
        for i = 1, #GeneralGlobalConfig.instanceFullLevelDic do
            local sss = GeneralGlobalConfig.instanceFullLevelDic[i]
            local ppp = GeneralGlobalConfig.instanceFullLevelDic[i - 1]
            if ppp then
                if curLand <= sss.landMax and curLand > ppp.landMax then
                    curLandNeedCharge = sss.chargeMin
                end
            else
                if curLand <= sss.landMax then
                    curLandNeedCharge = sss.chargeMin
                end
            end
        end
    else
        curLand = 0
    end

    return maxLand, curLand, curLandNeedCharge
end

function GeneralGlobalConfig.openCK(player)
    openstorage(player)
end

--�ر�
function GeneralGlobalConfig.customClose(player)
    close(player)
end

GameEvent.add(EventCfg.onAddBag, GeneralGlobalConfig.onAddBag, GeneralGlobalConfig)
setFormAllowFunc("ͨ�ù���", { "openCK","customClose" })

Message.RegisterClickMsg("ͨ�ù���", GeneralGlobalConfig)
