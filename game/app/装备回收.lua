AppEquipCycleData = require("Envir/Extension/DirectorDir/Config/app/cfg_װ������.lua")
---@class AppEquipCycle װ������
local AppEquipCycle = {}
local basicRes = [[
    <Img|show=4|bg=1|loadDelay=1|move=1|reset=1|img=custom/UI/zbhs/img_bk.png|esc=1>
    <Layout|x=503.0|y=32.0|width=50|height=50|link=@exit>
    <Button|x=518.0|y=50.0|nimg=custom/new1/close2.png|color=255|size=18|link=@exit>
    <Img|x=39.0|y=140.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=171.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=201.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=231.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=263.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Img|x=39.0|y=296.0|width=480|esc=0|img=custom/UI/zbhs/img1.png>
    <Text|x=65.0|y=149.0|color=161|size=18|outline=2|outlinecolor=0|text=����װ��>
    <Text|x=299.0|y=148.0|color=161|size=18|outline=2|outlinecolor=0|text=��������>
    <Text|x=65.0|y=180.0|color=161|size=18|outline=2|outlinecolor=0|text=����ħ��>
    <Text|x=299.0|y=178.0|color=161|size=18|outline=2|outlinecolor=0|text=����ս��>
    <Text|x=65.0|y=211.0|color=161|size=18|outline=2|outlinecolor=0|text=��������>
    <Text|x=300.0|y=209.0|color=161|size=18|outline=2|outlinecolor=0|text=���ߴ���>
    <Text|x=65.0|y=242.0|color=161|size=18|outline=2|outlinecolor=0|text=�������>
    <Text|x=300.0|y=241.0|color=161|size=18|outline=2|outlinecolor=0|text=��������>
    <Text|x=65.0|y=274.0|color=161|size=18|outline=2|outlinecolor=0|text=��������>
    <Text|x=301.0|y=272.0|color=161|size=18|outline=2|outlinecolor=0|text=ħ��װ��>
    <Text|x=50.0|y=303.0|size=16|color=70|outline=2|outlinecolor=0|text=�Զ�����>
    <Text|x=50.0|y=326.0|size=16|color=70|outline=2|outlinecolor=0|text=�Զ��Ի���>
    <Button|x=182.0|y=307.0|color=255|size=18|nimg=custom/UI/zbhs/btn1.png|outline=2|outlinecolor=0|text=ȫѡ|link=@click,װ������_selectAll>
    <Button|x=295.0|y=307.0|size=18|nimg=custom/UI/zbhs/btn1.png|color=255|outline=2|outlinecolor=0|text=��ѡ|link=@click,װ������_selectReverse>
    <Button|x=408.0|y=307.0|size=18|nimg=custom/UI/zbhs/btn1.png|color=255|outline=2|outlinecolor=0|text=һ������|link=@click,װ������_beginCycle>
    <Button|x=531.0|y=137.0|color=70|nimg=custom/UI/zbhs/btn2.png|size=24|outline=2|outlinecolor=0|text=��\��\��\��|link=@click,�������_main>
]]


function AppEquipCycle.getVarTb(player)
    local varTb = {}
    local isOpen = {}
    local jsonStr = lualib:GetVar(player, VarCfg["װ������"])
    if jsonStr == "" then
        -- for i = 1, #AppEquipCycleData.list, 1 do
        --     table.insert(isOpen, 0)
        -- end
        for k, v in pairs(AppEquipCycleData.list) do
            table.insert(isOpen, 0)
        end
        lualib:SetVar(player, VarCfg["װ������"], tbl2json(isOpen))
    else
        isOpen = json2tbl(jsonStr)
    end
    varTb.isOpen = isOpen
    varTb.isAutoHS = lualib:GetVar(player, VarCfg["�Զ�����"])
    varTb.isAutoCHB = lualib:GetVar(player, VarCfg["�Զ��Ի���"])
    --���ձ���
    local Rate = lualib:GetValueEx(player, 205) or 0
    varTb.Rate = Rate
    return varTb
end

function AppEquipCycle.main(player)
    local varTb = AppEquipCycle.getVarTb(player)
    local str = '' .. basicRes
    local count = 1
    local isAutoHS, isAutoCHB = varTb.isAutoHS, varTb.isAutoCHB
    for i = 1, 5 do
        for j = 1, 2 do
            str = str ..
            "<CheckBox|x=" ..
            (208 + (j - 1) * 230) ..
            "|y=" ..
            (144 + (i - 1) * 30) ..
            "|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" ..
            (varTb.isOpen[count]) .. "|link=@click,װ������_selectOne," .. count .. ">"
            str = str ..
            "<Text|x=" ..
            (140 + (j - 1) * 230) ..
            "|y=" ..
            (149 + (i - 1) * 30) ..
            "|color=249|size=18|outline=2|outlinecolor=0|text=(˵��)|tips=" ..
            AppEquipCycleData.list[count].describe .. "|tipsx=10|tipsy=70>"
            count = count + 1
        end
    end
    str = str ..
        "<CheckBox|x=141.0|y=296.0|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" ..
        isAutoHS .. "|link=@click,װ������_openAutoCycle>"
    str = str ..
        "<CheckBox|x=141.0|y=322.0|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" ..
        isAutoCHB .. "|link=@click,װ������_openAutochb>"
    str = str ..
    "<RText|x=399.0|y=95.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. (100 + varTb.Rate) .. "%/FCOLOR=250>>"
    say(player, str)
