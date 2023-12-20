---@class lsqysSkill 临时契约术
local lsqysSkill = {}

local monLevelCfg = zsf_RequireAppCfg("怪物等级")
--添加契约怪物仓库
function lsqysSkill.addBtn(player, skill, lv)
    if skill == SkillIDCfg["临时契约术"] or skill == SkillIDCfg["永久契约术"] then
        delbutton(player, 107, 555)
        addbutton(player, 107, 555,
            "<Button|x=-200.0|y=-60|color=255|size=18|nimg=custom/new1/hhh.png|link=@click,临时契约术_main>")
    end
end

--删除契约怪物仓库
function lsqysSkill.delBtn(player, skill)
    if Magic.BBcountEX(player, SkillIDCfg["临时契约术"]) or Magic.BBcountEX(player, SkillIDCfg["永久契约术"]) then
        return
    end
    delbutton(player, 107, 555)
    lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json({ "", "", "", "", "" }))
    lualib:SetVar(player, VarCfg["是否永久"], tbl2json({ 0, 0, 0, 0, 0 }))
end

--临时契约术
function lsqysSkill.getVarTb(player)
    local varTb = {}
    local jsonStr1 = lualib:GetVar(player, VarCfg['临时契约术怪物'])
    local jsonStr2 = lualib:GetVar(player, VarCfg['是否永久'])
    local jsonTb = {}
    if jsonStr1 and jsonStr1 == '' then
        lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json({ "", "", "", "", "" }))
        jsonTb = { "", "", "", "", "" }
    else
        jsonTb = json2tbl(jsonStr1)
    end
    varTb.bbName = jsonTb
    if jsonStr2 and jsonStr2 == '' then
        lualib:SetVar(player, VarCfg["是否永久"], tbl2json({ 0, 0, 0, 0, 0 }))
        jsonTb = { 0, 0, 0, 0, 0 }
    else
        jsonTb = json2tbl(jsonStr2)
    end
    varTb.isLong = jsonTb
    return varTb
end

function lsqysSkill.main(player)
    local varTb = lsqysSkill.getVarTb(player)
    local basicRes = [[
        <Img|show=4|bg=1|loadDelay=1|move=1|reset=1|img=custom/UI/lsqys/img_bk.png|loadDelay=0|esc=1>
        <Layout|x=378.0|y=-12.0|width=80|height=80|link=@exit>
        <Button|x=400.0|y=15.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <RText|x=177.0|y=14.0|color=255|size=18|outline=2|outlinecolor=0|text=<契约兽/FCOLOR=251>>
        <RText|x=30.0|y=40.0|color=255|size=14|outline=2|outlinecolor=0|text=<[暗影能量]:/FCOLOR=250><强化该技能可提升召唤契约兽数量！/FCOLOR=70>>
        <RText|x=30.0|y=62.0|color=255|size=14|outline=2|outlinecolor=0|text=<[契约精神]:/FCOLOR=250><强化该技能可提升契约兽种类！/FCOLOR=70>>
        <RText|x=30.0|y=85.0|color=255|size=12|outline=2|outlinecolor=0|text=<[注]:/FCOLOR=250><部分妖兽过于强大，将无法契约！/FCOLOR=249>>
        <ListView|x=26.0|y=41.0|children={1,2,3,4,5}|width=350|height=240|direction=2|margin=0|bounce=0>
    ]]
    local isNull = "空"
    local str = '' .. basicRes
    local child = { 10, 11, 12, 13, 14 }
    for i = 1, 5 do
        local monEff = 10
        isNull = "空"
        if varTb.bbName[i] ~= '' then
            isNull = "临时"
            monEff = tonumber(getdbmonfieldvalue(varTb.bbName[i], "appr"))
            if varTb.isLong[i] == 1 then
                isNull = "永久"
            end
        end
        str = str ..
            "<Layout|id=" ..
            i ..
            "|children={" ..
            child[1] ..
            ',' ..
            child[2] .. ',' .. child[3] .. ',' .. child[4] .. ',' .. child[5] .. "}|x=101.0|y=41.0|width=300|height=240>"
        str = str .. "<Img|id=" .. child[1] .. "|x=28.0|y=135.0|img=custom/UI/lsqys/img1.png>"
        str = str .. "<Effect|id=" .. child[2] .. "|x=138.0|y=138.0|scale=1|speed=1|effectid=" ..
            monEff .. "|effecttype=2>"
        str = str ..
            "<RText|id=" ..
            child[3] ..
            "|x=126|y=175|color=70|outline=2|outlinecolor=0|size=20|text=<" ..
            i .. "号仓/FCOLOR=251><[" .. isNull .. "]/FCOLOR=255>>"
        str = str ..
            "<Button|id=" ..
            child[4] ..
            "|x=80.0|y=197.0|size=18|nimg=custom/UI/lsqys/btn1.png|color=255|link=@click,临时契约术_callBB," .. i .. ">"
        str = str ..
            "<Button|id=" ..
            child[5] ..
            "|x=160.0|y=197.0|size=18|nimg=custom/UI/lsqys/btn2.png|color=255|link=@click,临时契约术_secureBB," .. i .. ">"
        for j = 1, 5 do
            child[j] = child[j] + 5
        end
    end
    say(player, str)
