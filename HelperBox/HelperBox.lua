
local var1 = "HelperBox页码"

function HelperBox.SetPlayer(player, targetName)
    local target = lualib:Name2GUID(targetName)
    if not (target and target ~= "" and target ~= "0") then
        Message:Msg9(player, string.format("操作失败，玩家【%s】不存在", targetName))
        return false
    end
    Message:Box(player, "设置成功，当前主操作玩家是"..tostring(targetName).."\\GUID="..tostring(target).."\\userId="..getconst(target, "<$USERID>"))
    --lualib:ChangeMode(player, 2, 65535, 0, 0)
    --lualib:MapMoveXY(player, lualib:GetMapId(target), lualib:X(target), lualib:Y(target), 1)
    lualib:DoClientUIMethod(player, "HelperBox_SetPlayer", targetName)
end

---检查权限
---@param player userdata 玩家
function HelperBox:CheckPermission(player)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if GeneralGlobalConfig.adminList[userAccount] == nil then
        Message:Msg9(player, "您没有权限使用该功能！")
        return false
    end
    return true
end

---获取目标，并检查权限
---@param player userdata 玩家
---@param targetName string 目标名字
function HelperBox:getTarget(player, targetName)
    if not self:CheckPermission(player) then
        Message:Msg9(player, "您没有权限使用该功能！")
        return false
    end
    local target = lualib:Name2GUID(targetName)
    if not (target and target ~= "" and target ~= "0") then
        Message:Msg9(player, string.format("操作失败，玩家【%s】不存在", targetName))
        return false
    end
    return target
end


function HelperBox.OpenUI(player)
    --local HelperBox = require("Envir/Extension/HelperBox/HelperBox_Data.lua")
    --lualib:ShowFormWithContent(player, "HelperBox/HelperBox_Main", {data=HelperBox})
    if not HelperBox:CheckPermission(player) then
        return
    end
    lualib:ShowFormWithContent(player, "HelperBox/HelperBox_Main", {})
end


--GameEvent.add(EventCfg.onClickNpc, HelperBox.onClicknpc, HelperBox)
