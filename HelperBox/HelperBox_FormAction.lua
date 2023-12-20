function HelperBox.FormAction(player, targetName, page1, page2, ...)
    local target = HelperBox:getTarget(player, targetName)
    if not target then
        return
    end
    page1 = tonumber(page1)
    page2 = tonumber(page2)
    if not page1 or not page2 then
        Message:Msg9(player, "index param error!")
        return
    end
    local findTarget = HelperBox[page1][page2].call
    click(target, findTarget, player, ...)
end

---ˢ��Ʒ
function HelperBox.FormActionCreateItem(target, actionPlayer, itemId, count, rule)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    local itemName
    if tonumber(itemId) then
        itemId = tonumber(itemId)
    else
        itemName = itemId
    end
    if tonumber(itemId) then
        itemName = lualib:GetStdItemInfo(itemId, 1)
    end
    count = tonumber(count)
    count = count or 1
    local ruleTb = {}
    if rule ~= "" then
        ruleTb = string.split(rule, "#")
    end

    lualib:AddItem(target, itemName, count, lualib:CalItemRuleCountEx(ruleTb), "HelperBox����")
    Message:Msg9(actionPlayer, string.format("�ɹ�����ҡ�%s����������%s * %s", lualib:Name(target), itemName, count))
end

---���ɹ���
function HelperBox.FormActionGenMonster(target, actionPlayer, mobId, mapId, x, y, count, range)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    range = tonumber(range)
    if not range then
        range = 1
    end
    if tonumber(mobId) then
        local mobName = getmonbaseinfo(mobId, 1)
        if mobName ~= "" and mobName ~= nil then
            mobId = mobName
        else
            return
        end
    end
    if count ~= "" then
        if tonumber(count) then
            count = tonumber(count)
        else
            Message:Box(actionPlayer, "������������")
            return
        end
    else
        count = 1
    end
    if x ~= "" then
        if tonumber(x) then
            x = tonumber(x)
        else
            Message:Box(actionPlayer, "������������")
            return
        end
    else
        x = lualib:X(actionPlayer)
    end
    if y ~= "" then
        if tonumber(y) then
            y = tonumber(y)
        else
            Message:Box(actionPlayer, "������������")
            return
        end
    else
        y = lualib:Y(actionPlayer)
    end
    if mapId == "" then
        mapId = lualib:GetMapId(actionPlayer)
    end
    local mobList = genmon(mapId, x, y, mobId, range, count, 255)
    if #mobList > 0 then
        lualib:SysWarnMsg(actionPlayer, "ˢ�ֳɹ���")
    else
        lualib:SysWarnMsg(actionPlayer, "ˢ��ʧ�ܣ�")
    end
end

---����json��Ʒ
function HelperBox.FormActionCreateJsonItem(target, actionPlayer, jsonInfo)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if lualib:GetBagFree(target) < 7 then
        Message:Box(target, "�����ռ䲻��")
        return
    end
    lualib:GiveItemByJson(target, jsonInfo)
end

---����ˢ��Ʒ
function HelperBox.FormActionThrowItem(target, actionPlayer, itemName)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    throwitem(target, lualib:GetMapId(target), lualib:X(target), lualib:Y(target), 2, itemName, 1, 10, true, false, false, false)
end