end

--��ѡ
function AppEquipCycle.selectOne(player, pos)
    pos = tonumber(pos)
    local varTb = AppEquipCycle.getVarTb(player)
    if not pos or not varTb.isOpen[pos] then
        return
    end
    --ɾ��������
    if varTb.isOpen[pos] == 1 then
        callscriptex(player, "DELRECYCLINGTYPE", AppEquipCycleData.list[pos].group)
        varTb.isOpen[pos] = 0
        --��ӻ�����
    elseif varTb.isOpen[pos] == 0 then
        callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[pos].group)
        varTb.isOpen[pos] = 1
    end
    lualib:SetVar(player, VarCfg["װ������"], tbl2json(varTb.isOpen))
end

--ȫѡ
function AppEquipCycle.selectAll(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 1, 10 do
        varTb.isOpen[i] = 1
        callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    lualib:SetVar(player, VarCfg["װ������"], tbl2json(varTb.isOpen))
    AppEquipCycle.main(player)
end

--ȫ��
function AppEquipCycle.selectReverse(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 1, 10 do
        varTb.isOpen[i] = 0
        callscriptex(player, "DELRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    -- callscriptex(player, "DELRECYCLINGTYPE", -1)
    lualib:SetVar(player, VarCfg["װ������"], tbl2json(varTb.isOpen))
    AppEquipCycle.main(player)
end

function AppEquipCycle.stringToTable(input)
    local result = {}

    for pair in input:gmatch("[^,]+") do
        local key, value = pair:match("(%d+)=(%d+)")
        if key and value then
            result[tonumber(key)] = tonumber(value)
        end
    end
    return result
end

--���մ���
function recycling(player)
    local varTb = AppEquipCycle.getVarTb(player)
    --���ձ���
    lualib:SetStr(player, "��������", getconst(player, "<$RECYITEMS>"))
    local goldNum = tonumber(getconst(player, "<$GETSTRVALUE(S$��������,1)>")) --���
    if goldNum then
        lualib:AddMoney(player, 1, goldNum * (varTb.Rate) / 100, "���ն����ȡ")
    end
    --ʱ����
    local curTime = lualib:GetAllTime()
    lualib:SetInt(player, "װ�����ռ��", curTime)
    --�Զ��Ի���
    if varTb.isAutoCHB == 1 then
        local bagList = lualib:GetBagList(player)
        for i, v in pairs(bagList) do
            local itemName = lualib:ItemName(player, v)
            if AppEquipCycleData.autoUse[itemName] then
                lualib:EatItem(player, itemName, 1)
            end
        end
    end
    return true
end

-- ��ʼ����
function AppEquipCycle.beginCycle(player)
    local curTime = lualib:GetAllTime()
    -- �����3���ӳ٣��������Ƶ��
    if curTime - lualib:GetInt(player, "װ�����ռ��") < 2 then
        Message:Msg9(player, "�벻ҪƵ�����գ�")
        return
    end
    lualib:CallTxtScript(player, "RECYCLING")
end

---�򿪻�ر��Զ�����
function AppEquipCycle.openAutoCycle(player)
    local varTb = AppEquipCycle.getVarTb(player)
    if varTb.isAutoHS == 1 then
        callscriptex(player, "AUTORECYCLING")
        lualib:SetVar(player, VarCfg["�Զ�����"], 0)
        setofftimer(player, 3)
    end
    if varTb.isAutoHS == 0 then
        callscriptex(player, "AUTORECYCLING", 20, 10)
        lualib:SetVar(player, VarCfg["�Զ�����"], 1)
        setontimer(player, 3, 20)
    end
end

--���Զ��Ի���
function AppEquipCycle.openAutochb(player)
    local varTb = AppEquipCycle.getVarTb(player)
    if varTb.isAutoCHB == 1 then
        lualib:SetVar(player, VarCfg["�Զ��Ի���"], 0)
        setofftimer(player, 5)
    end
    if varTb.isAutoCHB == 0 then
        lualib:SetVar(player, VarCfg["�Զ��Ի���"], 1)
        setontimer(player, 5, 20)
    end
end

function AppEquipCycle.onLogin(player)
    local varTb = AppEquipCycle.getVarTb(player)
    -- for i = 1, #AppEquipCycleData.list do
    --     if varTb.isOpen[i] == 1 then
    --         callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    --     end
    -- end
    for index, value in ipairs(AppEquipCycleData.list) do
        if varTb.isOpen[index] == 1 then
            callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[index].group)
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onLogin, AppEquipCycle.onLogin, AppEquipCycle)
-- setFormAllowFunc("װ������", { "main", "selectAll", "selectReverse", "openAutoCycle", "beginCycle", "selectOne" })
Message.RegisterClickMsg("װ������", AppEquipCycle)
return AppEquipCycle
