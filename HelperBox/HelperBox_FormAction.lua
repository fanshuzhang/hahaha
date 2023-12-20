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

---刷物品
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

    lualib:AddItem(target, itemName, count, lualib:CalItemRuleCountEx(ruleTb), "HelperBox给予")
    Message:Msg9(actionPlayer, string.format("成功给玩家《%s》补发道具%s * %s", lualib:Name(target), itemName, count))
end

---生成怪物
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
            Message:Box(actionPlayer, "输入有误，请检查")
            return
        end
    else
        count = 1
    end
    if x ~= "" then
        if tonumber(x) then
            x = tonumber(x)
        else
            Message:Box(actionPlayer, "输入有误，请检查")
            return
        end
    else
        x = lualib:X(actionPlayer)
    end
    if y ~= "" then
        if tonumber(y) then
            y = tonumber(y)
        else
            Message:Box(actionPlayer, "输入有误，请检查")
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
        lualib:SysWarnMsg(actionPlayer, "刷怪成功！")
    else
        lualib:SysWarnMsg(actionPlayer, "刷怪失败！")
    end
end

---发送json物品
function HelperBox.FormActionCreateJsonItem(target, actionPlayer, jsonInfo)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if lualib:GetBagFree(target) < 7 then
        Message:Box(target, "背包空间不足")
        return
    end
    lualib:GiveItemByJson(target, jsonInfo)
end

---地上刷物品
function HelperBox.FormActionThrowItem(target, actionPlayer, itemName)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    throwitem(target, lualib:GetMapId(target), lualib:X(target), lualib:Y(target), 2, itemName, 1, 10, true, false, false, false)
end

---查询全局变量
function HelperBox.FormActionGetSysVar(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    local varValue = ""
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    varValue = lualib:GetVar(nil, varname)
    Message:Msg9(actionPlayer, string.format("全局变量,查询变量名:%s，变量值为:%s", varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置全局变量
function HelperBox.FormActionSetSysVar(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，全局变量，查询变量名:%s，变量值为:%s", varname, lualib:GetVar(nil, varname)))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，全局变量，查询变量名:%s，变量值为:%s", varname, lualib:GetVar(nil, varname)))
    end

end

---查询个人int类型自定义变量
function HelperBox.FormActionGetSelfCustomVarInt(target, actionPlayer, varArea, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "请输入变量范围") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "变量范围输入错误") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    iniplayvar(target, "integer", varArea, varname)
    local varValue = getplayvar(target, varArea, varname)
    Message:Msg9(actionPlayer, string.format("目标玩家：%s,查询变量名:%s，自定义类型%s，变量值为:%s", lualib:Name(target), varname, "integer",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置个人int类型自定义变量
function HelperBox.FormActionSetSelfCustomVarInt(target, actionPlayer, varArea, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "请输入变量范围") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "变量范围输入错误") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "请输入保存类型") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，目标玩家：%s,查询变量名:%s，自定义类型：%s,变量值为:%s", lualib:Name(target), varname, "integer", varvalue))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，目标玩家：%s,查询变量名:%s，自定义类型：%s,变量值为:%s", lualib:Name(target), varname, "integer", varvalue))
    end
end

---查询个人str类型自定义变量
function HelperBox.FormActionGetSelfCustomVarStr(target, actionPlayer, varArea, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "请输入变量范围") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "变量范围输入错误") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    iniplayvar(target, "string", varArea, varname)
    local varValue = getplayvar(target, varArea, varname)
    Message:Msg9(actionPlayer, string.format("目标玩家：%s,查询变量名:%s，自定义类型%s，变量值为:%s", lualib:Name(target), varname, "string",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置个人str类型自定义变量
function HelperBox.FormActionSetSelfCustomVarStr(target, actionPlayer, varArea, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varArea == "" then lualib:MsgBox(actionPlayer, "请输入变量范围") return end
    if varArea ~= "HUMAN" and varArea ~= "GUILD" then lualib:MsgBox(actionPlayer, "变量范围输入错误") return end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "请输入保存类型") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，目标玩家：%s,查询变量名:%s，自定义类型：%s,变量值为:%s", lualib:Name(target), varname, "string", varvalue))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，目标玩家：%s,查询变量名:%s，自定义类型：%s,变量值为:%s", lualib:Name(target), varname, "string", varvalue))
    end
end