end

--召唤
function lsqysSkill.callBB(player, index)
    if not index then
        return
    end
    index = tonumber(index)
    local varTb = lsqysSkill.getVarTb(player)
    if not varTb.bbName[index] or not varTb.isLong[index] then
        release_print("参数error!")
        return
    end
    if varTb.bbName[index] == "" then
        Message:Msg9(player, "召唤失败！你没有跟妖兽达成契约")
        return
    end
    local num = 1
    if Magic.BBcountEX(player, SkillIDCfg["暗影能量"]) then
        num = 2
        if Magic.BBcountEX(player, SkillIDCfg["暗影能量"]) >= 3 then
            num = 3
        end
        if Magic.BBcountEX(player, SkillIDCfg["暗影能量"]) >= 6 then
            num = 4
        end
        if Magic.BBcountEX(player, SkillIDCfg["暗影能量"]) >= 9 then
            num = 5
        end
    end
    if lualib:GetInt(player, "召唤契约兽") >= num then
        Message:Msg9(player, "召唤失败！召唤兽数量已上限")
        return
    end
    local BBItem = recallmob(player, varTb.bbName[index], 7, 10, 1)
    if BBItem and BBItem ~= "" then
        if varTb.isLong[index] ~= 1 then
            varTb.bbName[index] = ""
        end
        --地狱鬼爪强化
        if lualib:GetVar(player, VarCfg["角色职业"]) == 4 then
            local ClawCount = Magic.ClawCount(player)
            if ClawCount >= 1 then
                local qhatt = 0.25
                if ClawCount >= 2 then qhatt = 0.45 end
                if ClawCount >= 3 then qhatt = 1 end
                --添加元素属性
                if addbuff(BBItem, 50004, 65535, 1, player, {
                        [21] = getbaseinfo(player, 51, 21) * qhatt,
                        [25] = getbaseinfo(player, 51, 25) * qhatt,
                        [28] = getbaseinfo(player, 51, 28) * qhatt,
                    }) then
                    Message:SendClawmsg(player, "地狱鬼爪：契约兽获得元素属性提升")
                end
            end
        end
        setcurrent(BBItem, 0, "契约兽")
        lualib:SetInt(player, "召唤契约兽", lualib:GetInt(player, "召唤契约兽") + 1)
        lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json(varTb.bbName))
        Message:Msg9(player, "召唤成功！")
    end

    lsqysSkill.main(player)
end

--解除
function lsqysSkill.secureBB(player, index)
    if not index then
        return
    end
    index = tonumber(index)
    local varTb = lsqysSkill.getVarTb(player)
    if not varTb.bbName[index] or not varTb.isLong[index] then
        release_print("参数error!")
        return
    end
    if varTb.bbName[index] == "" then
        Message:Msg9(player, "解除失败！你没有跟妖兽达成契约")
        return
    end
    varTb.bbName[index] = ""
    if varTb.isLong[index] == 1 then
        varTb.isLong = 0
    end
    lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json(varTb.bbName))
    lualib:SetVar(player, VarCfg["是否永久"], tbl2json(varTb.isLong))
    Message:Msg9(player, "解除契约成功！")
    lsqysSkill.main(player)
end

--杀怪触发
function lsqysSkill.onKillMon(player, monster, mobId, mapId)
    if Magic.BBcountEX(player, SkillIDCfg["临时契约术"]) or Magic.BBcountEX(player, SkillIDCfg["永久契约术"]) then
        local monName = lualib:Name(monster)
        lualib:SetStr(player, "刚刚击杀的怪物", monName)
    end
end

--杀死宝宝触发
function lsqysSkill.onSelfKillSlave(player, bbobj)
    if getcurrent(bbobj, 0) == "契约兽" then
        lualib:SetInt(player, "召唤契约兽", lualib:GetInt(player, "召唤契约兽") - 1)
    end
end

--登录触发
function lsqysSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["临时契约术"]) or Magic.BBcountEX(player, SkillIDCfg["永久契约术"]) then
        delbutton(player, 107, 555)
        addbutton(player, 107, 555,
            "<Button|x=-200.0|y=-60|color=255|size=18|nimg=custom/new1/hhh.png|link=@click,临时契约术_main>")
    end
end

