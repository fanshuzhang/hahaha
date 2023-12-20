SpecialCoinManager = {}

---��ȡ�����۳�
---@return number
function SpecialCoinManager.getDayCountCharge(player)
    local coin = lualib:GetMoneyEx(player, "�����۳�")
    local coinVar = lualib:GetVar(player, VarCfg["�����۳�"])
    if coin ~= coinVar then
        coin = coinVar
        lualib:SetMoneyEx(player, "�����۳�", "=", coinVar, "�����۳�ͬ��", false)
    end
    return coin
end

---���ý����۳�
---@param _value number @���õ�ֵ
---@param _desc string @����
---@param _push boolean @�Ƿ�����
---@return boolean
function SpecialCoinManager.setDayCountCharge(player, _value, _desc, _push)
    _push = _push or true
    local coin = lualib:GetMoneyEx(player, "�����۳�")
    local coinVar = lualib:GetVar(player, VarCfg["�����۳�"])
    if coin ~= coinVar then
        coin = coinVar
        --lualib:SetMoneyEx(player, "�����۳�", "=", coinVar, "�����۳�ͬ��", false)
    end
    lualib:SetMoneyEx(player, "�����۳�", "=", _value, _desc, _push)
    lualib:SetVar(player, VarCfg["�����۳�"], _value)
    return true
end