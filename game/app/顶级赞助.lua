---@class AppTopSponsorShip 顶级赞助

local AppTopSponsorShip = {}
AppTopSponsorShip.Name = "顶级赞助"
local AppTopSponsorShipCfg = zsf_RequireAppCfg(AppTopSponsorShip.Name)
local basicRes = [[
    <Img|show=4|bg=1|loadDelay=1|move=1|reset=1|img=custom/UI/public/img_bk2.png|esc=1>
    <Layout|x=500.0|y=28.0|width=50|height=50|link=@click,顶级赞助_close>
    <Button|x=517.0|y=48.0|nimg=custom/new1/close2.png|color=255|size=18|link=@click,顶级赞助_close>
    <RText|x=241.0|y=65.0|color=251|size=18|outline=2|outlinecolor=0|text=<赞助会员/FCOLOR=251>>
    <Img|x=194.0|y=89.0|height=260|img=custom/UI/public/img2.png|esc=0>
    <Img|x=367.0|y=89.0|height=260|img=custom/UI/public/img2.png|esc=0>
    <RText|x=56.0|y=97.0|size=22|color=255|outline=2|outlinecolor=0|text=<#青铜赞助#/FCOLOR=251>>
    <RText|x=52.0|y=139.0|color=255|size=20|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=70><5-5/FCOLOR=255>>
    <RText|x=52.0|y=171.0|size=20|color=255|outline=2|outlinecolor=0|text=<生     命：/FCOLOR=70><100/FCOLOR=255> >
    <RText|x=53.0|y=202.0|color=255|size=20|outline=2|outlinecolor=0|text=<魔法值：/FCOLOR=70><50/FCOLOR=255>>
    <RText|x=51.0|y=234.0|color=255|size=20|outline=2|outlinecolor=0|text=<致命一击：/FCOLOR=249><1%/FCOLOR=255>>
    <RText|x=57.0|y=269.0|color=255|size=20|outline=2|outlinecolor=0|text=<4*4范围拾取/FCOLOR=251>>
    <Button|id=1001|x=59.0|y=305.0|color=255|size=18|nimg=custom/UI/public/btn2.png|outline=2|outlinecolor=0|text=免费领取|link=@click,顶级赞助_MoveOk,1>
]]
local str = [[
    <RText|x=226.0|y=97.0|color=255|size=22|outline=2|outlinecolor=0|text=<#白银赞助#/FCOLOR=251>>
    <RText|x=222.0|y=139.0|color=255|size=20|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=70><10-10/FCOLOR=255>>
    <RText|x=224.0|y=171.0|color=255|size=20|outline=2|outlinecolor=0|text=<生     命：/FCOLOR=70><200/FCOLOR=255>>
    <RText|x=226.0|y=202.0|color=255|size=20|outline=2|outlinecolor=0|text=<魔法值：/FCOLOR=70><100/FCOLOR=255>>
    <RText|x=225.0|y=234.0|color=255|size=20|outline=2|outlinecolor=0|text=<致命一击：/FCOLOR=249><2%/FCOLOR=255>>
    <Button|id=1002|x=229.0|y=305.0|color=255|nimg=custom/UI/public/btn2.png|size=18|outline=2|outlinecolor=0|text=38元领取|link=@click,顶级赞助_MoveOk,2>
    <RText|x=388.0|y=97.0|color=255|size=22|outline=2|outlinecolor=0|text=<#黄金赞助#/FCOLOR=251>>
    <RText|x=383.0|y=139.0|color=255|size=20|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=70><25-25/FCOLOR=255>>
    <RText|x=383.0|y=171.0|color=255|size=20|outline=2|outlinecolor=0|text=<生     命：/FCOLOR=70><500/FCOLOR=255>>
    <RText|x=385.0|y=202.0|color=255|size=20|outline=2|outlinecolor=0|text=<魔法值：/FCOLOR=70><250/FCOLOR=255>>
    <RText|x=385.0|y=234.0|color=255|size=20|outline=2|outlinecolor=0|text=<致命一击：/FCOLOR=249><3%/FCOLOR=255>>
    <Button|id=1003|x=391.0|y=305.0|color=255|nimg=custom/UI/public/btn2.png|size=18|outline=2|outlinecolor=0|text=88元领取|link=@click,顶级赞助_MoveOk,3>
]]
local _str = [[
    <RText|x=226.0|y=97.0|color=255|size=22|outline=2|outlinecolor=0|text=<#钻石赞助#/FCOLOR=251>>
    <RText|x=222.0|y=139.0|color=255|size=20|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=70><50-50/FCOLOR=255>>
    <RText|x=224.0|y=171.0|color=255|size=20|outline=2|outlinecolor=0|text=<生     命：/FCOLOR=70><1000/FCOLOR=255>>
    <RText|x=226.0|y=202.0|color=255|size=20|outline=2|outlinecolor=0|text=<魔法值：/FCOLOR=70><500/FCOLOR=255>>
    <RText|x=225.0|y=234.0|color=255|size=20|outline=2|outlinecolor=0|text=<致命一击：/FCOLOR=249><4%/FCOLOR=255>>
    <Button|id=1004|x=229.0|y=305.0|color=255|nimg=custom/UI/public/btn2.png|size=18|outline=2|outlinecolor=0|text=168元领取|link=@click,顶级赞助_MoveOk,4>
    <RText|x=388.0|y=97.0|color=255|size=22|outline=2|outlinecolor=0|text=<#至尊赞助#/FCOLOR=251>>
    <RText|x=383.0|y=139.0|color=255|size=20|outline=2|outlinecolor=0|text=<攻魔道：/FCOLOR=70><100-100/FCOLOR=255>>
    <RText|x=383.0|y=171.0|color=255|size=20|outline=2|outlinecolor=0|text=<生     命：/FCOLOR=70><2000/FCOLOR=255>>
    <RText|x=385.0|y=202.0|color=255|size=20|outline=2|outlinecolor=0|text=<魔法值：/FCOLOR=70><1000/FCOLOR=255>>
    <RText|x=385.0|y=234.0|color=255|size=20|outline=2|outlinecolor=0|text=<致命一击：/FCOLOR=249><5%/FCOLOR=255>>
    <Button|id=1005|x=391.0|y=305.0|color=255|nimg=custom/UI/public/btn2.png|size=18|outline=2|outlinecolor=0|text=288元领取|link=@click,顶级赞助_MoveOk,5>
]]

