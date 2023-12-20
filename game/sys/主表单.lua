local function formSubmit(player, msgID, jsonMsg)
    local jsonTb = json2tbl(jsonMsg)
    local formStr = jsonTb.formStr
    local tempTb = string.split(formStr, ",")
    -- ���ȣ��ж�һ���Ƿ��������ģ�麯������
    local module, method = tempTb[1]:match "([^.]*)_(.*)"
    if not Message.formAllowFunc[module] then
        print("δע��ĵ���ģ��", tostring(module))
        return
    end
    if not Message.formAllowFunc[module][method] then
        print("�Ƿ�ģ�麯�����ã�", tostring(module), tostring(method))
        return
    end
    -- �г������б�
    local paramTb
    if tempTb[2] then
        paramTb = {}
        for i=2,#tempTb do
            table.insert(paramTb, tempTb[i])
        end
    end
    -- ִ��
    if paramTb then
        click(player, tempTb[1], unpack(paramTb), unpack(jsonTb.paramList))
    else
        click(player, tempTb[1], unpack(jsonTb.paramList))
    end
end

-- ������Ϣ
function handlerequest(player, msgID, arg1, arg2, arg3, jsonMsg)
    if msgID == 730 then
        -- ��Ϊ�ǵ���¼������а����˴��ݵĲ�����������Ҫ���⴦��
        formSubmit(player, msgID, jsonMsg)
        return
    end
    local result, errinfo = pcall(Message.dispatch, player, msgID, arg1, arg2, arg3, jsonMsg)
    if not result then
        local name = getbaseinfo(player, ConstCfg.gbase.name)
        local msgName = ssrNetMsgCfg[msgID]
        local err = "������Ϣ�ɷ�������ϢID="..msgID.."  ��ϢName="..msgName.."   "
        print(name, err, errinfo, arg1, arg2, arg3, jsonMsg)
    end
end