---@class NpcMovaHuanJin �þ�
local NpcMovaHuanJin = {}
local NpcMovaHuanJinCfg = {
    index = {
        [21] = 1,
    },
    cost = { { "�þ�ƾ֤", 1, id = 10416 } },
}
function NpcMovaHuanJin.main(player)
    say(player, [[
        <Img|reset=1|esc=1|move=1|loadDelay=1|show=4|img=custom/UI/public/img_bk2.png|bg=1>
        <Layout|x=481.0|y=0.0|width=80|height=80|link=@exit>
        <Button|x=516.0|y=49.0|nimg=custom/new1/close2.png|size=18|color=255|link=@exit>
        <RText|x=243.0|y=66.0|color=70|outlinecolor=0|size=18|outline=2|text=<�þ�����/FCOLOR=70>>
        <Text|x=60.0|y=120.0|size=22|color=250|text=[ɢ�˸�����ͼ]>
        <RText|x=61.0|y=157.0|width=430|size=18|color=254|text=�þ���ɫ��ͼ��ȫ��ѽ��롢ֻ��һ��<[�þ�ƾ֤]/FCOLOR=251>��ÿ��ˢ�����˹���������ɢ�˴��ĺõط����߱��ʡ�>
        <Button|x=218.0|y=279.0|color=251|nimg=custom/UI/public/btn2.png|size=18|text=����þ�|link=@npcmovahuanjinmoveok>
    ]])
end

--����
function npcmovahuanjinmoveok(player)
    --�����Ƿ����
    local flag, desc = lualib:BatchCheckItemEX(player, NpcMovaHuanJinCfg.cost)
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --�۳�����
    flag, desc = lualib:BatchDelItemEX(player, NpcMovaHuanJinCfg.cost, "����Ѫ����������")
    if not flag then
        Message:Msg9(player, desc)
        return
    end
    --����
    lualib:MapMove(player, "h001")
end

--Npc�������
function NpcMovaHuanJin.onClickNpc(player, npcID, npcName)
    if not NpcMovaHuanJinCfg.index[npcID] then
        return
    end
    NpcMovaHuanJin.main(player)
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onClickNpc, NpcMovaHuanJin.onClickNpc, NpcMovaHuanJin)
return NpcMovaHuanJin
