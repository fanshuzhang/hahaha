-- function moneychange8(player)
--     local ingot = lualib:GetMoneyEx(player, "��Ʒ��¼")
--     if ingot > 1000000000 then
--         lualib:SetMoneyEx(player, "��Ʒ��¼", "-",1000000000, "��Ʒ��¼�������ƣ���־��ѯ���Ը���", true)
--     end
-- end

-- function moneychange33(player)
--     -- �����񳬹�20�ڣ��Զ��һ�10��Ϊ�����
--     local myCQY = lualib:GetMoneyEx(player, "�����")
--     if myCQY > 3000000000 then
--         lualib:SetMoneyEx(player, "�����", "-", 1000000000, "��Ʒ�����������ֵ���Զ��һ�", true)
--         lualib:SetMoneyEx(player, "AI��", "+", 10000000, "����ҳ������ֵ���Զ��һ��������", true)
--         Message:Msg9(player, "���Ĵ����񳬹�30�ڣ����Զ���10�ڴ�����һ�Ϊ1000WAI��")

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

function changemoneyout(player, moneyId, moneyNum) --���ҳ�������

end

--��ҳ�������
function moneychange1(player)
    local myGold = lualib:GetMoneyEx(player, "���")
    if myGold >= 2000000000 then
        lualib:SetMoneyEx(player, "���", "-", 100000000, "��������������ֵ���Զ��һ�", true)
        giveitem(player, "����", 1, 32)
        Message:Msg9(player, "����[���]����20�ڣ����Զ���1�ڽ�Ҷһ�Ϊһ������")
    end
end
