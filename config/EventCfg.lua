EventCfg = {}


--�����¼�
EventCfg.onNewHuman           = "onNewHuman"      --�½�ɫ��һ�ε�¼    (������actor)
EventCfg.onLogin              = "onLogin"         --��¼    (������actor)
EventCfg.onLoginAttr          = "onLoginAttr"     --��¼��������    (������actor, ��¼��������)
EventCfg.onLoginEnd           = "onLoginEnd"      --��¼���    (������actor, ��¼ͬ������)
EventCfg.onKillMon            = "onKillMon"       --�����ͼɱ��    (������actor, �����������, ��������idx)
EventCfg.onKillPlay           = "onKillPlay"      --�����ͼɱ��
EventCfg.onPlayLevelUp        = "onPlayLevelUp"   --�������    (������actor, ��ǰ�ȼ�, ֮ǰ�ȼ�)
EventCfg.onTakeOnEx           = "onTakeOnEx"      --��װ��goPlayerVar
EventCfg.onTakeOffEx          = "onTakeOffEx"     --��װ��
EventCfg.onAddBag             = "onAddBag"        --��Ʒ������
EventCfg.onExitGame           = "onExitGame"      --С�˻������Ϸ
EventCfg.onTriggerChat        = "onTriggerChat"   --������������Ϣ
EventCfg.onClickNpc           = "onClickNpc"      --���ĳNPC
EventCfg.onRecharge           = "onRecharge"      --��ֵ     (������actor, ��ֵrmb���, ��ƷID��������, ����ID)
EventCfg.goEnterMap           = "goEnterMap"      --�����ͼ
-- EventCfg.goSwitchMap          = "goSwitchMap"     --�л���ͼ
EventCfg.onStartAutoGame      = "onStartAutoGame" --��ʼ�һ�
EventCfg.onStopAutoGame       = "onStopAutoGame"  --ֹͣ�һ�
EventCfg.onPickItem           = "onPickItem"      --ʰȡ��Ʒ
EventCfg.onUseItem            = "onUseItem"       --ʹ����Ʒ
EventCfg.onBindWeChat         = "onBindWeChat"    -- ΢�Ű󶨿�ʼ����
EventCfg.onBindReWeChat       = "onBindReWeChat"  -- ΢�Ű󶨽�������

--��Ϸ�¼�
EventCfg.goOpenUI             = "goOpenUI"             --�򿪽���
EventCfg.goSetAndViewStatus   = "goSetAndViewStatus"   --����������������
EventCfg.forceGuide           = "goForceGuide"         --ǿ����������������
EventCfg.goRefreshRelive      = "goRefreshRelive"      --��Ҹ���״̬ˢ��
EventCfg.goDonateChange       = "goDonateChange"       --���׸ı�
EventCfg.goRefreshTopIcon     = "goRefreshTopIcon"     --���Ͻ�ˢ��
EventCfg.goSetStatusConfig    = "goSetStatusConfig"    --�����������Ե����ñ�
EventCfg.goChangeLifeIntegral = "goChangeLifeIntegral" --��Ծ���ָı�
EventCfg.onUniqueSkillUpdate  = "onUniqueSkillUpdate"  --���漼����
EventCfg.onAuraChange         = "onAuraChange"         --�⻷����
EventCfg.onWholeFashionChange = "onWholeFashionChange" --һ��ʱװ����

EventCfg.onBeginmagic         = "onBeginmagic"         --�����ͷż���ǰ
EventCfg.onSendability        = "onSendability"        --���Ա仯
EventCfg.onAddSkill           = "onAddSkill"           --��Ӽ��ܺ�
EventCfg.onDelSkill           = "onDelSkill"           --ɾ�����ܺ�
EventCfg.onMagicAttack        = "onMagicAttack"        --���ħ��������
EventCfg.onAttack             = "onAttack"             --�����������
EventCfg.onSelfKillSlave      = "onSelfKillSlave"      --������������
EventCfg.onSetVar             = "onSetVar"             --�ı���������󴥷�
EventCfg.onAttackDamage       = "onAttackDamage"       --��������
EventCfg.onStruck             = "onStruck"             --�����ܻ�
EventCfg.onMagicStruck        = "onMagicStruck"        --ħ���ܻ�
EventCfg.onSetSkillInfo       = "onSetSkillInfo"       --ǿ�����ܺ󴥷�
EventCfg.onChangeClawLevel    = "onChangeClawLevel"    --��צ�ȼ��仯����--��ң�ְҵ��ǿ���ڼ���


return EventCfg
