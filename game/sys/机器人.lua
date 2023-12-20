local castleInfo = {
    ["0"] = 1,
    ["3"] = 1,
    ["n0150"] = 1,
    ["yzd"] = 1,
    ["137"] = 1,
    ["138"] = 1,
}
local SystemRobotData = {

}
function castle_trigger(player)
    if lualib:CastleInfo(5) then
        local mapId = lualib:GetMapId(player)
        if castleInfo[mapId] then
            return
        end
        lualib:MapMoveXY(player, "3", 330, 330, 10)
        Message:Msg9(player, "[ϵͳ:]�����Ѿ����������������ֵܿ�ս�ɣ�")
    end
end

-- ˢ�����Ͻ�
function SystemRobotData.openGift(player)
    local allPlayerList = lualib:GetGSPlayer()
    for i, v in pairs(allPlayerList) do
        if not lualib:IsDummy(v) then
            GameEvent.push(EventCfg.goRefreshTopIcon, v)
        end
    end
end

-- ÿ������
function SystemRobotData.daySet(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    lualib:SetVar(nil, VarCfg["��������"], lualib:GetVar(nil, VarCfg["��������"]) + 1)
    --lualib:CallTxtScript(player, "GMEXECUTE ��ʼ���� @��������")

    clearhumcustvar('*', "����������")
    --0������ɳ�Ǿ���
    clearhumcustvar('*', "���׽��")
    local playList = lualib:GetGSPlayer()
    for _, value in ipairs(playList) do
        local index = 6
        for index = 6, 1, -1 do
            if lualib:HasTitle(value, NpcDonate.title[index]) then
                lualib:DelTitle(value, NpcDonate.title[index]) --ɾ���ƺ�
                index = 1
            end
        end
    end
end

-- ��ɳ����
function SystemRobotData.castleSetting(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["��������"])
    if G100 > 0 then
        addattacksabakall()
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "ɳ�Ϳ˹���ս,��������8�㿪ʼ(���������һ�̣�ɱ��ɱ��ɱ��)����")
        end
    end
end

-- ��ɳ����
function SystemRobotData.castleTalking(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["��������"])
    if G100 > 0 then
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "ɳ�Ϳ˹���ս,��������9�㿪ʼ(���������һ�̣�ɱ��ɱ��ɱ��)����")
        end
    end
end

-- ���ɳ����
function SystemRobotData.clearCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    lualib:SetVar(nil, VarCfg["�ܾ��׽��"], 0) --������׽��
end

-- ����ɳ����
function SystemRobotData.openCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["��������"])
    if G100 > 0 then
        lualib:SetVar(nil, VarCfg["ɳ�������ű��"], 1)
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "ɳ�Ϳ˹���ս������������ߵ�С��ȫ����ȡ�����������Խ���������")
        end
    end
end

-- �ر�ɳ����
function SystemRobotData.closeCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    lualib:SetVar(nil, VarCfg["ɳ�������ű��"], 0)
    lualib:SetVar(nil, VarCfg["�ܾ��׽��"], 0) --������׽��
end

-- �����ɳ�ǵ�ͼ��ĵ�ͼ
function SystemRobotData.clearMapExcludeCastle(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount() --�Ϸ�����
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["��������"])
    if G100 > 0 then
        lualib:CallTxtScript(player, "GMEXECUTE ��ʼ���� @castle_trigger")
    end
end

---ÿ����ִ��
function SystemRobotData.executeEveryMinute()

end

-- ÿ��ִ��
function SystemRobotData.executeEverySeconds(player)
    local A300 = lualib:GetVar(nil, VarCfg["�������"])
    if A300 ~= "�Ѿ�����" then
        return
    end
    local nowTime = lualib:GetAllTime() --������ϵͳʱ���
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount > 0 then
        local hqOpenStamp = lualib:GetDBVar("����ʱ���")
    end
end

-- ȷ���������ͺ���ʱ�䣬�Ե�һλ��¼���Ϊ׼
function SystemRobotData.onLogin(player)
    local openStamp = lualib:GetVar(nil, VarCfg["����ʱ���"])
    if openStamp <= 0 then
        lualib:SetVar(nil, VarCfg["����ʱ���"], lualib:GetAllTime())
    end
    local hqOpenStamp = lualib:GetDBVar("����ʱ���")
    if hqOpenStamp <= 0 and GeneralGlobalConfig.getHQCount() > 0 then
        lualib:SetDBVar("����ʱ���", lualib:GetAllTime(), 1)
    end
end

--- ��ʼ������
function SystemRobotData.initVar()
    lualib:InitDBVar("integer", "����ʱ���", 6) --����ʱɾ��
end

SystemRobotData.initVar()

GameEvent.add(EventCfg.onLogin, SystemRobotData.onLogin, SystemRobotData)
Message.RegisterClickMsg("������", SystemRobotData)
return SystemRobotData
