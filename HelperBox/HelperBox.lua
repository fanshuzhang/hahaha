
local var1 = "HelperBoxҳ��"

function HelperBox.SetPlayer(player, targetName)
    local target = lualib:Name2GUID(targetName)
    if not (target and target ~= "" and target ~= "0") then
        Message:Msg9(player, string.format("����ʧ�ܣ���ҡ�%s��������", targetName))
        return false
    end
    Message:Box(player, "���óɹ�����ǰ�����������"..tostring(targetName).."\\GUID="..tostring(target).."\\userId="..getconst(target, "<$USERID>"))
    --lualib:ChangeMode(player, 2, 65535, 0, 0)
    --lualib:MapMoveXY(player, lualib:GetMapId(target), lualib:X(target), lualib:Y(target), 1)
    lualib:DoClientUIMethod(player, "HelperBox_SetPlayer", targetName)
end

---���Ȩ��
---@param player userdata ���
function HelperBox:CheckPermission(player)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if GeneralGlobalConfig.adminList[userAccount] == nil then
        Message:Msg9(player, "��û��Ȩ��ʹ�øù��ܣ�")
        return false
    end
    return true
end

---��ȡĿ�꣬�����Ȩ��
---@param player userdata ���
---@param targetName string Ŀ������
function HelperBox:getTarget(player, targetName)
    if not self:CheckPermission(player) then
        Message:Msg9(player, "��û��Ȩ��ʹ�øù��ܣ�")
        return false
    end
    local target = lualib:Name2GUID(targetName)
    if not (target and target ~= "" and target ~= "0") then
        Message:Msg9(player, string.format("����ʧ�ܣ���ҡ�%s��������", targetName))
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
