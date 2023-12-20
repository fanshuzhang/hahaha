-- 每秒执行
function ontimer1(player)
    if lualib:GetInt(player, "脱战CD") > 0 then
        lualib:SetInt(player, "脱战CD", lualib:GetInt(player, "脱战CD") - 1)
    end
    --复活
    
end

-- 每分钟执行
function ontimer2(player)
    -- 在线时长
    local onlineMin = lualib:GetVar(player, VarCfg["我的在线时间"])
    lualib:SetVar(player, VarCfg["我的在线时间"], onlineMin + 1)
    lualib:SetVar(player, VarCfg["我的总在线时间"], lualib:GetVar(player, VarCfg["我的总在线时间"]) + 1)
    if lualib:GetMoneyEx(player, "充值") > 0 then
        if NpcFreeMonkey and NpcFreeMonkey.MoveOk then
            NpcFreeMonkey.MoveOk(player)
        end
    end
    if lualib:GetInt(player, "是否解封") == 0 then
        lualib:DelayGoto(player, 333, "click,封测脚本_main", false)
    end
    --地狱鬼爪-大魔导师
    if lualib:GetVar(player, VarCfg["角色职业"]) == 6 and Magic.ClawCount(player) >= 2 then
        --添加Buff-50005
        if addbuff(player, 50005, 20, 1, player, {}) then
            Message:SendClawmsg(player, "地狱鬼爪：释放魔法盾，减少20%所受伤害")
        end
    end
end

-- 每20秒执行 回收
function ontimer3(player)
    -- 回收处理
    if lualib:GetVar(player, VarCfg["自动回收"]) == 1 then
        if lualib:GetBagFree(player) < 80 and AppEquipCycle.beginCycle then
            AppEquipCycle.beginCycle(player)
        end
    end
    --刷新爆率
    local baolv = lualib:GetValueEx(player, 203) --虚假爆率
    local _baolv = baolv / 10
    callscriptex(player, "KILLMONBURSTRATE", 100 + _baolv, 65535)
end

function ontimer5(player)
    -- 回收处理
    if lualib:GetVar(player, VarCfg["自动吃货币"]) == 1 then

    end
end

-- 每5秒执行
function ontimer4(player)
    
end
