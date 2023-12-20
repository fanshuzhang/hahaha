function HelperBox.RoleInfo(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local dataTb = {}
    for i=1, #HelperBox.constinfo do
        local sss = HelperBox.constinfo[i]
        table.insert(dataTb, {n=sss.n, v=parsetext(sss[1], target)})
    end
    for i=1, #HelperBox.baseinfo do
        local sss = HelperBox.baseinfo[i]
        table.insert(dataTb, {n=sss.n, v=lualib:GetBaseInfo(target, sss.id)})
    end
    lualib:DoClientUIMethod(player, "HelperBox_RoleInfo", dataTb)
end

function HelperBox.RoleStatus(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local dataTb = {}
    if not HelperBox.cfg_att_score then
        HelperBox.cfg_att_score = require("Envir/Extension/DirectorDir/Config/system/cfg_att_score.lua")
    end
    for i,v in pairs(HelperBox.cfg_att_score) do
        local sss = v
        if sss then
            local attType = "��ֵ"
            if sss.type == 1 then
                attType = "��ֵ"
            elseif sss.type == 2 then
                attType = "��ֱ�"
            elseif sss.type == 3 then
                attType = "�ٷֱ�"
            end
            table.insert(dataTb, {n=sss.name, v=attType..":"..lualib:GetBaseInfo(target, 51, sss.Idx)})
        end
    end

    lualib:DoClientUIMethod(player, "HelperBox_RoleStatus", dataTb)
end

function HelperBox.GSInfo(player)
    if not HelperBox:CheckPermission(player) then
        return
    end
    local dataTb = {}
    for i=1, #HelperBox.serverTb do
        table.insert(dataTb, {n=HelperBox.serverTb[i][1], v=lualib:GlobalInfo(HelperBox.serverTb[i][2])})
    end
    lualib:DoClientUIMethod(player, "HelperBox_GSInfo", dataTb)
end

function HelperBox.MemoryInfo(player)
    if not HelperBox:CheckPermission(player) then
        return
    end
    local dataTb = {}
    dataTb[1] = {n="������Lua�ڴ�", v=collectgarbage("count").."KB"}
    lualib:DoClientUIMethod(player, "HelperBox_MemoryInfo", dataTb)
end

function HelperBox.getMapTb(player)
    local dataTb = HelperBox.MapDB
    if not dataTb then
        dataTb = {}
        local line = 0
        local repeatBlank = 0
        while repeatBlank < 10 do
            callscriptex(player, "GetListString", "..\\MapInfo.txt", ""..tostring(line).."", "S0")
            line = line + 1
            if lualib:GetVar(player, "S0") == "" then
                repeatBlank = repeatBlank + 1
            else
                repeatBlank = 0
                local fileText = lualib:GetVar(player, "S0")

                local startpos, endpos = string.find(fileText, "%[.+%|.+%]")  -- ����"|"
                local name, desc
                if startpos then -- ����|
                    name, desc = fileText:match("%[(.-)|%s*(.-)%]")
                    local s1, s2 = desc:match("(.+)%s(.+)")
                    desc = s2
                else
                    name, desc = fileText:match("%[(.+)%s(.+)%]")
                end
                if name and desc then
                    dataTb[#dataTb+1] = {n=name, v=desc}
                end
            end
        end
        HelperBox.MapDB = dataTb
    end
    return dataTb
end

function HelperBox.MapInfo(player)
    if not HelperBox:CheckPermission(player) then
        return
    end
    local dataTb = HelperBox.getMapTb(player)
    lualib:DoClientUIMethod(player, "HelperBox_MapInfo", dataTb)
end

function HelperBox.MapInfoAction(player, mapId)
    if not HelperBox:CheckPermission(player) then
        return
    end
    lualib:MapMove(player, mapId)
end

function HelperBox.NpcInfo(player)
    if not HelperBox:CheckPermission(player) then
        return
    end
    --local mapInfo = HelperBox.getMapTb(player)
    local dataTb = {}
    if not HelperBox.cfg_npclist then
        HelperBox.cfg_npclist = require("Envir/Extension/DirectorDir/Config/system/cfg_npclist.lua")
    end


    local allLine = 0
    for i,v in pairs(HelperBox.cfg_npclist) do
        if i > allLine then
            allLine = i
        end
    end
    for i=1, allLine do
        local sss = HelperBox.cfg_npclist[i]
        if sss then
            local idx = sss.id
            if not (idx == "" or idx == nil or type(tonumber(idx)) ~= "number") then
                local sMapName = sss.sMapName
                local sX = sss.sX
                local sY = sss.sY
                local sName = sss.sName
                table.insert(dataTb,  { idx=idx, sMapName=sMapName, sX=sX, sY=sY, sName=sName })
            end
        end
    end

    lualib:DoClientUIMethod(player, "HelperBox_NpcInfo", dataTb)
end

function HelperBox.NpcInfoAction(player, mapId, x, y)
    if not HelperBox:CheckPermission(player) then
        return
    end
    lualib:MapMoveXY(player, mapId, x, y, 1)
end

function HelperBox.BuffInfo(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local dataTb = {[1]={n="BUFF��", v="buffId", g="buff���", a="����"}}
    local buffTb = getallbuffid(target)
    for i=1, #buffTb do
        local buff = buffTb[i]
        local buffName = getstdbuffinfo(buff, 1)
        local buffGroup = getstdbuffinfo(buff, 2)

        table.insert(dataTb,{n=buffName, v=buffTb[i], g=buffGroup})
    end
    lualib:DoClientUIMethod(player, "HelperBox_BuffInfo", dataTb)
end

function HelperBox.BuffInfoDeleteAction(player, targetName, buffId)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    buffId = tonumber(buffId)
    if not buffId then
        Message:Msg9(player, "��������ȷ��buffId")
        return
    end
    if not lualib:HasBuff(target, buffId) then
        Message:Msg9(player, "Ŀ��û�и�buff")
        return
    end
    lualib:DelBuff(target, buffId)
    Message:Msg9(player, "ɾ��buff�ɹ�")
    HelperBox.BuffInfo(player, targetName)
end