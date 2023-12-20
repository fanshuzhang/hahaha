---@class lsqysSkill ��ʱ��Լ��
local lsqysSkill = {}

local monLevelCfg = zsf_RequireAppCfg("����ȼ�")
--�����Լ����ֿ�
function lsqysSkill.addBtn(player, skill, lv)
    if skill == SkillIDCfg["��ʱ��Լ��"] or skill == SkillIDCfg["������Լ��"] then
        delbutton(player, 107, 555)
        addbutton(player, 107, 555,
            "<Button|x=-200.0|y=-60|color=255|size=18|nimg=custom/new1/hhh.png|link=@click,��ʱ��Լ��_main>")
    end
end

--ɾ����Լ����ֿ�
function lsqysSkill.delBtn(player, skill)
    if Magic.BBcountEX(player, SkillIDCfg["��ʱ��Լ��"]) or Magic.BBcountEX(player, SkillIDCfg["������Լ��"]) then
        return
    end
    delbutton(player, 107, 555)
    lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json({ "", "", "", "", "" }))
    lualib:SetVar(player, VarCfg["�Ƿ�����"], tbl2json({ 0, 0, 0, 0, 0 }))
end

--��ʱ��Լ��
function lsqysSkill.getVarTb(player)
    local varTb = {}
    local jsonStr1 = lualib:GetVar(player, VarCfg['��ʱ��Լ������'])
    local jsonStr2 = lualib:GetVar(player, VarCfg['�Ƿ�����'])
    local jsonTb = {}
    if jsonStr1 and jsonStr1 == '' then
        lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json({ "", "", "", "", "" }))
        jsonTb = { "", "", "", "", "" }
    else
        jsonTb = json2tbl(jsonStr1)
    end
    varTb.bbName = jsonTb
    if jsonStr2 and jsonStr2 == '' then
        lualib:SetVar(player, VarCfg["�Ƿ�����"], tbl2json({ 0, 0, 0, 0, 0 }))
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
        <RText|x=177.0|y=14.0|color=255|size=18|outline=2|outlinecolor=0|text=<��Լ��/FCOLOR=251>>
        <RText|x=30.0|y=40.0|color=255|size=14|outline=2|outlinecolor=0|text=<[��Ӱ����]:/FCOLOR=250><ǿ���ü��ܿ������ٻ���Լ��������/FCOLOR=70>>
        <RText|x=30.0|y=62.0|color=255|size=14|outline=2|outlinecolor=0|text=<[��Լ����]:/FCOLOR=250><ǿ���ü��ܿ�������Լ�����࣡/FCOLOR=70>>
        <RText|x=30.0|y=85.0|color=255|size=12|outline=2|outlinecolor=0|text=<[ע]:/FCOLOR=250><�������޹���ǿ�󣬽��޷���Լ��/FCOLOR=249>>
        <ListView|x=26.0|y=41.0|children={1,2,3,4,5}|width=350|height=240|direction=2|margin=0|bounce=0>
    ]]
    local isNull = "��"
    local str = '' .. basicRes
    local child = { 10, 11, 12, 13, 14 }
    for i = 1, 5 do
        local monEff = 10
        isNull = "��"
        if varTb.bbName[i] ~= '' then
            isNull = "��ʱ"
            monEff = tonumber(getdbmonfieldvalue(varTb.bbName[i], "appr"))
            if varTb.isLong[i] == 1 then
                isNull = "����"
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
            i .. "�Ų�/FCOLOR=251><[" .. isNull .. "]/FCOLOR=255>>"
        str = str ..
            "<Button|id=" ..
            child[4] ..
            "|x=80.0|y=197.0|size=18|nimg=custom/UI/lsqys/btn1.png|color=255|link=@click,��ʱ��Լ��_callBB," .. i .. ">"
        str = str ..
            "<Button|id=" ..
            child[5] ..
            "|x=160.0|y=197.0|size=18|nimg=custom/UI/lsqys/btn2.png|color=255|link=@click,��ʱ��Լ��_secureBB," .. i .. ">"
        for j = 1, 5 do
            child[j] = child[j] + 5
        end
    end
    say(player, str)
end

