---@class AppEquipCycleEX �������
local AppEquipCycleEX = {}

local basicRes=[[
    <Img|bg=1|move=1|loadDelay=1|reset=1|esc=1|show=4|img=custom/UI/zbhs/img_bk.png>
    <Layout|x=503.0|y=32.0|width=50|height=50|link=@exit>
    <Button|x=518.0|y=50.0|color=255|nimg=custom/new1/close2.png|size=18|link=@exit>
    <Img|x=39.0|y=140.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=171.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=201.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=231.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=263.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=296.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Text|x=46.0|y=149.0|outlinecolor=0|outline=2|color=161|size=18|text=������ֽ�>
    <Text|x=299.0|y=148.0|outlinecolor=0|outline=2|color=161|size=18|text=ѫ�·ֽ�>
    <Text|x=65.0|y=180.0|outlinecolor=0|outline=2|color=161|size=18|text=ͼ�ڷֽ�>
    <Text|x=299.0|y=178.0|outlinecolor=0|outline=2|color=161|size=18|text=ת������>
    <Text|x=65.0|y=211.0|outlinecolor=0|outline=2|color=161|size=18|text=��ƥ����>
    <Text|x=300.0|y=209.0|outlinecolor=0|outline=2|color=161|size=18|text=ƾ֤����>
    <Text|x=65.0|y=242.0|outlinecolor=0|outline=2|color=161|size=18|text=ͼֽ����>
    <Button|x=132.0|y=307.0|color=255|outline=2|nimg=custom/UI/zbhs/btn1.png|outlinecolor=0|size=18|text=ȫѡ|link=@click,�������_selectAll>
    <Button|x=300.0|y=307.0|color=255|outline=2|nimg=custom/UI/zbhs/btn1.png|outlinecolor=0|size=18|text=��ѡ|link=@click,�������_selectReverse>
    <Button|x=531.0|y=137.0|color=70|outline=2|nimg=custom/UI/zbhs/btn2.png|outlinecolor=0|size=24|text=��\ͨ\��\��|link=@click,װ������_main>
]]

function AppEquipCycleEX.main(player)
    local varTb = AppEquipCycle.getVarTb(player)
    local str = '' .. basicRes
    local count = 11
    for i = 1, 4 do
        for j = 1, 2 do
            str = str .. "<CheckBox|x=" .. (208 + (j - 1) * 230) .. "|y=" .. (144 + (i - 1) * 30) .. "|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" .. (varTb.isOpen[count]) .. "|link=@click,װ������_selectOne," .. count .. ">"
            str = str .. "<Text|x=" .. (140 + (j - 1) * 230) .. "|y=" .. (149 + (i - 1) * 30) .. "|color=249|size=18|outline=2|outlinecolor=0|text=(˵��)|tips="..AppEquipCycleData.list[count].describe.."|tipsx=10|tipsy=70>"
            count = count + 1
            if count>17 then
                break
            end
        end
    end
    str=str.."<RText|x=399.0|y=95.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. (100 + varTb.Rate) .. "%/FCOLOR=250>>"
    say(player, str)
end

--ȫѡ
function AppEquipCycleEX.selectAll(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 11, 17 do
        varTb.isOpen[i] = 1
        callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    lualib:SetVar(player, VarCfg["װ������"], tbl2json(varTb.isOpen))
    AppEquipCycleEX.main(player)
end

--ȫ��
function AppEquipCycleEX.selectReverse(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 11, 17 do
        varTb.isOpen[i] = 0
        callscriptex(player, "DELRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    lualib:SetVar(player, VarCfg["װ������"], tbl2json(varTb.isOpen))
    AppEquipCycleEX.main(player)
end

--��Ϸ�¼�
Message.RegisterClickMsg("�������", AppEquipCycleEX)
return AppEquipCycleEX
