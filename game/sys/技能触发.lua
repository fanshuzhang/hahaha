---magselffunc(X) 自身使用技能触发
---magtagfunc(X) 对目标人物使用技能时自身触发
---magmonfunc(X) 对目标怪物使用技能时自身触发
---magtagfuncex(X) 对目标人物释放技能时对方触发参数传递--玩家，技能名字，技能ID
---beginmagic()

Magic = {}

--获得技能强化等级
function Magic.BBcountEX(player, skillID)
    return getskillinfo(player, skillID, 2)
end

--获取鬼爪强化第几重
function Magic.ClawCount(player)
    local level = NpcHellishGhostClaw.getVarTb(player).level
    if level >= 9 then
        return 3
    elseif level >= 6 then
        return 2
    elseif level >= 3 then
        return 1
    else
        return 0
    end
end

--获取人物主属性
function Magic.GetPlayerAtt(player)
    local attUp, attLow
    local Job = lualib:Job(player)
    if Job == 0 then
        attUp = getbaseinfo(player, 20)
        attLow = getbaseinfo(player, 19)
    elseif Job == 1 then
        attUp = getbaseinfo(player, 22)
        attLow = getbaseinfo(player, 21)
    elseif Job == 2 then
        attUp = getbaseinfo(player, 24)
        attLow = getbaseinfo(player, 23)
    end
    return attUp, attLow
end

--宝宝叛变杀死宝宝
function heromobtreachery(player, hero, mon)
    killmonbyobj(player, mon, false, false, false)
end

---自身使用任意技能前触发   返回值：true/nil=允许施法  false=阻止施法
function beginmagic(player, maigicID, maigicName, targetObject, x, y)
    release_print(maigicName)
    local mapID = lualib:GetMapId(player)
    GameEvent.push(EventCfg.onBeginmagic, player, maigicID, maigicName, targetObject, x, y, mapID)
end

--狂暴战士
function magselffunc26(player) --烈火
    if Magic.ClawCount(player) >= 1 then
        lualib:SetFlagStatus(player, PlayerVarCfg["烈火剑法"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>地狱鬼爪：使用烈火,下次攻击伤害提升10%</font>")
    end
end

function magselffunc66(player) --开天
    if Magic.ClawCount(player) >= 2 then
        lualib:SetFlagStatus(player, PlayerVarCfg["开天剑法"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>地狱鬼爪：使用开天,下次攻击伤害提升20%</font>")
    end
end

function magselffunc66(player) --逐日
    if Magic.ClawCount(player) >= 3 then
        lualib:SetFlagStatus(player, PlayerVarCfg["逐日剑法"], 1)
        Message:Msg9(player, "<font color=\'#00FFFF\'>地狱鬼爪：使用逐日,下次攻击伤害提升30%</font>")
    end
end

return Magic
