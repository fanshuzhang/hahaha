local ssrResponseCfg = {
    yes                                         = 0,
    no                                          = 1,

    type9                                       = 9,

    not_level                                   = 100,      --�ȼ�����
    not_level2                                  = 101,      --�ȼ�����%d
    not_item                                    = 102,      --%s����
    not_money                                   = 103,      --���Ҳ���
    not_bag_num                                 = 104,      --�����ռ䲻��
    unmet                                       = 105,      --δ������ȡ����
    repeat_receive                              = 106,      --�ظ���ȡ
    not_open                                    = 107,      --xxδ����
    repeat_buy                                  = 108,      --�ظ�����

    not_open_activity                           = 138,      --�δ����

    --����
    not_tishi_item                             =20001,--��ʾ
    cuttitle                                    =20002,
    full_level                                  =20003
}

local Chinese = {
    [ssrResponseCfg.not_level]                  = '{"Msg":"<font color=\'#ff0000\'>�ȼ�����</font>","Type":9}',
    [ssrResponseCfg.not_level2]                 = '{"Msg":"<font color=\'#ff0000\'>�ȼ�����%d</font>","Type":9}',
    [ssrResponseCfg.not_item]                   = '{"Msg":"<font color=\'#ff0000\'>%s����</font>","Type":9}',
    [ssrResponseCfg.not_tishi_item]             = '{"Msg":"<font color=\'#00FF00\'>����ʾ��</font><font color=\'#ff0000\'>���%s����</font>","Type":9}',
    [ssrResponseCfg.not_money]                  = '{"Msg":"<font color=\'#ff0000\'>���Ҳ���</font>","Type":9}',
    [ssrResponseCfg.not_bag_num]                = '{"Msg":"<font color=\'#ff0000\'>�����������㣬��������</font>","Type":9}',
    [ssrResponseCfg.unmet]                      = '{"Msg":"<font color=\'#ff0000\'>δ������ȡ����</font>","Type":9}',
    [ssrResponseCfg.repeat_receive]             = '{"Msg":"<font color=\'#ff0000\'>������ȡ����Ʒ</font>","Type":9}',
    [ssrResponseCfg.not_open]                   = '{"Msg":"<font color=\'#ff0000\'>%sδ����</font>","Type":9}',
    [ssrResponseCfg.repeat_buy]                 = '{"Msg":"<font color=\'#ff0000\'>�ѹ������Ʒ</font>","Type":9}',
    [ssrResponseCfg.not_open_activity]          = '{"Msg":"<font color=\'#ff0000\'>�δ����</font>","Type":9}',
    [ssrResponseCfg.full_level]                 = '{"Msg":"<font color=\'#FFFF00\'>�Ѿ��ﵽ���ȼ���</font>","Type":9}',

    --������ȡ
    [ssrResponseCfg.cuttitle]                  =  '{"Msg":"<font color=\'#ff0000\'>�ѻ�ȡ���ø���</font>","Type":9}'
}

function ssrResponseCfg.get(code, ...)
    return string.format(Chinese[code], ...)
end

return ssrResponseCfg