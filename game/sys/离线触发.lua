function playoffline(player)
    callscriptex(player, "KILLSLAVE")
    lualib:SetVar(player, VarCfg["����������"], 0)
    lualib:SetVar(player, VarCfg["���������"], 0)
    lualib:SetVar(player, VarCfg["��ը�Ƴ�����"], 0)
    lualib:SetVar(player, VarCfg["�׼��Ƴ�����"], 0)
    lualib:SetVar(player, VarCfg["��������"], 0)
    ServerPlayerCache[player] = nil
end

function playreconnection(player)
    callscriptex(player, "KILLSLAVE")
    lualib:SetVar(player, VarCfg["����������"], 0)
    lualib:SetVar(player, VarCfg["���������"], 0)
    lualib:SetVar(player, VarCfg["��ը�Ƴ�����"], 0)
    lualib:SetVar(player, VarCfg["�׼��Ƴ�����"], 0)
    lualib:SetVar(player, VarCfg["��������"], 0)
    ServerPlayerCache[player] = nil
end