---查询全局int类型自定义变量
function HelperBox.FormActionGetSysCustomVarInt(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    inisysvar("integer", varname)
    local varValue = getsysvarex(varname)
    Message:Msg9(actionPlayer, string.format("全局自定义变量,查询变量名:%s，自定义类型%s，变量值为:%s", varname, "integer",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置全局int类型自定义变量
function HelperBox.FormActionSetSysCustomVarInt(target, actionPlayer, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "请输入保存类型") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，全局自定义变量,查询变量名:%s，自定义类型：%s,变量值为:%s", varname, "integer", lualib:GetDBVar(varname)))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，全局自定义变量,查询变量名:%s，自定义类型：%s,变量值为:%s", varname, "integer", lualib:GetDBVar(varname)))
    end
end

---查询全局str类型自定义变量
function HelperBox.FormActionGetSysCustomVarStr(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    inisysvar("string", varname)
    local varValue = getsysvarex(varname)
    Message:Msg9(actionPlayer, string.format("全局自定义变量,查询变量名:%s，自定义类型%s，变量值为:%s", varname, "string",varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置全局str类型自定义变量
function HelperBox.FormActionSetSysCustomVarStr(target, actionPlayer, varname, varvalue, insertFlag)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    if insertFlag == "" then lualib:MsgBox(actionPlayer, "请输入保存类型") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，全局自定义变量,查询变量名:%s，自定义类型：%s,变量值为:%s", varname, "string", lualib:GetDBVar(varname)))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，全局自定义变量,查询变量名:%s，自定义类型：%s,变量值为:%s", varname, "string", lualib:GetDBVar(varname)))
    end
end

---查询个人标识
function HelperBox.FormActionGetStatus(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    varname = tonumber(varname)
    if type(varname) ~= "number" then  lualib:MsgBox(actionPlayer, "请将varname输入纯数字") return end
    local varValue = getflagstatus(target, varname)
    Message:Msg9(actionPlayer, string.format("目标玩家：%s,查询标识序号:%d，变量值为:%s", lualib:Name(target), varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---设置个人标识
function HelperBox.FormActionSetStatus(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    varname = tonumber(varname)
    if type(varname) ~= "number" then  lualib:MsgBox(actionPlayer, "请将varname输入纯数字") return end

    if varvalue == "nil" then
        setflagstatus(target, varname, 0)
    else

        if varvalue == "" then
            HelperBox.FormActionGetStatus(target, actionPlayer, varname)
            return
        else
            varvalue = tonumber(varvalue)
            if type(varvalue) ~= "number" then  lualib:MsgBox(actionPlayer, "请将varvalue输入纯数字") return end

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
        Message:Msg9(actionPlayer, string.format("设置成功，目标玩家：%s,查询变量名:%s，变量值为:%s", lualib:Name(target), varname, varvalue))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，目标玩家：%s,查询变量名:%s，变量值为:%s", lualib:Name(target), varname, varvalue))
    end
end

---设置个人变量
function HelperBox.FormActionSetVar(target, actionPlayer, varname, varvalue)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
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
        Message:Msg9(actionPlayer, string.format("设置成功，目标玩家：%s,查询变量名:%s，变量值为:%s", lualib:Name(target), varname, varvalue))
    else
        Message:Msg9(actionPlayer, string.format("设置失败，目标玩家：%s,查询变量名:%s，变量值为:%s", lualib:Name(target), varname, varvalue))
    end
end

---查询个人变量
function HelperBox.FormActionGetVar(target, actionPlayer, varname)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if varname == "" then lualib:MsgBox(actionPlayer, "请输入变量名") return end
    local varValue = lualib:GetVar(target, varname)
    lualib:SetStr(actionPlayer, "GMBOX查询结果", varValue)
    Message:Msg9(actionPlayer, string.format("目标玩家：%s,查询变量名:%s，变量值为:%s", lualib:Name(target), varname, varValue))
    lualib:DoClientUIMethod(actionPlayer, "HelperBox_setSearchResult", varValue)
end

---玩家称号的操作方法
function HelperBox.FormActionTitleAction(target, actionPlayer, addTitleName, delTitleName, queryTitleName)
    if not HelperBox:CheckPermission(actionPlayer) then return false end

    if addTitleName ~= "" then
        if confertitle(target, addTitleName, 1) then
            Message:Msg9(actionPlayer, string.format("给玩家%s添加称号%s成功", getbaseinfo(target, 1), addTitleName))
        else
            Message:Msg9(actionPlayer, string.format("给玩家%s添加称号%s失败", getbaseinfo(target, 1), addTitleName))
        end
    end
    if delTitleName ~= "" then
        if deprivetitle(target, delTitleName) then
            Message:Msg9(actionPlayer, string.format("给玩家%s删除称号%s成功", getbaseinfo(target, 1), delTitleName))
        else
            Message:Msg9(actionPlayer, string.format("给玩家%s删除称号%s失败", getbaseinfo(target, 1), delTitleName))
        end
    end
    if queryTitleName ~= "" then
        if checktitle(target, queryTitleName) then
            Message:Msg9(actionPlayer, string.format("查询到玩家%s拥有称号%s", getbaseinfo(target, 1), queryTitleName))
        else
            Message:Msg9(actionPlayer, string.format("查询到玩家%s没有称号%s", getbaseinfo(target, 1), queryTitleName))
        end
    end
end

---玩家buff的操作方法
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
            Message:Msg9(actionPlayer, string.format("给玩家%s添加buff%s成功", getbaseinfo(target, 1), updateBuffId))
        else
            Message:Msg9(actionPlayer, string.format("给玩家%s添加buff%s失败", getbaseinfo(target, 1), updateBuffId))
        end
    end

end

---设置玩家属性（带有效期）
function HelperBox.FormActionSetTimeAtt(target, actionPlayer, statusId, statusValue, timeLimit)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    changehumabiliy(target, statusId, statusValue, timeLimit)
    Message:Msg9(actionPlayer, "调整完毕")
end

---在线补发邮件
function HelperBox.FormActionSendMail(target, actionPlayer, itemStr, mailId, mailTitle, mailDesc)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    mailId = tonumber(mailId)
    if not mailId or (mailId <= 0) then
        mailId = 10000
    end
    if not mailTitle or type(mailTitle) ~= "string" or mailTitle == "" then
        mailTitle = "补发物品"
    end
    if not mailDesc or type(mailDesc) ~= "string" or mailDesc == "" then
        mailDesc = "补发"
    end
    lualib:SendMail(target,mailId,mailTitle,mailDesc,itemStr)
    Message:Msg9(actionPlayer,string.format("补发给玩家%s成功！", lualib:Name(target)))
end

---模拟在线充值
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
    lualib:SetMoney(target, coinId, "+", value, "模拟充值增加", true)
    recharge(target, value, 0, coinId)
    Message:Msg9(actionPlayer, string.format("发送充值%d元给玩家%s成功！", value, lualib:Name(target)))
end

---身体特效
function HelperBox.FormActionBodyEffect(target, actionPlayer, eid, ox, oy, t, b, ss)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if t == "-1" then
        clearplayeffect(target, tonumber(eid))
        Message:Msg9(actionPlayer, "取消特效成功！")
    else
        playeffect(target, tonumber(eid), tonumber(ox), tonumber(oy), tonumber(t), tonumber(b), tonumber(ss))
        Message:Msg9(actionPlayer, "播放特效成功！")
    end
end

---头翎
function HelperBox.FormActionHeadEffect(target, actionPlayer, where, eft, rn, x, y, ad, ss)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    seticon(target, tonumber(where), tonumber(eft), rn, tonumber(x), tonumber(y), tonumber(ad), tonumber(ss))
    Message:Msg9(target, "设置头翎成功！")
end

---调用传奇脚本命令
function HelperBox.FormActionCallScriptInterface(target, actionPlayer, scriptName, ...)
    if not HelperBox:CheckPermission(actionPlayer) then return false end
    if scriptName == "" then lualib:MsgBox(actionPlayer, "请注意，传奇命令名不能为空！") return end
    print(scriptName)
    callscriptex(target, scriptName, unpack({ ... }))
    Message:Msg9(actionPlayer, "调用完毕")
end

---调用xT脚本标签
function HelperBox.FormActionCallScriptFunc(target, actionPlayer, fileName, labelName)
    if not HelperBox:CheckPermission(actionPlayer) then return end
    if fileName == "" then lualib:MsgBox(actionPlayer, "请注意，文件名不能为空！") return end
    if labelName == "" then lualib:MsgBox(actionPlayer, "请注意，标签名不能为空！") return end
    callscript(target, fileName, labelName)
    Message:Msg9(target, "调用完毕")
end

---原地创建临时NPC
function HelperBox.FormActionCreateNpc(target, actionPlayer, npcIdx, npcName, npcAppr, npcScript)
    if not HelperBox:CheckPermission(actionPlayer) then return end
    -- 将npcScript中的,替换为\
    npcScript = string.gsub(npcScript, ",", [[\]])
    local detail = {
        Idx = npcIdx,
        npcname = npcName,
        appr = npcAppr,
        script = npcScript,
    }
    createnpc(getbaseinfo(actionPlayer, 3), getbaseinfo(actionPlayer, 4), getbaseinfo(actionPlayer, 5), tbl2json(detail))
    Message:Msg9(actionPlayer, "执行创建临时NPC完毕")
end