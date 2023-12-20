AppEquipCycleData = require("Envir/Extension/DirectorDir/Config/app/cfg_装备回收.lua")
---@class AppEquipCycle 装备回收
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
    <Text|x=65.0|y=149.0|color=161|size=18|outline=2|outlinecolor=0|text=垃圾装备>
    <Text|x=299.0|y=148.0|color=161|size=18|outline=2|outlinecolor=0|text=沃玛祖玛>
    <Text|x=65.0|y=180.0|color=161|size=18|outline=2|outlinecolor=0|text=赤月魔龙>
    <Text|x=299.0|y=178.0|color=161|size=18|outline=2|outlinecolor=0|text=狂雷战神>
    <Text|x=65.0|y=211.0|color=161|size=18|outline=2|outlinecolor=0|text=炎龙天龙>
    <Text|x=300.0|y=209.0|color=161|size=18|outline=2|outlinecolor=0|text=王者传奇>
    <Text|x=65.0|y=242.0|color=161|size=18|outline=2|outlinecolor=0|text=皓月诛仙>
    <Text|x=300.0|y=241.0|color=161|size=18|outline=2|outlinecolor=0|text=神龙真龙>
    <Text|x=65.0|y=274.0|color=161|size=18|outline=2|outlinecolor=0|text=灵蛇天马>
    <Text|x=301.0|y=272.0|color=161|size=18|outline=2|outlinecolor=0|text=魔魂装备>
    <Text|x=50.0|y=303.0|size=16|color=70|outline=2|outlinecolor=0|text=自动回收>
    <Text|x=50.0|y=326.0|size=16|color=70|outline=2|outlinecolor=0|text=自动吃货币>
    <Button|x=182.0|y=307.0|color=255|size=18|nimg=custom/UI/zbhs/btn1.png|outline=2|outlinecolor=0|text=全选|link=@click,装备回收_selectAll>
    <Button|x=295.0|y=307.0|size=18|nimg=custom/UI/zbhs/btn1.png|color=255|outline=2|outlinecolor=0|text=反选|link=@click,装备回收_selectReverse>
    <Button|x=408.0|y=307.0|size=18|nimg=custom/UI/zbhs/btn1.png|color=255|outline=2|outlinecolor=0|text=一键回收|link=@click,装备回收_beginCycle>
    <Button|x=531.0|y=137.0|color=70|nimg=custom/UI/zbhs/btn2.png|size=24|outline=2|outlinecolor=0|text=特\殊\回\收|link=@click,特殊回收_main>
]]


function AppEquipCycle.getVarTb(player)
    local varTb = {}
    local isOpen = {}
    local jsonStr = lualib:GetVar(player, VarCfg["装备回收"])
    if jsonStr == "" then
        -- for i = 1, #AppEquipCycleData.list, 1 do
        --     table.insert(isOpen, 0)
        -- end
        for k, v in pairs(AppEquipCycleData.list) do
            table.insert(isOpen, 0)
        end
        lualib:SetVar(player, VarCfg["装备回收"], tbl2json(isOpen))
    else
        isOpen = json2tbl(jsonStr)
    end
    varTb.isOpen = isOpen
    varTb.isAutoHS = lualib:GetVar(player, VarCfg["自动回收"])
    varTb.isAutoCHB = lualib:GetVar(player, VarCfg["自动吃货币"])
    --回收倍率
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
            (varTb.isOpen[count]) .. "|link=@click,装备回收_selectOne," .. count .. ">"
            str = str ..
            "<Text|x=" ..
            (140 + (j - 1) * 230) ..
            "|y=" ..
            (149 + (i - 1) * 30) ..
            "|color=249|size=18|outline=2|outlinecolor=0|text=(说明)|tips=" ..
            AppEquipCycleData.list[count].describe .. "|tipsx=10|tipsy=70>"
            count = count + 1
        end
    end
    str = str ..
        "<CheckBox|x=141.0|y=296.0|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" ..
        isAutoHS .. "|link=@click,装备回收_openAutoCycle>"
    str = str ..
        "<CheckBox|x=141.0|y=322.0|nimg=public/1900000550.png|pimg=public/1900000551.png|default=" ..
        isAutoCHB .. "|link=@click,装备回收_openAutochb>"
    str = str ..
    "<RText|x=399.0|y=95.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. (100 + varTb.Rate) .. "%/FCOLOR=250>>"
    say(player, str)
