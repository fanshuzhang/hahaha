-- 打开本服GM面板
function GeneralGlobalConfig.openGMBoxPre(player)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if not GeneralGlobalConfig.adminList[tostring(userAccount)] then
        return
    end
    local str = ""
    str = str .. "<Button|x=-105|y=-260|nimg=custom/00232.png|size=18|text=GMBOX|link=@click,HelperBox_OpenUI>"
    str = str .. "<Button|x=55|y=-260|nimg=custom/00232.png|size=18|text=功能测试|link=@click,通用功能_openManageWnd>"
    addbutton(player, 108, 666, str)
end

-- 自定义calllua
-- 多重封装，方便调用
function lua_call_global_func(player, str, ...)
    click(player, str, ...)
end

-- 判断是否是新版本
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
        Message:Msg9(player,"添加成功！")
    end
    if data == 2 then
        lualib:DelSkill(player, SkillIDCfg[name])
        Message:Msg9(player,"删除成功！")
    end
end

local equipLevelLimit = {
    [1] = "武器",
    [0] = "盔甲",
    [4] = "头盔",
    [3] = "项链",
    [6] = "左手",
    [5] = "右手",
    [8] = "左戒",
    [7] = "右戒",
    [10] = "腰带",
    [11] = "鞋子",
}
---获取玩家的套装装备等级
---@param player string 玩家对象
---@return number 套装装备等级
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
    local hqCount = lualib:GetVar(nil, VarCfg["合区次数"])
    if hqCount <= 0 then
        return lualib:GlobalInfo(3)
    else
        return hqCount
    end
end

function GeneralGlobalConfig.getReward(player)
    Message:Msg9(player, "领取奖励")
end

---获取当前玩家能一键升级的最大大陆以及当前大陆和当前大陆需要的充值金额
---@param player string 玩家对象
---@return number maxLand 最大大陆
---@return number curLand 当前大陆
---@return number curLandNeedCharge 当前大陆需要的充值金额
function GeneralGlobalConfig.getMaxUpLand(player)
    local platCharge = lualib:GetMoneyEx(player, "充值")
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

--关闭
function GeneralGlobalConfig.customClose(player)
    close(player)
end

GameEvent.add(EventCfg.onAddBag, GeneralGlobalConfig.onAddBag, GeneralGlobalConfig)
setFormAllowFunc("通用功能", { "openCK","customClose" })

Message.RegisterClickMsg("通用功能", GeneralGlobalConfig)
