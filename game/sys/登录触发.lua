--- ��¼����
function login(player)
    GameEvent.push(EventCfg.onLogin, player)
    local level = lualib:Level(player)
    lualib:SetHpEx(player, "=", 100)
    lualib:SetMpEx(player, "=", 100)
    -- ��¼����
    local isNewMan = lualib:GetBaseInfo(player, 47)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    local hfCount = lualib:GlobalInfo(3)
    if isNewMan and GeneralGlobalConfig.adminList[userAccount] == nil and hfCount > 0 then
        lualib:SetVar(player, "T251", "����˺�")
        Message:Box(player, "�������޷�������ɫ��")
        lualib:Kick(player)
        return
    end
    if isNewMan then
        GameEvent.push(EventCfg.onNewHuman, player)
    end
    -- ����
    if lualib:IsDummy(player) then
        GameEvent.push(EventCfg.onNewHuman, player)
    end
    --ȥ������
    lualib:SetBaseInfo(player, 33, 0)

    -- �ֿ�ͱ�������
    lualib:SetBagCount(player, 126)
    lualib:SetStorage(player, 240)
    --4*4ʰȡ
    if lualib:GetVar(player, VarCfg["��������"]) > 0 then
        pickupitems(player, 0, 4, 500)
    end
    -- �ƺű�������
    GameEvent.push(EventCfg.goSetAndViewStatus, player)


    if lualib:GetVar(nil, VarCfg["�������"]) == "" then
        lualib:SetVar(nil, VarCfg["�������"], "�Ѿ�����")
        --lualib:CallTxtScript(player, "DummyloGon 3 140 92 10 0 50 30 2")
        lualib:SetVar(nil, "G10", lualib:Now())
    end
    lualib:SetInt(player, "�Զ����ձ�ʶ", 1)
    Message:Msg9(player, "�����Զ����ճɹ���")
    -- �Ƿ����
    if level < 10 then
        lualib:CallTxtScript(player, "GMEXECUTE ���� self 10000")
        Message:Msg5(player, "[��ʾ]����ĵȼ�����600�������Ա������ˣ���ȥ�����ɡ�")
    else
        lualib:CallTxtScript(player, "GMEXECUTE �ָ����� self")
    end
    -- ����Ա����/����GM
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if GeneralGlobalConfig.adminList[userAccount] ~= nil then
        lualib:SetVar(player, "T251", "")
        lualib:ChangeMode(player, 1, 1)
        lualib:ChangeMode(player, 2, 1)
        lualib:ChangeMode(player, 3, 1)
        lualib:SetInt(player, "��ǰģʽ", 1)
        Message:Msg9(player, parsetext("��ǰ��Ϸ��������<$USERCOUNT>", player))
        GeneralGlobalConfig.openGMBoxPre(player)
    end
    -- �Ϸ�������˴���
    if lualib:GetVar(player, "T251") ~= "" then
        Message:Box(player, "�˺ŷ��������ϵ�ٷ��ͷ���")
        lualib:Kick(player)
    end
    -- ���˴���
    if lualib:IsDummy(player) then
        if lualib:Gender(player) == 1 then
            lualib:Kick(player)
        end
        lualib:SetLevel(player, math.random(10, 20))
        lualib:SetGender(player, 0)
        lualib:SetHair(player, 0)
        lualib:MapMoveXY(player, "3", 330, 330, 10)
    end
    --callscript(player, "OtherQMSetting", "@��½����")

    if lualib:CastleInfo(5) then
        lualib:MapMoveXY(player, "3", 330, 330, 10)
    end

    GameEvent.push(EventCfg.goRefreshRelive, player)

    -- �������κ�
    lualib:SetAmuletBox(player, 0)

    -- ��ʱ��
    lualib:SetOnTimer(player, 1, 1)
    lualib:SetOnTimer(player, 2, 60)
    lualib:SetOnTimer(player, 4, 5)
    lualib:SetOnTimer(player, 6, 2)
    --�����߶�ʱ��
    if Magic.ClawCount(player) >= 1 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
        lualib:SetOnTimer(player, 104, 10)
    end
    --ʥ��ʿ��ʱ��
    if Magic.ClawCount(player) >= 1 and lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 3 then
        lualib:SetOnTimer(player, 105, 2)
    end
    --�Զ�����
    if lualib:GetVar(player, VarCfg["�Զ�����"]) == 1 then
        lualib:SetOnTimer(player, 3, 20)
    end
    if lualib:GetVar(player, VarCfg["�Զ��Ի���"]) == 1 then
        lualib:SetOnTimer(player, 5, 20)
    end

    -- �̶���Ϣ
    Message:TopFixChat(player, 1, 252, 0, 65535, "��{������ŵ���κα���.�Ż�.����.}����һϵ�л�������ϵ���ƭ��")

    -- ������¼
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 == "" then
        lualib:SetVar(nil, VarCfg["�������"], "�Ѿ�����")
    end

    -- ���Ƶ�¼
    lualib:DelayGoto(player, 333, "click,���ű�_main", false)
    lualib:DelayGoto(player, 500, "click,���ű�_main", false)
    lualib:DelayGoto(player, 1000, "click,���ű�_main", false)

    if lualib:GetVar(player, VarCfg["ÿ�յ�¼���"]) == 0 then
        lualib:SetVar(player, VarCfg["�ܵ�¼����"], lualib:GetVar(player, VarCfg["�ܵ�¼����"]) + 1)
        lualib:SetVar(player, VarCfg["ÿ�յ�¼���"], 1)
    end
    lualib:SetFlagStatus(player, PlayerVarCfg["���Զ�����Ф"], 0)
    lualib:SetFlagStatus(player, PlayerVarCfg["��ը�Ƴ濪��"], 0)
    lualib:SetFlagStatus(player, PlayerVarCfg["�Ƿ�����û�"], 0)

    refreshbag(player)

    --����ɳ������
    NpcDonate.ranking(player)
    --���ñ���ֵ
end
