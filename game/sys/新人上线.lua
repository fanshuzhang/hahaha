local GeneralNewManData = {
    reward = {
        -- { "���ػس�ʯ", 1, type = 3 },
        -- { "�������ʯ", 1, type = 3 },
        {"ħѪʯ(��)", 1, type=3},
        --ȫ�¿Ƽ�װ��
        -- { "ȫ�¿Ƽ���һ�ס�", 1, type = 3 },
        --{"����", 2, type=3},
        -- { "���뽭������", 1, type = 1, pos = 3 },
        -- { "���뽭������", 1, type = 1, pos = 4 },
        -- { "���뽭������", 1, type = 1, pos = 5 },
        -- { "���뽭������", 1, type = 1, pos = 6 },
        -- { "���뽭������", 1, type = 1, pos = 7 },
        -- { "���뽭������", 1, type = 1, pos = 8 },
        { "����(��)", 1, type = 1, pos = 0 },
        { "ľ��", 1, type = 1, pos = 1 },
        -- { "���뽭������", 1, type = 1, pos = 10 },
        -- { "���뽭����ѥ", 1, type = 1, pos = 11 },
        --{"��1�ס�С������ġ����", 1, type=1, pos=9},
        --{"��1�ס�С����ս�ġ����", 1, type=1, pos=14},
        -- { "��������", 3, type = 2, id = 3 },
        -- { "��ɱ����", 3, type = 2, id = 7 },
        -- { "��ɱ����", 3, type = 2, id = 12 },
        -- { "Ұ����ײ", 3, type = 2, id = 27 },
        -- { "�һ𽣷�", 3, type = 2, id = 26 },
    },
}
function GeneralNewManData.main(player)
    for i = 1, #GeneralNewManData.reward do
        local sss = GeneralNewManData.reward[i]
        if sss.type == 3 then
            lualib:AddItem(player, sss[1], sss[2])
        elseif sss.type == 2 then
            lualib:AddSkill(player, sss.id, sss[2])
        elseif sss.type == 1 then
            lualib:AddAndEquipItem(player, sss.pos, sss[1])
        end
    end
    for i = 1, 2 do
        Message:NoticeMsg(player, 255, 168, string.format("��ӭ����:��%s��.��������Ϸ,����24Сʱ���鲻���.������������.��ot~", lualib:Name(player)))
    end
    lualib:MapMoveXY(player, "xinshouc", 78, 43, 10)
    local myMapLevel = lualib:GetVar(player, VarCfg["��ͼ�ȼ�"]), lualib:GetVar(player, VarCfg["��ͼ�ȼ�"])
    if myMapLevel <= 0 then
        lualib:SetVar(player, VarCfg["��ͼ�ȼ�"], 1)
    end
end

GameEvent.add(EventCfg.onNewHuman, GeneralNewManData.main, GeneralNewManData)
return GeneralNewManData