end

--单选
function AppEquipCycle.selectOne(player, pos)
    pos = tonumber(pos)
    local varTb = AppEquipCycle.getVarTb(player)
    if not pos or not varTb.isOpen[pos] then
        return
    end
    --删除回收组
    if varTb.isOpen[pos] == 1 then
        callscriptex(player, "DELRECYCLINGTYPE", AppEquipCycleData.list[pos].group)
        varTb.isOpen[pos] = 0
        --添加回收组
    elseif varTb.isOpen[pos] == 0 then
        callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[pos].group)
        varTb.isOpen[pos] = 1
    end
    lualib:SetVar(player, VarCfg["装备回收"], tbl2json(varTb.isOpen))
end

--全选
function AppEquipCycle.selectAll(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 1, 10 do
        varTb.isOpen[i] = 1
        callscriptex(player, "ADDRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    lualib:SetVar(player, VarCfg["装备回收"], tbl2json(varTb.isOpen))
    AppEquipCycle.main(player)
end

--全否
function AppEquipCycle.selectReverse(player)
    local varTb = AppEquipCycle.getVarTb(player)
    for i = 1, 10 do
        varTb.isOpen[i] = 0
        callscriptex(player, "DELRECYCLINGTYPE", AppEquipCycleData.list[i].group)
    end
    -- callscriptex(player, "DELRECYCLINGTYPE", -1)
    lualib:SetVar(player, VarCfg["装备回收"], tbl2json(varTb.isOpen))
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

--回收触发
function recycling(player)
    local varTb = AppEquipCycle.getVarTb(player)
    --回收倍率
    lualib:SetStr(player, "回收数据", getconst(player, "<$RECYITEMS>"))
    local goldNum = tonumber(getconst(player, "<$GETSTRVALUE(S$回收数据,1)>")) --金币
    if goldNum then
        lualib:AddMoney(player, 1, goldNum * (varTb.Rate) / 100, "回收额外获取")
    end
    --时间间隔
    local curTime = lualib:GetAllTime()
    lualib:SetInt(player, "装备回收间隔", curTime)
    --自动吃货币
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

-- 开始回收
function AppEquipCycle.beginCycle(player)
    local curTime = lualib:GetAllTime()
    -- 这里加3秒延迟，避免回收频繁
    if curTime - lualib:GetInt(player, "装备回收间隔") < 2 then
        Message:Msg9(player, "请不要频繁回收！")
        return
    end
    lualib:CallTxtScript(player, "RECYCLING")
end

---打开或关闭自动回收
function AppEquipCycle.openAutoCycle(player)
    local varTb = AppEquipCycle.getVarTb(player)
    if varTb.isAutoHS == 1 then
        callscriptex(player, "AUTORECYCLING")
        lualib:SetVar(player, VarCfg["自动回收"], 0)
        setofftimer(player, 3)
    end
    if varTb.isAutoHS == 0 then
        callscriptex(player, "AUTORECYCLING", 20, 10)
        lualib:SetVar(player, VarCfg["自动回收"], 1)
        setontimer(player, 3, 20)
    end
end

--打开自动吃货币
function AppEquipCycle.openAutochb(player)
    local varTb = AppEquipCycle.getVarTb(player)
    if varTb.isAutoCHB == 1 then
        lualib:SetVar(player, VarCfg["自动吃货币"], 0)
        setofftimer(player, 5)
    end
    if varTb.isAutoCHB == 0 then
        lualib:SetVar(player, VarCfg["自动吃货币"], 1)
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

--游戏事件
GameEvent.add(EventCfg.onLogin, AppEquipCycle.onLogin, AppEquipCycle)
-- setFormAllowFunc("装备回收", { "main", "selectAll", "selectReverse", "openAutoCycle", "beginCycle", "selectOne" })
Message.RegisterClickMsg("装备回收", AppEquipCycle)
return AppEquipCycle
