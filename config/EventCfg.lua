EventCfg = {}


--引擎事件
EventCfg.onNewHuman           = "onNewHuman"      --新角色第一次登录    (参数：actor)
EventCfg.onLogin              = "onLogin"         --登录    (参数：actor)
EventCfg.onLoginAttr          = "onLoginAttr"     --登录附加属性    (参数：actor, 登录属性数据)
EventCfg.onLoginEnd           = "onLoginEnd"      --登录完成    (参数：actor, 登录同步数据)
EventCfg.onKillMon            = "onKillMon"       --任意地图杀怪    (参数：actor, 死亡怪物对象, 死亡怪物idx)
EventCfg.onKillPlay           = "onKillPlay"      --任意地图杀人
EventCfg.onPlayLevelUp        = "onPlayLevelUp"   --玩家升级    (参数：actor, 当前等级, 之前等级)
EventCfg.onTakeOnEx           = "onTakeOnEx"      --穿装备goPlayerVar
EventCfg.onTakeOffEx          = "onTakeOffEx"     --脱装备
EventCfg.onAddBag             = "onAddBag"        --物品进背包
EventCfg.onExitGame           = "onExitGame"      --小退或大退游戏
EventCfg.onTriggerChat        = "onTriggerChat"   --聊天栏输入信息
EventCfg.onClickNpc           = "onClickNpc"      --点击某NPC
EventCfg.onRecharge           = "onRecharge"      --充值     (参数：actor, 充值rmb金额, 产品ID（保留）, 货币ID)
EventCfg.goEnterMap           = "goEnterMap"      --进入地图
-- EventCfg.goSwitchMap          = "goSwitchMap"     --切换地图
EventCfg.onStartAutoGame      = "onStartAutoGame" --开始挂机
EventCfg.onStopAutoGame       = "onStopAutoGame"  --停止挂机
EventCfg.onPickItem           = "onPickItem"      --拾取物品
EventCfg.onUseItem            = "onUseItem"       --使用物品
EventCfg.onBindWeChat         = "onBindWeChat"    -- 微信绑定开始触发
EventCfg.onBindReWeChat       = "onBindReWeChat"  -- 微信绑定结束触发

--游戏事件
EventCfg.goOpenUI             = "goOpenUI"             --打开界面
EventCfg.goSetAndViewStatus   = "goSetAndViewStatus"   --激活特殊属性配置
EventCfg.forceGuide           = "goForceGuide"         --强制引导玩家新人玩家
EventCfg.goRefreshRelive      = "goRefreshRelive"      --玩家复活状态刷新
EventCfg.goDonateChange       = "goDonateChange"       --捐献改变
EventCfg.goRefreshTopIcon     = "goRefreshTopIcon"     --右上角刷新
EventCfg.goSetStatusConfig    = "goSetStatusConfig"    --设置特殊属性的配置表
EventCfg.goChangeLifeIntegral = "goChangeLifeIntegral" --活跃积分改变
EventCfg.onUniqueSkillUpdate  = "onUniqueSkillUpdate"  --传奇技更新
EventCfg.onAuraChange         = "onAuraChange"         --光环更新
EventCfg.onWholeFashionChange = "onWholeFashionChange" --一体时装更新

EventCfg.onBeginmagic         = "onBeginmagic"         --自身释放技能前
EventCfg.onSendability        = "onSendability"        --属性变化
EventCfg.onAddSkill           = "onAddSkill"           --添加技能后
EventCfg.onDelSkill           = "onDelSkill"           --删除技能后
EventCfg.onMagicAttack        = "onMagicAttack"        --玩家魔法攻击后
EventCfg.onAttack             = "onAttack"             --玩家物理攻击后
EventCfg.onSelfKillSlave      = "onSelfKillSlave"      --宝宝死亡触发
EventCfg.onSetVar             = "onSetVar"             --改变人物变量后触发
EventCfg.onAttackDamage       = "onAttackDamage"       --攻击触发
EventCfg.onStruck             = "onStruck"             --物理受击
EventCfg.onMagicStruck        = "onMagicStruck"        --魔法受击
EventCfg.onSetSkillInfo       = "onSetSkillInfo"       --强化技能后触发
EventCfg.onChangeClawLevel    = "onChangeClawLevel"    --鬼爪等级变化触发--玩家，职业，强化第几重


return EventCfg
