SpecialCoinManager = {}

---获取今日累充
---@return number
function SpecialCoinManager.getDayCountCharge(player)
    local coin = lualib:GetMoneyEx(player, "今日累充")
    local coinVar = lualib:GetVar(player, VarCfg["今日累充"])
    if coin ~= coinVar then
        coin = coinVar
        lualib:SetMoneyEx(player, "今日累充", "=", coinVar, "今日累充同步", false)
    end
    return coin
end

---设置今日累充
---@param _value number @设置的值
---@param _desc string @描述
---@param _push boolean @是否推送
---@return boolean
function SpecialCoinManager.setDayCountCharge(player, _value, _desc, _push)
    _push = _push or true
    local coin = lualib:GetMoneyEx(player, "今日累充")
    local coinVar = lualib:GetVar(player, VarCfg["今日累充"])
    if coin ~= coinVar then
        coin = coinVar
        --lualib:SetMoneyEx(player, "今日累充", "=", coinVar, "今日累充同步", false)
    end
    lualib:SetMoneyEx(player, "今日累充", "=", _value, _desc, _push)
    lualib:SetVar(player, VarCfg["今日累充"], _value)
    return true
end