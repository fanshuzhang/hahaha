-- function moneychange8(player)
--     local ingot = lualib:GetMoneyEx(player, "物品记录")
--     if ingot > 1000000000 then
--         lualib:SetMoneyEx(player, "物品记录", "-",1000000000, "物品记录超过限制，日志查询忽略该条", true)
--     end
-- end

-- function moneychange33(player)
--     -- 传奇玉超过20亿，自动兑换10亿为仙灵点
--     local myCQY = lualib:GetMoneyEx(player, "传奇币")
--     if myCQY > 3000000000 then
--         lualib:SetMoneyEx(player, "传奇币", "-", 1000000000, "物品数量超过最大值，自动兑换", true)
--         lualib:SetMoneyEx(player, "AI币", "+", 10000000, "传奇币超过最大值，自动兑换仙灵点获得", true)
--         Message:Msg9(player, "您的传奇玉超过30亿，已自动将10亿传奇玉兑换为1000WAI币")

--     end
-- end


function moneychange3(player)
    local str = ''
    local cType = lualib:GetClientType(player) -- 1-PC 2-MOBILE
    delbutton(player, 7, 105)
    str = ""
    if cType == 1 then
        str = str .. "<Text|id=105|x=25|y=20|outline=2|outlinecolor=0|color=251|size=18|text=" ..
            querymoney(player, 3) .. ">"
    else
        str = str ..
            "<Text|id=105|x=70|y=348|outline=2|outlinecolor=0|color=251|size=18|text=" .. querymoney(player, 3) .. ">"
    end
    addbutton(player, 7, 105, str)
end

function changemoneyout(player, moneyId, moneyNum) --货币超出限制

end

--金币超出限制
function moneychange1(player)
    local myGold = lualib:GetMoneyEx(player, "金币")
    if myGold >= 2000000000 then
        lualib:SetMoneyEx(player, "金币", "-", 100000000, "金币数量超过最大值，自动兑换", true)
        giveitem(player, "金箱", 1, 32)
        Message:Msg9(player, "您的[金币]超过20亿，已自动将1亿金币兑换为一个金箱")
    end
end
