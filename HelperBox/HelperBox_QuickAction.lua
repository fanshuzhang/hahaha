function HelperBox.QuickAction(player, targetName, pos)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    pos = tonumber(pos)
    if not HelperBox.ts1[pos] then
        Message:Msg9(player, "�ò���������")
        return
    end
    if pos == 1 then -- ������
        local itemList = getbagitems(target)
        for _,item in pairs(itemList) do
            local sid = getiteminfo(target, item, 1)
            if sid ~= nil then
                delitembymakeindex(target,sid)
            end
        end
        lualib:SysWarnMsg(player, "�������")
    elseif pos == 2 then -- �������
        clearitemmap(getbaseinfo(target, 3), getbaseinfo(target, 4), getbaseinfo(target, 5), 10)
        lualib:SysWarnMsg(player, "������Ϊ����10x10��Χ�ڵĵ�����Ʒ������ɣ�")
    elseif pos == 3 then -- �򿪲ֿ�
        openstorage(target)
        lualib:SysWarnMsg(player, "�򿪲ֿ����")
    elseif pos == 4 then -- �������
        clearskill(target)
        lualib:SysWarnMsg(player, "����������")
    elseif pos == 5 then -- ������
        setbagcount(target, 126)
        lualib:SysWarnMsg(player, "��İ�������Ϊ126��")
    elseif pos == 6 then -- ���ֿ�
        changestorage(target, 144)
        lualib:SysWarnMsg(player, "��Ĳֿ����Ϊ144��")
    elseif pos == 7 then
        openhyperlink(target, 34)
    elseif pos == 8 then
        mapmove(player, "3", 126, 103, 10)
    elseif pos == 9 then
        repairall(player)
        lualib:SysWarnMsg(player, "װ���������")
    elseif pos == 10 then
        lualib:ChangeMode(player, 2, 0, 0, 0)
        Message:Warn(player, "����������")
    elseif pos == 11 then
        lualib:ChangeMode(player, 1, 0,0,0)
        Message:Warn(player, "����޵����")
    elseif pos == 12 then
        local mapId = lualib:GetMapId(player)
        local mobList = lualib:GetObjectInMap(mapId, 0, 0, 500, 2)
        for i,v in pairs(mobList) do
            killmonbyobj(player, v, false, false, false)
        end
    elseif pos == 13 then
        callscriptex(player, "KICKDUMMY")
        Message:Msg9(player, "�޳����˳ɹ�")
    elseif pos == 14 then
        callscriptex(player, "DummyloGon", 3, 126, 103, 10, 0, 50, 30, 2)
        Message:Msg9(player, "��¼���˳ɹ�")
    elseif pos == 15 then
        callscriptex(player, "Tdummy", "*", "*", "*")
        Message:Msg9(player, "�޳��һ��ɹ�")
    elseif pos == 16 then
        if lualib:CastleInfo(5) then
            callscriptex(player, "GMEXECUTE", "����")
        else
            addattacksabakall()
            callscriptex(player, "GMEXECUTE", "����")
        end
    elseif pos == 17 then
        setgmlevel(player, 10)
        Message:Msg9(player, "����ǰ�Ѿ���ʮ��Ȩ��")
        --lualib:Kick(player)
    elseif pos == 18 then
        setgmlevel(player, 0)
        Message:Msg9(player, "����ǰ�Ѿ���0��Ȩ��")
        --lualib:Kick(player)
    end
end