ConstCfg = {
    
    --全局信息
    global = {
        openday         = 1,        --开服天数
        opendate        = 2,        --开服时间
        mergecount      = 3,        --合服次数
        mergedate       = 4,        --合服时间
        serverip        = 5,        --服务器IP
        actornum        = 6,        --玩家数量
        maxbagnum       = 7,        --背包最大数量
    },

    --设置人物，怪物，base字段
    gbase = {
        isplayer        = -1,      --是否玩家
        isdie           = 0,       --是否死亡(true:死亡状态)
        name            = 1,       --角色名 （返回值字符型）
        id              = 2,       --角色唯一ID （返回值字符型）
        mapid           = 3,       --角色当前地图ID （返回值字符型）
        x               = 4,       --角色X坐标
        y               = 5,       --角色Y坐标
        level           = 6,       --角色等级
        job             = 7,       --角色职业 （0-战 1-法 2-道）
        sex             = 8,       --角色性别
        curhp           = 9,       --角色当前HP
        maxhp           = 10,      --角色当前MAXHP
        curmp           = 11,      --角色当前MP
        maxmp           = 12,      --角色当前MAXMP
        curexp          = 13,      --角色当前Exp
        maxexp          = 14,      --角色当前MaxExp
        ac              = 15,      --角色物防下限
        ac2             = 16,      --角色物防上限
        mac             = 17,      --角色魔防下限
        mac2            = 18,      --角色魔防上限
        dc              = 19,      --角色物攻下限
        dc2             = 20,      --角色物攻上限
        mc              = 21,      --角色魔攻下限
        mc2             = 22,      --角色魔攻上限
        sc              = 23,      --角色道攻下限
        sc2             = 24,      --角色道攻上限
        lucky           = 25,      --角色幸运值
        hpadd           = 26,      --角色HP恢复
        mpadd           = 27,      --角色MP恢复
        poison_add      = 28,      --角色中毒恢复
        poison_avoid    = 29,      --毒物躲避
        magic_avoid     = 30,      --角色魔法躲避
        accuracy        = 31,      --角色准确
        agile           = 32,      --角色敏捷
        hair            = 33,      --发型
        bag_num         = 34,      --背包物品数量（仅人物）
        team_num        = 35,      --队伍成员数量（仅人物）
        guild           = 36,      --行会名（仅人物）
        isboos          = 37,      --是否会长（仅人物）
        pets_num        = 38,      --宠物数量
        renew_level     = 39,      --转生等级（仅人物）
        exp_rate        = 40,      --杀怪经验倍数（仅人物）
        exp_time        = 41,      --杀怪经验时间（仅人物）
        delay_call_time = 42,      --显示延时TIMERECALL还剩多少秒（仅人物）
        drop_rate       = 43,      --人物杀怪爆率倍数（仅人物）
        revive_time     = 44,      --复活时间
        map_title       = 45,      --地图名MAPTITLE
        pkvalue         = 46,      --PK点
        isnewhuman      = 47,      --是否新人（仅人物）
        issaferect      = 48,      --是否安全区
        isstall         = 49,      --是否摆摊中（仅人物）
        istrade         = 50,      --是否交易中（仅人物）
        custom_attr     = 51,      --自定义扩展属性，需要提供 参数3:属性ID（cfg_att_score.xls设置：1-91，200~249）
        behavior        = 52,      --穿人/怪方式 0=恢复/1=穿人/2=穿怪/3=穿人穿怪
        login           = 53,      --登录状态，0：正常，1：断线重连（仅人物）
        userid          = 54,      --主人UserId
        idx             = 55,      --Idx
        color           = 56,      --颜色（0~255）
        fashion         = 58,      --时装显示状态(仅人物)  0=不显示 1=显示
    },   

    --获取人物，怪物，base字段
    sbase = {
        level           = 6,       --设置等级
        job             = 7,       --职业
        sex             = 8,       --性别
        curhp           = 9,       --当前HP
        curmp           = 11,      --当前MP
        ac              = 15,      --物防下限
        ac2             = 16,      --物防上限
        mac             = 17,      --魔防下限
        mac2            = 18,      --魔防上限
        dc              = 19,      --物攻下限
        dc2             = 20,      --物攻上限
        mc              = 21,      --魔攻下限
        mc2             = 22,      --魔攻上限
        sc              = 23,      --道攻下限
        sc2             = 24,      --道攻上限
        lucky           = 25,      --幸运值
        hpadd           = 26,      --HP恢复
        mpadd           = 27,      --MP恢复
        poison_add      = 28,      --中毒恢复
        poison_avoid    = 29,      --毒物躲避
        magic_avoid     = 30,      --魔法躲避
        accuracy        = 31,      --准确
        agile           = 32,      --敏捷
        hair            = 33,      --发型
        renew_level     = 39,      --转生等级（仅人物）
        exp_rate        = 40,      --杀怪经验倍数（仅人物）
        exp_time        = 41,      --杀怪经验时间（仅人物）
        drop_rate       = 43,      --人物杀怪爆率倍数（仅人物）
        pkvalue         = 46,      --人物PK点（仅人物）
        behavior        = 50,      --行为方式，只针对宠物，包含多个行为时，求和（1：禁止攻击玩家，2：不可被攻击，4：优先攻击 玩家攻击对象，8：优先攻击 玩家受击对象 ）
        mutiny          = 51,      --叛变（仅怪物）
        through         = 52,      --穿人/怪方式 0=恢复/1=穿人/2=穿怪/3=穿人穿怪
        color           = 56,      --颜色（0~255）
        fashion         = 57       --时装显示状态(仅人物)  0=不显示 1=显示
    },

    --永久属性
    forever_attr = {
        dc              = 1,        --攻击下限（0~65535）
        dc2             = 2,        --攻击上限（0~65535）
        mc              = 3,        --魔法下限（0~65535）
        mc2             = 4,        --魔法上限（0~65535）
        sc              = 5,        --道术下限（0~65535）
        sc2             = 6,        --道术上限（0~65535）
        ac              = 7,        --防御下限（0~65535）
        ac2             = 8,        --防御上限（0~65535）
        mac             = 9,        --魔防下限（0~65535）
        mac2            = 10,       --魔防上限（0~65535）
        maxhp           = 11,       --生命值（支持21亿）
        maxmp           = 12,       --魔法值（支持21亿）
        accuracy        = 13,       --准确（支持21亿）
        agile           = 14,       --躲避就是准确（支持21亿）
    },

     --自定义属性
     custom_attr = {
        attr200         = 200,     --减少受到来自怪物的固定伤害
    },

    --人物模式
    --第三个参数无敌,隐身,禁止攻击时没有使用.
    --如果是禁锢时，第三个参数表示禁锢范围
    pmode = {
        god                 = 1,    --无敌
        unsee               = 2,    --隐身
        hp                  = 3,    --HP
        mp                  = 4,    --MP
        dc2                 = 5,    --攻击力
        mc2                 = 6,    --魔法力
        sc2                 = 7,    --道术力
        ias                 = 8,    --攻击速度
        ban_act             = 9,    --禁止攻击
        lock                = 10,   --锁定
        trap                = 11,   -- 禁锢(释放一个类似困魔咒的光圈，敌对人物或怪物只能在这个圈子里移动，无法走出圈子外面，所有传送失效，不能小退)
        frost               = 12,   -- 冰冻
        stick               = 13,   -- 蛛网
        nopalsy             = 14,   -- 防麻痹
        mptrap              = 15,   -- 防禁锢
        nofrost             = 16,   -- 防冰冻
        nostick             = 17,   -- 防蛛网
        palsy               = 18,   -- 麻痹
        protect             = 19,   -- 护身
        inblood             = 20,   -- 吸血
        inblue              = 21,   -- 吸蓝
        lucent              = 22,   -- 隐身(类似隐身戒指)
        realive             = 23,   -- 复活
        norealive           = 24,   -- 破复活
    },

    --攻击模式
    amode = {
        qt                  = 0,     --全体攻击
        hp                  = 1,     --和平攻击
        fq                  = 2,     --夫妻攻击
        st                  = 3,     --师徒攻击
        bz                  = 4,     --编组攻击
        hh                  = 5,     --行会攻击
        hm                  = 6,     --红名攻击
        gg                  = 7,     --国家攻击
    },

    --怪物表
    stdmoninfo = {
        name                = 1,    --怪物名 （返回值字符型）
        color               = 2,    --怪物名颜色
    },

    --货币
    money = {
        gold                = 1,    --元宝
        yb                  = 2,    --玉币
        bdgold              = 3,    --金条
        bdyb                = 4,    --绑定玉币
        lf                  = 7,   --灵符
        cent                = 11,   --充值点 1rmb = 1充值点
    },

    --物品信息
    iteminfo = {
        id                  = 1,    --唯一ID
        idx                 = 2,    --物品ID
        curdura             = 3,    --剩余持久
        maxdura             = 4,    --最大持久
        overlap             = 5,    --叠加数量
        bind                = 6,    --绑定状态值
    },
    
    --物品基础信息
    stditeminfo = {
        idx                 = 0,    --0:idx
        name                = 1,    --1:名称
        stdmode             = 2,    --2:StdMode
        shape               = 3,    --3:Shape
        weight              = 4,    --4:重量
        anicount            = 5,    --5:AniCount
        maxdura             = 6,    --6:最大持久
        overlap             = 7,    --7:叠加数量
        price               = 8,    --8:价格（price）
        need                = 9,    --9:使用条件
        needlevel           = 10,   --10:使用等级
        custom25            = 11,   --11:道具表自定义常量(25列)
        custom26            = 12,   --12:道具表自定义常量（26列）
    },

    --技能
    skill = {
        level               = 1,    --技能等级
        superlevel          = 2,    --技能强化等级
        proficiency         = 3,    --熟练度
    },

    --公告
    notice = {
        own                 = 1,    --发送给自己
        all                 = 2,    --发送给全服
        guild               = 3,    --发送给行会
        map                 = 4,    --发送给地图
        team                = 5,    --发送给组队
    },

    --隐藏穿戴物品
    unseen_equip = {
        attr = {    --隐藏属性
            rule = 63,                  --隐藏装备绑定规则
            idx = 50000,               --隐藏装备Idx
            where = 100,                --穿戴位置
        },
    },
    
    --获取沙巴克信息返回值
    castle = {
        info = {        --castleinfo
            name            = 1,         --沙城名称
            guildname       = 2,         --沙城行会名称
            guildmgr        = 3,         --沙城城主
            day             = 4,         --占领天数，返回number
            state           = 5,         --当前是否在攻沙状态，返回Bool
            guilddeputy     = 6,         --沙城多个副城主 (返回类型table)
        },
        identity = {    --castleidentity
            no              = 0,        --非沙巴克成员
            yes             = 1,        --沙巴克成员
            boos            = 2,        --沙巴克老大
        }
    },

    --stdmode 与 where 的映射关系
    stdmodewheremap = {
        [10]        = {0},        --衣服(男)
        [11]        = {0},        --衣服(女)
        [5]         = {1},        --武器(男)
        [6]         = {1},        --武器(女)
        [30]        = {2},        --勋章
        [19]        = {3},        --项链
        [20]        = {3},        --项链
        [21]        = {3},        --项链
        [15]        = {4},        --头盔
        [24]        = {5, 6},     --手镯
        [26]        = {5, 6},     --手镯
        [22]        = {7, 8},     --戒指
        [23]        = {7, 8},     --戒指
        [25]        = {9},        --符、毒药
        [54]        = {10},       --腰带
        [64]        = {10},       --腰带
        [52]        = {11},       --靴子
        [62]        = {11},       --靴子
        [53]        = {12},       --宝石、魔血石
        [63]        = {12},       --宝石、魔血石
        [7]         = {12},       --宝石、魔血石
        [16]        = {13},       --斗笠
        [65]        = {14},       --军鼓
        [28]        = {15},       --马牌
        [48]        = {16},       --盾牌
        [50]        = {55},       --面巾

        [66]        = {17},       --时装衣服(男)
        [67]        = {17},       --时装衣服(男)
        [68]        = {18},       --时装衣服(女)
        [69]        = {18},       --时装衣服(女)
        [71]        = {19},       --时装斗笠
        [75]        = {20},       --时装项链
        [76]        = {20},       --时装项链
        [77]        = {20},       --时装项链
        [78]        = {21},       --时装头盔
        [79]        = {22, 23},   --时装手镯
        [80]        = {22, 23},   --时装手镯
        [81]        = {24, 25},   --时装戒指
        [82]        = {24, 25},   --时装戒指
        [83]        = {26},       --时装勋章
        [84]        = {27},       --时装腰带
        [85]        = {27},       --时装腰带
        [86]        = {28},       --时装靴子
        [87]        = {28},       --时装靴子
        [88]        = {29},       --时装宝石
        [89]        = {29},       --时装宝石

        [100]       = {30},       --首饰盒位置1
        [101]       = {31},       --首饰盒位置2
        [102]       = {32},       --首饰盒位置3
        [103]       = {33},       --首饰盒位置4
        [104]       = {34},       --首饰盒位置5
        [105]       = {35},       --首饰盒位置6
        [106]       = {36},       --首饰盒位置7
        [107]       = {37},       --首饰盒位置8
        [108]       = {38},       --首饰盒位置9
        [109]       = {39},       --首饰盒位置10
        [110]       = {40},       --首饰盒位置11
        [111]       = {41},       --首饰盒位置12

        [90]        = {42},       --时装马牌
        [91]        = {43},       --时装符印
        [92]        = {44},       --时装军鼓
        [93]        = {45},       --时装盾牌
        [94]        = {46},       --时装面巾

        --自定义装备位
        [10001]     = {71},       --无双装备
        [10002]     = {72},       --无双装备
        [10003]     = {73},       --无双装备
        [10004]     = {74},       --无双装备
        [10005]     = {75},       --无双装备
        [10006]     = {76},       --无双装备
        [10007]     = {77},       --无双装备
        [10008]     = {78},       --无双装备
        [10009]     = {79},       --无双装备
        [10010]     = {80},       --无双装备
        [10011]     = {81},       --无双装备

        [10021]     = {82},       --官职装备
        [10022]     = {83},       --官职装备
        [10023]     = {84},       --官职装备
        [10024]     = {85},       --官职装备
        [10025]     = {86},       --官职装备
        [10026]     = {87},       --官职装备
        [10027]     = {88},       --官职装备
        [10028]     = {89},       --官职装备

        [10031]     = {90},       --侍女装备
        [10032]     = {91},       --侍女装备
        [10033]     = {92},       --侍女装备
        [10034]     = {93},       --侍女装备
        [10035]     = {94},       --侍女装备
    },

    activitystate = {
        closing         = 0,        --关闭中
        opening         = 1,        --进行中
        ended           = 2,        --已结束
    },

    flag = {
        no                  = 0,
        yes                 = 1,
    },

    first_login_addskill = {
        --初次登陆给予的技能id
        25,                 --半月弯刀
        7,                  --攻杀剑术
        12,                 --刺杀剑术
        27,                 --野蛮冲撞
        26,                 --烈火剑法
        25,                 --半月弯刀
    },

    binding                 = 354,              --绑定物品规则
    daysec                  = 86400,            --一天的秒数
    attrtime                = 123456789,        --附加属性时间
    bagcellnum              = 86,              --固定背包有120个格子
    warehousecellnum        = 216,              --仓库开启格子数量
    -- pickuptime              = 1000,             --物品掉落只有自己可捡取时间

    DEBUG                   = true,             --调试模式

    --- @field [parent=#Constant] #table CHINA_NUM 中文数字
    CHINA_NUM = {
        [0] = "零",
        "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
        "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
        "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十",
        "三十一", "三十二", "三十三", "三十四", "三十五", "三十六", "三十七", "三十八", "三十九", "四十",
        "四十一", "四十二", "四十三", "四十四", "四十五", "四十六", "四十七", "四十八", "四十九", "五十",
        "五十一", "五十二", "五十三", "五十四", "五十五", "五十六", "五十七", "五十八", "五十九", "六十",
        "六十一", "六十二", "六十三", "六十四", "六十五", "六十六", "六十七", "六十八", "六十九", "七十",
    },
    --- @field [parent=#Constant] #table WARN_MSG_TB 警告信息表
    WARN_MSG_TB={
        Msg="",
        FColor=nil,
        BColor=nil,
        Type=1,
        Time=nil,
        SendName=nil,
        SendId=nil
    },
    --- @field [parent=#Constant] #table PROGRESS_TB 警告信息表
    PROGRESS_TB = {
        open=1,
        show=1,
        name="",
        color=3,
        imgcolor=0,
        cur=0,
        max=100,
        level=0,
    },
    --- @field [parent=#Constant] #table EQUIP_POS_DIC  装备位置字典 1-道具类型	2-数据库stdmode 3-穿戴位置 4-位置常量 5-位置唯一ID常量(取下保留对应唯一ID)
    EQUIP_POS_DIC = {
        -- 道具类型	数据库stdmode	穿戴位置	位置常量	位置唯一ID常量(取下保留对应唯一ID)
        {"衣服(男)",{10},0,"<$DRESS>","<$DRESSID>"},
        {"衣服(女)",{11},0,"<$DRESS>","<$DRESSID>"},
        {"武器(男)",{5,6},1,"<$WEAPON>","<$WEAPONID>"},
        {"武器(女)",{5,6},1,"<$WEAPON>","<$WEAPONID>"},
        {"勋章",{30},2,"<$RIGHTHAND>","<$RIGHTHANDID>"},
        {"项链",{19,20,21},3,"<$NECKLACE>","<$NECKLACEID>"},
        {"头盔",{15},4,"<$HELMET>","<$HELMETID>"},
        {"右手镯",{24,26},5,"<$ARMRING_R>","<$ARMRING_RID>"},
        {"左手镯",{24,26},6,"<$ARMRING_L>","<$ARMRING_LID>"},
        {"右戒指",{22,23},7,"<$RING_R>","<$RING_RID>"},
        {"左戒指",{22,23},8,"<$RING_L>","<$RING_LID>"},
        {"符、毒药",{25},9,"<$BUJUK>","<$BUJUKID>"},
        {"腰带",{54,64},10,"<$BELT>","<$BELTID>"},
        {"靴子",{52,62},11,"<$BOOTS>","<$BOOTSID>"},
        {"宝石、血石",{53,63,7},12,"<$CHARM>","<$CHARMID>"},
        {"斗笠",{16},13,"<$HAT>","<$HATID>"},
        {"军鼓",{65},14,"<$DRUM>","<$DRUMID>"},
        {"马牌",{28},15,"<$HORSE>","<$HORSEID>"},
        {"盾牌",{48},16,"<$SHIELD>","<$SHIELDID>"},
        {"面巾",{50},55,"<$FTOWEL>","<$FTOWELID>"},
        {"时装衣服(男)",{66},17,"<$SDRESS>","<$SDRESSID>"},
        {"时装衣服(女)",{67},17,"<$SDRESS>","<$SDRESSID>"},
        {"时装武器(男)",{68},18,"<$SWEAPON>","<$SWEAPONID>"},
        {"时装武器(女)",{69},18,"<$SWEAPON>","<$SWEAPONID>"},
        {"时装斗笠",{71},19,"<$SHAT>","<$SHATID>"},
        {"时装项链",{75,76,77},20,"<$SNECKLACE>","<$SNECKLACEID>"},
        {"时装头盔",{78},21,"<$SHELMET>","<$SHELMETID>"},
        {"时装左手镯",{79,80},22,"<$SARMRING_L>","<$SARMRING_LID>"},
        {"时装右手镯",{79,80},23,"<$SARMRING_R>","<$SARMRING_RID>"},
        {"时装左戒指",{81,82},24,"<$SRING_L>","<$SRING_LID>"},
        {"时装右戒指",{81,82},25,"<$SRING_R>","<$SRING_RID>"},
        {"时装勋章",{83},26,"<$SRIGHTHAND>","<$SRIGHTHANDID>"},
        {"时装腰带",{84,85},27,"<$SBELT>","<$SBELTID>"},
        {"时装靴子",{86,87},28,"<$SBOOTS>","<$SBOOTSID>"},
        {"时装宝石",{88,89},29,"<$SCHARM>","<$SCHARMID>"},
        {"时装马牌",{90},42,"<$SHORSE>","<$SHORSEID>"},
        {"时装符印",{91},43,"<$SBUJUK>","<$SBUJUKID>"},
        {"时装军鼓",{92},44,"<$SDRUM>","<$SDRUMID>"},
        {"时装盾牌",{93},45,"<$SSHIELD>","<$SSHIELDID>"},
        {"时装面巾",{94},46,"<$SFTOWEL>","<$SFTOWELID>"},
        {"首饰盒位置1",{100},30,"<$GODBLESSITEM1>","<$GODBLESSITEM1ID>"},
        {"首饰盒位置2",{101},31,"<$GODBLESSITEM2>","<$GODBLESSITEM2ID>"},
        {"首饰盒位置3",{102},32,"<$GODBLESSITEM3>","<$GODBLESSITEM3ID>"},
        {"首饰盒位置4",{103},33,"<$GODBLESSITEM4>","<$GODBLESSITEM4ID>"},
        {"首饰盒位置5",{104},34,"<$GODBLESSITEM5>","<$GODBLESSITEM5ID>"},
        {"首饰盒位置6",{105},35,"<$GODBLESSITEM6>","<$GODBLESSITEM6ID>"},
        {"首饰盒位置7",{106},36,"<$GODBLESSITEM7>","<$GODBLESSITEM7ID>"},
        {"首饰盒位置8",{107},37,"<$GODBLESSITEM8>","<$GODBLESSITEM8ID>"},
        {"首饰盒位置9",{108},38,"<$GODBLESSITEM9>","<$GODBLESSITEM9ID>"},
        {"首饰盒位置10",{109},39,"<$GODBLESSITEM10>","<$GODBLESSITEM10ID>"},
        {"首饰盒位置11",{110},40,"<$GODBLESSITEM11>","<$GODBLESSITEM11ID>"},
        {"首饰盒位置12",{111},41,"<$GODBLESSITEM12>","<$GODBLESSITEM12ID>"},
    },
}

return ConstCfg