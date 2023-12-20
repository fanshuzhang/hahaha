---@class NPCProAttire 职业时装
local NPCProAttire = {}
local NPCProAttireCfg = zsf_RequireNpcCfg("职业时装")


local basicRes = [[
    <Img|reset=1|esc=1|move=1|loadDelay=1|show=4|img=custom/UI/public/img_bk2.png|bg=1>
    <Layout|x=481.0|y=0.0|width=80|height=80|link=@exit>
    <Button|x=516.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
    <RText|x=243.0|y=66.0|size=18|color=70|outline=2|outlinecolor=0|text=<职业时装/FCOLOR=70>>
    <Img|x=56.0|y=96.0|img=custom/new1/img_k.png|esc=0>
    <Img|x=56.0|y=165.0|img=custom/new1/img_k.png|esc=0>
    <Img|x=56.0|y=231.0|img=custom/new1/img_k.png|esc=0>
    <RText|x=145.0|y=119.0|color=255|size=18|outline=2|outlinecolor=0|text==    200<[时装碎片]/FCOLOR=254>   +   5000<[元宝]/FCOLOR=251>>
    <RText|x=145.0|y=191.0|color=255|size=18|outline=2|outlinecolor=0|text==    500<[时装碎片]/FCOLOR=254>   +   10000<[元宝]/FCOLOR=251>>
    <RText|x=145.0|y=256.0|color=255|size=18|outline=2|outlinecolor=0|text==    1000<[时装碎片]/FCOLOR=254>   +   20000<[元宝]/FCOLOR=251>>
]]
function NPCProAttire.getVarTb(player, pos)
    pos = tonumber(pos) or 1
    local varTb = {}
    varTb.Job = lualib:GetVar(player, VarCfg["角色职业"])
    local equip = lualib:LinkBodyItem(player, NPCProAttireCfg.pos[pos])
    if equip ~= "0" and equip then
        varTb.equipName = lualib:ItemName(player, equip)
        varTb.equip = equip
        varTb.level = NPCProAttireCfg.equip[varTb.equipName]
    else
        varTb.equipName = ""
        varTb.equip = ""
        varTb.level = 0
    end
    varTb.sex = lualib:Gender(player) --0男 1女
    return varTb
end

function NPCProAttire.main(player, pos)
    pos = tonumber(pos) or 1
    local varTb = NPCProAttire.getVarTb(player, pos)
    local str = ""
    str = str .. basicRes
    str = str .. [[
        <Button|x=82.0|y=305.0|size=18|nimg=custom/UI/public/btn2.png|color=255|outline=2|outlinecolor=0|text=时装武器|link=@click,职业时装_changeTab,1>
        <Button|x=231.0|y=305.0|size=18|nimg=custom/UI/public/btn2.png|color=255|outline=2|outlinecolor=0|text=时装男衣|link=@click,职业时装_changeTab,2>
        <Button|x=372.0|y=305.0|size=18|nimg=custom/UI/public/btn2.png|color=255|outline=2|outlinecolor=0|text=时装女衣|link=@click,职业时装_changeTab,3>
    ]]
    str = str .. [[
        <Text|x=442.0|y=120.0|color=250|size=18|outline=2|outlinecolor=0|text=开始锻造|link=@click,职业时装_MoveOk,1,]] .. pos ..
        [[>
        <Text|x=442.0|y=193.0|color=250|size=18|outline=2|outlinecolor=0|text=开始锻造|link=@click,职业时装_MoveOk,2,]] .. pos ..
        [[>
        <Text|x=442.0|y=257.0|color=250|size=18|outline=2|outlinecolor=0|text=开始锻造|link=@click,职业时装_MoveOk,3,]] .. pos ..
        [[>
    ]]
    str = str .. [[
        <ItemShow|x=58.0|y=99.0|width=70|height=70|itemid=]] ..
        (NPCProAttireCfg.list[varTb.Job][pos][1].e[2]) .. [[|itemcount=1|showtips=1|bgtype=0>
        <ItemShow|x=58.0|y=168.0|width=70|height=70|itemid=]] ..
        (NPCProAttireCfg.list[varTb.Job][pos][2].e[2]) .. [[|itemcount=1|showtips=1|bgtype=0>
        <ItemShow|x=58.0|y=232.0|width=70|height=70|itemid=]] ..
        (NPCProAttireCfg.list[varTb.Job][pos][3].e[2]) .. [[|itemcount=1|showtips=1|bgtype=0>
    ]]
    say(player, str)
end

--开始锻造
function NPCProAttire.MoveOk(player, nextLevel, pos)
    if not nextLevel or not pos then
        return
    end
    nextLevel = tonumber(nextLevel) or 1
    pos = tonumber(pos) or 1
    local varTb = NPCProAttire.getVarTb(player, pos)
    local sex = 0
    if pos == 2 then
        sex = 0
    elseif pos == 3 then
        sex = 1
    end
    if varTb.sex ~= sex and pos > 1 then
        Message:Msg9(player, "你干嘛呀~那是你能穿的吗~")
        return
    end
    if varTb.level >= 3 then
        Message:Msg9(player, "您当前职业时装已锻造至满级！")
        return
    end
    if nextLevel == 2 then
        if varTb.level ~= 1 then
            Message:Msg9(player, "请先穿戴好上一级的职业时装")
            return
        end
    end
    if nextLevel == 3 then
        if varTb.level ~= 2 then
            Message:Msg9(player, "请先穿戴好上一级的职业时装")
            return
        end
    end
    if lualib:GetBagFree(player) < 5 then
        Message:Msg9(player, "您的背包空间不足5格，无法提升！")
        return
    end
    local se = NPCProAttireCfg.list[varTb.Job][pos][nextLevel]
    --材料是否充足
    local flag, desc = lualib:BatchCheckItemEX(player, se.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --扣除材料
    flag, desc = lualib:BatchDelItemEX(player, se.cost, "职业时装提升消耗")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --拿
    if varTb.level ~= 0 and nextLevel>1 then
        lualib:FTakeItemEX(player, varTb.equip)
    end
    --给
    lualib:AddAndEquipItem(player, NPCProAttireCfg.pos[pos], se.e[1])
    NPCProAttire.main(player, pos)
end

--选择Tab
function NPCProAttire.changeTab(player, pos)
    pos = tonumber(pos) or 1
    NPCProAttire.main(player, pos)
end

--Npc点击触发
function NPCProAttire.onClickNpc(player, npcID, npcName)
    if not NPCProAttireCfg.index[npcID] then
        return
    end
    NPCProAttire.main(player)
end

--游戏事件
GameEvent.add(EventCfg.onClickNpc, NPCProAttire.onClickNpc, NPCProAttire)
Message.RegisterClickMsg("职业时装", NPCProAttire)
return NPCProAttire
