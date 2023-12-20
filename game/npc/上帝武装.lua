---@class NpcGodArm �ϵ���װ

local NpcGodArm = {}

NpcGodArm.Name = "�ϵ���װ"
NpcGodArmCfg = zsf_RequireNpcCfg(NpcGodArm.Name)

function NpcGodArm.getVarTb(player)
    local varTb = {}
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    -- varTb.mapLevel=2
    return varTb
end

--��ȡ�ȼ�
function NpcGodArm.main(player)
    local varTb = NpcGodArm.getVarTb(player)
    lualib:ShowFormWithContent(player, "npc/" .. NpcGodArm.Name, { data = varTb, version = NpcGodArmCfg.version })
end

--������ȡ
function NpcGodArm.MoveOk(player, equipIndex, Tab)
    if not equipIndex or not Tab then
        return
    end
    equipIndex,Tab=tonumber(equipIndex),tonumber(Tab)
    local se = {}
    local mapLevel = NpcGodArm.getVarTb(player).mapLevel
    if mapLevel and mapLevel == 1 then
        se = NpcGodArmCfg.list[1]
    elseif mapLevel and mapLevel == 2 then
        se = NpcGodArmCfg.list[2][Tab]
    end

    local basicRes = [[
        <Img|show=4|bg=1|loadDelay=1|move=1|esc=1|img=custom/UI/jlxy/img3.png|reset=1>
        <Layout|x=194.0|y=-7.0|width=40|height=40|link=@exit>
        <Button|x=200.0|y=0.0|color=255|size=18|nimg=custom/new1/close.png|link=@exit>
    ]]
    local tstr = ""
    local str = '' .. basicRes
    for i = 1, #se[equipIndex].cost do
        tstr = se[equipIndex].cost[i][1] .. '*' .. se[equipIndex].cost[i][2]
        str = str ..
            "<Text|x=13.0|y=" ..(41 + (i - 1) * 20) .. "|color=251|size=18|outline=2|outlinecolor=0|text=" .. tstr .. ">"
    end
    str = str .. "<Text|x=9.0|y=12.0|color=250|size=18|outline=2|outlinecolor=0|text=�ϳ�װ����Ҫ���ϣ�>"
    str = str .. "<Button|x=48.0|y=166.0|color=70|size=18|outline=2|outlinecolor=0|nimg=custom/UI/jlxy/btn1.png|text=�ϳ�|link=@click,�ϵ���װ_synthesis," .. equipIndex .. "," .. Tab .. ">"
    close(player)
    say(player, str)
end

--�ϳ�
function NpcGodArm.synthesis(player, equipIndex, Tab)
    if not equipIndex or not Tab then
        return
    end
    equipIndex,Tab=tonumber(equipIndex),tonumber(Tab)
    local se = {}
    local mapLevel = NpcGodArm.getVarTb(player).mapLevel
    if mapLevel and mapLevel == 1 then
        se = NpcGodArmCfg.list[1]
    elseif mapLevel and mapLevel == 2 then
        se = NpcGodArmCfg.list[2][Tab]
    end
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷�������")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, se[equipIndex].cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, se[equipIndex].cost, "�ϵ���װ��������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --��
    lualib:FGiveItem(player, se[equipIndex].e[1], 1)
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcGodArm.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcGodArm.Name .. "_setNewData", 1, NpcGodArmCfg)
end

--Npc�������
function NpcGodArm.onClickNpc(player, npcID, npcName)
    if not NpcGodArmCfg.index[npcID] then
        return
    end
    NpcGodArm.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcGodArm.onClickNpc, NpcGodArm)

setFormAllowFunc(NpcGodArm.Name, { "main", "reloadData", "MoveOk" })
Message.RegisterClickMsg(NpcGodArm.Name, NpcGodArm)

return NpcGodArm
