---@class NpcMapMove ��ͼ����

local NpcMapMove = {}

NpcMapMove.Name = "��ͼ����"
NpcMapMoveCfg = zsf_RequireNpcCfg(NpcMapMove.Name)

function NpcMapMove.getVarTb(player)
    local varTb = {}
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    local jsonStr = lualib:GetVar(player, VarCfg["��ͼ����"])
    local jsonTb = {}
    if jsonStr and jsonStr == "" then
        jsonTb = {
            ["����½"] = 0,
            ["���׵�"] = 0,
            ["�������"] = 0,
            ["��������"] = 0,
            ["����ɽ��"] = 0,
            ["����Ҫ��"] = 0,
            ["����½"] = 0,
            ["�����۹�"] = 0,
            ["ŵ�깬��"] = 0,
            ["������Ĺ"] = 0,
            ["��������"] = 0,
            ["������Ĺ"] = 0,
            ["�������"] = 0,
            ["�Ĵ�½"] = 0,
        }
        lualib:SetVar(player, VarCfg['��ͼ����'], tbl2json(jsonTb))
        jsonStr = tbl2json(jsonTb)
    end
    jsonTb = json2tbl(jsonStr)
    varTb.jsonTb = jsonTb
    return varTb
end

--��ȡ�ȼ�
function NpcMapMove.main(player)
    --���
    local varTb = NpcMapMove.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/" .. NpcMapMove.Name, { data = varTb, version = NpcMapMoveCfg.version })
end

--������ȡ
function NpcMapMove.MoveOk(player, mapIndex)
    if not mapIndex then
        return
    end
    mapIndex = tonumber(mapIndex)
    local varTb = NpcMapMove.getVarTb(player)
    if not NpcMapMoveCfg.list[varTb.mapLevel].childrenMap[mapIndex] then
        release_print("����error��")
        return
    end
    local se = NpcMapMoveCfg.list[varTb.mapLevel].childrenMap
    --�Ƿ�ɽ���--ħ���������ж�
    local cost = se[mapIndex].cost
    if se[mapIndex][1] == "ħ����" then
        if varTb.jsonTb["����½"] == 0 then
            cost = se[mapIndex].cost2
        end
    end
    --�Ƿ񼤻�
    if se[mapIndex].need then
        if varTb.jsonTb[se[mapIndex][1]] == 0 then
            if se[mapIndex].need.type == 1 then
                if getbagitemcount(player, se[mapIndex].need[1]) < se[mapIndex].need[2] then
                    Message:Msg9(player, string.format("��ǰ��ͼ��Ҫ������%s����", se[mapIndex].need[1]))
                    return
                end
                if takeitem(player, se[mapIndex].need[1], se[mapIndex].need[2]) then
                    varTb.jsonTb[se[mapIndex][1]] = 1
                    lualib:SetVar(player, VarCfg['��ͼ����'], tbl2json(varTb.jsonTb))
                    Message:Msg9(player, "��ͼ�Ѽ��")
                end
            end
            if se[mapIndex].need.type == 2 then
                if lualib:GetVar(player, VarCfg["̽���߳ƺ�"]) < se[mapIndex].need[2] then
                    Message:Msg9(player, string.format("��ǰ��ͼ��Ҫ�����Ҫ�ﵽ[%s]", se[mapIndex].need[1]))
                    return
                else
                    varTb.jsonTb[se[mapIndex][1]] = 1
                    lualib:SetVar(player, VarCfg['��ͼ����'], tbl2json(varTb.jsonTb))
                end
            end
        end
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, cost, "���͵�ͼ����")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    -- lualib:MapMove(player, se[mapIndex][2])
    lualib:MapMoveXY(player, se[mapIndex][2], se[mapIndex].move[1], se[mapIndex].move[2], 3)

    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_OnClose")
end

--�������
function NpcMapMove.Active(player, txtIndex)
    if not txtIndex or not txtIndex then
        return
    end
    local varTb = NpcMapMove.getVarTb(player)
    local maplevel = varTb.mapLevel + 1
    if txtIndex == "����" then
        Message:Msg9(player, "����ɹ���")
        varTb.jsonTb["����½"] = 1
        varTb.jsonTb["����½"] = 1
        lualib:SetVar(player, VarCfg['��ͼ����'], tbl2json(varTb.jsonTb))
    end
    if txtIndex == "����" then
        if maplevel >= 3 then
            maplevel = 3
        end
        --�Ƿ񼤻�
        lualib:MapMoveXY(player, NpcMapMoveCfg.list[maplevel].index, NpcMapMoveCfg.list[maplevel].range[1],
            NpcMapMoveCfg.list[maplevel].range[2], NpcMapMoveCfg.list[maplevel].range[3])
    end
    -- varTb = NpcMapMove.getVarTb(player)
    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_OnClose")
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcMapMove.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcMapMove.Name .. "_setNewData", 1, NpcMapMoveCfg)
end

--Npc�������
function NpcMapMove.onClickNpc(player, npcID, npcName)
    if not NpcMapMoveCfg.index[npcID] then
        return
    end
    NpcMapMove.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcMapMove.onClickNpc, NpcMapMove)

setFormAllowFunc(NpcMapMove.Name, { "main", "reloadData", "MoveOk", "Active" })
Message.RegisterClickMsg(NpcMapMove.Name, NpcMapMove)

return NpcMapMove