--�ٻ�
function lsqysSkill.callBB(player, index)
    if not index then
        return
    end
    index = tonumber(index)
    local varTb = lsqysSkill.getVarTb(player)
    if not varTb.bbName[index] or not varTb.isLong[index] then
        release_print("����error!")
        return
    end
    if varTb.bbName[index] == "" then
        Message:Msg9(player, "�ٻ�ʧ�ܣ���û�и����޴����Լ")
        return
    end
    local num = 1
    if Magic.BBcountEX(player, SkillIDCfg["��Ӱ����"]) then
        num = 2
        if Magic.BBcountEX(player, SkillIDCfg["��Ӱ����"]) >= 3 then
            num = 3
        end
        if Magic.BBcountEX(player, SkillIDCfg["��Ӱ����"]) >= 6 then
            num = 4
        end
        if Magic.BBcountEX(player, SkillIDCfg["��Ӱ����"]) >= 9 then
            num = 5
        end
    end
    if lualib:GetInt(player, "�ٻ���Լ��") >= num then
        Message:Msg9(player, "�ٻ�ʧ�ܣ��ٻ�������������")
        return
    end
    local BBItem = recallmob(player, varTb.bbName[index], 7, 10, 1)
    if BBItem and BBItem ~= "" then
        if varTb.isLong[index] ~= 1 then
            varTb.bbName[index] = ""
        end
        --������צǿ��
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 4 then
            local ClawCount = Magic.ClawCount(player)
            if ClawCount >= 1 then
                local qhatt = 0.25
                if ClawCount >= 2 then qhatt = 0.45 end
                if ClawCount >= 3 then qhatt = 1 end
                --���Ԫ������
                if addbuff(BBItem, 50004, 65535, 1, player, {
                        [21] = getbaseinfo(player, 51, 21) * qhatt,
                        [25] = getbaseinfo(player, 51, 25) * qhatt,
                        [28] = getbaseinfo(player, 51, 28) * qhatt,
                    }) then
                    Message:SendClawmsg(player, "������צ����Լ�޻��Ԫ����������")
                end
            end
        end
        setcurrent(BBItem, 0, "��Լ��")
        lualib:SetInt(player, "�ٻ���Լ��", lualib:GetInt(player, "�ٻ���Լ��") + 1)
        lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json(varTb.bbName))
        Message:Msg9(player, "�ٻ��ɹ���")
    end

    lsqysSkill.main(player)
end

--���
function lsqysSkill.secureBB(player, index)
    if not index then
        return
    end
    index = tonumber(index)
    local varTb = lsqysSkill.getVarTb(player)
    if not varTb.bbName[index] or not varTb.isLong[index] then
        release_print("����error!")
        return
    end
    if varTb.bbName[index] == "" then
        Message:Msg9(player, "���ʧ�ܣ���û�и����޴����Լ")
        return
    end
    varTb.bbName[index] = ""
    if varTb.isLong[index] == 1 then
        varTb.isLong = 0
    end
    lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json(varTb.bbName))
    lualib:SetVar(player, VarCfg["�Ƿ�����"], tbl2json(varTb.isLong))
    Message:Msg9(player, "�����Լ�ɹ���")
    lsqysSkill.main(player)
end

--ɱ�ִ���
function lsqysSkill.onKillMon(player, monster, mobId, mapId)
    if Magic.BBcountEX(player, SkillIDCfg["��ʱ��Լ��"]) or Magic.BBcountEX(player, SkillIDCfg["������Լ��"]) then
        local monName = lualib:Name(monster)
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", monName)
    end
end

--ɱ����������
function lsqysSkill.onSelfKillSlave(player, bbobj)
    if getcurrent(bbobj, 0) == "��Լ��" then
        lualib:SetInt(player, "�ٻ���Լ��", lualib:GetInt(player, "�ٻ���Լ��") - 1)
    end
end

--��¼����
function lsqysSkill.onLogin(player)
    if Magic.BBcountEX(player, SkillIDCfg["��ʱ��Լ��"]) or Magic.BBcountEX(player, SkillIDCfg["������Լ��"]) then
        delbutton(player, 107, 555)
        addbutton(player, 107, 555,
            "<Button|x=-200.0|y=-60|color=255|size=18|nimg=custom/new1/hhh.png|link=@click,��ʱ��Լ��_main>")
    end
end

