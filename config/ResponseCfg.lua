local ssrResponseCfg = {
    yes                                         = 0,
    no                                          = 1,

    type9                                       = 9,

    not_level                                   = 100,      --等级不足
    not_level2                                  = 101,      --等级不足%d
    not_item                                    = 102,      --%s不足
    not_money                                   = 103,      --货币不足
    not_bag_num                                 = 104,      --背包空间不足
    unmet                                       = 105,      --未满足领取条件
    repeat_receive                              = 106,      --重复领取
    not_open                                    = 107,      --xx未开启
    repeat_buy                                  = 108,      --重复购买

    not_open_activity                           = 138,      --活动未开启

    --新增
    not_tishi_item                             =20001,--提示
    cuttitle                                    =20002,
    full_level                                  =20003
}

local Chinese = {
    [ssrResponseCfg.not_level]                  = '{"Msg":"<font color=\'#ff0000\'>等级不足</font>","Type":9}',
    [ssrResponseCfg.not_level2]                 = '{"Msg":"<font color=\'#ff0000\'>等级不足%d</font>","Type":9}',
    [ssrResponseCfg.not_item]                   = '{"Msg":"<font color=\'#ff0000\'>%s不足</font>","Type":9}',
    [ssrResponseCfg.not_tishi_item]             = '{"Msg":"<font color=\'#00FF00\'>【提示】</font><font color=\'#ff0000\'>你的%s不足</font>","Type":9}',
    [ssrResponseCfg.not_money]                  = '{"Msg":"<font color=\'#ff0000\'>货币不足</font>","Type":9}',
    [ssrResponseCfg.not_bag_num]                = '{"Msg":"<font color=\'#ff0000\'>背包容量不足，请清理背包</font>","Type":9}',
    [ssrResponseCfg.unmet]                      = '{"Msg":"<font color=\'#ff0000\'>未满足领取条件</font>","Type":9}',
    [ssrResponseCfg.repeat_receive]             = '{"Msg":"<font color=\'#ff0000\'>您已领取过奖品</font>","Type":9}',
    [ssrResponseCfg.not_open]                   = '{"Msg":"<font color=\'#ff0000\'>%s未开启</font>","Type":9}',
    [ssrResponseCfg.repeat_buy]                 = '{"Msg":"<font color=\'#ff0000\'>已购买该物品</font>","Type":9}',
    [ssrResponseCfg.not_open_activity]          = '{"Msg":"<font color=\'#ff0000\'>活动未开启</font>","Type":9}',
    [ssrResponseCfg.full_level]                 = '{"Msg":"<font color=\'#FFFF00\'>已经达到最大等级！</font>","Type":9}',

    --福利领取
    [ssrResponseCfg.cuttitle]                  =  '{"Msg":"<font color=\'#ff0000\'>已获取过该福利</font>","Type":9}'
}

function ssrResponseCfg.get(code, ...)
    return string.format(Chinese[code], ...)
end

return ssrResponseCfg