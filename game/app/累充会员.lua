---@class AppLCHYrecharge 累充会员

local AppLCHYrecharge = {}
AppLCHYrecharge.Name = "累充会员"
local AppLCHYrechargeCfg = zsf_RequireAppCfg(AppLCHYrecharge.Name)

--
function AppLCHYrecharge.getVarTb(player)
    local varTb = {}
    -- local level = lualib:GetVar(player, VarCfg["累充会员"]) or 0
    local level = 0
    local rechargeNum = lualib:GetMoney(player, 5) or 0 --累计充值
    for _, value in ipairs(AppLCHYrechargeCfg.list) do
        if querymoney(player, 5) >= value.needNum then
            level = level + 1
        else
            break
        end
    end
    varTb.level = level
    varTb.rechargeNum = rechargeNum
    local isReceive = {}
    local jsonStr = lualib:GetVar(player, VarCfg["累充会员领取状态"])
    if jsonStr == '' then
        isReceive = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        lualib:SetVar(player, VarCfg["累充会员领取状态"], tbl2json(isReceive))
    else
        isReceive = json2tbl(jsonStr)
    end
    varTb.isReceive = isReceive
    return varTb
end

function AppLCHYrecharge.main(player)
    local varTb = AppLCHYrecharge.getVarTb(player)
    lualib:ShowFormWithContent(player, "app/" .. AppLCHYrecharge.Name,
        { data = varTb, version = AppLCHYrechargeCfg.version })
end

--领取
function AppLCHYrecharge.MoveOk(player, index)
    if not index then
        return
    end
    local varTb = AppLCHYrecharge.getVarTb(player)
    if not varTb.isReceive[index] then
        release_print("参数error！")
        return
    end
    index = tonumber(index)
    --是否已领取
    if varTb.isReceive[index] == 1 then
        Message:Msg9(player, "你已经领取过该福利，无法重复领取！")
        return
    end
    --是否按顺序领取
    if index > 1 and varTb.isReceive[index - 1] ~= 1 then
        Message:Msg9(player, "请按顺序领取！")
        return
    end
    --充值是否足够
    if querymoney(player, 5) < AppLCHYrechargeCfg.list[index].needNum then
        Message:Msg9(player, "尊敬的VIP客户，您的充值点不足，请稍后再来领取！")
        --Message:Box(player, "尊敬的VIP用户，您的充值点不足！是否前往充值", "", "@exit")
        return
    end
    --背包空间是否充足
    if lualib:GetBagFree(player) < 8 then
        Message:Msg9(player, "您的背包空间不足8格，无法领取！")
        return
    end
    --给物品
    lualib:AddBatchItem(player, AppLCHYrechargeCfg.list[index].give, "vip福利领取", 2)
    --设置已领取
    varTb.isReceive[index] = 1
    lualib:SetVar(player, VarCfg["累充会员领取状态"], tbl2json(varTb.isReceive))
    --给称号
    if index > 1 then
        lualib:DelTitle(player, AppLCHYrechargeCfg.list[index - 1].e[1]) --删除称号
    end
    lualib:AddTitleEx(player, AppLCHYrechargeCfg.list[index].e[1])       --给称号
    TitleShow.RefreshTitleShow(player)
    varTb = AppLCHYrecharge.getVarTb(player)
    lualib:DoClientUIMethodEx(player, AppLCHYrecharge.Name .. "_notifyWnd", 1, varTb)
end

--版本不对，数据重载，重新发送配置表到客户端
function AppLCHYrecharge.reloadData(player)
    lualib:DoClientUIMethodEx(player, AppLCHYrecharge.Name .. "_setNewData", 1, AppLCHYrechargeCfg)
end

--游戏事件
setFormAllowFunc(AppLCHYrecharge.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg("累充会员", AppLCHYrecharge)
return AppLCHYrecharge
