---@class NpcDonate ɳ�Ǿ���
local NpcDonate = {}

NpcDonate.title = { "���׵�һ��", "���׵ڶ���", "���׵�����", "���׵�����", "���׵�����", "���ײ�����", }

function NpcDonate.getVarTb()
    local varTb = {}
    local sortTb = sorthumvar("���׽��", 0, 1, 0)
    varTb.name = {}
    varTb.num = {}
    for i = 1, #sortTb, 2 do
        if sortTb[i] ~= nil and sortTb[i + 1] ~= nil and sortTb[i] ~= '' and sortTb[i + 1] ~= 0 then
            table.insert(varTb.name, sortTb[i])
            table.insert(varTb.num, sortTb[i + 1])
        end
    end
    return varTb
end

function NpcDonate.main(player)
    local basicRes = [[
        <Img|show=4|bg=1|loadDelay=1|move=1|reset=1|img=custom/UI/scjx/img_bk.png|esc=1>
        <Layout|x=764.0|y=12.0|width=80|height=80|link=@exit>
        <Button|x=789.0|y=49.0|color=255|size=18|nimg=custom/new1/close2.png|link=@exit>
        <RText|x=374.0|y=63.0|color=255|size=20|outline=2|outlinecolor=0|text=<ɳ�Ǿ���/FCOLOR=70>>
        <RText|x=177.0|y=371.0|color=255|size=18|outline=2|outlinecolor=0|text=<����100000��Ҽ��ɻ�ã�/FCOLOR=70><��ħ�� 5-5  ���� 100   ħ�� 100/FCOLOR=246>>
        <RText|x=160.0|y=400.0|color=255|size=22|outline=2|outlinecolor=0|text=<���׽�ҵ�30%�ۻ���ɳ�ǽ��أ����ǽ�������ʧ��/FCOLOR=249>>
        <Img|x=393.0|y=480.0|width=154|img=custom/UI/scjx/img1.png>
        <Text|x=612.0|y=137.0|size=22|color=251|outline=2|outlinecolor=0|text=[��������]|tips={��ħ��:50-50 ����:1000 ħ��:500/FCOLOR=250}^{�������˺�����20%/FCOLOR=251}^{��ħ���˺�����20%/FCOLOR=251}|tipsx=10|tipsy=70|>
        <Text|x=612.0|y=183.0|size=22|color=251|outline=2|outlinecolor=0|text=[��������]|tips={��ħ��:30-30 ����:600 ħ��:300/FCOLOR=250}^{�������˺�����10%/FCOLOR=251}^{��ħ���˺�����10%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=226.0|size=22|color=251|outline=2|outlinecolor=0|text=[��������]|tips={��ħ��:20-20 ����:400 ħ��:200/FCOLOR=250}^{�������˺�����8%/FCOLOR=251}^{��ħ���˺�����8%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=272.0|size=22|color=251|outline=2|outlinecolor=0|text=[��������]|tips={��ħ��:15-15 ����:300 ħ��:150/FCOLOR=250}^{�������˺�����5%/FCOLOR=251}^{��ħ���˺�����5%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=317.0|size=22|color=251|outline=2|outlinecolor=0|text=[��������]|tips={��ħ��:10-10 ����:200 ħ��:100/FCOLOR=250}^{�������˺�����3%/FCOLOR=251}^{��ħ���˺�����3%/FCOLOR=251}|tipsx=10|tipsy=70>
    ]]
    local str = '' .. basicRes
    local varTb = NpcDonate.getVarTb()
    local name, num = "", ""
    for i = 1, 5 do
        if varTb.name[i] and varTb.num[i] then
            name = varTb.name[i]
            num = varTb.num[i]
        else
            name, num = "#�����ϰ�#", "��"
        end
        str = str ..
            "<RText|x=210.0|y=" ..
            (137 + 44 * (i - 1)) .. "|color=255|size=24|outline=2|outlinecolor=0|text=<" .. name .. "/FCOLOR=255>>"
        str = str ..
            "<RText|x=407.0|y=" ..
            (137 + 44 * (i - 1)) .. "|color=255|size=24|outline=2|outlinecolor=0|text=<" .. num .. "/FCOLOR=255>>"
    end

    local moneyNum, moneyNum30 = "��ɳ�ڼ�չʾ", "��ɳ�ڼ�չʾ"
    if castleinfo(5) then
        moneyNum = lualib:GetVar(player, VarCfg["�ܾ��׽��"])
        moneyNum30 = moneyNum * 0.3
    end
    local money = getplayvar(player, "HUMAN", "���׽��")
    local mainStr = '' .. str
    mainStr = mainStr ..
        "<RText|x=211.0|y=440.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. moneyNum .. "/FCOLOR=251>>"
    mainStr = mainStr ..
        "<RText|x=551.0|y=440.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. moneyNum30 .. "/FCOLOR=251>>"
    mainStr = mainStr ..
        "<RText|x=195.0|y=487.0|color=70|size=18|outline=2|outlinecolor=0|text=<" .. money .. "/FCOLOR=250>>"
    mainStr = mainStr ..
        "<Input|x=395.0|y=482.0|width=150|height=25|type=1|inputid=9|size=20|outline=2|outlinecolor=0|color=255|place=��������׽��|placecolor=0>"
    mainStr = mainStr ..
        "<Button|x=577.0|y=472.0|color=255|size=18|submitInput=9|nimg=custom/UI/scjx/btn1.png|link=@click,ɳ�Ǿ���_MoveOk>"
    say(player, mainStr)
end

--����
function NpcDonate.MoveOk(player)
    local num = tonumber(getconst(player, "<$NPCINPUT(9)>"))
    if not num then
        return
    end
    if num < 100000 then
        Message:Msg9(player, "��;���100000���")
        return
    end
    if getbindmoney(player, "���") < num then
        Message:Msg9(player, "��Ľ�Ҳ���")
        return
    end
    consumebindmoney(player, "���",num, "��������")
    --��¼
    lualib:SetPlayerInt(player, "���׽��", lualib:GetPlayerInt(player, "���׽��") + num)
    lualib:SetVar(player, VarCfg["�ܾ��׽��"], lualib:GetVar(player, VarCfg["�ܾ��׽��"]) + num)
    Message:SendMsgNew(player, "���[" .. lualib:Name(player) .. "]������"..num.."���")
    NpcDonate.main(player)
    --�����ж�
    NpcDonate.ranking(player)
end

--��������
function NpcDonate.ranking(player)
    --�����ж�
    local varTb = NpcDonate.getVarTb()
    --�������а�-���ƺ�
    for index, value in ipairs(varTb.name) do
        if index >= 6 then index = 6 end
        if value and value ~= '' then
            local playItem = lualib:GetPlayerByName(value)
            if isnotnull(playItem) then
                for i = 1, 6 do
                    if lualib:HasTitle(playItem, NpcDonate.title[i]) then
                        lualib:DelTitle(playItem, NpcDonate.title[i]) --ɾ���ƺ�
                    end
                end
                lualib:AddTitleEx(playItem, NpcDonate.title[index]) --���ƺ�
            end
        end
    end
end

--���NPC����
function NpcDonate.onClickNpc(player, npcID, npcName)
    if npcID == 7 then
        NpcDonate.main(player)
        return
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcDonate.onClickNpc, NpcDonate)
Message.RegisterClickMsg("ɳ�Ǿ���", NpcDonate)
return NpcDonate
