Global = {}

function beforedawn()
    local t = getplayerlst()
    for _,actor in ipairs(t) do
        Global.dailyupdate(actor)
    end
    local openday = grobalinfo(ConstCfg.global.openday)
    GameEvent.push(EventCfg.RoBeforedawn, openday)
end

--声明全局变量
function Global.declareVar()
    QaQdeclareVar()  --全局变量
    GameEvent.push(EventCfg.goDeclareVar, "")
end


function QaQdeclareVar() --C区全局变量
    --LOGPrint("C区全局变量act")
    inisysvar("integer", "C_QsQsyhdweek")  --周变量标记ShangYeHuoDong1
    inisysvar("integer", "C_QsQsyhdFourdays")  --4天循环变量ShangYeHuoDong2
    inisysvar("integer", "C_QsQsyhdThreedays")  --3天循环变量ShangYeHuoDong3
    for i=1,6 do
        inisysvar("integer", "C_QsQhzlqmax"..i)  --一个服务器最多5个不同会长领取 ShangYeHuoDong4
        inisysvar("integer", "C_QsQcylqmax"..i)  --一个服务器最多1000个不同行会成员领取ShangYeHuoDong4
    end
    inisysvar("string", "C_QsQranklist_tab")  --newranklist 自定义战力榜
    setontimerex(23, 60)   --23 60  添加刷新排行榜全局定时器
    --LOGPrint("C区全局变量end")
end
-------------------------------网络消息---------------------------------------
--同步总实冲分
function Global.SyncTotalRealRecharge(actor)
    local real_recharge_cent = getplaydef(actor, VarCfg.U_real_recharge_cent)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_SyncTotalRealRecharge, real_recharge_cent)
end

--同步今日实冲分
function Global.SyncTodayRealRecharge(actor)
    local today_real_recharge_cent = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_SyncTodayRealRecharge, today_real_recharge_cent)
end

--请求打开天天省钱
function Global.RequestOpenTTSQ(actor)
    qqgiftbox(actor)
end

-------------------------------逻辑处理---------------------------------------
--每日更新
function Global.dailyupdate(actor, islogin, datas)
    local before_date = getplaydef(actor, VarCfg.T_daily_date)
    local cur_date = os.date("%Y%m%d") --当前年月日
    if cur_date ~= before_date then
        --清理今日实际充值分
        setplaydef(actor, VarCfg.U_today_real_recharge_cent, 0)

        setplaydef(actor, VarCfg.T_daily_date, cur_date)  --过了一天更新当前年月日
        GameEvent.push(EventCfg.goDailyUpdate, actor, islogin, datas)
    end
end

--检查模块开启
function Global.checkModuleOpen(actor)
    -- openmoduleid = 100
    -- GameEvent.push(EventCfg.goOpenModule, actor, openmoduleid)
    --通过 openmoduleid 获取模块对象， 同步模块数据
    -- Message.sendmsg(actor, ssrNetMsgCfg.Global_OpenModuleRun, openmoduleid)
end

-------------------------------事件---------------------------------------
--登录完成
local _login_SyncOpenDay = {ssrNetMsgCfg.Global_SyncOpenDay, 0}
local _login_SyncCreateActor = {ssrNetMsgCfg.Global_SyncCreateActor, 0, 0}
local _login_SyncTotalRealRecharge = {ssrNetMsgCfg.Global_SyncTotalRealRecharge, 0}
local _login_SyncTodayRealRecharge = {ssrNetMsgCfg.Global_SyncTodayRealRecharge, 0}
function Global.LoginEnd(actor, logindatas)
    Global.dailyupdate(actor, true, logindatas)

    --开服天数
    _login_SyncOpenDay[2] = grobalinfo(ConstCfg.global.openday)
    table.insert(logindatas, _login_SyncOpenDay)

    --创建角色信息
    _login_SyncCreateActor[2] = getplaydef(actor, VarCfg.U_create_actor_time)
    _login_SyncCreateActor[3] = Player.getCreateActorDay(actor)
    table.insert(logindatas, _login_SyncCreateActor)

    --总实冲分
    _login_SyncTotalRealRecharge[2] = getplaydef(actor, VarCfg.U_real_recharge_cent)
    table.insert(logindatas, _login_SyncTotalRealRecharge)

    --今日实冲分
    _login_SyncTodayRealRecharge[2] = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    table.insert(logindatas, _login_SyncTodayRealRecharge)
end

--每日凌晨
function Global.Beforedawn(actor, beforedawndatas)
    Global.dailyupdate(actor, false, beforedawndatas)

    --开服天数
    _login_SyncOpenDay[2] = grobalinfo(ConstCfg.global.openday)
    table.insert(beforedawndatas, _login_SyncOpenDay)

    --今日实冲分
    _login_SyncTodayRealRecharge[2] = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    table.insert(beforedawndatas, _login_SyncTodayRealRecharge)
end

--点击某NPC
function Global.ClickNpcResponse(actor, npcid)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_ClickNpcResponse, npcid)
end

--充值触发
function Global.Recharge(actor, gold, productid, moneyid)
    -- Global.SyncTotalRealRecharge(actor)     --充值后同步总实冲分
    -- Global.SyncTodayRealRecharge(actor)     --充值后同步总虚冲分

    Message.sendmsg(actor, ssrNetMsgCfg.Global_Recharge, gold, productid, moneyid)
end

-- 打开界面
function Global.OpenUI(player)
    --Message.sendmsg(player, ssrNetMsgCfg.CostPlan_OpenUIResponse, )
end


-------------------------------监听事件---------------------------------------
--GameEvent.add(EventCfg.onLoginEnd, Global.LoginEnd, Global, 1)
--GameEvent.add(EventCfg.goBeforedawn, Global.Beforedawn, Global, 1)
--GameEvent.add(EventCfg.onClickNpc, Global.ClickNpcResponse, Global, 1)
--GameEvent.add(EventCfg.onRecharge, Global.Recharge, Global, 1)
GameEvent.add(EventCfg.goOpenUI, Global.OpenUI, Global, 1)

-------------------------------监听网络---------------------------------------
Message.RegisterNetMsg(ssrNetMsgCfg.Global, Global)

return Global