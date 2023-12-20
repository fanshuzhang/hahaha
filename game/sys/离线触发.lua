function playoffline(player)
    callscriptex(player, "KILLSLAVE")
    lualib:SetVar(player, VarCfg["亡灵大军数量"], 0)
    lualib:SetVar(player, VarCfg["死灵大法数量"], 0)
    lualib:SetVar(player, VarCfg["爆炸蛊虫数量"], 0)
    lualib:SetVar(player, VarCfg["献祭蛊虫数量"], 0)
    lualib:SetVar(player, VarCfg["虫王数量"], 0)
    ServerPlayerCache[player] = nil
end

function playreconnection(player)
    callscriptex(player, "KILLSLAVE")
    lualib:SetVar(player, VarCfg["亡灵大军数量"], 0)
    lualib:SetVar(player, VarCfg["死灵大法数量"], 0)
    lualib:SetVar(player, VarCfg["爆炸蛊虫数量"], 0)
    lualib:SetVar(player, VarCfg["献祭蛊虫数量"], 0)
    lualib:SetVar(player, VarCfg["虫王数量"], 0)
    ServerPlayerCache[player] = nil
end
