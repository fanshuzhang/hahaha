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
        Message:Msg9(player, "[系统:]攻城已经开启！快叫上你的兄弟开战吧！")
    end
end

-- 刷新右上角
function SystemRobotData.openGift(player)
    local allPlayerList = lualib:GetGSPlayer()
    for i, v in pairs(allPlayerList) do
        if not lualib:IsDummy(v) then
            GameEvent.push(EventCfg.goRefreshTopIcon, v)
        end
    end
end

-- 每日重置
function SystemRobotData.daySet(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    lualib:SetVar(nil, VarCfg["开区天数"], lualib:GetVar(nil, VarCfg["开区天数"]) + 1)
    --lualib:CallTxtScript(player, "GMEXECUTE 开始提问 @重置数据")

    clearhumcustvar('*', "封神塔层数")
    --0点清理沙城捐献
    clearhumcustvar('*', "捐献金额")
    local playList = lualib:GetGSPlayer()
    for _, value in ipairs(playList) do
        local index = 6
        for index = 6, 1, -1 do
            if lualib:HasTitle(value, NpcDonate.title[index]) then
                lualib:DelTitle(value, NpcDonate.title[index]) --删除称号
                index = 1
            end
        end
    end
end

-- 攻沙设置
function SystemRobotData.castleSetting(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["开区天数"])
    if G100 > 0 then
        addattacksabakall()
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "沙巴克攻城战,将在晚上8点开始(荣辱就在这一刻！杀！杀！杀！)！！")
        end
    end
end

-- 攻沙喊话
function SystemRobotData.castleTalking(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["开区天数"])
    if G100 > 0 then
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "沙巴克攻城战,将在晚上9点开始(荣辱就在这一刻！杀！杀！杀！)！！")
        end
    end
end

-- 清除沙奖励
function SystemRobotData.clearCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    lualib:SetVar(nil, VarCfg["总捐献金额"], 0) --清除捐献金额
end

-- 发放沙奖励
function SystemRobotData.openCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["开区天数"])
    if G100 > 0 then
        lualib:SetVar(nil, VarCfg["沙奖励开放标记"], 1)
        for i = 1, 3 do
            Message:MoveMsg(player, 1, 253, 255, 350 - (i - 1) * 30, 1, "沙巴克攻城战结束，请参与者到小安全区领取奖励，激情仍将继续！！")
        end
    end
end

-- 关闭沙奖励
function SystemRobotData.closeCastleReward(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount <= 0 then
        return
    end
    lualib:SetVar(nil, VarCfg["沙奖励开放标记"], 0)
    lualib:SetVar(nil, VarCfg["总捐献金额"], 0) --清除捐献金额
end

-- 清理除沙城地图外的地图
function SystemRobotData.clearMapExcludeCastle(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local hfCount = GeneralGlobalConfig.getHQCount() --合服次数
    if hfCount <= 0 then
        return
    end
    local G100 = lualib:GetVar(nil, VarCfg["开区天数"])
    if G100 > 0 then
        lualib:CallTxtScript(player, "GMEXECUTE 开始提问 @castle_trigger")
    end
end

---每分钟执行
function SystemRobotData.executeEveryMinute()

end

-- 每秒执行
function SystemRobotData.executeEverySeconds(player)
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 ~= "已经开区" then
        return
    end
    local nowTime = lualib:GetAllTime() --服务器系统时间戳
    local hfCount = GeneralGlobalConfig.getHQCount()
    if hfCount > 0 then
        local hqOpenStamp = lualib:GetDBVar("合区时间戳")
    end
end

-- 确定出开区和合区时间，以第一位登录玩家为准
function SystemRobotData.onLogin(player)
    local openStamp = lualib:GetVar(nil, VarCfg["开区时间戳"])
    if openStamp <= 0 then
        lualib:SetVar(nil, VarCfg["开区时间戳"], lualib:GetAllTime())
    end
    local hqOpenStamp = lualib:GetDBVar("合区时间戳")
    if hqOpenStamp <= 0 and GeneralGlobalConfig.getHQCount() > 0 then
        lualib:SetDBVar("合区时间戳", lualib:GetAllTime(), 1)
    end
end

--- 初始化变量
function SystemRobotData.initVar()
    lualib:InitDBVar("integer", "合区时间戳", 6) --合区时删除
end

SystemRobotData.initVar()

GameEvent.add(EventCfg.onLogin, SystemRobotData.onLogin, SystemRobotData)
Message.RegisterClickMsg("机器人", SystemRobotData)
return SystemRobotData
