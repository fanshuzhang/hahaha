---@class NpcDonate 沙城捐献
local NpcDonate = {}

NpcDonate.title = { "捐献第一名", "捐献第二名", "捐献第三名", "捐献第四名", "捐献第五名", "捐献参与者", }

function NpcDonate.getVarTb()
    local varTb = {}
    local sortTb = sorthumvar("捐献金额", 0, 1, 0)
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
        <RText|x=374.0|y=63.0|color=255|size=20|outline=2|outlinecolor=0|text=<沙城捐献/FCOLOR=70>>
        <RText|x=177.0|y=371.0|color=255|size=18|outline=2|outlinecolor=0|text=<捐献100000金币即可获得：/FCOLOR=70><攻魔道 5-5  生命 100   魔法 100/FCOLOR=246>>
        <RText|x=160.0|y=400.0|color=255|size=22|outline=2|outlinecolor=0|text=<捐献金币的30%累积到沙城奖池，攻城结束后消失！/FCOLOR=249>>
        <Img|x=393.0|y=480.0|width=154|img=custom/UI/scjx/img1.png>
        <Text|x=612.0|y=137.0|size=22|color=251|outline=2|outlinecolor=0|text=[捐献属性]|tips={攻魔道:50-50 生命:1000 魔法:500/FCOLOR=250}^{受物理伤害减少20%/FCOLOR=251}^{受魔法伤害减少20%/FCOLOR=251}|tipsx=10|tipsy=70|>
        <Text|x=612.0|y=183.0|size=22|color=251|outline=2|outlinecolor=0|text=[捐献属性]|tips={攻魔道:30-30 生命:600 魔法:300/FCOLOR=250}^{受物理伤害减少10%/FCOLOR=251}^{受魔法伤害减少10%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=226.0|size=22|color=251|outline=2|outlinecolor=0|text=[捐献属性]|tips={攻魔道:20-20 生命:400 魔法:200/FCOLOR=250}^{受物理伤害减少8%/FCOLOR=251}^{受魔法伤害减少8%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=272.0|size=22|color=251|outline=2|outlinecolor=0|text=[捐献属性]|tips={攻魔道:15-15 生命:300 魔法:150/FCOLOR=250}^{受物理伤害减少5%/FCOLOR=251}^{受魔法伤害减少5%/FCOLOR=251}|tipsx=10|tipsy=70>
        <Text|x=612.0|y=317.0|size=22|color=251|outline=2|outlinecolor=0|text=[捐献属性]|tips={攻魔道:10-10 生命:200 魔法:100/FCOLOR=250}^{受物理伤害减少3%/FCOLOR=251}^{受魔法伤害减少3%/FCOLOR=251}|tipsx=10|tipsy=70>
    ]]
    local str = '' .. basicRes
    local varTb = NpcDonate.getVarTb()
    local name, num = "", ""
    for i = 1, 5 do
        if varTb.name[i] and varTb.num[i] then
            name = varTb.name[i]
            num = varTb.num[i]
        else
            name, num = "#无人上榜#", "无"
        end
        str = str ..
            "<RText|x=210.0|y=" ..
            (137 + 44 * (i - 1)) .. "|color=255|size=24|outline=2|outlinecolor=0|text=<" .. name .. "/FCOLOR=255>>"
        str = str ..
            "<RText|x=407.0|y=" ..
            (137 + 44 * (i - 1)) .. "|color=255|size=24|outline=2|outlinecolor=0|text=<" .. num .. "/FCOLOR=255>>"
    end

    local moneyNum, moneyNum30 = "攻沙期间展示", "攻沙期间展示"
    if castleinfo(5) then
        moneyNum = lualib:GetVar(player, VarCfg["总捐献金额"])
        moneyNum30 = moneyNum * 0.3
    end
    local money = getplayvar(player, "HUMAN", "捐献金额")
    local mainStr = '' .. str
    mainStr = mainStr ..
        "<RText|x=211.0|y=440.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. moneyNum .. "/FCOLOR=251>>"
    mainStr = mainStr ..
        "<RText|x=551.0|y=440.0|color=255|size=18|outline=2|outlinecolor=0|text=<" .. moneyNum30 .. "/FCOLOR=251>>"
    mainStr = mainStr ..
        "<RText|x=195.0|y=487.0|color=70|size=18|outline=2|outlinecolor=0|text=<" .. money .. "/FCOLOR=250>>"
    mainStr = mainStr ..
        "<Input|x=395.0|y=482.0|width=150|height=25|type=1|inputid=9|size=20|outline=2|outlinecolor=0|color=255|place=请输入捐献金额|placecolor=0>"
    mainStr = mainStr ..
        "<Button|x=577.0|y=472.0|color=255|size=18|submitInput=9|nimg=custom/UI/scjx/btn1.png|link=@click,沙城捐献_MoveOk>"
    say(player, mainStr)
end

--捐献
function NpcDonate.MoveOk(player)
    local num = tonumber(getconst(player, "<$NPCINPUT(9)>"))
    if not num then
        return
    end
    if num < 100000 then
        Message:Msg9(player, "最低捐献100000金币")
        return
    end
    if getbindmoney(player, "金币") < num then
        Message:Msg9(player, "你的金币不足")
        return
    end
    consumebindmoney(player, "金币",num, "捐献消耗")
    --记录
    lualib:SetPlayerInt(player, "捐献金额", lualib:GetPlayerInt(player, "捐献金额") + num)
    lualib:SetVar(player, VarCfg["总捐献金额"], lualib:GetVar(player, VarCfg["总捐献金额"]) + num)
    Message:SendMsgNew(player, "玩家[" .. lualib:Name(player) .. "]捐献了"..num.."金币")
    NpcDonate.main(player)
    --排名判断
    NpcDonate.ranking(player)
end

--排名更新
function NpcDonate.ranking(player)
    --排名判断
    local varTb = NpcDonate.getVarTb()
    --更新排行榜-给称号
    for index, value in ipairs(varTb.name) do
        if index >= 6 then index = 6 end
        if value and value ~= '' then
            local playItem = lualib:GetPlayerByName(value)
            if isnotnull(playItem) then
                for i = 1, 6 do
                    if lualib:HasTitle(playItem, NpcDonate.title[i]) then
                        lualib:DelTitle(playItem, NpcDonate.title[i]) --删除称号
                    end
                end
                lualib:AddTitleEx(playItem, NpcDonate.title[index]) --给称号
            end
        end
    end
end

--点击NPC触发
function NpcDonate.onClickNpc(player, npcID, npcName)
    if npcID == 7 then
        NpcDonate.main(player)
        return
    end
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NpcDonate.onClickNpc, NpcDonate)
Message.RegisterClickMsg("沙城捐献", NpcDonate)
return NpcDonate
