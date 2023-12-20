local function formSubmit(player, msgID, jsonMsg)
    local jsonTb = json2tbl(jsonMsg)
    local formStr = jsonTb.formStr
    local tempTb = string.split(formStr, ",")
    -- 首先，判断一下是否是允许的模块函数调用
    local module, method = tempTb[1]:match "([^.]*)_(.*)"
    if not Message.formAllowFunc[module] then
        print("未注册的调用模块", tostring(module))
        return
    end
    if not Message.formAllowFunc[module][method] then
        print("非法模块函数调用！", tostring(module), tostring(method))
        return
    end
    -- 列出参数列表
    local paramTb
    if tempTb[2] then
        paramTb = {}
        for i=2,#tempTb do
            table.insert(paramTb, tempTb[i])
        end
    end
    -- 执行
    if paramTb then
        click(player, tempTb[1], unpack(paramTb), unpack(jsonTb.paramList))
    else
        click(player, tempTb[1], unpack(jsonTb.paramList))
    end
end

-- 网络消息
function handlerequest(player, msgID, arg1, arg2, arg3, jsonMsg)
    if msgID == 730 then
        -- 因为是点击事件，其中包含了传递的参数，所以需要特殊处理
        formSubmit(player, msgID, jsonMsg)
        return
    end
    local result, errinfo = pcall(Message.dispatch, player, msgID, arg1, arg2, arg3, jsonMsg)
    if not result then
        local name = getbaseinfo(player, ConstCfg.gbase.name)
        local msgName = ssrNetMsgCfg[msgID]
        local err = "网络消息派发错误：消息ID="..msgID.."  消息Name="..msgName.."   "
        print(name, err, errinfo, arg1, arg2, arg3, jsonMsg)
    end
end