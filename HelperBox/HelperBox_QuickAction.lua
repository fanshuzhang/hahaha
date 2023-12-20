function HelperBox.QuickAction(player, targetName, pos)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    pos = tonumber(pos)
    if not HelperBox.ts1[pos] then
        Message:Msg9(player, "该操作不存在")
        return
    end
    if pos == 1 then -- 清理背包
        local itemList = getbagitems(target)
        for _,item in pairs(itemList) do
            local sid = getiteminfo(target, item, 1)
            if sid ~= nil then
                delitembymakeindex(target,sid)
            end
        end
        lualib:SysWarnMsg(player, "清理完毕")
    elseif pos == 2 then -- 清理地面
        clearitemmap(getbaseinfo(target, 3), getbaseinfo(target, 4), getbaseinfo(target, 5), 10)
        lualib:SysWarnMsg(player, "以人物为中心10x10范围内的地面物品清理完成！")
    elseif pos == 3 then -- 打开仓库
        openstorage(target)
        lualib:SysWarnMsg(player, "打开仓库完毕")
    elseif pos == 4 then -- 清除技能
        clearskill(target)
        lualib:SysWarnMsg(player, "清除技能完毕")
    elseif pos == 5 then -- 开背包
        setbagcount(target, 126)
        lualib:SysWarnMsg(player, "你的包裹格子为126个")
    elseif pos == 6 then -- 开仓库
        changestorage(target, 144)
        lualib:SysWarnMsg(player, "你的仓库格子为144个")
    elseif pos == 7 then
        openhyperlink(target, 34)
    elseif pos == 8 then
        mapmove(player, "3", 126, 103, 10)
    elseif pos == 9 then
        repairall(player)
        lualib:SysWarnMsg(player, "装备修理完毕")
    elseif pos == 10 then
        lualib:ChangeMode(player, 2, 0, 0, 0)
        Message:Warn(player, "解除隐身完毕")
    elseif pos == 11 then
        lualib:ChangeMode(player, 1, 0,0,0)
        Message:Warn(player, "解除无敌完毕")
    elseif pos == 12 then
        local mapId = lualib:GetMapId(player)
        local mobList = lualib:GetObjectInMap(mapId, 0, 0, 500, 2)
        for i,v in pairs(mobList) do
            killmonbyobj(player, v, false, false, false)
        end
    elseif pos == 13 then
        callscriptex(player, "KICKDUMMY")
        Message:Msg9(player, "剔除假人成功")
    elseif pos == 14 then
        callscriptex(player, "DummyloGon", 3, 126, 103, 10, 0, 50, 30, 2)
        Message:Msg9(player, "登录假人成功")
    elseif pos == 15 then
        callscriptex(player, "Tdummy", "*", "*", "*")
        Message:Msg9(player, "剔除挂机成功")
    elseif pos == 16 then
        if lualib:CastleInfo(5) then
            callscriptex(player, "GMEXECUTE", "攻城")
        else
            addattacksabakall()
            callscriptex(player, "GMEXECUTE", "攻城")
        end
    elseif pos == 17 then
        setgmlevel(player, 10)
        Message:Msg9(player, "您当前已经是十级权限")
        --lualib:Kick(player)
    elseif pos == 18 then
        setgmlevel(player, 0)
        Message:Msg9(player, "您当前已经是0级权限")
        --lualib:Kick(player)
    end
end