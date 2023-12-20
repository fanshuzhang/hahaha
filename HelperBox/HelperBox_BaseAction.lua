function HelperBox.BaseAction(player, targetName)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    local dataTb = {}
    for i=1, #HelperBox.baseEnter do
        local v = HelperBox.baseEnter[i].v
        local value = lualib:GetBaseInfo(target, v)
        if value then
            table.insert(dataTb, value)
        end
    end
    lualib:DoClientUIMethod(player, "HelperBox_BaseAction", dataTb)
end

function HelperBox.BaseActionEx(player, targetName, pos, inputText)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    pos = tonumber(pos)
    inputText = tonumber(inputText)
    if not inputText then
        Message:Msg9(player, "请输入数字！")
        return
    end
    local sss = HelperBox.baseEnter[pos]
    if sss then
        local v = sss.v
        lualib:SetBaseInfo(target, v, inputText)
        lualib:RefreshPlayer(target)
        Message:Msg9(player, table.concat({"设置成功，玩家",targetName,"的",sss.input,"为：",inputText}, ""))
    end
    local dataTb = {}
    for i=1, #HelperBox.baseEnter do
        local v = HelperBox.baseEnter[i].v
        local value = lualib:GetBaseInfo(target, v)
        if value then
            table.insert(dataTb, value)
        end
    end
    lualib:DoClientUIMethod(player, "HelperBox_BaseActionUpdate", dataTb)
end