---��ѯȫ�ֱ���
function HelperBox.FormActionGetSysVar(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    local varValue = ""
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    varValue = lualib:GetVar(nil, varname)
    Message:Msg9(actionPlayer, string.format("ȫ�ֱ���,��ѯ������:%s������ֵΪ:%s", varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---����ȫ�ֱ���
function HelperBox.FormActionSetSysVar(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if varvalue == "nil" then
        lualib:SetVar(nil, varname, 0)
        lualib:SetVar(nil, varname, "")
    else
        if varvalue == "" then
            HelperBox.FormActionGetSysVar(target, actionPlayer, varname)
            return
        else
            lualib:SetVar(nil, varname, varvalue)
        end
    end
    local setFlag
    if tostring(lualib:GetVar(nil, varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end

    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���ȫ�ֱ�������ѯ������:%s������ֵΪ:%s", varname, lualib:GetVar(nil, varname)))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�ȫ�ֱ�������ѯ������:%s������ֵΪ:%s", varname, lualib:GetVar(nil, varname)))
    end

end

---��ѯ����int�����Զ������
function HelperBox.FormActionGetSelfCustomVarInt(target, actionPlayer, varArea, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "�����������Χ") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "������Χ�������") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    iniplayvar(target, "integer", varArea, varname)
    local varValue = getplayvar(target, varArea, varname)
    Message:Msg9(actionPlayer, string.format("Ŀ����ң�%s,��ѯ������:%s���Զ�������%s������ֵΪ:%s", lualib:Name(target), varname, "integer",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---���ø���int�����Զ������
function HelperBox.FormActionSetSelfCustomVarInt(target, actionPlayer, varArea, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "�����������Χ") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "������Χ�������") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "�����뱣������") return end
    insertFlag = tonumber(insertFlag)
    iniplayvar(target, "integer", varArea, varname)


    if varvalue == "nil" then
        setplayvar(target, varArea, varname, 0, insertFlag)
    else
        if varvalue == "" then
            HelperBox.FormActionGetSelfCustomVarInt(target, actionPlayer, varArea, varname)
            return
        else
            setplayvar(target, varArea, varname, varvalue, insertFlag)
        end
    end
    local setFlag
    if tostring(getplayvar(target, varArea, varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���Ŀ����ң�%s,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", lualib:Name(target), varname, "integer", varvalue))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�Ŀ����ң�%s,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", lualib:Name(target), varname, "integer", varvalue))
    end
end

---��ѯ����str�����Զ������
function HelperBox.FormActionGetSelfCustomVarStr(target, actionPlayer, varArea, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "�����������Χ") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "������Χ�������") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    iniplayvar(target, "string", varArea, varname)
    local varValue = getplayvar(target, varArea, varname)
    Message:Msg9(actionPlayer, string.format("Ŀ����ң�%s,��ѯ������:%s���Զ�������%s������ֵΪ:%s", lualib:Name(target), varname, "string",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---���ø���str�����Զ������
function HelperBox.FormActionSetSelfCustomVarStr(target, actionPlayer, varArea, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "�����������Χ") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "������Χ�������") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "�����뱣������") return end
    insertFlag = tonumber(insertFlag)
    iniplayvar(actionPlayer, "string", varArea, varname)


    if varvalue == "nil" then
        setplayvar(target, varArea, varname, "", insertFlag)
    else
        if varvalue == "" then
            HelperBox.FormActionGetSelfCustomVarStr(target, actionPlayer, varArea, varname)
            return
        else
            setplayvar(target, varArea, varname, varvalue, insertFlag)
        end
    end
    local setFlag
    if tostring(getplayvar(target, varArea, varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���Ŀ����ң�%s,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", lualib:Name(target), varname, "string", varvalue))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�Ŀ����ң�%s,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", lualib:Name(target), varname, "string", varvalue))
    end
end

---��ѯȫ��int�����Զ������
function HelperBox.FormActionGetSysCustomVarInt(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    inisysvar("integer", varname)
    local varValue = getsysvarex(varname)
    Message:Msg9(actionPlayer, string.format("ȫ���Զ������,��ѯ������:%s���Զ�������%s������ֵΪ:%s", varname, "integer",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---����ȫ��int�����Զ������
function HelperBox.FormActionSetSysCustomVarInt(target, actionPlayer, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "�����뱣������") return end
    insertFlag = tonumber(insertFlag)
    inisysvar("integer", varname)

    if varvalue == "nil" then
        setsysvarex(varname, 0, insertFlag)
    else
        if varvalue == "" then
            HelperBox.FormActionGetSysCustomVarInt(target, actionPlayer, varname)
            return
        else
            setsysvarex(varname, tonumber(varvalue), insertFlag)
        end
    end
    local setFlag
    if tostring(getsysvarex(varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���ȫ���Զ������,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", varname, "integer", lualib:GetDBVar(varname)))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�ȫ���Զ������,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", varname, "integer", lualib:GetDBVar(varname)))
    end
end

---��ѯȫ��str�����Զ������
function HelperBox.FormActionGetSysCustomVarStr(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    inisysvar("string", varname)
    local varValue = getsysvarex(varname)
    Message:Msg9(actionPlayer, string.format("ȫ���Զ������,��ѯ������:%s���Զ�������%s������ֵΪ:%s", varname, "string",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---����ȫ��str�����Զ������
function HelperBox.FormActionSetSysCustomVarStr(target, actionPlayer, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "�����뱣������") return end
    insertFlag = tonumber(insertFlag)
    inisysvar("string", varname)

    if varvalue == "nil" then
        setsysvarex(varname, "", insertFlag)
    else
        if varvalue == "" then
            HelperBox.FormActionGetSysCustomVarStr(target, actionPlayer, varname)
            return
        else
            setsysvarex(varname, tostring(varvalue), insertFlag)
        end
    end
    local setFlag
    if tostring(getsysvarex(varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���ȫ���Զ������,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", varname, "string", lualib:GetDBVar(varname)))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�ȫ���Զ������,��ѯ������:%s���Զ������ͣ�%s,����ֵΪ:%s", varname, "string", lualib:GetDBVar(varname)))
    end
end

---��ѯ���˱�ʶ
function HelperBox.FormActionGetStatus(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    varname = tonumber(varname)
    if type(varname) ~= "number" then  lualib:MsgBox(actionPlayer, "�뽫varname���봿����") return end
    local varValue = getflagstatus(target, varname)
    Message:Msg9(actionPlayer, string.format("Ŀ����ң�%s,��ѯ��ʶ���:%d������ֵΪ:%s", lualib:Name(target), varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---���ø��˱�ʶ
function HelperBox.FormActionSetStatus(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    varname = tonumber(varname)
    if type(varname) ~= "number" then  lualib:MsgBox(actionPlayer, "�뽫varname���봿����") return end

    if varvalue == "nil" then
        setflagstatus(target, varname, 0)
    else

        if varvalue == "" then
            HelperBox.FormActionGetStatus(target, actionPlayer, varname)
            return
        else
            varvalue = tonumber(varvalue)
            if type(varvalue) ~= "number" then  lualib:MsgBox(actionPlayer, "�뽫varvalue���봿����") return end

            setflagstatus(target, varname, varvalue)
        end
    end
    local setFlag
    if tostring(getflagstatus(target, varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���Ŀ����ң�%s,��ѯ������:%s������ֵΪ:%s", lualib:Name(target), varname, varvalue))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�Ŀ����ң�%s,��ѯ������:%s������ֵΪ:%s", lualib:Name(target), varname, varvalue))
    end
end

---���ø��˱���
function HelperBox.FormActionSetVar(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    if varvalue == "nil" then
        lualib:SetVar(target, varname, 0)
        lualib:SetVar(target, varname, "")
    else
        if varvalue == "" then
            HelperBox.FormActionGetVar(target, actionPlayer, varname)
            return
        else
            lualib:SetVar(target, varname, varvalue)
        end
    end
    local setFlag
    if tostring(lualib:GetVar(target, varname)) == tostring(varvalue) then
        setFlag = true
    else
        setFlag = false
    end
    if setFlag then
        Message:Msg9(actionPlayer, string.format("���óɹ���Ŀ����ң�%s,��ѯ������:%s������ֵΪ:%s", lualib:Name(target), varname, varvalue))
    else
        Message:Msg9(actionPlayer, string.format("����ʧ�ܣ�Ŀ����ң�%s,��ѯ������:%s������ֵΪ:%s", lualib:Name(target), varname, varvalue))
    end
end

---��ѯ���˱���
function HelperBox.FormActionGetVar(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "�����������") return end
    local varValue = lualib:GetVar(target, varname)
    lualib:SetStr(actionPlayer, "GMBOX��ѯ���", varValue)
    Message:Msg9(actionPlayer, string.format("Ŀ����ң�%s,��ѯ������:%s������ֵΪ:%s", lualib:Name(target), varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---��ҳƺŵĲ�������
function HelperBox.FormActionTitleAction(target, actionPlayer, addTitleName, delTitleName, queryTitleName)
    if not HelperBox:CheckPermission(actionPlayer) then return false end

    if addTitleName ~= "" then
        if confertitle(target, addTitleName, 1) then
            Message:Msg9(actionPlayer, string.format("�����%s��ӳƺ�%s�ɹ�", getbaseinfo(target, 1), addTitleName))
        else
            Message:Msg9(actionPlayer, string.format("�����%s��ӳƺ�%sʧ��", getbaseinfo(target, 1), addTitleName))
        end
    end
    if delTitleName ~= "" then
        if deprivetitle(target, delTitleName) then
            Message:Msg9(actionPlayer, string.format("�����%sɾ���ƺ�%s�ɹ�", getbaseinfo(target, 1), delTitleName))
        else
            Message:Msg9(actionPlayer, string.format("�����%sɾ���ƺ�%sʧ��", getbaseinfo(target, 1), delTitleName))
        end
    end
    if queryTitleName ~= "" then
        if checktitle(target, queryTitleName) then
            Message:Msg9(actionPlayer, string.format("��ѯ�����%sӵ�гƺ�%s", getbaseinfo(target, 1), queryTitleName))
        else
            Message:Msg9(actionPlayer, string.format("��ѯ�����%sû�гƺ�%s", getbaseinfo(target, 1), queryTitleName))
        end
    end
end

---���buff�Ĳ�������
function HelperBox.FormActionBuffAction(target, actionPlayer, updateBuffId, extraStatus)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    local statusTb = {}
    if extraStatus ~= "" then
        local extraStatusTempTb = string.split(extraStatus, "&")
        for _, v in pairs(extraStatusTempTb) do
            local tempTb = string.split(v, "#")
            statusTb[tonumber(tempTb[1])] = tonumber(tempTb[2])
        end
    end
    updateBuffId = tonumber(updateBuffId)
    if updateBuffId then
        if lualib:AddBuffEx(target, updateBuffId, 0, 1, target, statusTb) then
            Message:Msg9(actionPlayer, string.format("�����%s���buff%s�ɹ�", getbaseinfo(target, 1), updateBuffId))
        else
            Message:Msg9(actionPlayer, string.format("�����%s���buff%sʧ��", getbaseinfo(target, 1), updateBuffId))
        end
    end

end

---����������ԣ�����Ч�ڣ�
function HelperBox.FormActionSetTimeAtt(target, actionPlayer, statusId, statusValue, timeLimit)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    changehumabiliy(target, statusId, statusValue, timeLimit)
    Message:Msg9(actionPlayer, "�������")
end

---���߲����ʼ�
function HelperBox.FormActionSendMail(target, actionPlayer, itemStr, mailId, mailTitle, mailDesc)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    mailId = tonumber(mailId)
    if not mailId or (mailId <= 0) then
        mailId = 10000
    end
    if not mailTitle or type(mailTitle) ~= "string" or mailTitle == "" then
        mailTitle = "������Ʒ"
    end
    if not mailDesc or type(mailDesc) ~= "string" or mailDesc == "" then
        mailDesc = "����"
    end
    lualib:SendMail(target,mailId,mailTitle,mailDesc,itemStr)
    Message:Msg9(actionPlayer,string.format("���������%s�ɹ���", lualib:Name(target)))
end

---ģ�����߳�ֵ
function HelperBox.FormActionChargeMonitor(target, actionPlayer, value, coinId, finger)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if finger and finger ~= "" then
        local fingerTb = string.split(finger, "#")
        lualib:SetVar(target, fingerTb[1], value..fingerTb[2])
    end
    coinId = math.floor(math.abs(tonumber(coinId)))
    value = math.floor(math.abs(tonumber(value)))
    lualib:SetVar(target, "M0", value)
    lualib:SetVar(target, "N0", coinId)
    lualib:SetMoney(target, coinId, "+", value, "ģ���ֵ����", true)
    recharge(target, value, 0, coinId)
    Message:Msg9(actionPlayer, string.format("���ͳ�ֵ%dԪ�����%s�ɹ���", value, lualib:Name(target)))
end

---������Ч
function HelperBox.FormActionBodyEffect(target, actionPlayer, eid, ox, oy, t, b, ss)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if t == "-1" then
        clearplayeffect(target, tonumber(eid))
        Message:Msg9(actionPlayer, "ȡ����Ч�ɹ���")
    else
        playeffect(target, tonumber(eid), tonumber(ox), tonumber(oy), tonumber(t), tonumber(b), tonumber(ss))
        Message:Msg9(actionPlayer, "������Ч�ɹ���")
    end
end

---ͷ��
function HelperBox.FormActionHeadEffect(target, actionPlayer, where, eft, rn, x, y, ad, ss)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    seticon(target, tonumber(where), tonumber(eft), rn, tonumber(x), tonumber(y), tonumber(ad), tonumber(ss))
    Message:Msg9(target, "����ͷ��ɹ���")
end

---���ô���ű�����
function HelperBox.FormActionCallScriptInterface(target, actionPlayer, scriptName, ...)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if scriptName == "" then lualib:MsgBox(actionPlayer, "��ע�⣬��������������Ϊ�գ�") return end
    print(scriptName)
    callscriptex(target, scriptName, unpack({ ... }))
    Message:Msg9(actionPlayer, "�������")
end

---����xT�ű���ǩ
function HelperBox.FormActionCallScriptFunc(target, actionPlayer, fileName, labelName)
    if not HelperBox:CheckPermission(actionPlayer) then return end
    if fileName == "" then lualib:MsgBox(actionPlayer, "��ע�⣬�ļ�������Ϊ�գ�") return end
    if labelName == "" then lualib:MsgBox(actionPlayer, "��ע�⣬��ǩ������Ϊ�գ�") return end
    callscript(target, fileName, labelName)
    Message:Msg9(target, "�������")
end

---ԭ�ش�����ʱNPC
function HelperBox.FormActionCreateNpc(target, actionPlayer, npcIdx, npcName, npcAppr, npcScript)
    if not HelperBox:CheckPermission(actionPlayer) then return end
    -- ��npcScript�е�,�滻Ϊ\
    npcScript = string.gsub(npcScript, ",", [[\]])
    local detail = {
        Idx = npcIdx,
        npcname = npcName,
        appr = npcAppr,
        script = npcScript,
    }
    createnpc(getbaseinfo(actionPlayer, 3), getbaseinfo(actionPlayer, 4), getbaseinfo(actionPlayer, 5), tbl2json(detail))
    Message:Msg9(actionPlayer, "ִ�д�����ʱNPC���")
end