function AppTopSponsorShip.getVarTb(player)
    local varTb = {}
    local jsonStr = lualib:GetVar(player, VarCfg["赞助领取状态"])
    local isReceive = {}
    if jsonStr == "" then
        isReceive = { 0, 0, 0, 0, 0 }
        lualib:SetVar(player, VarCfg["赞助领取状态"], tbl2json(isReceive))
    else
        isReceive = json2tbl(jsonStr)
    end
    varTb.isReceive = isReceive
    local level = lualib:GetVar(player, VarCfg["顶级赞助"])
    varTb.level = level
    return varTb
end

function AppTopSponsorShip.main(player)
    if lualib:GetFlagStatus(player, PlayerVarCfg["第一次打开顶级赞助"]) == 0 then
        Message:Msg9(player, "免费送范围拾取")
        lualib:SetFlagStatus(player, PlayerVarCfg["第一次打开顶级赞助"], 1)
    end
    local varTb = AppTopSponsorShip.getVarTb(player)
    if varTb.isReceive[1] == 1 and varTb.isReceive[2] == 1 and varTb.isReceive[3] == 1 then
        say(player, basicRes .. _str)
    else
        say(player, basicRes .. str)
    end
    for i = 1, 5, 1 do
        if varTb.isReceive[i] == 1 then
            reddot(player, 0, (1000 + i), 53, 15, 0, "res/custom/new1/hdyl_0002.png")
        end
    end
end

function AppTopSponsorShip.MoveOk(player, index)
    if not index then
        return
    end
    index = tonumber(index) or 1
    --是否可领取
    local varTb = AppTopSponsorShip.getVarTb(player)
    if varTb.isReceive[index] and varTb.isReceive[index] == 1 then
        Message:Msg9(player, "你已经领取过该赞助福利，无法重复领取！")
        return
    end
    --开启充值
    --第一个免费
    if index == 1 and varTb.level == 0 then
        lualib:AddTitle(player, AppTopSponsorShipCfg.list[1].title)
        varTb.isReceive[1] = 1
        lualib:SetVar(player, VarCfg["顶级赞助"], 1)
        lualib:SetVar(player, VarCfg["赞助领取状态"], tbl2json(varTb.isReceive))
        --开启范围拾取
        pickupitems(player, 0, 4, 500)
        Message:Msg9(player, "领取成功！")
        AppTopSponsorShip.main(player)
        return
    end
    --其他
    if index - varTb.level ~= 1 then
        Message:Msg9(player, "请先领取之前的")
        return
    end
    pullpay(player, AppTopSponsorShipCfg.list[index].money, 1, 2)
    lualib:SetFlagStatus(player, PlayerVarCfg["顶级赞助充值"], 1)
    lualib:SetInt(player, "顶级赞助标记", index)
end

function AppTopSponsorShip.close(player)
    lualib:SetFlagStatus(player, PlayerVarCfg["顶级赞助充值"], 0)
    close(player)
end

--充值触发
function AppTopSponsorShip.onRecharge(player, gold, productId, moneyId, desc)
    if lualib:GetFlagStatus(player, PlayerVarCfg["顶级赞助充值"]) == 1 then --打开顶级赞助充值
        local index = lualib:GetInt(player, "顶级赞助标记")
        if gold >= AppTopSponsorShipCfg.list[index].money and moneyId == 2 then --达到充值金额
            local varTb = AppTopSponsorShip.getVarTb(player)
            if not varTb.isReceive[index] then --判断参数无误
                return
            end
            varTb.isReceive[index] = 1
            lualib:SetVar(player, VarCfg["赞助领取状态"], tbl2json(varTb.isReceive))
            lualib:DelTitle(player, AppTopSponsorShipCfg.list[index - 1].title) --删除称号
            lualib:AddTitle(player, AppTopSponsorShipCfg.list[index].title)     --给称号
            lualib:SetFlagStatus(player, PlayerVarCfg["顶级赞助充值"], 0)
            lualib:SetInt(player, "顶级赞助标记", 0)
            lualib:SetVar(player, VarCfg["顶级赞助"], index)
            Message:Msg9(player, "领取赞助称号成功!")
            AppTopSponsorShip.main(player)
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onRecharge, AppTopSponsorShip.onRecharge, AppTopSponsorShip)
setFormAllowFunc(AppTopSponsorShip.Name, { "main", "MoveOk", "close" })
Message.RegisterClickMsg("顶级赞助", AppTopSponsorShip)
return AppTopSponsorShip