--�ͷż���--��ʱ��Լ��
function magselffunc1014(player)
    local monName = lualib:GetStr(player, "�ոջ�ɱ�Ĺ���")
    if not monName or monName == "" then
        Message:Msg9(player, "ֻ�ܺ͸ձ���ɱ�Ĺ�������Լ��")
        return
    end
    if GeneralGlobalConfig.prohibitMonCfg[monName] then --������Լ����
        Message:Msg9(player, "�����޾ܾ���������Լ��")
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
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
    if isQY then --�Ѿ���Լ���ù���
        Message:Msg9(player, "���Ѿ���Լ���ù��")
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["��Լ����"])
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
    if num >= canNum then --��Լ�Ĺ�����������
        Message:Msg9(player, "����Լ�Ĺ������������ޣ�")
        return
    end
    if index == 0 then
        Message:Msg9(player, "��ǰ��Լ�ֿ�������")
        return
    end
    if not monLevelCfg[monName] then
        Message:Msg9(player, "���������⣬������Լ������")
        return
    end
    if math.random(2) > 1 then --50%�ɹ���
        if getbaseinfo(player, 6) - monLevelCfg[monName] > 0 then
            varTb.bbName[index] = monName
            Message:Msg9(player, "��ʱ��Լ���޳ɹ�����ǰ��[����]�鿴")
            lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json(varTb.bbName))
            lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
            return
        else
            Message:Msg9(player, "�����޹���ǿ����Լʧ��")
            lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
            return
        end
    else
        Message:Msg9(player, "�������ѣ���Լʧ�ܣ�")
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
        return
    end
end

--�ͷż���--������Լ��
function magselffunc506(player)
    local monName = lualib:GetStr(player, "�ոջ�ɱ�Ĺ���")
    if not monName or monName == "" then
        Message:Msg9(player, "ֻ�ܺ͸ձ���ɱ�Ĺ�������Լ��")
        return
    end
    if GeneralGlobalConfig.prohibitMonCfg[monName] then --������Լ����
        Message:Msg9(player, "�����޾ܾ���������Լ��")
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
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
    if isQY then --�Ѿ���Լ���ù���
        Message:Msg9(player, "���Ѿ���Լ���ù��")
        return
    end
    local level = Magic.BBcountEX(player, SkillIDCfg["��Լ����"])
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
    if num >= canNum then --��Լ�Ĺ�����������
        Message:Msg9(player, "����Լ�Ĺ������������ޣ�")
        return
    end
    if index == 0 then
        Message:Msg9(player, "��ǰ��Լ�ֿ�������")
        return
    end
    local yjqyslevel = Magic.BBcountEX(player, SkillIDCfg["������Լ��"])
    if not monLevelCfg[monName] then
        Message:Msg9(player, "���������⣬������Լ������")
        return
    end
    if getbaseinfo(player, 6) + yjqyslevel - monLevelCfg[monName] > 0 then
        if math.random(100) <= (10 + 2 * yjqyslevel) then
            varTb.bbName[index] = monName
            varTb.isLong[index] = 1
            Message:Msg9(player, "������Լ���޳ɹ�����ǰ��[����]�鿴")
            lualib:SetVar(player, VarCfg["��ʱ��Լ������"], tbl2json(varTb.bbName))
            lualib:SetVar(player, VarCfg["�Ƿ�����"], tbl2json(varTb.isLong))
            lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
            return
        else
            Message:Msg9(player, "�������ѣ���Լʧ�ܣ�")
            lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
            return
        end
    else
        Message:Msg9(player, "�����޹���ǿ����Լʧ��")
        lualib:SetStr(player, "�ոջ�ɱ�Ĺ���", "")
        return
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onAddSkill, lsqysSkill.addBtn, lsqysSkill)
GameEvent.add(EventCfg.onDelSkill, lsqysSkill.delBtn, lsqysSkill)
GameEvent.add(EventCfg.onLogin, lsqysSkill.onLogin, lsqysSkill)
GameEvent.add(EventCfg.onKillMon, lsqysSkill.onKillMon, lsqysSkill)
GameEvent.add(EventCfg.onSelfKillSlave, lsqysSkill.onSelfKillSlave, lsqysSkill)

Message.RegisterClickMsg("��ʱ��Լ��", lsqysSkill)
return lsqysSkill
