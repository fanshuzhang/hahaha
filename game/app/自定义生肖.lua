---@class NpcCustomJewelry 自定义生肖

local NpcCustomJewelry = {}

NpcCustomJewelry.Name = "自定义生肖"
-- NpcCustomJewelryCfg = zsf_RequireNpcCfg(NpcCustomJewelry.Name)
local baseStr = [[
    <Img|x=4.0|y=-38.0|reset=1|show=4|bg=1|move=1|img=custom/UI/sc/img_bk.png|loadDelay=1|esc=1>
    <Layout|x=399.0|y=-46.0|width=80|height=80|link=@exit>
    <Button|x=421.0|y=-22.0|nimg=custom/UI/sc/close.png|pimg=public/1900000511.png|link=@click,自定义生肖_close>
]]
--[[    <Layout|x=399.0|y=-46.0|width=80|height=80|link=@exit>
    <Button|x=421.0|y=-22.0|nimg=custom/UI/sc/close.png|pimg=public/1900000511.png|link=@exit>]]
function NpcCustomJewelry.close(player)
    close(player)
    lualib:SetFlagStatus(player, PlayerVarCfg["打开自定义生肖"], 0)
end

function NpcCustomJewelry.getVarTb(player)
    local varTb = {}
    local level = lualib:GetVar(player, VarCfg["生肖装备开孔数量"])
    if level then
        varTb.level = level
    else
        varTb.level = 0
    end
    local equipNum = 0
    local pos = { 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82 }
    for i = 1, #pos do
        local equip = linkbodyitem(player, pos[i])
        if equip and equip ~= '0' then
            equipNum = equipNum + 1
        end
    end
    varTb.equipNum = equipNum
    return varTb
end

function NpcCustomJewelry.main(player)
    if lualib:GetFlagStatus(player, PlayerVarCfg["打开自定义生肖"]) == 1 then--1:打开 0:关闭
        close(player)
        lualib:SetFlagStatus(player, PlayerVarCfg["打开自定义生肖"], 0)
    
    else
    NpcCustomJewelry.updataData(player)
    lualib:SetFlagStatus(player, PlayerVarCfg["打开自定义生肖"], 1)
    end
end

--30,23
function NpcCustomJewelry.updataData(player)
    local varTb = NpcCustomJewelry.getVarTb(player)
    local str = "" .. baseStr
    local num, data = 0, 71
    for i = 1, 3 do
        for j = 1, 4 do
            if varTb.level > num then
                str = str .."<Img|x=" .. (30 + (j - 1) * 100) .."|y=" .. (23 + (i - 1) * 100) .. "|children={" .. data .. "}|img=custom/new1/img_k.png>"
                str = str .."<EquipShow|id=" ..data .."|x=0.0|y=-0.0|width=70|height=70|showtips=1|index=" .. data .. "|bgtype=0|dblink=@click,自定义生肖_takeoffEquip," .. data .. ">"
            else
                str = str .. "<Img|x=" .. (30 + (j - 1) * 100) .. "|y=" .. (23 + (i - 1) * 100) .."|width=60|height=60|img=custom/UI/sc/stop.png>"
            end
            num = num + 1
            data = data + 1
        end
    end
    say(player, str)
end

function NpcCustomJewelry.takeoffEquip(player, equipPos)
    if not equipPos then
        return
    end
    lualib:TakeOffItem(player, equipPos)
end

function NpcCustomJewelry.onTakeOnEx(player, item, itemName, where)
    if where and where >= 71 and where <= 82 then
        local varTb = NpcCustomJewelry.getVarTb(player)
        if varTb.equipNum > varTb.level then
            NpcCustomJewelry.takeoffEquip(player, where)
            Message:Msg9(player, "[系统提示]:请前往[轮回转世]获得更多装备开孔")
            return
        end
        if lualib:GetFlagStatus(player, PlayerVarCfg["打开自定义生肖"])==1 then
            close(player)
            NpcCustomJewelry.updataData(player)
        end
    end
end

function NpcCustomJewelry.onTakeOffEx(player, item, itemName, where)
    if where and where >= 71 and where <= 82 then
        if lualib:GetFlagStatus(player, PlayerVarCfg["打开自定义生肖"])==1 then
            close(player)
            NpcCustomJewelry.updataData(player)
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onTakeOnEx, NpcCustomJewelry.onTakeOnEx, NpcCustomJewelry)
GameEvent.add(EventCfg.onTakeOffEx, NpcCustomJewelry.onTakeOffEx, NpcCustomJewelry)

Message.RegisterClickMsg(NpcCustomJewelry.Name, NpcCustomJewelry)

return NpcCustomJewelry
