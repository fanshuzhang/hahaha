Global = {}

function beforedawn()
    local t = getplayerlst()
    for _,actor in ipairs(t) do
        Global.dailyupdate(actor)
    end
    local openday = grobalinfo(ConstCfg.global.openday)
    GameEvent.push(EventCfg.RoBeforedawn, openday)
end

--����ȫ�ֱ���
function Global.declareVar()
    QaQdeclareVar()  --ȫ�ֱ���
    GameEvent.push(EventCfg.goDeclareVar, "")
end


function QaQdeclareVar() --C��ȫ�ֱ���
    --LOGPrint("C��ȫ�ֱ���act")
    inisysvar("integer", "C_QsQsyhdweek")  --�ܱ������ShangYeHuoDong1
    inisysvar("integer", "C_QsQsyhdFourdays")  --4��ѭ������ShangYeHuoDong2
    inisysvar("integer", "C_QsQsyhdThreedays")  --3��ѭ������ShangYeHuoDong3
    for i=1,6 do
        inisysvar("integer", "C_QsQhzlqmax"..i)  --һ�����������5����ͬ�᳤��ȡ ShangYeHuoDong4
        inisysvar("integer", "C_QsQcylqmax"..i)  --һ�����������1000����ͬ�л��Ա��ȡShangYeHuoDong4
    end
    inisysvar("string", "C_QsQranklist_tab")  --newranklist �Զ���ս����
    setontimerex(23, 60)   --23 60  ���ˢ�����а�ȫ�ֶ�ʱ��
    --LOGPrint("C��ȫ�ֱ���end")
end
-------------------------------������Ϣ---------------------------------------
--ͬ����ʵ���
function Global.SyncTotalRealRecharge(actor)
    local real_recharge_cent = getplaydef(actor, VarCfg.U_real_recharge_cent)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_SyncTotalRealRecharge, real_recharge_cent)
end

--ͬ������ʵ���
function Global.SyncTodayRealRecharge(actor)
    local today_real_recharge_cent = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_SyncTodayRealRecharge, today_real_recharge_cent)
end

--���������ʡǮ
function Global.RequestOpenTTSQ(actor)
    qqgiftbox(actor)
end

-------------------------------�߼�����---------------------------------------
--ÿ�ո���
function Global.dailyupdate(actor, islogin, datas)
    local before_date = getplaydef(actor, VarCfg.T_daily_date)
    local cur_date = os.date("%Y%m%d") --��ǰ������
    if cur_date ~= before_date then
        --�������ʵ�ʳ�ֵ��
        setplaydef(actor, VarCfg.U_today_real_recharge_cent, 0)

        setplaydef(actor, VarCfg.T_daily_date, cur_date)  --����һ����µ�ǰ������
        GameEvent.push(EventCfg.goDailyUpdate, actor, islogin, datas)
    end
end

--���ģ�鿪��
function Global.checkModuleOpen(actor)
    -- openmoduleid = 100
    -- GameEvent.push(EventCfg.goOpenModule, actor, openmoduleid)
    --ͨ�� openmoduleid ��ȡģ����� ͬ��ģ������
    -- Message.sendmsg(actor, ssrNetMsgCfg.Global_OpenModuleRun, openmoduleid)
end

-------------------------------�¼�---------------------------------------
--��¼���
local _login_SyncOpenDay = {ssrNetMsgCfg.Global_SyncOpenDay, 0}
local _login_SyncCreateActor = {ssrNetMsgCfg.Global_SyncCreateActor, 0, 0}
local _login_SyncTotalRealRecharge = {ssrNetMsgCfg.Global_SyncTotalRealRecharge, 0}
local _login_SyncTodayRealRecharge = {ssrNetMsgCfg.Global_SyncTodayRealRecharge, 0}
function Global.LoginEnd(actor, logindatas)
    Global.dailyupdate(actor, true, logindatas)

    --��������
    _login_SyncOpenDay[2] = grobalinfo(ConstCfg.global.openday)
    table.insert(logindatas, _login_SyncOpenDay)

    --������ɫ��Ϣ
    _login_SyncCreateActor[2] = getplaydef(actor, VarCfg.U_create_actor_time)
    _login_SyncCreateActor[3] = Player.getCreateActorDay(actor)
    table.insert(logindatas, _login_SyncCreateActor)

    --��ʵ���
    _login_SyncTotalRealRecharge[2] = getplaydef(actor, VarCfg.U_real_recharge_cent)
    table.insert(logindatas, _login_SyncTotalRealRecharge)

    --����ʵ���
    _login_SyncTodayRealRecharge[2] = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    table.insert(logindatas, _login_SyncTodayRealRecharge)
end

--ÿ���賿
function Global.Beforedawn(actor, beforedawndatas)
    Global.dailyupdate(actor, false, beforedawndatas)

    --��������
    _login_SyncOpenDay[2] = grobalinfo(ConstCfg.global.openday)
    table.insert(beforedawndatas, _login_SyncOpenDay)

    --����ʵ���
    _login_SyncTodayRealRecharge[2] = getplaydef(actor, VarCfg.U_today_real_recharge_cent)
    table.insert(beforedawndatas, _login_SyncTodayRealRecharge)
end

--���ĳNPC
function Global.ClickNpcResponse(actor, npcid)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_ClickNpcResponse, npcid)
end

--��ֵ����
function Global.Recharge(actor, gold, productid, moneyid)
    -- Global.SyncTotalRealRecharge(actor)     --��ֵ��ͬ����ʵ���
    -- Global.SyncTodayRealRecharge(actor)     --��ֵ��ͬ��������

    Message.sendmsg(actor, ssrNetMsgCfg.Global_Recharge, gold, productid, moneyid)
end

-- �򿪽���
function Global.OpenUI(player)
    --Message.sendmsg(player, ssrNetMsgCfg.CostPlan_OpenUIResponse, )
end


-------------------------------�����¼�---------------------------------------
--GameEvent.add(EventCfg.onLoginEnd, Global.LoginEnd, Global, 1)
--GameEvent.add(EventCfg.goBeforedawn, Global.Beforedawn, Global, 1)
--GameEvent.add(EventCfg.onClickNpc, Global.ClickNpcResponse, Global, 1)
--GameEvent.add(EventCfg.onRecharge, Global.Recharge, Global, 1)
GameEvent.add(EventCfg.goOpenUI, Global.OpenUI, Global, 1)

-------------------------------��������---------------------------------------
Message.RegisterNetMsg(ssrNetMsgCfg.Global, Global)

return Global