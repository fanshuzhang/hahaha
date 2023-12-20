local GeneralNewManData = {
    reward = {
        -- { "盟重回城石", 1, type = 3 },
        -- { "随机传送石", 1, type = 3 },
        {"魔血石(大)", 1, type=3},
        --全新科技装备
        -- { "全新科技【一阶】", 1, type = 3 },
        --{"金条", 2, type=3},
        -- { "初入江湖·链", 1, type = 1, pos = 3 },
        -- { "初入江湖·盔", 1, type = 1, pos = 4 },
        -- { "初入江湖·镯", 1, type = 1, pos = 5 },
        -- { "初入江湖·镯", 1, type = 1, pos = 6 },
        -- { "初入江湖·戒", 1, type = 1, pos = 7 },
        -- { "初入江湖·戒", 1, type = 1, pos = 8 },
        { "布衣(男)", 1, type = 1, pos = 0 },
        { "木剑", 1, type = 1, pos = 1 },
        -- { "初入江湖·带", 1, type = 1, pos = 10 },
        -- { "初入江湖·靴", 1, type = 1, pos = 11 },
        --{"【1阶】小刀№符文◆☆◆", 1, type=1, pos=9},
        --{"【1阶】小刀№战鼓◆☆◆", 1, type=1, pos=14},
        -- { "基本剑术", 3, type = 2, id = 3 },
        -- { "攻杀剑术", 3, type = 2, id = 7 },
        -- { "刺杀剑术", 3, type = 2, id = 12 },
        -- { "野蛮冲撞", 3, type = 2, id = 27 },
        -- { "烈火剑法", 3, type = 2, id = 26 },
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
        Message:NoticeMsg(player, 255, 168, string.format("欢迎新人:「%s」.进入了游戏,本服24小时激情不间断.人气超乎想象.Ｈot~", lualib:Name(player)))
    end
    lualib:MapMoveXY(player, "xinshouc", 78, 43, 10)
    local myMapLevel = lualib:GetVar(player, VarCfg["地图等级"]), lualib:GetVar(player, VarCfg["地图等级"])
    if myMapLevel <= 0 then
        lualib:SetVar(player, VarCfg["地图等级"], 1)
    end
end

GameEvent.add(EventCfg.onNewHuman, GeneralNewManData.main, GeneralNewManData)
return GeneralNewManData
