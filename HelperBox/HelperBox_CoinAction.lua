function HelperBox.getDataTb(target)
    local dataTb = {}
    if not HelperBox.cfg_item then
        HelperBox.cfg_item = require("Envir/Extension/DirectorDir/Config/system/cfg_item.lua")
    end
    for i=1, 100 do
        local v = HelperBox.cfg_item[i]
        if v then
            local value = lualib:GetMoney(target, v.Idx)
            if value then
                table.insert(dataTb, {n=v.Name,v=value, id=v.Idx})
            end
        end
    end
    return dataTb
end

function HelperBox.CoinAction(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local dataTb = HelperBox.getDataTb(target)
    lualib:DoClientUIMethod(player, "HelperBox_CoinAction", dataTb)
end

function HelperBox.CoinActionEx(player, targetName, pos, inputText)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    pos = tonumber(pos)
    if string.find(inputText, "+") then
        local backTb = string.split(inputText, "+")
        local value1, value2 = backTb[1], backTb[2]
        value1 = tonumber(value1)
        value2 = tonumber(value2)
        if not value1 or not value2 then
            Message:Msg9(player, "���������֣�")
            return
        end
        inputText = value1 + value2
    elseif string.find(inputText, "-") then
        local backTb = string.split(inputText, "-")
        local value1, value2 = backTb[1], backTb[2]
        value1 = tonumber(value1)
        value2 = tonumber(value2)
        if not value1 or not value2 then
            Message:Msg9(player, "���������֣�")
            return
        end
        inputText = value1 - value2
    end
    inputText = tonumber(inputText)
    if not inputText then
        Message:Msg9(player, "��+-�������������֣�")
        return
    end
    local dataTb = HelperBox.getDataTb(target)
    if dataTb[pos] then
        lualib:SetMoneyEx(target, dataTb[pos].n, "=", inputText, "HelperBox����", true)
        Message:Msg9(player, table.concat({"���óɹ������",targetName,"�Ļ��ң�",dataTb[pos].n,"Ϊ��",inputText}, ""))
        dataTb[pos].v = inputText
    end
    lualib:DoClientUIMethod(player, "HelperBox_CoinActionUpdate", dataTb)
end