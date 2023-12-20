---@class NpcCopyEquipProduct ����װ������
local NpcCopyEquipProductCfg = zsf_RequireNpcCfg("����װ������")
local NpcCopyEquipProduct = {}
NpcCopyEquipProduct.Name = "����װ������"

function NpcCopyEquipProduct.getVarTb(player)
    local varTb = {}
    varTb.level = lualib:Level(player)
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

function NpcCopyEquipProduct.main(player)
    local varTb = NpcCopyEquipProduct.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/" .. NpcCopyEquipProduct.Name,
        { data = varTb, version = NpcCopyEquipProductCfg.version })
end

--ѡ��
function NpcCopyEquipProduct.Choose(player, choose, tab, index)
    if not choose then
        return
    end
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    if choose == "�ֽ�" then
        Message:Box(player, "�𾴵���ң���װ����Ϊ�����ȷ���Ƿ�ֽ�", "@click,����װ������_MoveOkFJ," .. tab .. ',' .. index, "@exit")
    elseif choose == "�ϳ�" then
        Message:Box(player, "�𾴵���ң����Ѿ�����ѡ��ϳɸ�װ������", "@click,����װ������_MoveOk," .. tab .. ',' .. index, "@exit")
    end
    return
end

function NpcCopyEquipProduct.MoveOk(player, tab, index) --�ϳ�
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    tab, index = tonumber(tab), tonumber(index)
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷����죡")
        return
    end
    local se = NpcCopyEquipProductCfg.list[tab][index]
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "����װ����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --��װ��
    lualib:AddItem(player, se.e[1], 1, 0, "����װ������")
    --
    Message:Msg9(player, "����ɹ���")
end

--

function NpcCopyEquipProduct.MoveOkFJ(player, tab, index) --�ֽ�
    if not tab or not index or not tonumber(tab) or not tonumber(index) then
        return
    end
    tab, index = tonumber(tab), tonumber(index)
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷����죡")
        return
    end
    local se = NpcCopyEquipProductCfg.list[tab][index]
    --���װ��
    if getbagitemcount(player, se.e[1], 0) < 1 then
        Message:Msg9(player, "���ı�����û��[" .. se.e[1] .. "]")
        return
    end
    --��
    lualib:DelItem(player, se.e[1], 1, 0, "����װ������")
    --��
    lualib:AddBatchItem(player, se.dismantle, "����װ������")
    --
    Message:Msg9(player, "�����ɹ�����ô�������")
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcCopyEquipProduct.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcCopyEquipProduct.Name .. "_setNewData", 1, NpcCopyEquipProductCfg)
end

function NpcCopyEquipProduct.onClickNpc(player, NpcID, NpcIName)
    if not NpcCopyEquipProductCfg.index[NpcID] then
        return
    end
    NpcCopyEquipProduct.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcCopyEquipProduct.onClickNpc, NpcCopyEquipProduct)
setFormAllowFunc(NpcCopyEquipProduct.Name, { "reloadData", "Choose" })
Message.RegisterClickMsg("����װ������", NpcCopyEquipProduct)
return NpcCopyEquipProduct
