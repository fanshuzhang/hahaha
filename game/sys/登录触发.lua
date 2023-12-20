--- 登录触发
function login(player)
    GameEvent.push(EventCfg.onLogin, player)
    local level = lualib:Level(player)
    lualib:SetHpEx(player, "=", 100)
    lualib:SetMpEx(player, "=", 100)
    -- 登录设置
    local isNewMan = lualib:GetBaseInfo(player, 47)
    local userAccount = parsetext("<$USERACCOUNT>", player)
    local hfCount = lualib:GlobalInfo(3)
    if isNewMan and GeneralGlobalConfig.adminList[userAccount] == nil and hfCount > 0 then
        lualib:SetVar(player, "T251", "封禁账号")
        Message:Box(player, "合区后无法建立角色。")
        lualib:Kick(player)
        return
    end
    if isNewMan then
        GameEvent.push(EventCfg.onNewHuman, player)
    end
    -- 假人
    if lualib:IsDummy(player) then
        GameEvent.push(EventCfg.onNewHuman, player)
    end
    --去除发型
    lualib:SetBaseInfo(player, 33, 0)

    -- 仓库和背包格子
    lualib:SetBagCount(player, 126)
    lualib:SetStorage(player, 240)
    --4*4拾取
    if lualib:GetVar(player, VarCfg["顶级赞助"]) > 0 then
        pickupitems(player, 0, 4, 500)
    end
    -- 称号爆率修正
    GameEvent.push(EventCfg.goSetAndViewStatus, player)


    if lualib:GetVar(nil, VarCfg["开服标记"]) == "" then
        lualib:SetVar(nil, VarCfg["开服标记"], "已经开区")
        --lualib:CallTxtScript(player, "DummyloGon 3 140 92 10 0 50 30 2")
        lualib:SetVar(nil, "G10", lualib:Now())
    end
    lualib:SetInt(player, "自动回收标识", 1)
    Message:Msg9(player, "开启自动回收成功！")
    -- 是否禁言
    if level < 10 then
        lualib:CallTxtScript(player, "GMEXECUTE 禁言 self 10000")
        Message:Msg5(player, "[提示]：你的等级低于600级，所以被禁言了，快去升级吧。")
    else
        lualib:CallTxtScript(player, "GMEXECUTE 恢复禁言 self")
    end
    -- 管理员处理/开启GM
    local userAccount = parsetext("<$USERACCOUNT>", player)
    if GeneralGlobalConfig.adminList[userAccount] ~= nil then
        lualib:SetVar(player, "T251", "")
        lualib:ChangeMode(player, 1, 1)
        lualib:ChangeMode(player, 2, 1)
        lualib:ChangeMode(player, 3, 1)
        lualib:SetInt(player, "当前模式", 1)
        Message:Msg9(player, parsetext("当前游戏在线人数<$USERCOUNT>", player))
        GeneralGlobalConfig.openGMBoxPre(player)
    end
    -- 合服后的新人处理
    if lualib:GetVar(player, "T251") ~= "" then
        Message:Box(player, "账号封禁！请联系官方客服！")
        lualib:Kick(player)
    end
    -- 假人处理
    if lualib:IsDummy(player) then
        if lualib:Gender(player) == 1 then
            lualib:Kick(player)
        end
        lualib:SetLevel(player, math.random(10, 20))
        lualib:SetGender(player, 0)
        lualib:SetHair(player, 0)
        lualib:MapMoveXY(player, "3", 330, 330, 10)
    end
    --callscript(player, "OtherQMSetting", "@登陆设置")

    if lualib:CastleInfo(5) then
        lualib:MapMoveXY(player, "3", 330, 330, 10)
    end

    GameEvent.push(EventCfg.goRefreshRelive, player)

    -- 开启首饰盒
    lualib:SetAmuletBox(player, 0)

    -- 定时器
    lualib:SetOnTimer(player, 1, 1)
    lualib:SetOnTimer(player, 2, 60)
    lualib:SetOnTimer(player, 4, 5)
    lualib:SetOnTimer(player, 6, 2)
    --鬼武者定时器
    if Magic.ClawCount(player) >= 1 and lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
        lualib:SetOnTimer(player, 104, 10)
    end
    --圣骑士定时器
    if Magic.ClawCount(player) >= 1 and lualib:GetVar(player, VarCfg["角色职业"]) == 3 then
        lualib:SetOnTimer(player, 105, 2)
    end
    --自动回收
    if lualib:GetVar(player, VarCfg["自动回收"]) == 1 then
        lualib:SetOnTimer(player, 3, 20)
    end
    if lualib:GetVar(player, VarCfg["自动吃货币"]) == 1 then
        lualib:SetOnTimer(player, 5, 20)
    end

    -- 固顶消息
    Message:TopFixChat(player, 1, 252, 0, 65535, "《{本服承诺无任何比例.优惠.返利.}》等一系列活动，切勿上当受骗！")

    -- 开区记录
    local A300 = lualib:GetVar(nil, VarCfg["开服标记"])
    if A300 == "" then
        lualib:SetVar(nil, VarCfg["开服标记"], "已经开区")
    end

    -- 限制登录
    lualib:DelayGoto(player, 333, "click,封测脚本_main", false)
    lualib:DelayGoto(player, 500, "click,封测脚本_main", false)
    lualib:DelayGoto(player, 1000, "click,封测脚本_main", false)

    if lualib:GetVar(player, VarCfg["每日登录标记"]) == 0 then
        lualib:SetVar(player, VarCfg["总登录天数"], lualib:GetVar(player, VarCfg["总登录天数"]) + 1)
        lualib:SetVar(player, VarCfg["每日登录标记"], 1)
    end
    lualib:SetFlagStatus(player, PlayerVarCfg["打开自定义生肖"], 0)
    lualib:SetFlagStatus(player, PlayerVarCfg["爆炸蛊虫开关"], 0)
    lualib:SetFlagStatus(player, PlayerVarCfg["是否测试用户"], 0)

    refreshbag(player)

    --更新沙捐排名
    NpcDonate.ranking(player)
    --重置变量值
end