--释放技能--临时契约术
function magselffunc1014(player)
    local monName = lualib:GetStr(player, "刚刚击杀的怪物")
    if not monName or monName == "" then
        Message:Msg9(player, "只能和刚被击杀的怪物达成契约！")
        return
    end
    if GeneralGlobalConfig.prohibitMonCfg[monName] then --不可契约怪物
        Message:Msg9(player, "此妖兽拒绝跟你达成契约！")
        lualib:SetStr(player, "刚刚击杀的怪物", "")
        return
    end
    local varTb = lsqysSkill.getVarTb(player)
    local num, isQY, index = 0, false, 0
    for i = 1, 5 do
        if varTb.bbName[i] ~= "" then
            num = num + 1
            if varTb.bbName[i] == monName then
                isQY = true
            end
        else
            if index == 0 then
                index = i
            end
        end
    end
    if isQY then --已经契约过该怪物
        Message:Msg9(player, "你已经契约过该怪物！")
        lualib:SetStr(player, "刚刚击杀的怪物", "")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["契约精神"])
    local canNum = 1
    if level then
        canNum = 2
        if level >= 3 then
            canNum = 3
            if level >= 6 then
                canNum = 4
                if level >= 9 then
                    canNum = 5
                end
            end
        end
    end
    if num >= canNum then --契约的怪物种类上限
        Message:Msg9(player, "可契约的怪物种类已上限！")
        return
    end
    if index == 0 then
        Message:Msg9(player, "当前契约仓库已满！")
        return
    end
    if not monLevelCfg[monName] then
        Message:Msg9(player, "该妖兽特殊，不受契约术控制")
        return
    end
    if math.random(2) > 1 then --50%成功率
        if getbaseinfo(player, 6) - monLevelCfg[monName] > 0 then
            varTb.bbName[index] = monName
            Message:Msg9(player, "临时契约妖兽成功！请前往[兽栏]查看")
            lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json(varTb.bbName))
            lualib:SetStr(player, "刚刚击杀的怪物", "")
            return
        else
            Message:Msg9(player, "该妖兽过于强大！契约失败")
            lualib:SetStr(player, "刚刚击杀的怪物", "")
            return
        end
    else
        Message:Msg9(player, "运气不佳，契约失败！")
        lualib:SetStr(player, "刚刚击杀的怪物", "")
        return
    end
end

--释放技能--永久契约术
function magselffunc506(player)
    local monName = lualib:GetStr(player, "刚刚击杀的怪物")
    if not monName or monName == "" then
        Message:Msg9(player, "只能和刚被击杀的怪物达成契约！")
        return
    end
    if GeneralGlobalConfig.prohibitMonCfg[monName] then --不可契约怪物
        Message:Msg9(player, "此妖兽拒绝跟你达成契约！")
        lualib:SetStr(player, "刚刚击杀的怪物", "")
        return
    end
    local varTb = lsqysSkill.getVarTb(player)
    local num, isQY, index = 0, false, 0
    for i = 1, 5 do
        if varTb.bbName[i] ~= "" then
            num = num + 1
            if varTb.bbName[i] == monName then
                isQY = true
            end
        else
            if index == 0 then
                index = i
            end
        end
    end
    if isQY then --已经契约过该怪物
        Message:Msg9(player, "你已经契约过该怪物！")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["契约精神"])
    local canNum = 1
    if level then
        canNum = 2
        if level >= 3 then
            canNum = 3
            if level >= 6 then
                canNum = 4
                if level >= 9 then
                    canNum = 5
                end
            end
        end
    end
    if num >= canNum then --契约的怪物种类上限
        Message:Msg9(player, "可契约的怪物种类已上限！")
        return
    end
    if index == 0 then
        Message:Msg9(player, "当前契约仓库已满！")
        return
    end
    local yjqyslevel = Magic.BBcountEX(player, SkillIDCfg["永久契约术"])
    if not monLevelCfg[monName] then
        Message:Msg9(player, "该妖兽特殊，不受契约术控制")
        return
    end
    if getbaseinfo(player, 6) + yjqyslevel - monLevelCfg[monName] > 0 then
        if math.random(100) <= (10 + 2 * yjqyslevel) then
            varTb.bbName[index] = monName
            varTb.isLong[index] = 1
            Message:Msg9(player, "永久契约妖兽成功！请前往[兽栏]查看")
            lualib:SetVar(player, VarCfg["临时契约术怪物"], tbl2json(varTb.bbName))
            lualib:SetVar(player, VarCfg["是否永久"], tbl2json(varTb.isLong))
            lualib:SetStr(player, "刚刚击杀的怪物", "")
            return
        else
            Message:Msg9(player, "运气不佳，契约失败！")
            lualib:SetStr(player, "刚刚击杀的怪物", "")
            return
        end
    else
        Message:Msg9(player, "该妖兽过于强大！契约失败")
        lualib:SetStr(player, "刚刚击杀的怪物", "")
        return
    end
end

--游戏事件
GameEvent.add(EventCfg.onAddSkill, lsqysSkill.addBtn, lsqysSkill)
GameEvent.add(EventCfg.onDelSkill, lsqysSkill.delBtn, lsqysSkill)
GameEvent.add(EventCfg.onLogin, lsqysSkill.onLogin, lsqysSkill)
GameEvent.add(EventCfg.onKillMon, lsqysSkill.onKillMon, lsqysSkill)
GameEvent.add(EventCfg.onSelfKillSlave, lsqysSkill.onSelfKillSlave, lsqysSkill)

Message.RegisterClickMsg("临时契约术", lsqysSkill)
return lsqysSkill
