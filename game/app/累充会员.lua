---@class AppLCHYrecharge �۳��Ա

local AppLCHYrecharge = {}
AppLCHYrecharge.Name = "�۳��Ա"
local AppLCHYrechargeCfg = zsf_RequireAppCfg(AppLCHYrecharge.Name)

--
function AppLCHYrecharge.getVarTb(player)
    local varTb = {}
    -- local level = lualib:GetVar(player, VarCfg["�۳��Ա"]) or 0
    local level = 0
    local rechargeNum = lualib:GetMoney(player, 5) or 0 --�ۼƳ�ֵ
    for _, value in ipairs(AppLCHYrechargeCfg.list) do
        if querymoney(player, 5) >= value.needNum then
            level = level + 1
        else
            break
        end
    end
    varTb.level = level
    varTb.rechargeNum = rechargeNum
    local isReceive = {}
    local jsonStr = lualib:GetVar(player, VarCfg["�۳��Ա��ȡ״̬"])
    if jsonStr == '' then
        isReceive = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        lualib:SetVar(player, VarCfg["�۳��Ա��ȡ״̬"], tbl2json(isReceive))
    else
        isReceive = json2tbl(jsonStr)
    end
    varTb.isReceive = isReceive
    return varTb
end

function AppLCHYrecharge.main(player)
    local varTb = AppLCHYrecharge.getVarTb(player)
    lualib:ShowFormWithContent(player, "app/" .. AppLCHYrecharge.Name,
        { data = varTb, version = AppLCHYrechargeCfg.version })
end

--��ȡ
function AppLCHYrecharge.MoveOk(player, index)
    if not index then
        return
    end
    local varTb = AppLCHYrecharge.getVarTb(player)
    if not varTb.isReceive[index] then
        release_print("����error��")
        return
    end
    index = tonumber(index)
    --�Ƿ�����ȡ
    if varTb.isReceive[index] == 1 then
        Message:Msg9(player, "���Ѿ���ȡ���ø������޷��ظ���ȡ��")
        return
    end
    --�Ƿ�˳����ȡ
    if index > 1 and varTb.isReceive[index - 1] ~= 1 then
        Message:Msg9(player, "�밴˳����ȡ��")
        return
    end
    --��ֵ�Ƿ��㹻
    if querymoney(player, 5) < AppLCHYrechargeCfg.list[index].needNum then
        Message:Msg9(player, "�𾴵�VIP�ͻ������ĳ�ֵ�㲻�㣬���Ժ�������ȡ��")
        --Message:Box(player, "�𾴵�VIP�û������ĳ�ֵ�㲻�㣡�Ƿ�ǰ����ֵ", "", "@exit")
        return
    end
    --�����ռ��Ƿ����
    if lualib:GetBagFree(player) < 8 then
        Message:Msg9(player, "���ı����ռ䲻��8���޷���ȡ��")
        return
    end
    --����Ʒ
    lualib:AddBatchItem(player, AppLCHYrechargeCfg.list[index].give, "vip������ȡ", 2)
    --��������ȡ
    varTb.isReceive[index] = 1
    lualib:SetVar(player, VarCfg["�۳��Ա��ȡ״̬"], tbl2json(varTb.isReceive))
    --���ƺ�
    if index > 1 then
        lualib:DelTitle(player, AppLCHYrechargeCfg.list[index - 1].e[1]) --ɾ���ƺ�
    end
    lualib:AddTitleEx(player, AppLCHYrechargeCfg.list[index].e[1])       --���ƺ�
    TitleShow.RefreshTitleShow(player)
    varTb = AppLCHYrecharge.getVarTb(player)
    lualib:DoClientUIMethodEx(player, AppLCHYrecharge.Name .. "_notifyWnd", 1, varTb)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function AppLCHYrecharge.reloadData(player)
    lualib:DoClientUIMethodEx(player, AppLCHYrecharge.Name .. "_setNewData", 1, AppLCHYrechargeCfg)
end

--��Ϸ�¼�
setFormAllowFunc(AppLCHYrecharge.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg("�۳��Ա", AppLCHYrecharge)
return AppLCHYrecharge
