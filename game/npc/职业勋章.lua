---@class NpcJobMedal ְҵѫ��

local NpcJobMedal = {}

NpcJobMedal.Name = "ְҵѫ��"
NpcJobMedalCfg = zsf_RequireNpcCfg(NpcJobMedal.Name)

function NpcJobMedal.getVarTb(player)
    local varTb = {}
    local equip = lualib:LinkBodyItem(player, NpcJobMedalCfg.pos[2])
    if equip ~= "0" and equip then
        varTb.equipName = lualib:ItemName(player, equip)
        varTb.equip = equip
        varTb.level = NpcJobMedalCfg.equipIndex[varTb.equipName]
    else
        -- varTb.index=0
        varTb.equipName = ""
        varTb.equip = 0
        varTb.level = 0
    end
    --ְҵ
    local Job = lualib:GetVar(player, VarCfg["��ɫְҵ"])
    varTb.Job = Job
    if not varTb.Job or varTb.Job == 0 then
        Message:Msg9(player, "���Ƚ�������ְҵѡ��")
        Message:Box(player, "ǰ��ѡ������ְҵ", "@click,ְҵѡ��_main", "@exit")
    end
    varTb.mapLevel = GeneralGlobalConfig.mapReferLevel[lualib:GetMapId(player)]
    return varTb
end

--��ȡ�ȼ�
function NpcJobMedal.main(player)
    local varTb = NpcJobMedal.getVarTb(player)
    if not varTb.Job or varTb.Job == 0 then
        return
    end
    lualib:ShowFormWithContent(player, "npc/" .. NpcJobMedal.Name, { data = varTb, version = NpcJobMedalCfg.version })
end

--������ȡ
function NpcJobMedal.MoveOk(player, tab)
    if not tab or tonumber(tab) < 2 or tonumber(tab) > 9 then
        _print("�ͻ��˴��ݲ�������")
        return
    end
    local Job = NpcJobMedal.getVarTb(player).Job
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷�������")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, NpcJobMedalCfg.list.equip[Job][tab].cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, NpcJobMedalCfg.list.equip[Job][tab].cost, "ְҵѫ����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --��
    -- if varTb.level ~= 0 then
    --     lualib:FTakeItemEX(player, varTb.equip)
    -- end

    --��
    lualib:FGiveItem(player, NpcJobMedalCfg.list.equip[Job][tab].name, 1)
    -- varTb = NpcBloodJade.getVarTb(player)
    Message:Msg9(player, "�����ɹ���")
    -- lualib:DoClientUIMethodEx(player, NpcBloodJade.Name .. "_notifyWnd", 1, varTb)
end

function NpcJobMedal.Exchange(player)
    local Job = NpcJobMedal.getVarTb(player).Job
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "���ı����ռ䲻��5���޷��һ���")
        return
    end
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, NpcJobMedalCfg.list.Debris2Medal)
    if not flag then
        Message:Msg9(player, "���ϲ��㣡")
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, NpcJobMedalCfg.list.Debris2Medal, "�һ�һ��ְҵѫ������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --��
    lualib:FGiveItem(player, NpcJobMedalCfg.list.equip[Job][1].name, 1)
    Message:Msg9(player, "���" .. NpcJobMedalCfg.list.equip[Job][1].name)
end

--����
function NpcJobMedal.Destruction(player)
    local basicRes = [[
        <Img|x=-405|y=137|show=4|bg=1|loadDelay=1|move=1|esc=1|img=custom/UI/jlxy/img3.png|reset=1>
        <Layout|x=-210.0|y=132.0|width=40|height=40|link=@exit>
        <Button|x=-203.0|y=138.0|color=255|size=18|nimg=custom/new1/close.png|link=@exit>
    ]]
    local str = '' .. basicRes
    str = str ..
        "<ITEMBOX|x=-335.0|y=188.0|width=70|height=70|boxindex=1|stdmode=*|tips=<����1~3��ѫ��/FCOLOR=249>|tipsx=4|tipsy=100|img=public/1900000651_3.png>"
    str = str .. "<Text|x=-370.0|y=145.0|color=250|size=18|outline=2|outlinecolor=0|text=����ѫ�¶һ���Ƭ>"
    str = str .. "<Text|x=-391.0|y=278.0|color=70|size=18|outline=2|outlinecolor=0|text=һ���һ�|link=@click,ְҵѫ��_Change,1>"
    str = str .. "<Text|x=-268.0|y=278.0|color=70|size=18|outline=2|outlinecolor=0|text=�һ�|link=@click,ְҵѫ��_Change,2>"
    say(player, str)
end

--һ���һ�
function NpcJobMedal.Change(player, sel)
    if not sel then
        return
    end
    sel = tonumber(sel)
    if sel == 2 then
        local nameOK = lualib:GetConst(player, "<$BOXITEM[1].NAME>")
        if not NpcJobMedalCfg.equipIndex[nameOK] or NpcJobMedalCfg.equipIndex[nameOK] > 3 then
            Message:Msg9(player, "ֻ�ܷ���1~3��ְҵѫ��")
            callscriptex(player, "ReturnBoxItem", 1)
        end
        --ɾ����Ʒ
        callscriptex(player, "DELBOXITEM", 1)
        --����Ʒ
        local level = NpcJobMedalCfg.equipIndex[nameOK]
        if not level then
            return
        end
        lualib:FGiveItem(player, NpcJobMedalCfg.list.Medal2Debris[level][1], NpcJobMedalCfg.list.Medal2Debris[level][2])
        Message:Msg9(player, "�һ��ɹ���")
    elseif sel == 1 then
        local bagItemTb = lualib:GetBagItems(player)
        if not bagItemTb or type(bagItemTb) ~= 'table' then
            return
        end
        local name = ''
        for _, value in pairs(bagItemTb) do
            name = lualib:nameByItem(player, value)
            if NpcJobMedalCfg.equipIndex[name] and NpcJobMedalCfg.equipIndex[name] <= 3 then
                --����Ʒ
                lualib:FTakeItem(player, name, 1)
                --����Ʒ
                local level = NpcJobMedalCfg.equipIndex[name]
                lualib:FGiveItem(player, NpcJobMedalCfg.list.Medal2Debris[level][1], NpcJobMedalCfg.list.Medal2Debris[level][2])
            end
        end
        Message:Msg9(player, "һ���һ��ɹ���")
    end
end

--�汾���ԣ��������أ����·������ñ��ͻ���
function NpcJobMedal.reloadData(player)
    lualib:DoClientUIMethodEx(player, NpcJobMedal.Name .. "_setNewData", 1, NpcJobMedalCfg)
end

--Npc�������
function NpcJobMedal.onClickNpc(player, npcID, npcName)
    if not NpcJobMedalCfg.index[npcID] then
        return
    end
    sel = tonumber(sel)
    NpcJobMedal.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcJobMedal.onClickNpc, NpcJobMedal)

setFormAllowFunc(NpcJobMedal.Name, { "main", "reloadData", "MoveOk", "Exchange", "Destruction" })
Message.RegisterClickMsg(NpcJobMedal.Name, NpcJobMedal)

return NpcJobMedal
