local HelperBox = {
    titleName = "既然今天杨天尊帮了你，那么你准备什么时候V杨天尊50吃个KFC呢?现在立即联系杨天尊吧！QQ：614322689",
    version = "Version 0.0.0.9",
    Constant = {
        jobDesc = {[0]="战士", [1]="法师", [2]="道士", [98]="其它", [99]="通用"},
        skillMenu = {[0]={0, "战士"}, {1, "法师"}, {2, "道士"}, {98, "其它"}, {99, "通用"}},
    },
    baseEnter = { -- 一个输入框一个按钮就能解决的
        {btn="确定", input="等级", v=6},
        {btn="确定", input="转生", v=39},
        {btn="确定", input="性别", v=8},
        {btn="确定", input="职业", v=7},
        {btn="确定", input="PK点", v=46},
        {btn="确定", input="物攻下限", v=19},
        {btn="确定", input="物攻上限", v=20},
        {btn="确定", input="杀怪爆率", v=43},
        {btn="确定", input="当前血量", v=9},
        {btn="确定", input="当前蓝量", v=11},
    },

    {
        {btn='快捷操作',{msg="快捷操作"},call="",dv={}},
        {btn='基础操作',{msg="基础操作"},call="",dv={}},
        {btn='货币操作',{msg="货币操作"},call="",dv={}},
        {btn='刷物品',{"物品名或id", "数量(不填为1)", "物品规则(2#6#7#9)(不填默认)",},call="HelperBox_FormActionCreateItem",dv={"<$USERNAME>"}},
        {btn='查看人物信息',{msg="人物信息"},call="",dv={}},
        {btn='查看人物属性',{msg="人物属性信息"},call="",dv={}},
        {btn='服务器信息',{msg="服务器信息"},call="",dv={}},
        {btn='内存信息',{msg="内存信息"},call="",dv={}},
        {btn='查看所有地图',{msg="地图信息"},call="",dv={}},
        {btn='查看NPC刷新',{msg="NPC信息"},call="",dv={}},
        {btn='查看所有BUFF',{msg="BUFF信息"},call="",dv={}},
        {btn='刷怪',{"怪物名字或id", "地图id(不填为当前)", "X轴(不填为当前)", "Y轴(不填为当前)", "数量(不填为1)", "范围(不填为1)"},call="HelperBox_FormActionGenMonster",dv={}},
        --{btn='查看全NPC刷新',{msg="全NPC信息"},call="",dv={}},
        --{btn='查看本服技能',{msg="技能信息"},call="",dv={}},
        --{btn='获取本服套装',{msg="本服套装"},call="",dv={}},
        {btn='原地创建临时NPC',{"idx", "npc名称", "npc外形", "npc脚本（`,`代替`正斜杠`）"},call="HelperBox_FormActionCreateNpc",dv={nil, "临时NPCX", "0", nil}},
        {btn='调用TXT脚本命令',{ "文件名(Market_def文件夹下)", "标签名如@Test"},call="HelperBox_FormActionCallScriptFunc",dv={"<$USERNAME>"}},
        {btn='调用传奇脚本命令',{ "脚本接口", "参数1","参数2","参数3","参数4","参数5","参数6","参数7"},call="HelperBox_FormActionCallScriptInterface",dv={"<$USERNAME>"},tip={ox=0,oy=0,{c=249, "由于输入框数量上限10个"},{c=249,"请在参数7处用`&`符号"},{c=249,"链接7，8，9，10号参数"}}},
        {btn='顶戴花翎',{"位置 0-9","播放效果(0图片名称 1特效ID)","图片名或者特效ID","X坐标 (为空时默认X=0)","Y坐标 (为空时默认Y=0)","自动补全空白位置0,1(0=掉 1=不掉)","是否只有自己看见(0=所有人都可见 1=仅仅自己可见)"},call="HelperBox_FormActionHeadEffect",dv={"<$USERNAME>",0,1,nil,0,0,1,0}},
        {btn='在人物身上播放特效',{"特效ID","相对于人物偏移的X坐标","相对于人物偏移的Y坐标","播放次数0-一直播放（此处填-1代表取消特效）","播放模式0-前面1-后面","仅自己可见0-否，视野内均可见，1-是"},call="HelperBox_FormActionBodyEffect",dv={"<$USERNAME>",nil,0,0,0,0,0}},
        {btn='模拟在线充值',{"要充值的金额","货币类型","指纹（变量#指纹名）"},call="HelperBox_FormActionChargeMonitor",dv={"<$USERNAME>"}},
        {btn='在线补发物品',{"物品1#数量#绑定标记&物品2。。。", "邮件ID", "邮件标题", "邮件内容"},call="HelperBox_FormActionSendMail",dv={"<$USERNAME>"}},
        --{btn='',{},call="",dv={}},
        name = "特殊操作",
    },
    {
        {btn='调整人物属性(带有效期)',{"属性ID(1-20)", "属性值", "时间(秒)注意填0不代表永久"},call="HelperBox_FormActionSetTimeAtt",dv={"<$USERNAME>"},tip= {ox=143,oy=210,{c=249,"注意其中属性id如下所示："},{c=255,"1-防御下限"},{c=255,"2-防御上限"},{c=255,"3-魔御下限"},{c=255,"4-魔御上限"},{c=255,"5-攻击下限"},{c=255,"6-攻击上限"},{c=255,"7-魔法下限"},{c=255,"8-魔法上限"},{c=255,"9-道术下限"},{c=255,"10-道术上限"},{c=255,"11-MaxHP"},{c=255,"12-MaxMP"},{c=255,"13-HP恢复"},{c=255,"14-MP恢复"},{c=255,"15-毒恢复"},{c=255,"16-毒躲避"},{c=255,"17-魔法躲避"},{c=255,"18-准确"},{c=255,"19-敏捷"},{c=255,"20-幸运"} }},
        {btn='BUFF操作',{"增加buff属性的buffid","附加属性"},call="HelperBox_FormActionBuffAction",dv={"<$USERNAME>"}},
        {btn='称号操作',{"增加称号的名字","删除称号的名字","查询的称号名字"},call="HelperBox_FormActionTitleAction",dv={"<$USERNAME>"}},
        {btn='查询玩家变量',{"要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetVar",dv={"<$USERNAME>",nil,"$RESULT$"}},
        {btn='设置玩家变量',{"要设置的变量","要设置的变量值","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetVar",dv={"<$USERNAME>",nil,nil,"$RESULT$"}},
        {btn='查询玩家标识',{"标识序号","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetStatus",dv={"<$USERNAME>"}},
        {btn='设置玩家标识',{"标识序号","属性值","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetStatus",dv={"<$USERNAME>"}},
        {btn='查询玩家自定义int变量',{"变量范围(HUMAN/GUILD)","要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetSelfCustomVarInt",dv={"<$USERNAME>"}},
        {btn='设置玩家自定义int变量',{"变量范围(HUMAN/GUILD)","要设置的变量","要设置的变量值","是否保存到数据库(0-否 1-是)","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetSelfCustomVarInt",dv={"<$USERNAME>"}},
        {btn='查询玩家自定义str变量',{"变量范围(HUMAN/GUILD)","要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetSelfCustomVarStr",dv={"<$USERNAME>"}},
        {btn='设置玩家自定义str变量',{"变量范围(HUMAN/GUILD)","要设置的变量","要设置的变量值","是否保存到数据库(0-否 1-是)","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetSelfCustomVarStr",dv={"<$USERNAME>"}},

        name = "玩家操作"
    },

    {
        --{btn='系统重载',{msg="系统重载", {{n="重载NPC",p={"ReloadNpc"}},{n="重载QM",p={"ReloadManage"}},{n="重载QF",p={"ReloadManage", "1"}},{n="重载机器人配置",p={"ReloadRobotManage"}},{n="重载机器人脚本",p={"ReloadRobot"}},{n="重载怪物爆率配置",p={"ReloadMonItems"}},{n="重载管理员列表",p={"ReloadAdmin"}},{n="重载物品数据库",p={"ReloadItemDB"}},{n="重载技能列表",p={"ReloadMagic"}},{n="重载怪物数据库",p={"ReloadMonsterDB"}},{n="重载小地图配置",p={"ReloadMinMap"}},} },call="",dv={}},
        {btn='查询全局变量',{"要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetSysVar",dv={}},
        {btn='设置全局变量',{"要设置的变量","要设置的变量值","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetSysVar",dv={}},
        {btn='查询全局自定义int变量',{"要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetSysCustomVarInt",dv={}},
        {btn='设置全局自定义int变量',{"要设置的变量","要设置的变量值","是否保存到数据库(0-否 1-是)","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetSysCustomVarInt",dv={}},
        {btn='查询全局自定义str变量',{"要查询的变量","变量结果（仅展示不提交）"},call="HelperBox_FormActionGetSysCustomVarStr",dv={}},
        {btn='设置全局自定义str变量',{"要设置的变量","要设置的变量值","是否保存到数据库(0-否 1-是)","变量结果（仅展示不提交）"},call="HelperBox_FormActionSetSysCustomVarStr",dv={}},

        name = "系统操作"
    },

    {
        {btn='客户端功能测试',{msg="客户端功能测试"},call="",dv={"<$USERNAME>"}},
        {btn='装备复制',{msg="装备复制"},call="ytz_box_test1",dv={}},
        {btn='发送json物品',{"json值"},call="HelperBox_FormActionCreateJsonItem",dv={"<$USERNAME>"}},
        {btn='地上刷物品',{"物品名"},call="HelperBox_FormActionThrowItem",dv={"<$USERNAME>"}},
        {btn='刮刮乐无边',{msg="刮刮乐无边"},call="",dv={"<$USERNAME>"}},
        {btn='旋转容器',{msg="旋转容器"},call="",dv={"<$USERNAME>"}},

        name = "测试操作",
    },

    --{
    --    {btn='进行封号',{"要被封号的玩家名称"},call="suspend",dv={"<$USERNAME>"}},
    --    {btn='解除封号',{"要被解封的玩家名称"},call="suspstar",dv={"<$USERNAME>"}},
    --    {btn='进行禁言',{"要被禁言的玩家名称"},call="speakend",dv={"<$USERNAME>"}},
    --    {btn='解除禁言',{"解除禁言的玩家名称"},call="speakstar",dv={"<$USERNAME>"}},
    --    {btn='解散行会',{"解散行会的名称"},call="family",dv={}},
    --    name = "封禁操作"
    --},

    {
        {btn='版本信息',{msg="描述","当前版本号V-2023-05-09 10:44:00","v1-为GM判断新增权限值判断", "v2-新增系统重载页", "v3-新增历史记录查询", "v3-新增变量查询展示", "v4-新增全图NPC搜索", "v5-新增怪物信息", "v6-装备复制完善", "v6-新增服务器信息"},call="",dv={}},

        name="其它",
    },

    appTest = {
        {n="场景特效", c=94},
    },

    ts1 = { -- 用于基础操作内的特殊按钮 可以无限向下扩展，注意p的增长
        {n="清理背包", c=94, p=1},
        {n="清理地面", c=94, p=2},
        {n="打开仓库", c=94, p=3},
        {n="清除技能", c=94, p=4},
        {n="开背包", c=154, p=5},
        {n="仓库全开", c=94, p=6},
        {n="游戏小退", c=249, p=7},
        {n="迅速回城", c=218, p=8, data={k="3",x=114,y=91,r=10}}, -- 根据版本自行配置data部分
        {n="装备全修", c=154, p=9},
        {n="解除隐身", c=255, p=10},
        {n="解除无敌", c=255, p=11},
        {n="清除地图怪物", c=144, p=12},
        {n="剔除假人", c=144, p=13},
        {n="登录假人", c=144, p=14},
        {n="剔除挂机", c=144, p=15},
        {n="强制攻城", c=144, p=16},
        {n="十级权限", c=249, p=17},
        {n="清除权限", c=224, p=18},
    },
    baseinfo = {
        {id=55, n="IDX"},{id=1, n="角色名"},{id=2, n="角色唯一ID"},{id=45, n="地图名MAPTITLE"},{id=3, n="角色当前地图ID"},{id=4, n="角色X坐标"},{id=5, n="角色Y坐标"},{id=36, n="行会名"},{id=37, n="是否会长"},{id=65, n="回城地图"},{id=67, n="攻击对象"},{id=6, n="角色等级"},{id=7, n="角色职业"},{id=8, n="角色性别"},{id=9, n="角色当前HP"},{id=10, n="角色当前MAXHP"},{id=11, n="角色当前MP"},{id=12, n="角色当前MAXMP"},{id=13, n="角色当前Exp"},{id=14, n="角色当前MaxExp"},{id=15, n="角色物防下限"},{id=16, n="角色物防上限"},{id=17, n="角色魔防下限"},{id=18, n="角色魔防上限"},{id=19, n="角色物攻下限"},{id=20, n="角色物攻上限"},{id=21, n="角色魔攻下限"},{id=22, n="角色魔攻上限"},{id=23, n="角色道攻下限"},{id=24, n="角色道攻上限"},{id=25, n="角色幸运值"},{id=26, n="角色HP恢复"},{id=27, n="角色MP恢复"},{id=28, n="角色中毒恢复"},{id=29, n="毒物躲避"},{id=30, n="角色魔法躲避"},{id=31, n="角色准确"},{id=32, n="角色敏捷"},{id=33, n="发型"},{id=34, n="背包物品数量"},{id=35, n="队伍成员数量"},{id=38, n="宠物数量"},{id=39, n="转生等级"},{id=40, n="杀怪经验倍数"},{id=41, n="杀怪经验时间"},{id=42, n="延时还剩多少秒"},{id=43, n="人物杀怪爆率倍数"},{id=44, n="复活时间"},{id=46, n="PK点"},{id=47, n="是否新人"},{id=48, n="是否安全区"},{id=49, n="是否摆摊中"},{id=50, n="是否交易中"},{id=51, n="自定义扩展属性"},{id=52, n="穿人/怪方式"},{id=56, n="颜色"},{id=58, n="时装显示状态"},{id=60, n="是否在攻城区域"},{id=61, n="是否为离线挂机状态"},{id=63, n="人物背包大小"},{id=64, n="当前的身体颜色值"},
    },
    constinfo = {
        {"<$USERACCOUNT>",n="账户id(常)"},
    },
    castleTb = {
        {"沙城名称", 1},
        {"沙城行会名称", 2},
        {"沙城行会会长名字", 3},
        {"占领天数", 4},
        {"当前是否在攻沙状态", 5},
        {"沙城行会副会长名字列表", 6},
    },
    serverTb = {
        {"全局玩家信息", 0,},
        {"开服天数(后台维护)", 1,},
        {"开服时间(后台维护)", 2,},
        {"合服次数", 3,},
        {"合服时间", 4,},
        {"服务器IP", 5,},
        {"玩家数量", 6,},
        {"背包最大数量", 7,},
        {"引擎版本号", 8,},
        {"游戏id", 9,},
        {"服务器名称", 10,},
        {"服务器id", 11,},
    }
}

return HelperBox