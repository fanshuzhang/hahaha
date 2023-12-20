module("lualib", package.seeall)
--[[
    package.seeall: ����һ��ģ�����������η��������� Lua �ڵ����ģ��ʱ������ţ������ͺ�����ȫ��������ȫ�ֻ����С�����ζ�������� Lua �ļ��е��������ģ��󣬿���ֱ�ӷ��ʸ�ģ���е����б����ͺ�����������Ҫʹ��ģ������ǰ׺��
]]
-- lualib={}
local TSGMName = "������" -- ��ʱEX�ӿ�ʹ�ã�������������Ч
--˲�����ú���
local function load_mainex_system(player, func)
    lualib:GoTo(player, func)
    return
end
--���޲�������
local function unpack(t, i, n)
    i = i or 1
    n = n or #t
    if i <= n then
        return t[i], unpack(t, i + 1, n)
    end
end

function lualib:Parsetext(player, text)
    parsetext(text, player)
end

--��ʱ�ص�����
function lualib:DelayCall(player, time, func) --��ʱʱ�� Ŀ¼:������,���� ����λ��Ĭ��QuestDiary 1:MapQuest_def 2:Market_def
    local split = strsplit(func, ":")
    local file, func = split[1], split[2]
    include("QuestDiary/" .. file .. ".lua")
    delaygoto(player, time, func)
    return true
end

--��ʱ�ص�����
function lualib:GoToEx(player, time, func)
    delaygoto(player, time, func)
    return true
end

--��ʱ�ص���������˲��
function lualib:GoToExs(player, time, func)
    delaygoto(player, time, "load_mainex_system," .. func)
    return true
end

--˲��
function lualib:GoTo(player, func)
    -- assert(player, "player ����Ϊ����")
    local split = strsplit(func, ":")
    local file, func = split[1], split[2]
    local tbs = strsplit(func, ",")
    func = tbs[1]
    include("QuestDiary/" .. file .. ".lua")
    local split = strsplit(file, "/")
    local _, form = split[1], split[2]
    if form ~= nil and form ~= "" then
        table.remove(tbs, 1)
        if _G[form] == nil then
            _G["lualib"][func](player, unpack(tbs))
        else
            _G[form][func](player, unpack(tbs))
        end
    else
        _G["lualib"][func](player, unpack(tbs))
    end
    return true
end

--�Զ�������
function lualib:GetRank(var, playflag, sortflag, count, param) --������   0-������� 1-������� 2-�л�   0-����1-����   ��ȡ��������Ϊ�ջ�0ȡ���У�ȡǰ���� �Ƿ������
    local tb = {}
    if param == nil then
        tb = sorthumvar("_Int" .. var, playflag, sortflag, count)
    else
        tb = sorthumvar(var, playflag, sortflag, count)
    end
    local tbs = {}
    if not tb then
        for i = 1, count do
            tbs[i] = { '', '' }
        end
        return tbs
    end
    local a = 1
    for i = 1, count * 2, 2 do
        if tb[i] ~= nil then
            tbs[a] = { tb[i], tb[i + 1] }
        else
            tbs[a] = { "", "" }
        end
        a = a + 1
    end
    return tbs
end

---��ȡ��Ʒ����
---@param player userdata ���
---@param name string ��Ʒ����
---@param bool boolean �Ƿ��ȡ������Ʒ
function lualib:ItemCount(player, name, bool) --��Ʒ���� bool==nil ��ȡȫ�� bool==true ��ȡ���� bool==false ��ȡ����
    local num = 0
    if bool then
        num = lualib:ItemCountPlayer(player, name)
    else
        num = lualib:ItemCountBag(player, name)
    end
    return num
end

--��ȡ������Ʒ����
function lualib:ItemCountBag(player, name)
    local num = 0
    local ncount = getbaseinfo(player, 34)
    for i = 0, ncount - 1 do
        local item = getiteminfobyindex(player, i)
        local id = getiteminfo(player, item, 2)
        local mz = getstditeminfo(id, 1)
        if mz == name then
            local sl = getiteminfo(player, item, 5)
            if sl == 0 then
                sl = 1
            end
            num = num + sl
        end
    end
    return num
end

--��ȡ������Ʒ����
function lualib:ItemCountPlayer(player, name)
    local num = 0
    for i = 1, 100 do
        local item = linkbodyitem(player, i)
        local id = getiteminfo(player, item, 2)
        local mz = getstditeminfo(id, 1)
        if mz == name then
            num = num + 1
        end
    end
    return num
end

---��ȡ���ϵ�װ��
---@param player userdata ���
---@return table װ���б�
function lualib:GetEquipList(player)
    local tb = {}
    -- ����װ��
    for i = 1, 41 do
        local equip = lualib:LinkBodyItem(player, i)
        if equip ~= "" and equip ~= nil and equip ~= "0" then
            table.insert(tb, equip)
        end
    end
    -- �Զ���װ��
    for i = 71, 120 do
        local equip = lualib:LinkBodyItem(player, i)
        if equip ~= "" and equip ~= nil and equip ~= "0" then
            table.insert(tb, equip)
        end
    end
    return tb
end

---��ȡ������Ʒ�б�
---@param player userdata ���
---@return table ������Ʒ�б�
function lualib:GetBagList(player)
    local tb = {}
    local ncount = getbaseinfo(player, 34)
    for i = 0, ncount - 1 do
        local item = getiteminfobyindex(player, i)
        if item ~= "" and item ~= nil and item ~= "0" then
            table.insert(tb, item)
        end
    end
    return tb
end

---�����ʼ�
---@param player userdata ���UserId����������������Ҫ��ǰ���#����:#����
---@param mailId number �Զ����ʼ�ID
---@param title string �ʼ�����
---@param text string �ʼ�����
---@param rewards string �������ݣ���Ʒ1#����#�󶨱��&��Ʒ2#����#�󶨱�ǣ�&���飬#�ָ�
---@return boolean
function lualib:SendMail(player, mailId, title, text, rewards)
    sendmail(getbaseinfo(player, 2), mailId, title, text, rewards)
    return true
end

---����������ַ����ʼ�
---@param player userdata ���UserId����������������Ҫ��ǰ���#����:#����
---@param mailId number �Զ����ʼ�ID
---@param title string �ʼ�����
---@param text string �ʼ�����
---@param rewards string �������ݣ���Ʒ1#����#�󶨱��&��Ʒ2#����#�󶨱�ǣ�&���飬#�ָ�
---@return boolean
function lualib:SendMailEx(playerName, mailId, title, text, rewards)
    sendmail("#" .. playerName, mailId, title, text, rewards)
    return true
end

---��ȡ��������Ҷ���
function lualib:GetGSPlayer()
    return getplayerlst()
end

--�������ƻ�ȡ��Ҷ���
function lualib:GetPlayerByName(name) --û�з���nil
    return getplayerbyname(name)
end

--����id��ȡ��Ҷ���
function lualib:GetPlayerById(id)
    return getplayerbyid(id)
end

--���ô���
function lualib:GotoLabel(player, info, func, range) --����ģʽ��0-С���Ա����1-�л��Ա����2-��ǰ��ͼ�����ﴥ��3-���Լ�����Ϊ����ָ����Χ���ﴥ��  ��ת��Ľӿ�(Qf.lua) ����ģʽ=3ʱָ���ķ�Χ��С
    gotolabel(player, info, func, range)
    return true
end

--��ȡ�����ʶ ��ʶ(0-9) ע�ⷵ��string����
function lualib:GetMobIndex(mob, var)
    local var = tostring(var)
    return getcurrent(mob, var)
end

--���ù����ʶ  ��ʶ(0-9) ע�ⷵ��string����
function lualib:SetMobIndex(mob, var, par)
    local var, par = tostring(var), tostring(par)
    setcurrent(mob, var, par)
    return true
end

---�ж϶����Ƿ�����
---@param player�����id
---@return boolean true:���� false:δ����
function lualib:Die(player)
    return getbaseinfo(player, 0)
end

--���ý���������
function lualib:SetItemBar(player, item, index, open, show, name, color, img, cur, max, lv) --���������0-2 open:0��1��  show:0-����ʾ��ֵ1-�ٷֱȣ�2-���� �������ı�  ��������ɫ��0~255 imgcount:1 cur:��ǰֵ max:���ֵ level:����(0~65535)
    local json_tb = {
        open = open,
        show = show,
        name = name,
        color = color,
        imgcount = img,
        cur = cur,
        max = max,
        level =
            lv
    }
    local str = cjson.encode(json_tb)
    setcustomitemprogressbar(player, item, index, str)
    refreshitem(player, item)
    return true
end

--����װ����ʶ
function lualib:SetItemIndex(player, item, int, par) --֧�֣�1-32)lua �����Ӧ(1-32)
    setitemaddvalue(player, item, 3, int, par)
    return true
end

--��ȡװ����ʶ
function lualib:GetItemIndex(player, item, int) --֧�֣�1-32)lua �����Ӧ(1-32)
    return getitemaddvalue(player, item, 3, int)
end

---֪ͨ��Ʒ���͵�ǰ��ˢ��
---@param player�����id
---@param item����Ʒid
function lualib:NotifyItem(player, item)
    refreshitem(player, item)
    return true
end

---��ȡ�����ո�������
---@param player�����id
---@return number ��ȡ�����ո�������
function lualib:GetBagFree(player) --��ȡ�����ո�������  ע�⣺�������6������Ҳ������ϣ�
    return getbagblank(player)
end

--��ʼ���л��Զ����ַ�������
function lualib:FamilyStr(family, name, param)
    if param ~= nil then
        iniguildvar(family, "string", name)
    else
        iniguildvar(family, "string", "_FamilyStr" .. name)
    end
    return true
end

--��ʼ���л��Զ�����ֵ�ͱ���
function lualib:FamilyInt(family, name, param)
    if param ~= nil then
        iniguildvar(family, "integer", name)
    else
        iniguildvar(family, "integer", "_FamilyInt" .. name)
    end
    return true
end

--��ȡȫ���Զ����ַ�����
function lualib:GetFamilyStr(family, name, param)
    lualib:FamilyStr(family, name, param)
    if param ~= nil then
        return getguildvar(family, "_FamilyStr" .. name)
    else
        return getguildvar(family, name)
    end
end

--����ȫ���Զ����ַ�����
function lualib:SetFamilyStr(family, name, par, param)
    lualib:FamilyStr(family, name, param)
    if param ~= nil then
        setguildvar(family, name, par, 1)
    else
        setguildvar(family, "_FamilyStr" .. name, par, 1)
    end
    return true
end

--��ȡ�л��Զ�����ֵ����
function lualib:GetFamilyInt(family, name, param)
    lualib:FamilyInt(family, name, param)
    if param ~= nil then
        return getguildvar(family, name)
    else
        return getguildvar(family, "_FamilyInt" .. name)
    end
end

--�����л��Զ�����ֵ����
function lualib:SetFamilyInt(family, name, par, param)
    lualib:FamilyInt(family, name, param)
    if param ~= nil then
        setguildvar(family, name, par, 1)
    else
        setguildvar(family, "_FamilyInt" .. name, par, 1)
    end
    return true
end

--�����л�ȫ���Զ������
function lualib:ClearFamily(family_name) --Ҫ������л����ƴ����ֵ��ʾ���������л�  ������, ���������|�ָ� *�������б���
    if family_name == nil then
        clearguildcustvar(" ", '*')
    else
        clearguildcustvar(family_name, '*')
    end
    return true
end

--�����л��Զ�����ֵ����
function lualib:ClearFamilyInt(family_name, str, param) --Ҫ������л����ƴ����ֵ��ʾ���������л�  ������, ���������|�ָ� *�������б���
    if param ~= nil then
        if str == nil then
            clearguildcustvar(" ", family_name)
        else
            clearguildcustvar(family_name, str)
        end
    else
        if str == nil then
            family_name = "_FamilyInt" .. family_name
            family_name = family_name:gsub("|", "|_FamilyInt")
            clearguildcustvar(" ", family_name)
        else
            str = "_FamilyInt" .. str
            str = str:gsub("|", "|_FamilyInt")
            clearguildcustvar(family_name, str)
        end
    end
    return true
end

--�����л��Զ����ַ�����
function lualib:ClearFamilyStr(family_name, str, param) --Ҫ������л����ƴ����ֵ��ʾ���������л�  ������, ���������|�ָ� *�������б���
    if param ~= nil then
        if str == nil then
            clearguildcustvar(" ", family_name)
        else
            clearguildcustvar(family_name, str)
        end
    else
        if str == nil then
            family_name = "_FamilyStr" .. family_name
            family_name = family_name:gsub("|", "|_FamilyStr")
            clearguildcustvar(" ", family_name)
        else
            str = "_FamilyStr" .. str
            str = str:gsub("|", "|_FamilyStr")
            clearguildcustvar(family_name, str)
        end
    end
    return true
end

--����ȫ���Զ������
function lualib:ClearGlobal() --������, ���������|�ָ� *�������б���
    clearglobalcustvar("*")
    return true
end

--����ȫ���Զ����ַ�����
function lualib:ClearGlobalStr(str, param) --������, ���������|�ָ� *�������б���
    if param == nil then
        str = "_DBStr" .. str
        str = str:gsub("|", "|_DBStr")
    end
    clearglobalcustvar(str)
    return true
end

--����ȫ���Զ�����ֵ����
function lualib:ClearGlobalNum(str, param) --������, ���������|�ָ� *�������б���
    if param == nil then
        str = "_DBNum" .. str
        str = str:gsub("|", "|_DBNum")
    end
    clearglobalcustvar(str)
    return true
end

--��ʼ��ȫ���Զ����ַ�������
function lualib:SystemStr(name, param)
    if param ~= nil then
        inisysvar("string", name)
    else
        inisysvar("string", "_DBStr" .. name)
    end
    return true
end

--��ʼ��ȫ���Զ�����ֵ�ͱ���
function lualib:SystemInt(name, param)
    if param ~= nil then
        inisysvar("string", name)
    else
        inisysvar("string", "_DBNum" .. name)
    end
    return true
end

--[[
��ʼ���Զ������
inisysvar

����
������	��ѡ	����	˵��
sVartype	��	string	��������(integer/string)
sVarName	��	string	������
itype	��	int	�������� Ĭ��0
0:��������
1:��������(�ั�������һ��Ϊ׼)
2:ȡ���ַ��Ͳ����ã�
3:ȡС���ַ��Ͳ����ã�
4:��ӣ��ַ��Ͳ����ã�
5:�����������Ͳ����ã�
6:ɾ��
--]]
---��ʼ���Զ������
---@param sVartype string ��������(integer/string)
---@param sVarName string ������
---@param itype number �������� Ĭ��0 0:�������� 1:��������(�ั�������һ��Ϊ׼) 2:ȡ���ַ��Ͳ����ã� 3:ȡС���ַ��Ͳ����ã� 4:��ӣ��ַ��Ͳ����ã� 5:�����������Ͳ����ã� 6:ɾ��
function lualib:InitDBVar(sVartype, sVarName, itype)
    if itype == nil then
        itype = 0
    end
    inisysvar(sVartype, sVarName, itype)
end

---��ȡȫ���Զ������
---@param sVarName string ������
function lualib:GetDBVar(sVarName)
    return getsysvarex(sVarName)
end

---����ȫ���Զ������
---@param sVarName string ������
---@param sVarValue string ����ֵ
---@param sVarType number �Ƿ񱣴浽���ݿ�,0:�����棬1������
function lualib:SetDBVar(sVarName, sVarValue, sVarType)
    if sVarType == nil then
        sVarType = 1
    end
    setsysvarex(sVarName, sVarValue, sVarType)
end

---��ʼ�������Զ����ַ�������
---@param player userdata ��Ҷ���
---@param name string ������
function lualib:PlayerStr(player, name)
    iniplayvar(player, "string", "HUMAN", name)
    return true
end

---��ʼ�������Զ�����ֵ�ͱ���
---@param player userdata ��Ҷ���
---@param name string ������
function lualib:PlayerInt(player, name, param)
    iniplayvar(player, "integer", "HUMAN", name)
    return true
end

---��ȡ�����Զ����ַ�����
---@param player userdata ��Ҷ���
---@param name string ������
function lualib:GetPlayerStr(player, name)
    lualib:PlayerStr(player, name, param)
    return getplayvar(player, "HUMAN", name)
end

---���ø����Զ����ַ�����
---@param player userdata ��Ҷ���
---@param name string ������
---@param par string ����ֵ
---@param param boolean �Ƿ񱣴浽���ݿ�,0:�����棬1������
function lualib:SetPlayerStr(player, name, par)
    lualib:PlayerStr(player, name, param)
    setplayvar(player, "HUMAN", name, par, 1)
    return true
end

---��ȡ�����Զ�����ֵ����
---@param player userdata ��Ҷ���
---@param name string ������
function lualib:GetPlayerInt(player, name)
    lualib:PlayerInt(player, name)
    return getplayvar(player, "HUMAN", name)
end

---���ø����Զ�����ֵ����
---@param player userdata ��Ҷ���
---@param name string ������
---@param par number ����ֵ
function lualib:SetPlayerInt(player, name, par)
    lualib:PlayerInt(player, name)
    setplayvar(player, "HUMAN", name, par, 1)
    return true
end

--��ȡ�����ʱ�ַ�������
function lualib:GetStr(player, name)
    return getplaydef(player, "S$" .. name)
end

--���������ʱ�ַ�������
function lualib:SetStr(player, name, par)
    setplaydef(player, "S$" .. name, par)
    return true
end

--��ȡ�����ʱ��ֵ�ͱ���
function lualib:GetInt(player, name)
    return getplaydef(player, "N$" .. name)
end

--���������ʱ��ֵ�ͱ���
function lualib:SetInt(player, name, par)
    setplaydef(player, "N$" .. name, par)
    return true
end

--��ȡ�ֱ���
function lualib:GetPx(player)
    return tonumber(parsetext("<$SCREENWIDTH>", player)), tonumber(parsetext("<$SCREENHEIGHT>", player))
end

--����������
function lualib:ServerName(player)
    return parsetext("<$SERVERNAME>", player)
end

---����Ψһidɾ����Ʒ
---@param player userdata ��Ҷ���
---@param makeIndex string ��ƷΨһID�����Ŵ���
---@param count number ��Ʒ����
function lualib:DelItemByMakeIndex(player, makeIndex, count)
    if delitembymakeindex(player, makeIndex, count) then
        return true
    else
        return false
    end
end

---����Ψһidɾ����Ʒ
---@param player userdata ��Ҷ���
---@param id string ��ƷΨһID�����Ŵ���
function lualib:DestroyItem(player, id) --��ƷΨһID�����Ŵ���
    if delitembymakeindex(player, id) then
        return true
    else
        return false
    end
end

--����ǰ������
function lualib:ShowFrom(player, form, str, par1, par2, par3)
    if par1 == nil then
        par1 = 0
    end
    if par2 == nil then
        par2 = 0
    end
    if par3 == nil then
        par3 = 0
    end
    local par = math.random(100, 1000)
    if str ~= nil then
        sendluamsg(player, par, par1, par2, par3, form .. "#" .. str)
    else
        sendluamsg(player, par, par1, par2, par3, cjson.encode(form_tb))
    end
    return true
end

--���ͽű���
function lualib:Invoke(player, func, p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF)
    if not lualib:IsPlayer(player) then return "" end
    if type(func) ~= "string" or func == "" then
        print("Invoke��������ʧ�ܣ����������ݴ���")
        return
    end
    local t = { p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF }
    local num = 0
    for i = 15, 1, -1 do
        if t[i] ~= nil then
            num = i
            break
        end
    end
    local pre_table_name = "server_unname"
    local pre_table_index = 1
    local pre_table_define = ""
    local script_param = ""
    for i = 1, num do
        local v = t[i]
        local val_type = type(v)
        local pre_param = ""
        local param = ""
        if val_type == "nil" then
            param = "nil"
        elseif val_type == "number" then
            param = tostring(v)
        elseif val_type == "string" then
            param = string.format("%q", v)
        elseif val_type == "table" then
            pre_param = "local " .. pre_table_name .. pre_table_index .. "=" .. serialize(v) .. ";"
            param = pre_table_name .. pre_table_index
            pre_table_index = pre_table_index + 1
        elseif val_type == "function" then
            print("Invoke�������ô��󣬺������Ͳ�����֧�֣�")
        else
            print("Invoke�������ô���δ֪�Ĳ������ͣ�")
        end
        if pre_param ~= "" then
            pre_table_define = pre_table_define .. pre_param
        end
        if param ~= "" then
            if script_param == "" then
                script_param = script_param .. param
            else
                script_param = script_param .. "," .. param
            end
        end
    end
    local script = pre_table_define
    script = script .. func .. "(" .. script_param .. ")"
    lualib:ShowFrom(player, "�ű���", script)
    return true
end

--����
--function lualib:MapMove(player,maps,x,y,r) --���͵�ͼ x���� y���� ��Χ
--    if maps == nil then return"" end
--    if x==nil then
--        map(player,maps)
--    else
--        mapmove(player,maps,x,y,r)
--    end
--    return true
--end
---����
---@param player void ���id
---@param str string ����
---@param confirmFunc string ȷ�Ϻ���@confirm
---@param cancelFunc string ȡ������@cancel
function lualib:MsgBox(player, str, confirmFunc, cancelFunc)
    confirmFunc = confirmFunc or ""
    cancelFunc = cancelFunc or ""
    messagebox(player, str, confirmFunc, cancelFunc)
    return true
end

---������ҵ�Ѫ��
---@param player void ���id
---@param operate void ��������'+''-''='
---@param hp void Ѫ��
---@param id void �ز�id
---@param delay void �ӳ�֧��С��
---@param hiter void �˺���Դ����
function lualib:SetHp(player, operate, hp, effid, delay, hiter)
    return humanhp(player, operate, hp, effid, delay, hiter)
end

---������ҵ�����
---@param player void ���id
---@param operate void ��������'+''-''='
---@param mp void ����
function lualib:SetMp(player, operate, mp)
    return humanmp(player, operate, mp)
end

---������ҵ�Ѫ���ٷֱ�
---@param player void ���id
---@param operate void ��������'+''-''='
---@param percent void Ѫ���ٷֱ�
function lualib:SetHpEx(player, operate, percent)
    callscriptex(player, "AddhpPer", operate, percent)
end

---������ҵ������ٷֱ�
---@param player void ���id
---@param operate void ��������'+''-''='
---@param percent void �����ٷֱ�
function lualib:SetMpEx(player, operate, percent)
    callscriptex(player, "AddmpPer", operate, percent)
end

---��ȡ����ֵ�ٷֱ�
---@param player void ���id
function lualib:HpEx(player)
    return math.ceil((lualib:Hp(player, false) / lualib:Hp(player, true)) * 100)
end

---��ȡħ��ֵ�ٷֱ�
---@param player void ���id
function lualib:MpEx(player)
    return math.ceil((lualib:Mp(player, false) / lualib:Mp(player, true)) * 100)
end

---�Ƿ��ڰ�ȫ��
---@param player void ���id
function lualib:IsSafeArea(player)
    return getbaseinfo(player, 48)
end

---������Ϸ�ٶ�
---@param player void ���id
---@param par void �ٶ�����'1-�ƶ��ٶ�2-�����ٶ�3-ʩ���ٶ�'
---@param var void �ٶȵȼ�'-10-10'
function lualib:ChangeSpeed(player, par, var)
    changespeed(player, par, var)
    return true
end

---��Ӽ���
---@param player void ���id
---@param skill void ����id
---@param lv void ���ܵȼ�
function lualib:AddSkill(player, skill, lv)
    if getskillinfo(player, skill, 1) then
        Message:Msg9(player, "��ѧϰ�ü��ܣ�")
        return
    end
    addskill(player, skill, lv)

    GameEvent.push(EventCfg.onAddSkill, player, skill, lv)
end

---ɾ������
---@param player void ���id
---@param skill void ����id
function lualib:DelSkill(player, skill)
    delskill(player, skill)
    GameEvent.push(EventCfg.onDelSkill, player, skill)
end

---���ü��ܵȼ�
---@param player void ���id
---@param skillid void ����id
---@param flag void ���� 1-���ܵȼ� 2-ǿ���ȼ� 3-������
---@param point void �ȼ������
function lualib:SetSkillInfo(player, skillid, flag, point)
    setskillinfo(player, skillid, flag, point)
    GameEvent.push(EventCfg.onSetSkillInfo, player, skillid, flag, point)
end

---��ȡ������ĳ��Ʒ����
---@param player void ���id
---@param itemName void ��Ʒ����
---@return number ��Ʒ����
function lualib:GetBagItemCount(player, itemName)
    return getbagitemcount(player, itemName)
end

---�����Ʒ
---@param player void ���id
---@param item_n void ��Ʒ����
---@param item_m void ��Ʒ����
---@param item_b void ��Ʒ����
---@param desc void ��Ʒ����
function lualib:AddItem(player, item_n, item_m, item_b, desc) --��������  �������� ���߹��� (���һ����Ʒ����)��������ʹ���ڵ�����Ʒ��һ���Ը������Ʒ�����������Ʒ����ӱ���������ע����ܱ����յ����
    item_b = item_b or 0
    local item = giveitem(player, item_n, item_m, item_b)
    if desc then
        logact(player, 10001, table.concat({ desc, "��", item_n, " * ", item_m }))
    else
        logact(player, 10001, table.concat({ "���ģ�", item_n, " * ", item_m }))
    end
    return item
end

---�Ƿ�ӵ����Ʒ
---@param player void ���id
---@param item_n void ��Ʒ����
function lualib:HasItem(player, item)
    return hasitem(player, item)
end

---���װ����װ��
---@param player void ���id
---@param where void װ��λ��
---@param item_n void ��Ʒ����
---@param item_b void ��Ʒ���� ��Ϊ��
function lualib:AddAndEquipItem(player, where, itemName, item_b)
    if item_b == nil then
        item_b = 0
    end
    return giveonitem(player, where, itemName, 1, item_b)
end

---ɾ����Ʒ
---@param player void ���id
---@param item_n void ��Ʒ����
---@param item_m void ��Ʒ����
---@param item_j void �Ƿ���Լ�Ʒ
---@param desc void ��Ʒ����
function lualib:DelItem(player, item_n, item_m, item_j, desc, logId) --���� ���� ���Լ�Ʒ��0��1�ǣ�
    item_j = item_j or 0
    logId = logId or 10002
    if item_m == 0 then
        return true
    end
    if takeitem(player, item_n, item_m, item_j) then
        if desc then
            logact(player, logId, table.concat({ desc, "��", item_n, " * ", item_m }))
        else
            logact(player, logId, table.concat({ "���ģ�", item_n, " * ", item_m }))
        end
        return true
    else
        return false
    end
end

---�Ƿ��ڹ���
function lualib:IsCastle()
    return castleinfo(5)
end

---ǿ�ƹ���ģʽ
---@param player void ���id
---@param par void ����ģʽ'0-ȫ�幥��1-��ƽ����2-���޹���3-ʦͽ����4-���鹥��5-�лṥ��6-��������7-���ҹ���'
---@param time void ����ʱ��
function lualib:SetAttackMode(player, par, time)
    setattackmode(player, par, time)
    return true
end

---��ȡ����ģʽ
---@param player void ���id
---@return number ����ģʽ'0-ȫ�幥��1-��ƽ����2-���޹���3-ʦͽ����4-���鹥��5-�лṥ��6-��������7-���ҹ���'
function lualib:GetAttackMode(player)
    return getattackmode(player)
end

---��ȡ���ɳ�Ϳ����
---@param player void ���id
---@return number ɳ�Ϳ����'0-��ɳ�Ϳ˳�Ա1-ɳ�Ϳ˳�Ա2-ɳ�Ϳ��ϴ�'
function lualib:GetCastleIdentity(player)
    return castleidentity(player)
end

-- ��ֹƵ������  ��ֹ����  ��ֹ���� ��λ:��
function lualib:StopTimes(player, var, int)
    if not lualib:IsPlayer(player) then return "" end
    local begin = tonumber(GetNowTime())
    local par = lualib:GetInt(player, var .. "_cd")
    if begin - tonumber(par) < int then
        return false
    else
        lualib:SetInt(player, var .. "_cd", begin)
        return true
    end
end

---�޸�����ģʽ
---@param player void ���id
---@param idx void ģʽ1~24
---@param time void ʱ��(��)
---@param par void ����1,12-13��18��20��21�����ʣ������������ֵ
---@param pars void ����2����������ֵ
function lualib:ChangeMode(player, idx, time, par, pars) --���鿴���˵����..
    changemode(player, idx, time, par, pars)
    return true
end

---���Ӹ����˺�Ч��
---@param player void ���id
---@param x void x����
---@param y void y����
---@param r void �뾶
---@param pow void ����
---@param addtype void ��������
---@param addvalue void ��������ֵ��
---@param checkstate void ������� 0=��� 1=���� 2=��Һ͹���
---@param targettype void Ŀ������(0���=����Ŀ��;1=������;2=������)
---@param effectid number ��Чid
---@param harmNum number Ⱥ���˺�Ŀ�����
function lualib:RangeHarm(player, x, y, r, pow, addtype, addvalue, checkstate, targettype, effectid, harmNum)
    rangeharm(player, x, y, r, pow, addtype, addvalue, checkstate, targettype, effectid, harmNum)
    return true
end

---�޸��������״̬
---@param player void ���id
---@param par void ״̬id ����(0=�̶� 1=�춾 5=��� 12=���� 13= ���� ������Ч) ʱ�䣨�룩 ������ֻ����̶�����
---@param time void ����ʱ��
---@param value void ����
function lualib:MakePoison(player, param, time, value)
    makeposion(player, param, time, value)
end

-- �ⶾ
function lualib:Detox(player)
    if not lualib:IsPlayer(player) then return "" end
    callscriptex(player, "DETOXIFCATION")
    return true
end

--�޸�������ʱ����
function lualib:SetValue(player, att_id, par, time) --����id ����ֵ ����ʱ��
    if not lualib:IsPlayer(player) then return "" end
    changehumnewvalue(player, att_id, par, time)
    recalcabilitys(player)
    return true
end

--��ȡ������ʱ����
function lualib:GetValue(player, att_id)
    if not lualib:IsPlayer(player) then return "" end
    return gethumnewvalue(player, att_id)
end

--��ȡ�����Զ�������
function lualib:GetValueEx(player, att_id)
    if not lualib:IsPlayer(player) then return "" end
    recalcabilitys(player)
    return tonumber(getconst(player, "<$CUSTABIL[" .. att_id .. "]>"))
end

---������Ʒ����
---@param player void ���id
---@param item void ��Ʒid
---@param att void ����id 0.AC1.MAC2.DC3.MC4.SC5.����6.׼ȷ7.����8.�����ٶ�9.ħ�����10.������11.�����ָ�12.ħ���ָ�13.�ж��ָ�15.ɳ�Ϳ������������20.�����˺�����21.ħ���˺�����22.����Ŀ�����23.�����˺�����24.������������25.����ħ������26.����Ŀ�걬��27.�� ʥ28.ǿ ��29.�� ��30.������31.�����˺�32.�����˺� 40~44. �ű�ʹ��
function lualib:SetItemValue(player, item, att, par)
    setitemaddvalue(player, item, 1, att, par)
    return true
end

---��ȡ��Ʒ����
---@param player void ���id
---@param item void ��Ʒid
---@param att number ����id 0.AC1.MAC2.DC3.MC4.SC5.����6.׼ȷ7.����8.�����ٶ�9.ħ�����10.������11.�����ָ�12.ħ���ָ�13.�ж��ָ�15.ɳ�Ϳ������������20.�����˺�����21.ħ���˺�����22.����Ŀ�����23.�����˺�����24.������������25.����ħ������26.����Ŀ�걬��27.�� ʥ28.ǿ ��29.�� ��30.������31.�����˺�32.�����˺� 40~44. �ű�ʹ��
function lualib:GetItemValue(player, item, att)
    return getitemaddvalue(player, item, 1, att)
end

--�ù����ٱ�(ע��:�ں���Ķ����ʵ��)
function lualib:MonItem(player, par) --�������� �ɱ�����(���20��)
    monitems(player, par)
    return true
end

--�ù����ٱ�
function lualib:MonItemex(player, mob, par, time) --�������� �ɱ�����(���20��) �ӳٺ�����(Ĭ�ϲ��ӳ�)
    callscriptex(player, "MonItemsex", mob, par, time)
    return true
end

-- ��ʱ���ӹ��ﱬ��
function lualib:MobItemsList(player, mob, item) --�����Ʒʹ��|�ָ������ӱ�����Ʒ����Ҫ��KillMon������ʹ�ã���һ����Ч��
    additemtodroplist(player, mob, item)
    return true
end

--���ù��ﱬ��
function lualib:SetMobAtt(player, par, time)
    -- setbaseinfo(player,43,par)
    callscriptex(player, "KILLMONBURSTRATE", par, time)
    return true
end

--����������������
function lualib:SetPlayerPower(player, par, time)
    powerrate(player, par, time)
    return true
end

--��ȡ�ƺ��б�
function lualib:Title_Tb(player)
    return gettitlelist(player)
end

---��������
---@param player void ���id
---@param where void λ��(0-9)
---@param effType void ����Ч��(0ͼƬ���� 1��ЧID)
---@param resNameOrId void ��Чid
---@param x void X���� (Ϊ��ʱĬ��X=0)
---@param y void Y���� (Ϊ��ʱĬ��Y=0)
---@param drop void �Զ���ȫ�հ�λ��0,1(0=�� 1=����)
---@param selfsee void �Ƿ�ֻ���Լ�����(0=�����˶��ɼ� 1=�����Լ��ɼ�)
---@param posM number ����λ��(����Ĭ��Ϊ0)0=�ڽ�ɫ֮��;1=�ڽ�ɫ֮��;
function lualib:SetIcon(player, where, effType, resNameOrId, x, y, drop, selfsee, posM)
    seticon(player, where, effType, resNameOrId, x, y, drop, selfsee, posM)
    return true
end

---������Ч
---@param player void  ���id
---@param effectid number  ��Чid
---@param x number  ���������ƫ�Ƶ�X����
---@param y number  ���������ƫ�Ƶ�Y����
---@param times number  ���Ŵ���0-һֱ����
---@param behind number  ����ģʽ0-ǰ��1-����
---@param selfshow number  ���Լ��ɼ�0-����Ұ�ھ��ɼ���1-��
function lualib:PlayerEffect(player, effectid, x, y, times, behind, selfshow)
    playeffect(player, effectid, x, y, times, behind, selfshow)
    return true
end

---ɾ��������Ч
---@param player void  ���id
---@param txid number  ��Чid
function lualib:ClearPlayerEffect(player, txid)
    clearplayeffect(player, txid)
    return true
end

---��ȡpkֵ
---@param player void  ���id
function lualib:Pk(player)
    return getbaseinfo(player, 46)
end

---����pkֵ
---@param player void  ���id
---@param par void  pkֵ
function lualib:SetPk(player, par)
    setbaseinfo(player, 46, par)
    recalcabilitys(player)
end

---��ȡ��������
function lualib:GetConvertCount()
    return grobalinfo(3)
end

-- ��ȡ��ͼ��������
function lualib:GetMapMobs(map, mob, x, y, r) --��������Ϊ�� or * Ϊ������й�
    return checkrangemoncount(map, mob, x, y, r)
end

--�������
function lualib:ClearMapMob(map) --��ͼ����
    -- killmonsters(map,mob,0,false)
    callscriptex(nil, "CLEARMAPMON", map)
    return true
end

---ˢ��
---@param map void  ��ͼ����
---@param x void  x����
---@param y void  y����
---@param r void  ��Χ
---@param mob void  ��������
---@param num void  ��������
---@param color void  ����������ɫ
function lualib:GenMon(map, x, y, r, mob, num, color) --��ͼ���� x���� y���� ��Χ �������� �������� ����������ɫ
    local tb = genmon(map, x, y, mob, r, num, color)
    return tb
end

---�Զ�ʰȡ
---@param player void  ���id
---@param mode number  ģʽ��0=������Ϊ���ļ�ȡ��1=��С����Ϊ���ļ�ȡ��
---@param range number  ��Χ
---@param time number  �������С500ms
function lualib:PickupItems(player, mode, range, time)
    pickupitems(player, mode, range, time)
end

---ֹͣʰȡ
---@param player void  ���id
function lualib:StopPickupItems(player)
    stoppickupitems(player)
end

--�����л������
function lualib:AddAttackSabukAll()
    addattacksabakall()
    callscriptex(nil, "AddAttackSabukAll", 0)
    return true
end

--��ȡNPC����
function lualib:Npc(npcidx)
    getnpcbyindex(npcidx)
    return true
end

-- ��ȡ��Ʒ��Դ
function lualib:GetItemJosnLy(player, item)
    local str_tb = getthrowitemly(player, item)
    str_tb = cjson.decode(str_tb)
    return str_tb
end

-- ��ȡ��Ʒ����
function lualib:GetItemInt(player, item, var)
    return getitemaddvalue(player, item, 1, 40 + var)
end

-- ������Ʒ����
function lualib:SetItemInt(player, item, var, par)
    setitemaddvalue(player, item, 1, 40 + var, par)
    return true
end

--��ȡ΢����֤��
function lualib:WeChatKey(player, par) --1��ȡ��KEY 2��ȡ���KEY 3��ȡ��֤KEY
    callscriptex(player, "BindWeChat", par)
    return true
end

--������ں����г���
function lualib:ClearWeChat(player)
    callscriptex(player, "ClearWeChat")
    return true
end

---����������
function lualib:Star_Show(player, time, fun, str, int, funs) --������ʱ���� �ɹ����� ��ʾ��Ϣ �Ƿ���жϣ�0,1�� �жϺ���
    showprogressbardlg(player, time, fun, str, int, funs)
    return true
end

--��������
function lualib:CreateWnd(player, w, h, img) --�� �� ͼƬ
    local w, h = tonumber(w), tonumber(h)
    lualib:SetInt(player, "������", w)
    lualib:SetInt(player, "����߶�", h)
    lualib:SetInt(player, "��������", 0)
    local px1, px2 = lualib:GetPx(player)
    local msg = [[
        <Img|img=custom/bjk.png|x=-1000|y=-1000|width=9999|height=9999|link=@exit>
        <Img|x=]] ..
        ((px1 - w) / 2) ..
        [[|y=]] ..
        ((px2 - h) / 2) ..
        [[|width=]] .. w ..
        [[|height=]] .. h .. [[|scale9l=10|scale9r=10|scale9t=10|scale9b=10|esc=1|move=1|bg=1|img=]] .. img .. [[>
    ]]
    return msg, math.ceil((px1 - w) / 2), math.ceil((px2 - h) / 2)
end

---�رս���
function lualib:WndClose(player)
    close(player)
    return true
end

---������
function lualib:Kick(player)
    kick(player)
    return true
end

-- �ڿ���̨��ӡ��Ϣ
function lualib:Warn(message)
    release_print(message)
end

---�����������Ϣ
---@param player string ���id
---@param Msg string ��Ϣ����
---@return void ��
function lualib:SysWarnMsg(player, Msg) --���Ͷ���1-�Լ���
    local msgT = table.deepCopy(ConstCfg.WARN_MSG_TB, msgT)
    msgT.Msg = Msg
    local msg = tbl2json(msgT)
    sendmsg(player, 1, msg)
    return true
end

--�����������Ϣ
function lualib:SysWarn(player, Msg) --���Ͷ���1-�Լ���
    local msgT = table.deepCopy(ConstCfg.WARN_MSG_TB, msgT)
    msgT.Msg = Msg
    local msg = tbl2json(msgT)
    sendmsg(player, 1, msg)
    return true
end

-- ��ʼ���Զ������
function lualib:InitPlayerVar(player, varType, varArea, varName)
    return iniplayvar(player, varType, varArea, varName)
end

---��ʼ��int���͵��Զ������(HUMAN)
---@param player void ���id
---@param varName void ������
function lualib:InitPlayerIntHumVar(player, varName)
    return iniplayvar(player, "integer", "HUMAN", varName)
end

---��ʼ��string���͵��Զ������(HUMAN)
---@param player void ���id
---@param varName void ������
function lualib:InitPlayerStrHumVar(player, varName)
    return iniplayvar(player, "string", "HUMAN", varName)
end

---�Զ����������(HUMAN)
---@param varName void ������
---@param playerFlag void ��ұ�ʶ 0-������� 1-��ǰ��� 2-�л�
---@param sortFlag void �����ʶ 0-���� 1-����
---@param count void ����
---@return table
function lualib:SortHumanVar(varName, playerFlag, sortFlag, count)
    return sorthumvar(varName, playerFlag, sortFlag, count)
end

---ȡ�Զ������ֱ�����λ��
---@param player void ���id
---@param varName void ������
---@param playerFlag void ��ұ�ʶ 0-������� 1-��ǰ��� 2-�л�
---@param sortFlag void �����ʶ 0-���� 1-����
---@return number �������
function lualib:humanVarRank(player, varName, playFlag, sortFlag)
    return humvarrank(player, varName, playFlag, sortFlag)
end

---��������Զ������
---@param player void ���id����*Ϊ�����������
---@param varName void ������ ����*Ϊ�������б���
function lualib:ClearHumanCusVar(player, varName)
    clearhumcustvar(player, varName)
end

---��ȡ���GUID
---@param player void ���GUID
function lualib:Name2GUID(playerName)
    return getplayerbyname(playerName)
end

---�������id��ȡ���GUID
---@param playerId void ���id
function lualib:ID2GUID(playerId)
    return getplayerbyid(playerId)
end

---����������ϵ���Ч
---@param player void ���GUID
function lualib:DelEffectOfPlayer(player, magicID)
    return clearplayeffect(player, magicID)
end

---��������ϲ�����Ч
---@param player void ���GUID
function lualib:AddEffectOfPlayer(player, magicID, offsetX, offsetY, times, behind, showType)
    return playeffect(player, magicID, offsetX, offsetY, times, behind, showType)
end

---�������ӳƺ�
---@param player void ���GUID
---@param titleName void �ƺ�����
function lualib:AddTitle(player, titleName)
    return confertitle(player, titleName, 0)
end

---�������ӳƺŲ�����
---@param player void ���GUID
---@param titleName void �ƺ�����
function lualib:AddTitleEx(player, titleName)
    return confertitle(player, titleName, 1)
end

---���ɾ���ƺ�
---@param player void ���GUID
---@param titleName void �ƺ�����
function lualib:DelTitle(player, titleName)
    return deprivetitle(player, titleName)
end

---�����ʾ�ƺ�
---@param player void ���GUID
---@param titleName void �ƺ�����
function lualib:ApplyTitle(player, titleName)
    return setranklevelname(player, titleName)
end

---�����ҳƺ�
---@param player void ���GUID
---@param titleName void �ƺ�����
function lualib:HasTitle(player, titleName)
    return checktitle(player, titleName)
end

---��ȡ��һ���
---@param player string ���GUID
---@param coinId number ����id
function lualib:GetMoney(player, coinId)
    return querymoney(player, coinId)
end

---��ȡ��һ��Ҹ��ݻ�������
---@param player void ���GUID
---@param coinName string �������� �磺Ԫ��
function lualib:GetMoneyEx(player, coinName)
    local coinId = self:GetStdItemInfo(coinName, 0)
    return querymoney(player, coinId)
end

---������һ���
---@param player void ���GUID
---@param coinId void ��������
---@param opt void ������ '+ - ='
---@param count void ����
---@param desc void ����
---@param send void �Ƿ�����Ϣ
function lualib:SetMoney(player, coinId, opt, count, desc, send)
    return changemoney(player, coinId, opt, count, desc, send)
end

---������һ��Ҹ��ݻ�������
---@param player void ���GUID
---@param coinName string �������� �磺Ԫ��
---@param opt void ������ '+ - ='
---@param count void ����
---@param desc void ����
---@param send void �Ƿ�����Ϣ
---@return boolean �Ƿ�ɹ�
function lualib:SetMoneyEx(player, coinName, opt, count, desc, send)
    local coinId = self:GetStdItemInfo(coinName, 0)
    return changemoney(player, coinId, opt, count, desc, send)
end

---�����һ���
---@param player void ���GUID
---@param coinId void ��������
---@param count void ����
---@param desc void ����
function lualib:AddMoney(player, coinId, count, desc)
    return changemoney(player, coinId, "+", count, desc, true)
end

---�۳���һ���
---@param player void ���GUID
---@param coinId void ��������
---@param count void ����
---@param desc void ����
function lualib:SubMoney(player, coinId, count, desc)
    return changemoney(player, coinId, "-", count, desc, true)
end

--[[
M0-M99 �������ֱ�����100���������߲�����
D0-D99 �������ֱ�����100���������߲�����
N0-N99 �������ֱ�����100���������߲�����
U0-U254 �������ֱ�����255�������ɱ���
S0-S99 �����ַ�������100���������߲�����
T0-T254 �����ַ�������255���������߱���
֧���Զ�����ʱ����
��ʽ��1.�Զ������ֱ�������N$Ϊͷ��־��
2.�Զ����ַ���������S$Ϊͷ��־
--]]
---��ȡ����
---@param player void ���GUID �˴���playerΪnil��Ϊϵͳ����
---@param varName void ������
---@return void ����ֵ
function lualib:GetVar(player, varName)
    if player == nil or player == "0" or player == 0 then
        return getsysvar(varName)
    else
        return getplaydef(player, varName)
    end
end

---���ñ���
---@param player void ���GUID �˴���playerΪnil��Ϊϵͳ����
---@param varName void ������
---@param varValue void ����ֵ
function lualib:SetVar(player, varName, varValue)
    --���Ƹı�ְҵ
    -- if VarCfg["����ְҵ"] and varName == VarCfg["����ְҵ"] and self.GetVar(player, VarCfg["����ְҵ"]) ~= 0 then
    --     return
    -- end
    if player == nil or player == "0" or player == 0 then
        return setsysvar(varName, varValue)
    else
        setplaydef(player, varName, varValue)
        if CSDataSyncUtil then
            CSDataSyncUtil.setSyncVar(player, varName, varValue)
        end
    end
    GameEvent.push(EventCfg.onSetVar, player, varName, varValue)
end

------------------------------------------------------------------------------------------------------------------------��ͼ����
---��ҷɵ�ͼ�����
---@param player void ���GUID
---@param mapId void ��ͼId
function lualib:MapMove(player, mapId)
    return map(player, mapId)
end

---��ҷɵ�ͼָ���ص�
---@param player void ���GUID
---@param mapId void ��ͼ��id
---@param x void x����
---@param y void y����
---@param r void ��Χ
function lualib:MapMoveXY(player, mapId, x, y, r)
    if x and y then
        return mapmove(player, mapId, x, y, r)
    else
        return move(player, mapId)
    end
end

---��ȡ�ͻ�������
---@param player void ���GUID
---@return number type= 1:PC 2:�ƶ�
function lualib:GetClientType(player)
    return tonumber(getconst(player, "<$CLIENTFLAG>"))
end

---���ڻ�ȡ���children id����
---����: ����1,����2,����3
---����  lualib:GetConcatArrTbStr(3, "����", ",")
---@param count number ��Ҫ���ӵ�����
---@param prefix string ÿ��str��ǰ׺���׺Ĭ��Ϊ���
---@param cat string ���ӷ� Ĭ��Ϊ","
function lualib:GetConcatArrTbStr(count, prefix, cat)
    local tempTb = {}
    for i = 1, count do
        tempTb[i] = prefix .. i
    end
    if cat then
        return table.concat(tempTb, cat)
    else
        return table.concat(tempTb, ",")
    end
end

---���ڻ�ȡ���children id����
---����: ����1,����2,����3
---����  lualib:GetConcatArrTbStr(3, "����", ",")
---@param count number ��Ҫ���ӵ�����
---@param prefix table ÿ��str��ǰ׺���׺Ĭ��Ϊ���
---@param cat string ���ӷ� Ĭ��Ϊ","
function lualib:GetConcatArrTbStrEx(count, prefixTb, cat)
    local str = ""
    local tempTb = {}
    for i = 1, #prefixTb do
        table.insert(tempTb, self:GetConcatArrTbStr(count, prefixTb[i], cat))
    end
    return table.concat(tempTb, ",")
end

---����Ȩ�ػ�ȡһ�����Ԫ��ֵ
---����Ȩ�������ȡһ��Ԫ�ص�����
--[[
    ��ʵ��
    local weights = {
        {n="XX", weight=6},
        {n="XXX", weight=94},
    }
--]]
---����Ȩ�ر������ȡһ��Ԫ�غ�����
---@param weights��Ȩ�ر�
---@return table �������Ԫ��
function lualib:GetRndItemByWeight(weights)
    local totalWeight = 0
    for i, w in ipairs(weights) do
        totalWeight = totalWeight + w.weight
    end
    local rand = math.random() * totalWeight
    for i, w in ipairs(weights) do
        rand = rand - w.weight
        if rand <= 0 then
            return weights[i], i
        end
    end
end

---��Lua�����ʱ��Ȼ�ͻ��˿��Խ���һЩ����ļ���жϣ��������Ҳ����Ҫͬʱ���жϣ���ͻ����ǿ��޸ĵľ���΢�ſ��Ըı��������һ���������ڿͻ������������·����ҲҪͬʱ�ж�
---�������������ж��Ƿ������<,>,/,\,@�����ţ��������ֹ
---@param input�����������
function lualib:CheckInput(input)
    local pattern = "[<>/%@\\]"
    if string.find(input, pattern) then
        -- ����ָ�����ţ���ֹ����
        return false
    else
        -- ������ָ�����ţ���������
        return true
    end
end

---���·�װsendmsg
---ʵ��ʹ��ʱ��ֻ��Ҫ����player, sendTarget, msg, Type
---lualib:SendMsg(player, sendTarget, msg, Type)
---����������ѡ
---@param player void ���id
---@param sendTarget void ����Ŀ�� 1-�Լ���2-ȫ�� 3-�лᣬ4-��ǰ��ͼ 5-���
---@param msg void ��Ϣ����
---@param Type void ��Ϣ����
---@param FColor void ������ɫ
---@param BColor void ������ɫ
---@param Time void ��Ϣ��ʾʱ��
---@param SendName void ����������
---@param SendId void ������id
---@return ���޷���ֵ
function lualib:SendMsg(player, sendTarget, msg, Type, FColor, BColor, Time, SendName, SendId)
    if player == nil or player == "0" or player == 0 then return end
    local msgT = table.deepCopy(ConstCfg.WARN_MSG_TB, msgT)
    msgT.Msg = msg
    msgT.Type = Type
    msgT.FColor = FColor
    msgT.BColor = BColor
    msgT.Time = Time
    msgT.SendName = SendName or ""
    msgT.SendId = SendId
    sendmsg(player, sendTarget, tbl2json(msgT))
end

---����Ŀ���ַ������Ƿ����ָ���ַ���
---@param str void Ŀ���ַ���
---@param findStr void ָ���ַ���
---@param isCase void �Ƿ����ִ�Сд
function lualib:FindStr(str, findStr, isCase)
    local b, e
    if isCase then
        b, e = string.find(str, findStr)
    else
        b, e = string.find(string.lower(str), string.lower(findStr))
    end
    if b then return true else return false end
end

---�������
---@param player void ���id
---@param percent void ����ٷֱ�(��ѡ)
function lualib:Relive(player, percent)
    realive(player)
    local maxHp = getbaseinfo(player, 10)
    local maxMp = getbaseinfo(player, 12)
    percent = tonumber(percent) or 100
    percent = math.floor(percent)
    if percent < 0 or percent > 100 then
        percent = 100
    end
    humanhp(player, '=', tonumber(maxHp * percent / 100), 1, 0, player)
    humanmp(player, '=', tonumber(maxMp * percent / 100), 1)
end

---��ȡ��ƷList���չʾ�ؼ�str
---@param list void ��Ʒ�б�
---@param prefix void �ؼ�ǰ׺
---@param beginX void ��ʼX����
---@param beginY void ��ʼY����
---@param lWidth void �ؼ����
---@param lHeight void �ؼ��߶�
---@param margin void �ؼ���� table���ͣ�{30, 30}
---@param scale void �ؼ����ű���
---@param column void ����
---@param centerFlag void �Ƿ������ʾ nil�򲻾��У����������
---@return ��ƴ�����list�ַ���
function lualib:GetListItemShowStr(list, prefix, beginX, beginY, lWidth, lHeight, margin, scale, column, centerFlag,
                                   bkData, magicData)
    local str = ""
    local pw, ph = math.floor(56 * scale), math.floor(56 * scale)
    local marginW, marginH = margin[1], margin[2]
    local tc = #list
    if column then
        -- ��list����һ���б���ÿ����column��Ԫ�أ�����Ϊrow��
        local tempList, tempRow = {}, {}
        for i = 1, tc do
            if i % column == 0 then
                table.insert(tempRow, list[i])
                table.insert(tempList, tempRow)
                tempRow = {}
            else
                table.insert(tempRow, list[i])
            end
        end
        if #tempRow > 0 then
            table.insert(tempList, tempRow)
        end
        if centerFlag ~= nil then
            local usew = pw * column + marginW * (column - 1)
            beginX = beginX + (lWidth - usew) / 2
        end
        str = str ..
            "<ListView|id=" ..
            prefix ..
            "|children={" ..
            self:GetConcatArrTbStr(#tempList, prefix .. "��", ",") ..
            "}|x=" ..
            (beginX) ..
            "|y=" ..
            beginY ..
            "|width=" ..
            lWidth ..
            "|height=" .. lHeight .. "|cantouch=0|rotate=0|bounce=0|direction=1|margin=" .. marginH ..
            "|reload=0|loadDelay=4>"
        for i = 1, #tempList do
            local tempRow = tempList[i]
            local childrenStr = ""
            if bkData then
                childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "����ͼ" .. i, ",") .. ","
            end
            if magicData then
                childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "��Ч" .. i, ",") .. ","
            end
            childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "��Ʒչʾ" .. i, ",") .. ","

            str = str ..
                "<Layout|id=" .. prefix .. "��" .. i .. "|children={" .. childrenStr ..
                "}|width=" .. lWidth .. "|height=" .. ph .. ">"
            for j = 1, #tempRow do
                local item = tempRow[j]
                local itemId = getstditeminfo(item[1], 0)
                local itemNum = item[2]
                local posX = (j - 1) * (pw + marginW)
                if bkData then
                    str = str ..
                        "<Img|id=" ..
                        prefix ..
                        "����ͼ" ..
                        i ..
                        j ..
                        "|x=" ..
                        (posX + bkData.x) ..
                        "||y=" ..
                        bkData.y .. "|width=" .. bkData.w .. "|height=" .. bkData.h .. "|img=" .. bkData.img .. ">"
                end
                str = str ..
                    "<ItemShow|id=" ..
                    prefix ..
                    "��Ʒչʾ" ..
                    i .. j .. "|x=" .. (posX) ..
                    "|y=0|bgtype=0|itemcount=" .. itemNum .. "|itemid=" .. itemId .. "|scale=" .. scale .. ">"
                if magicData then
                    str = str ..
                        "<Effect|id=" ..
                        prefix ..
                        "��Ч" ..
                        i ..
                        j ..
                        "|x=" ..
                        (posX + magicData.x) ..
                        "|y=" .. magicData.y .. "|effectid=" .. magicData.id .. "|effecttype=0|scale=" ..
                        magicData.scale .. ">"
                end
            end
        end
    else
        if centerFlag ~= nil then
            local usew = pw * tc + marginW * (tc - 1)
            beginX = beginX + (lWidth - usew) / 2
        end
        str = str ..
            "<ListView|id=" ..
            prefix ..
            "|children={" ..
            self:GetConcatArrTbStr(#list, prefix, ",") ..
            "}|x=" ..
            (beginX) ..
            "|y=" ..
            beginY ..
            "|width=" ..
            lWidth ..
            "|height=" .. lHeight .. "|cantouch=0|rotate=0|bounce=0|direction=2|margin=" .. marginW ..
            "|reload=0|loadDelay=4>"
        for i = 1, tc do
            local item = list[i]
            itemId = getstditeminfo(item[1], 0)
            local itemNum = item[2]
            str = str ..
                "<Layout|id=" ..
                prefix ..
                i ..
                "|children={" ..
                prefix .. "����ͼ" .. i .. "," .. prefix .. "��Ч" ..
                i .. "," .. prefix .. "��Ʒ��" .. i .. "}|width=" .. pw .. "|height=" .. ph .. ">"
            if bkData then
                str = str ..
                    "<Img|id=" ..
                    prefix ..
                    "����ͼ" ..
                    i ..
                    "|x=" .. bkData.x .. "|y=" ..
                    bkData.y .. "|width=" .. bkData.w .. "|height=" .. bkData.h .. "|img=" .. bkData.img .. ">"
            end
            if magicData then
                str = str ..
                    "<Effect|id=" ..
                    prefix ..
                    "��Ч" ..
                    i ..
                    "|x=" ..
                    magicData.x ..
                    "|y=" ..
                    magicData.y .. "|effectid=" .. magicData.id .. "|effecttype=0|scale=" .. magicData.scale .. ">"
            end
            str = str ..
                "<ItemShow|id=" ..
                prefix ..
                "��Ʒ��" .. i .. "|bgtype=0|itemcount=" .. itemNum .. "|itemid=" .. itemId .. "|scale=" .. scale ..
                ">"
        end
    end
    return str
end

---��ȡ��ǰ��ͼ����
---@param obj void ���id,����id
---@return ����ͼ����
function lualib:GetMapId(obj)
    return getbaseinfo(obj, 3)
end

---��ȡ��ǰ��ͼ����
---@param obj void ���id,����id
---@return ����ͼ����
function lualib:GetMapName(obj)
    return getbaseinfo(obj, 45)
end

---��ȡ��ǰ���ڵ�ͼ��X����
---@param obj void ���id,����id
---@return ��X����
function lualib:X(obj)
    return getbaseinfo(obj, 4)
end

---��ȡ��ǰ���ڵ�ͼ��Y����
---@param obj void ���id,����id
---@return ��Y����
function lualib:Y(obj)
    return getbaseinfo(obj, 5)
end

---��ȡ���������
---@param obj void ���id,����id
---@return ����������
function lualib:Name(obj)
    return getbaseinfo(obj, 1)
end

---�ж϶����Ƿ������
---@param obj void ���id,����id
---@return ��true/false
function lualib:IsPlayer(obj)
    return isplayer(obj)
end

---�ж϶����Ƿ��ǹ���
---@param obj void ���id,����id
---@return ��true/false
function lualib:IsMonster(obj)
    return ismon(obj)
end

---�ж϶����Ƿ��ǳ���
---@param obj void ���id,����id
---@return ��true/false
function lualib:IsPet(obj)
    return ismob(obj)
end

---�ж϶����Ƿ��Ǽ���
---@param obj void ���id,����id
---@return ��true/false
function lualib:IsDummy(obj)
    return callcheckscriptex(obj, "IsDummy")
end

---��ȡ�����userid
---@param obj void ���id,����id
---@return ��userid
function lualib:UserId(obj)
    return getbaseinfo(obj, 2)
end

---��ȡ����ĵȼ�
---@param obj void ���id,����id
---@return ���ȼ�
function lualib:Level(obj)
    return getbaseinfo(obj, 6)
end

---���ö���ĵȼ�
---@param player void ���id,����id
---@param level void �ȼ�
function lualib:SetLevel(player, level)
    setbaseinfo(player, 6, level)
    recalcabilitys(player)
end

---��ȡ�����ְҵ
---@param obj void ���id,����id
---@return ��ְҵ 0ս 1�� 2��
function lualib:Job(obj)
    return getbaseinfo(obj, 7)
end

---���ö����ְҵ
---@param obj void ���id,����id
---@param job void ְҵ 0ս 1�� 2��
function lualib:SetJob(player, job)
    setbaseinfo(player, 7, job)
    recalcabilitys(player)
end

---��ȡ������Ա�
---@param obj void ���id,����id
---@return ���Ա� 0�� 1Ů
function lualib:Gender(obj)
    return getbaseinfo(obj, 8)
end

---���ö�����Ա�
---@param player void ���id,����id
---@param job void �Ա� 0�� 1Ů
function lualib:SetGender(player, gender)
    setbaseinfo(player, 8, gender)
    recalcabilitys(player)
end

---��ȡ�����Ѫ��
---@param obj void ���id,����id
---@param valueType void nil ��ǰѪ�� �����nil ���Ѫ��
---@return ��Ѫ��
function lualib:Hp(obj, valueType)
    if not valueType then
        return getbaseinfo(obj, 9)
    else
        return getbaseinfo(obj, 10)
    end
end

---��ȡ�����ħ��ֵ
---@param obj void ���id,����id
---@param valueType void nil ��ǰħ��ֵ �����nil ���ħ��ֵ
---@return ��ħ��ֵ
function lualib:Mp(obj, valueType)
    if not valueType then
        return getbaseinfo(obj, 11)
    else
        return getbaseinfo(obj, 12)
    end
end

---��ȡ����ľ���ֵ
---@param obj void ���id
---@param valueType void nil ��ǰ����ֵ �����nil �����ֵ
---@return ������ֵ
function lualib:Exp(obj, valueType)
    if valueType == nil then
        return getbaseinfo(obj, 13)
    else
        return getbaseinfo(obj, 14)
    end
end

---��ȡ�����ת���ȼ�
---@param obj void ���id
---@return ��ת���ȼ�
function lualib:ReLevel(obj)
    return getbaseinfo(obj, 39)
end

---����ת��
---@param obj void ���id
---@param reLevel void ת���ȼ�
---@param toLevel void ת��������ȼ�
---@param num void ת������������
function lualib:ReLevel(player, reLevel, toLevel, num)
    renewlevel(player, reLevel, toLevel, num)
end

---���ö����ת���ȼ�
---@param player void ���id
---@param reLevel void ת���ȼ�
function lualib:SetReLevel(player, reLevel)
    self:ReLevel(player, reLevel, 0, 0)
end

---���ö����ת���ȼ�
---@param player void ���id
---@param reLevel void ת���ȼ�
function lualib:SetReLevelEX(player, reLevel)
    setbaseinfo(player, 39, reLevel)
end

---�ж��ǲ�����
---@param obj void ���id
---@return ��true/false
function lualib:IsPlayer(player)
    return getbaseinfo(player, -1)
end

---�жϵ�ǰ���������Ƿ���Ӣ��(����ʱ��̫���ˣ���������)
---@param obj void ���id,����id
---@return ��true/false
function lualib:Attack_IsPlayer(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 0)
end

---�жϵ�ǰ���������Ƿ��ǹ���(����ʱ��̫���ˣ���������)
---@param obj void ���id,����id
---@return ��true/false
function lualib:Attack_IsMonster(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 1)
end

---�жϵ�ǰ���������Ƿ���Ӣ��(����ʱ��̫���ˣ���������)
---@param obj void ���id,����id
---@return ��true/false
function lualib:Attack_IsHero(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 2)
end

---��ʱ���Կ�ʼ
---@param obj void ���id,����id
function lualib:TestBegin(player)
    printusetime(player, 1)
end

---��ʱ���Խ���
---@param obj void ���id,����id
function lualib:TestEnd(player)
    printusetime(player, 2)
end

---��ʱ���Կ�ʼ
function lualib:TestBeginEx()
    local player = lualib:GetPlayerByName(TSGMName)
    if player ~= "0" and player ~= nil and player ~= "" then
        callscriptex(player, "PRINTUSETIME", 1)
    end
end

---��ʱ���Խ���
function lualib:TestEndEx()
    local player = lualib:GetPlayerByName(TSGMName)
    if player ~= "0" and player ~= nil and player ~= "" then
        callscriptex(player, "PRINTUSETIME", 2)
    end
end

---����ַ��� (�����ֱ���б�̫���ˣ���������)
---@param weightStr void ����ַ��� ��ʽ������1#2000|����2#1000|����3#5000
function lualib:GetRandomStr(weightStr)
    -- ����|�ָ�
    local strList = string.split(weightStr, "|")
    -- ����Ȩ�ر�
    local weightList = {}
    for i = 1, #strList do
        local str = strList[i]
        local strInfo = string.split(str, "#")
        table.insert(weightList, { strInfo[1], weight = tonumber(strInfo[2]) })
    end
    -- ��ȡ������
    local result = self:GetRndItemByWeight(weightList)
    return result[1], result.weight
end

---��ȡ��Ʒ��Ϣ
---@param player number ���id
---@param item number ��Ʒ����
---@param idx number ��Ʒ����id'1-Ψһid 2-��Ʒid 3-ʣ��־� 4-���־� 5-�������� 6-��״̬ '
---@return number ����Ʒ����ֵ
function lualib:GetItemInfo(player, item, idx)
    if idx == 5 then
        return (getiteminfo(player, item, idx) == 0) and 1 or getiteminfo(player, item, idx)
    else
        return getiteminfo(player, item, idx)
    end
end

---��ȡ��Ʒ������Ϣ
---@param itemid/itemName number/string ��Ʒid/��Ʒ����
---@param idx number ��Ʒ����idx'0:idx 1:���� 2:StdMode 3:Shape 4:���� 5:AniCount 6:���־� 7:�������� 8:�۸�price�� 9:ʹ������ 10:ʹ�õȼ� 11:���߱��Զ��峣��(29��)12 void���߱��Զ��峣����30�У�'13[��ȡ��Ʒ��ɫ];
function lualib:GetStdItemInfo(itemid, idx)
    return getstditeminfo(itemid, idx)
end

---��ȡ���������Ϣ
---@param obj void ���id,����id
---@param idx void 0=�Ƿ�����(true:����״̬) 1=��ɫ�� 2=��ɫΨһID = userid 3=��ɫ��ǰ��ͼID 4=��ɫX���� 5=��ɫY���� 6=��ɫ�ȼ� 7=��ɫְҵ(0-ս 1-�� 2-���� 8=��ɫ�Ա� 9=��ɫ��ǰHP 10=��ɫ��ǰMAXHP 11=��ɫ��ǰMP 12=��ɫ��ǰMAXMP 13=��ɫ��ǰExp 14=��ɫ��ǰMaxExp
---@param idx2 void '������Ϊ����ʱ��param3=0��ȱʡ�����ع�����ʾ������ȥ����β�������֣���'
function lualib:GetBaseInfo(obj, idx, idx2)
    return getbaseinfo(obj, idx, idx2)
end

---���ö��������Ϣ
---@param obj void ���id,����id
---@param idx void 0=�Ƿ�����(true:����״̬) 1=��ɫ�� 2=��ɫΨһID = userid 3=��ɫ��ǰ��ͼID 4=��ɫX���� 5=��ɫY���� 6=��ɫ�ȼ� 7=��ɫְҵ(0-ս 1-�� 2-���� 8=��ɫ�Ա� 9=��ɫ��ǰHP 10=��ɫ��ǰMAXHP 11=��ɫ��ǰMP 12=��ɫ��ǰMAXMP 13=��ɫ��ǰExp 14=��ɫ��ǰMaxExp
---@param value void ����ֵ
function lualib:SetBaseInfo(obj, idx, value)
    setbaseinfo(obj, idx, value)
    recalcabilitys(obj)
end

---��ȡ�����������
---@param obj void ����id
function lualib:GetMobKeyName(obj)
    return getbaseinfo(obj, 1, 1)
end

---��ȡ����״̬
---@param idx number 1=ɳ�����ƣ�����string 2=ɳ���л����ƣ�����string 3=ɳ���л�᳤���֣�����string 4=ռ������������number 5=��ǰ�Ƿ��ڹ�ɳ״̬������Bool 6=ɳ���лḱ�᳤�����б�����table
function lualib:CastleInfo(idx)
    return castleinfo(idx)
end

---�ڵ�ͼ�ϲ�����Ч
---@param id number ��Ч����id
---@param mapid string ��ͼid
---@param x number x����
---@param y number y����
---@param effId number ��Чid
---@param time number ����ʱ��
---@param mode number ģʽ:(0~4��0�����˿ɼ���1�Լ��ɼ���2��ӿɼ���3�л��Ա�ɼ���4�жԿɼ�)
function lualib:MapEffect(id, mapid, x, y, effId, time, mode)
    mapeffect(id, mapid, x, y, effId, time, mode)
end

---ɾ����ͼ�ϲ��ŵ���Ч
---@param id number ��Ч����id
function lualib:RemoveMapEffect(id)
    delmapeffect(id)
end

---��ȡ��ұ�ʶ
---@param player number ���id
---@param idx number ��ʶid
---@return number ����ʶֵ
function lualib:GetFlagStatus(player, idx)
    return getflagstatus(player, idx)
end

---������ұ�ʶ
---@param player number ���id
---@param idx number ��ʶid
---@param value number ��ʶֵ
function lualib:SetFlagStatus(player, idx, value)
    setflagstatus(player, idx, value)
    if CSDataSyncUtil and CSDataSyncUtil.setSyncFlag then
        CSDataSyncUtil.setSyncFlag(player, idx, value)
    end
end

---���Զ���װ������
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@param attrindex number ����λ��(0~9��ÿ��װ�������Զ���10������
---@param bindindex number ������(0~4)
---@param bindvalue number �󶨵�ֵ
---@param group number ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@return boolean
function lualib:ChangeCustomItemAbil(play, item, attrindex, bindindex, bindvalue, group)
    return changecustomitemabil(play, item, attrindex, bindindex, bindvalue, group)
end

---�޸��Զ�������ֵ
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@param attrindex number ����λ��(0~9��ÿ��װ�������Զ���10������
---@param operate string ��������+��-��=
---@param value number ����ֵ
---@param group number ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@return void
function lualib:ChangeCustomItemValue(play, item, attrindex, operate, value, group)
    return changecustomitemvalue(play, item, attrindex, operate, value, group)
end

---���Ӻ��޸��Զ������Է�������
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@param typename string ��������(-1Ϊ���)
---@param group number ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@return void
function lualib:ChangeCustomItemText(play, item, typename, group)
    return changecustomitemtext(play, item, typename, group)
end

---���Ӻ��޸ķ���������ɫ
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@param color number ������ɫ(0~255)
---@param group number ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@return void
function lualib:ChangeCustomItemTextColor(play, item, color, group)
    return changecustomitemtextcolor(play, item, color, group)
end

---������Ʒ�Զ�������
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@param group number ���-1�������飬0~5����Ӧ���
---@return void
function lualib:ClearItemCustomAbil(play, item, group)
    return clearitemcustomabil(play, item, group)
end

---ˢ����Ʒ��Ϣ��ǰ��
---@param play string ��Ҷ���
---@param item string ��Ʒ����
---@return void
function lualib:RefreshItem(play, item)
    return refreshitem(play, item)
end

---����������ϵ�װ��
---@param play string ��Ҷ���
---@param where number װ��λ��
---@return string ������Ʒ����
function lualib:LinkBodyItem(play, where)
    return linkbodyitem(play, where)
end

---����������ϵ�װ��
---@param play string ��Ҷ���
---@param where number װ��λ��
---@return string ������Ʒ����
function lualib:GetEquipItem(play, where)
    return linkbodyitem(play, where)
end

---��ȡ�Զ������������
---@param play string ��Ҷ���
---@param item string װ������
---@param index number װ��������������0~2��
---@return string ���ؽ��������ݣ�json�ַ���  {open:1,  //0-�رգ�1-�� show:1,  //0-����ʾ��ֵ��1-�ٷֱȣ�2-����name:"����",  //�������ı�color:3,  //��������ɫ��0~255imgcount:0,  //0-��ѭ�����ƣ�1-ͼƬѭ������cur:0,  //��ǰֵmax:100,  //���ֵlevel:0  //����(0~65535)}
function lualib:GetCustomItemProgressBar(play, item, index)
    return getcustomitemprogressbar(play, item, index)
end

---�����Զ������������
---@param play string ��Ҷ���
---@param item string װ������
---@param index number װ��������������0~2��
function lualib:SetCustomItemProgressBar(play, item, index, json)
    return setcustomitemprogressbar(play, item, index, json)
end

---��ȡ����˺�id
---@param player string ��Ҷ���
---@return string ��������˺�id
function lualib:UserId(player)
    return self:GetBaseInfo(player, 2)
end

---�����������������������10000��1��
---@param num number ����
---@return string ������������
function lualib:NumToChinese(num)
    -- ʵ��
    local str = ""
    local numStr = tostring(num)
    local len = string.len(numStr)
    local numTable = {}
    for i = 1, len do
        local n = string.sub(numStr, i, i)
        table.insert(numTable, n)
    end
    local unit = { "", "ʮ", "��", "ǧ", "��", "ʮ��", "����", "ǧ��", "��", "ʮ��", "����", "ǧ��" }
    local num = { [0] = "��", "һ", "��", "��", "��", "��", "��", "��", "��", "��" }
    for i = 1, len do
        local n = tonumber(numTable[i])
        if n == 0 then
            if i == len then
                --str = str .. num[n]
            else
                if tonumber(numTable[i + 1]) ~= 0 then
                    str = str .. num[n]
                end
            end
        else
            str = str .. num[n] .. unit[len - i + 1]
        end
    end
    return str
end

---�����������������������10000��1��100000��10��ע�⣬�𲽸���������Ҫʵ��1��100��1000��1�ڣ�10�ڣ�
---@param num number ����
---@return string ������������
function lualib:NumToChinese2(n)
    local units = { "", "��", "��" }
    local result = ""
    local unit_index = 1

    while n > 0 do
        local part = n % 10000 -- ȡ��
        if part > 0 then
            if unit_index > 1 and part < 1000 then
                result = "" .. result
            end
            result = tostring(part) .. units[unit_index] .. result
        end
        n = math.floor(n / 10000)
        unit_index = unit_index + 1
    end

    return result
end

---������Ʒ����
---����� 1.��ֹ�� 2.��ֹ���� 3.��ֹ�� 4.��ֹ�� 5.��ֹ���� 6.��ֹ���� 7.������ʧ 8.�����ر� 9.��ֹ���� 10.��ֹ��ս
---@param ruleTb table
function lualib:CalItemRuleCount(ruleTb)
    local count = 0
    for i = 1, #ruleTb do
        if ruleTb[i] ~= 0 then
            count = count + math.pow(2, i - 1)
        end
    end
    return count
end

---������Ʒ����(ֻ��Ҫ������Ҫ�Ĺ���)
---����� 1.��ֹ�� 2.��ֹ���� 3.��ֹ�� 4.��ֹ�� 5.��ֹ���� 6.��ֹ���� 7.������ʧ 8.�����ر� 9.��ֹ���� 10.��ֹ��ս
---@param ruleTb table
function lualib:CalItemRuleCountEx(ruleTb)
    local count = 0
    for i = 1, #ruleTb do
        count = count + math.pow(2, ruleTb[i] - 1)
    end
    return count
end

---ͨ�����ֵ���Ƴ���Ʒ����
---@param count number
---@return table
function lualib:CalItemRuleTb(count)
    local ruleTb = {}
    local index = 1
    while count > 0 do
        local num = count % 2
        if num == 1 then
            table.insert(ruleTb, index)
        end
        count = math.floor(count / 2)
        index = index + 1
    end
    return ruleTb
end

---��ȡ��������ϵͳʱ���
---@return number ���ط�������ϵͳʱ���
function lualib:GetAllTime()
    return os.time()
end

---��ȡ�ַ������������x
---@param str string �ַ���
---@param width number ���
---@param font number �����С
---@return number �����ַ������������x
function lualib:GetFontCenterX(str, width, font)
    local len = string.len(str)
    local w = len * (font / 2)
    return (width - w) / 2
end

---����ͻ��˵�֧��
---����:���̨���õ�flagidΪ  1:10Ԫ������Ӧ��IDΪ2����ô����������ֵ��дflagid ����Ϊ2
---@param player string ��Ҷ���
---@param money number ���
---@param type number ��ֵ��ʽ��1-֧������2-���£�΢��
---@param flagid number ��ֵ����ID
---@return void
function lualib:Pay(player, money, type, flagid)
    return pullpay(player, money, type, flagid)
end

---���͹�����Ϣ
---@param player string ��Ҷ���
---@param type number ģʽ�����Ͷ��� 0-�Լ� 1-������ 2-�л� 3-��ǰ��ͼ 4-���
---@param FColor number ���徰ɫ
---@param BColor number ����ɫ
---@param Y number Y����
---@param scroll number ��������
---@param msg string ��Ϣ����
function lualib:SendMoveMsg(player, type, FColor, BColor, Y, scroll, msg)
    return sendmovemsg(player, type, FColor, BColor, Y, scroll, msg)
end

---������
---@param player string ��Ҷ���
function lualib:RefreshBag(player)
    refreshbag(player)
end

---֪ͨ�ͻ��˴򿪽���     --lualib:ShowFormWithContent(player, "npc/װ������", { "��ã��ͻ��ˣ����Ƿ���˵�װ������", {"������"} })
---@param player string ��Ҷ���
---@param methodStr string ������
---@param content string ����
function lualib:ShowFormWithContent(player, relativePath, contentTb, p1, p2, p3)
    contentTb = contentTb or {}
    -- contentTb��һ������1��ʼ��ÿ��Ԫ����һ������ֵ
    p1 = p1 or 0
    p2 = p2 or 0
    p3 = p3 or 0
    -- ���ͻ���Ŀ�귽���������
    contentTb.relativePath = relativePath
    Message.sendmsg(player, 730, p1, p2, p3, tbl2json(contentTb))
end

---�����Զ���ͻ���UI�ű�
---@param player string ��Ҷ���
---@param methodStr string ������
---@param content string ����
function lualib:DoClientUIMethod(player, str, ...)
    if not str then
        return
    end
    funcType = funcType or 0
    -- ���ͻ���Ŀ�귽���������
    local contentTb = {}
    contentTb.script = str
    -- ��...�еĲ����������
    contentTb.paramList = {}
    local arg = { ... }
    for i = 1, #arg do
        contentTb.paramList[i] = arg[i]
    end
    Message.sendmsg(player, 523, 0, 0, 0, tbl2json(contentTb))
end

---�����Զ���ͻ���UI�ű���չ����ָ�����õķ��������磺��.ע��Ĳ�ͬ����
---@param player string ��Ҷ���
---@param methodStr string ������
---@param funcType number �������� 0-.ע�� 1-:ע��
---@param content string ����
function lualib:DoClientUIMethodEx(player, str, funcType, ...)
    if not str then
        return
    end
    funcType = funcType or 0
    -- ���ͻ���Ŀ�귽���������
    local contentTb = {}
    contentTb.script = str
    -- ��...�еĲ����������
    contentTb.paramList = {}
    local arg = { ... }
    for i = 1, #arg do
        contentTb.paramList[i] = arg[i]
    end
    Message.sendmsg(player, 523, funcType, 0, 0, tbl2json(contentTb))
end

---�����ͻ�������
---@param player string ��Ҷ���
---@param _id string ����ID
---@param content string ��������
---@param _pid string ������ID 0-������ 1-���� 2-���� 3-���� 4-���� 5-����
---@param _dir string ��ͷ���� 1 --���� 2 --���� 3 --���� 4 --���� 5 --���� 6 --����
function lualib:GuideClient(player, _id, content, _pid, _dir)
    _pid = _pid or 0
    self:DoClientUIMethodEx(player, "CL_Guide", 1, "nil", _id, content, _pid, _dir)
end

---���ͻ���
---@param player string ��Ҷ���
---@param _pid string ������ID 0-������ 1-���� 2-���� 3-���� 4-���� 5-����
---@param _id string ����ID
---@param _x number x����
---@param _y number y����
function lualib:RedClient(player, _id, _x, _y, _pid)
    _pid = _pid or 0
    self:DoClientUIMethodEx(player, "CL_Red", 1, 0, 0, nil, _id, _x, _y, _pid)
end

---���ü�����Ϣ
---@param player string ��Ҷ���
---@param skillId number ����id
---@param skillType number �������� ���ͣ�1-���ܵȼ� 2-ǿ���ȼ� 3-������ 4-����������
---@return number ����ֵ(��Ӧ����ֵ) ,û�м��ܣ�����-1
function lualib:GetSkillInfo(player, skillId, skillType)
    local result = getskillinfo(player, skillId, skillType)
    if not result then
        return -1
    else
        return result
    end
end

---���ü�����Ϣ
---@param player string ��Ҷ���
---@param skillId number ����id
---@param skillType number �������� ���ͣ�1-���ܵȼ� 2-ǿ���ȼ� 3-������
---@param level number ���ܵȼ�
function lualib:SetSkillInfo(player, skillId, skillType, level)
    setskillinfo(player, skillId, skillType, level)
end

---�������ﱶ���ٷֱ�
---@param player string ��Ҷ���
---@param percent number �����ٷֱ�
---@param time number ����ʱ��
function lualib:SetPowerRate(player, percent, time)
    powerrate(player, percent, time)
end

---������������
---@param player string ��Ҷ���
---@param id number ����ID��1-20��1=�������� 2=�������� 3=ħ������ 4=ħ������ 5=�������� 6=�������� 7=ħ������ 8=ħ������ 9=�������� 10=�������� 11=MaxHP 12=MaxMP 13=HP�ָ� 14=MP�ָ� 15=���ָ� 16=����� 17=ħ����� 18=׼ȷ 19=���� 20= ����
---@param value number ����ֵ
---@param time number ʱ��(��)
function lualib:SetPlayerAbility(player, id, value, time)
    changehumability(player, id, value, time)
end

---��ȡ��������
---@param player string ��Ҷ���
---@param id number ����ID��1-20��1=�������� 2=�������� 3=ħ������ 4=ħ������ 5=�������� 6=�������� 7=ħ������ 8=ħ������ 9=�������� 10=�������� 11=MaxHP 12=MaxMP 13=HP�ָ� 14=MP�ָ� 15=���ָ� 16=����� 17=ħ����� 18=׼ȷ 19=���� 20= ����
---@return number ����ֵ
function lualib:GetPlayerAbility(player, id)
    return gethumability(player, id)
end

---������������
---@param player string ��Ҷ���
---@param id number ����ID ��Ӧcfg_att_score��
---@param value number ����ֵ
---@param time number ʱ��(��)
function lualib:SetPlayerTempAbility(player, id, value, time)
    changehumability(player, id, value, time)
end

---��ȡ��������
---@param player string ��Ҷ���
---@param id number ����ID ��Ӧcfg_att_score��
---@return number ����ֵ
function lualib:GetPlayerTempAbility(player, id)
    return gethumability(player, id)
end

---����������������
---@param player string ��Ҷ���
---@param id number ����ID 1���������ޣ�0~65535�� 2���������ޣ�0~65535�� 3��ħ�����ޣ�0~65535�� 4��ħ�����ޣ�0~65535�� 5���������ޣ�0~65535�� 6���������ޣ�0~65535�� 7���������ޣ�0~65535�� 8���������ޣ�0~65535�� 9��ħ�����ޣ�0~65535�� 10��ħ�����ޣ�0~65535�� 11������ֵ��֧��21�ڣ� 12��ħ��ֵ��֧��21�ڣ� 13��׼ȷ��֧��21�ڣ� 14����ܣ�֧��21�ڣ� 15���������ޣ�֧��21�ڣ� 16���������ޣ�֧��21�ڣ� 17��ħ�����ޣ�֧��21�ڣ� 18��ħ�����ޣ�֧��21�ڣ�
---@param value number ����ֵ
function lualib:SetPlayerForeverAbility(player, id, value)
    setusebonuspoint(player, id, value)
end

---��ȡ������������
---@param player string ��Ҷ���
---@param id number ����ID 1���������ޣ�0~65535�� 2���������ޣ�0~65535�� 3��ħ�����ޣ�0~65535�� 4��ħ�����ޣ�0~65535�� 5���������ޣ�0~65535�� 6���������ޣ�0~65535�� 7���������ޣ�0~65535�� 8���������ޣ�0~65535�� 9��ħ�����ޣ�0~65535�� 10��ħ�����ޣ�0~65535�� 11������ֵ��֧��21�ڣ� 12��ħ��ֵ��֧��21�ڣ� 13��׼ȷ��֧��21�ڣ� 14����ܣ�֧��21�ڣ� 15���������ޣ�֧��21�ڣ� 16���������ޣ�֧��21�ڣ� 17��ħ�����ޣ�֧��21�ڣ� 18��ħ�����ޣ�֧��21�ڣ�
---@return number ����ֵ
function lualib:GetPlayerForeverAbility(player, id)
    return getusebonuspoint(player, id)
end

---����json������Ʒ
---@param player string ��Ҷ���
---@param jsonInfo string json��
function lualib:GiveItemByJson(player, jsonInfo)
    giveitembyjson(player, jsonInfo)
end

---������Ʒʵ���ȡjson
---@param item string ��Ʒʵ��
---@return string json��
function lualib:GetItemJson(item)
    return getitemjson(item)
end

---��Ӿ����ͼ
---@param oldMap string ԭ��ͼID
---@param NewMap string �µ�ͼID
---@param NewName string �µ�ͼ��
---@param time number ��Чʱ��(��)
---@param BackMap string �سǵ�ͼ(��Чʱ������󣬴���ȥ�ĵ�ͼ)
---@param miniMapID number ����С��ͼID
---@param miniMapX number ����С��ͼX����
---@param miniMapY number ����С��ͼY����
function lualib:AddMirrorMap(oldMap, NewMap, NewName, time, BackMap, miniMapID, miniMapX, miniMapY)
    addmirrormap(oldMap, NewMap, NewName, time, BackMap, miniMapID, miniMapX, miniMapY)
end

---ɾ�������ͼ
---@param MapId string ��ͼID
function lualib:DelMirrorMap(MapId)
    delmirrormap(MapId)
end

---��ȡ�����ͼʣ��ʱ��
---@param MapId string ��ͼID
---@param time number ���õ�ͼ��Чʱ��
---@return number ʣ��ʱ��
function lualib:GetMirrorMapTime(MapId, time)
    return mirrormaptime(MapId, time)
end

---��⾵���ͼ�Ƿ����
---@param MapId string ��ͼID
---@return boolean �Ƿ����
function lualib:CheckMirrorMap(MapId)
    return checkmirrormap(MapId)
end

---����ť���Ӻ��
---@param player string ��Ҷ���
---@param btnId string ��ť����
---@param x number x����
---@param y number y����
---@param wndId string ����ID
---@param model number ģ��
---@param path string ·�� (��=ԭ��ģʽ 0=ͼƬ,1=��Ч)
function lualib:AddRedPoint(player, btnId, x, y, wndId, model, path)
    if not btnId then
        return
    end
    if not wndId then wndId = 0 end
    if not x then x = 0 end
    if not y then y = 0 end
    if not model then model = 0 end
    if not path then path = "res/public/btn_npcfh_04.png" end
    reddot(player, wndId, btnId, x, y, model, path)
end

---����ť���Ӻ��
---@param player string ��Ҷ���
---@param btnId string ��ť����
---@param wndId string ����ID
function lualib:DelRedPoint(player, btnId, wndId)
    if not btnId then
        return
    end
    if not wndId then wndId = 0 end
    --callscriptex(player, "Reddel", wndId, btnId)
    reddel(player, wndId, btnId)
end

---��Ļ��
---@param player string ��Ҷ���
---@param type number ģʽ(0~4)0.���Լ�;1.����������;2��Ļ��Χ������;3.��ǰ��ͼ��������;4.ָ����ͼ��������;
---@param level number ��(1~3)
---@param num number ����
---@param mapid number ��ͼID(ģʽ����4ʱ����Ҫ�ò���)
function lualib:ScreenShake(player, type, level, num, mapid)
    scenevibration(player, type, level, num, mapid)
end

---��Ӷ�ʱ��
---@param id number ��ʱ��ID
---@param tick number ִ�м������
---@param count number ִ�д�����Ϊ0ʱ���޴���
function lualib:SetOnTimerEx(id, tick, count)
    setontimerex(id, tick, count)
end

---�Ƴ���ʱ��
---@param id number ��ʱ��ID
function lualib:SetOffTimerEx(id)
    setofftimerex(id)
end

---ɱ��
---@param mapid string ��ͼID
---@param monname string ����ȫ������ ���� * ɱ��ȫ��
---@param count number ������0����
---@param drop boolean �Ƿ������Ʒ��true����
function lualib:KillMonsters(mapid, monname, count, drop)
    killmonsters(mapid, monname, count, drop)
end

---�ڵ�ͼ�Ϸ�����Ʒ
---@param play string ��Ҷ���
---@param MapId string ��ͼID
---@param X number ����X
---@param Y number ����Y
---@param range number ��Χ
---@param itemName string ��Ʒ��
---@param count number ����
---@param time number ʱ�䣨�룩
---@param hint boolean �Ƿ������ʾ
---@param take boolean �Ƿ�����ʰȡ
---@param onlyself boolean ���Լ�ʰȡ
---@param xyinorder boolean ��-��λ��˳�򣬷�-���λ��
function lualib:ThrowItem(play, MapId, X, Y, range, itemName, count, time, hint, take, onlyself, xyinorder)
    throwitem(play, MapId, X, Y, range, itemName, count, time, hint, take, onlyself, xyinorder)
end

---������������XYֵ�Ϳ�߻�ȡ��Ե��
---@param x1 number ���Ͻ�X����
---@param y1 number ���Ͻ�Y����
---@param w number ��
---@param h number ��
---@return table ��Ե������
function lualib:getEdgePointByPoint(x1, y1, w, h)
    local points = {}
    -- Top edge
    for x = x1, x1 + w do
        table.insert(points, { x, y1 })
    end
    -- Right edge
    for y = y1 + 1, y1 + h do
        table.insert(points, { x1 + w, y })
    end
    -- Bottom edge
    for x = x1 + w - 1, x1, -1 do
        table.insert(points, { x, y1 + h })
    end
    -- Left edge
    for y = y1 + h - 1, y1 + 1, -1 do
        table.insert(points, { x1, y })
    end
    return points
end

---�������ε����ĵ�Ͱ뾶����ȡ���εı�Ե��
---@param x0 number ���ĵ�X����
---@param y0 number ���ĵ�Y����
---@param r number �뾶
---@return table ��Ե������
function lualib:getEdgePointForDiamond(x0, y0, r)
    local points = {}
    -- Top edge
    for dx = 0, r do
        table.insert(points, { x0 + dx, y0 + r - dx })
    end
    -- Right edge
    for dy = 0, r do
        table.insert(points, { x0 + r - dy, y0 - dy })
    end
    -- Bottom edge
    for dx = 0, r do
        table.insert(points, { x0 - dx, y0 - r + dx })
    end
    -- Left edge
    for dy = 0, r do
        table.insert(points, { x0 - r + dy, y0 + dy })
    end
    return points
end

---�ж�һ�����Ƿ���������
---@param x number ��X����
---@param y number ��Y����
---@param x0 number �������ĵ�X����
---@param y0 number �������ĵ�Y����
---@param r number ���ΰ뾶
function lualib:PointInDiamond(x, y, x0, y0, r)
    return math.abs(x - x0) + math.abs(y - y0) <= r
end

---ˢ����������
---@param player string ��Ҷ���
function lualib:RefreshPlayer(player)
    recalcabilitys(player)
end

---��������
---@param player string ��Ҷ���
---@param NPCIdx number ����ID
---@param BtnIdx number ��ť����
---@param sMsg string ��ʾ������
function lualib:Guide(player, NPCIdx, BtnIdx, sMsg)
    if not sMsg then
        sMsg = "���"
    end
    navigation(player, NPCIdx, BtnIdx, sMsg)
end

---ʹ�õ���(������Ҫ�߱�˫��ʹ�õĹ���)
---@param player string ��Ҷ���
---@param itemname string ��Ʒ����
---@param count number ����
function lualib:EatItem(player, itemname, count)
    if not count then count = 1 end
    eatitem(player, itemname, count)
end

---��ϵͳ����
---@param player string ��Ҷ���
---@param type number ��������
function lualib:OpenGameWnd(player, param)
    param = tonumber(param)
    openhyperlink(player, param, 0)
end

---�������ﱳ��������
---@param player string ��Ҷ���
---@param count number ���Ӵ�С
function lualib:SetBagCount(player, count)
    setbagcount(player, count)
end

---�򿪲ֿ����
---@param player string ��Ҷ���
function lualib:openStorage(player)
    openstorage(player)
end

---�½����ֿ����
---@param player string ��Ҷ���
---@param nCount number �½����ĸ�����
function lualib:SetStorage(player, nCount)
    changestorage(player, nCount)
end

---���÷���
---@param player string ��Ҷ���
---@param hair number ����ID
function lualib:SetHair(player, hair)
    setbaseinfo(player, 33, 0)
end

---��/�����κ� ��Ф
---@param player string ��Ҷ���
---@param bState number 0���رգ�1������
function lualib:SetAmuletBox(player, bState)
    setsndaitembox(player, bState)
end

---��Ӹ��˶�ʱ��
---@param player string ��Ҷ���
---@param id number ��ʱ��ID
---@param RunTick number ִ�м������
---@param RunTime number ִ�д�����>0ִ����ɺ��Զ��Ƴ�
---@param kf number ����Ƿ����ִ�� 1������
function lualib:SetOnTimer(player, id, RunTick, RunTime, kf)
    if not kf then kf = 0 end
    setontimer(player, id, RunTick, RunTime, kf)
end

---�Ƴ����˶�ʱ��
---@param player string ��Ҷ���
---@param id number ��ʱ��ID
function lualib:SetOffTimer(player, id)
    setofftimer(player, id)
end

---����ȫ�������Ϣ
---@param player string ��Ҷ���
---@param status string �Ƿ���� 0-������ 1-����
function lualib:FilterGlobalMsg(player, status)
    filterglobalmsg(player, status)
    --self:CallTxtScript(player, "FILTERGLOBALMSG " .. status)
end

---��ȡ��Ʒ��������
---@param player string ��Ҷ���
---@param item string ��Ʒ����
---@param type number [1,2,3]
---@param position number λ��
---@return number ��������ֵ
function lualib:GetItemAddValue(player, item, type, position)
    return getitemaddvalue(player, item, type, position)
end

---������Ʒ��������
---@param player string ��Ҷ���
---@param item string ��Ʒ����
---@param type number [1,2,3]
---@param position number λ��
---@param value number ��������ֵ
function lualib:SetItemAddValue(player, item, type, position, value)
    setitemaddvalue(player, item, type, position, value)
    --lualib:RefreshItem(player, item)
end

---�ⶾ����
---@param player string ��Ҷ���
---@param par number ������ 1�������ж�;0,�̶�;1,�춾;3,�϶�;5,���;6,����;7,����
function lualib:RemovePoison(player, par)
    detoxifcation(player, par)
end

---�޸�����װ��
---@param player string ��Ҷ���
function lualib:RepairAll(player)
    repairall(player)
end

---���������˺�����
---@param player string ��Ҷ���
---@param operate string ��������
---@param sum number ��������
---@param rate number ���ձ��ʣ�ǧ�ֱ� 1=0.1%��100=10%
---@param success number ���ճɹ���
function lualib:SetSuckDamage(player, operate, sum, rate, success)
    setsuckdamage(player, operate, sum, rate, success)
end

---��ʱ����
---@param player string ��Ҷ���
---@param time number ��ʱʱ�䣬��λ����
---@param func string �ص�����
---@param del number ����ͼ�Ƿ�ɾ���ص����� 0-��ɾ�� 1-ɾ��
function lualib:DelayGoto(player, time, func, del)
    delaygoto(player, time, func, del)
end

---����txt�ű�
---@param player string ��Ҷ���
---@param txt string �ű�����
function lualib:CallTxtScript(player, str)
    if not player then
        player = globalinfo(0)
    end
    local pt = string.split(str, " ")
    callscriptex(player, unpack(pt))
end

---�����Զ��һ�
---@param player string ��Ҷ���
function lualib:StartAutoAttack(player)
    startautoattack(player)
end

---ֹͣ�Զ��һ�
---@param player string ��Ҷ���
function lualib:StopAutoAttack(player)
    stopautoattack(player)
end

---ȫ����Ϣ
---@param id number ��ϢID 0: ȫ�������Ϣ 1: ��������(��̨ά��) 2: ����ʱ��(��̨ά��) 3: �Ϸ����� 4: �Ϸ�ʱ�� 5: ������IP 6: ������� 7: ����������� 8: ����汾�ţ������ϰ汾Ϊ׼,���԰桢���ذ���ܴ��ڲ��죩 9����Ϸid 10������������ 11��������id
---@return string ��Ϣ����
function lualib:GlobalInfo(id)
    return globalinfo(id)
end

---��ʬ
function lualib:MonItems(player, count)
    monitems(player, count)
end

---���buff
---@param base string ��Ҷ���
---@param buffid number buff id��10000�Ժ�
---@param time number ʱ��,��Ӧbuff����ά���ĵ�λ
---@param OverLap number ���Ӳ�����Ĭ��1
---@param objOwner string ʩ����
---@param Abil table ���Ա� {[1]=200, [4]=20}������id=ֵ
---@return boolean �Ƿ���ӳɹ�
function lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    return addbuff(base, buffid, time, OverLap, objOwner, Abil)
end

---���buff��չ
---@param base string ��Ҷ���
---@param buffid number buff id��10000�Ժ�
---@param time number ʱ��,��Ӧbuff����ά���ĵ�λ
---@param OverLap number ���Ӳ�����Ĭ��1
---@param objOwner string ʩ����
---@param Abil table ���Ա� {[1]=200, [4]=20}������id=ֵ
---@return boolean �Ƿ���ӳɹ�
function lualib:AddBuffEx(base, buffid, time, OverLap, objOwner, Abil)
    if lualib:HasBuff(base, buffid) then
        lualib:DelBuff(base, buffid)
        return lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    else
        return lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    end
end

---ɾ��buff
---@param base string ��Ҷ���
---@param buffid number buff id
function lualib:DelBuff(base, buffid)
    delbuff(base, buffid)
end

---�Ƿ���buff
---@param base string ��Ҷ���
---@param buffid number buff id
---@return boolean �Ƿ���
function lualib:HasBuff(base, buffid)
    return hasbuff(base, buffid)
end

---��ȡbuff��Ϣ
---@param base string ��Ҷ���
---@param buffid number buff id
---@param type number ���ͣ�1:���Ӳ��� 2:ʣ��ʱ��(��λ������һ��)
---@return number ����ֵ
function lualib:GetBuffInfo(base, buffid, type)
    return getbuffinfo(base, buffid, type)
end

---��ȡ��Ʒ������
---@param item string ��Ʒ����
---@return string ����
function lualib:ItemName(player, item)
    return lualib:GetItemInfo(player, item, 7)
end

---��ȡ��Ʒ��Shape
---@param item string ��Ʒ����
---@return string Shape
function lualib:ItemShape(player, item)
    local id = lualib:GetItemInfo(player, item, 2)
    if id then
        return lualib:GetStdItemInfo(id, 3)
    else
        return nil
    end
end

---����ʱ����ĳ�ʼʱ����������Ѿ����˶����� 1970-01-01 00:00:00
---@param timestamp number ʱ���
---@return number ����
function lualib:GetAllDays()
    -- ����ʱ����UTCƫ��Ϊ8Сʱ��8 * 60 * 60�룩
    local utcOffset = 8 * 60 * 60

    -- ������ʱ��ת��ΪUTCʱ���
    local utcTimestamp = os.time() + utcOffset

    -- ����ʱ���֮���ת��Ϊ����
    local days = math.floor((utcTimestamp) / (86400))

    return days
end

---���ַ���ʱ��ת��Ϊʱ���
---@param date_str string ʱ���ַ�������ʽΪ 2019-01-01 00:00:00
---@return number ʱ���
function lualib:Str2Time(date_str)
    local y, m, d, H, M, S = date_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    local timestamp = os.time({ year = y, month = m, day = d, hour = H, min = M, sec = S })
    return timestamp
end

---��ʱ���ת��Ϊ�ַ���ʱ��
---@param timestamp number ʱ���
---@return string ʱ���ַ�������ʽΪ 2019-01-01 00:00:00
function lualib:Time2Str(timestamp)
    local date_table = os.date("*t", timestamp)
    local date_str = string.format("%04d-%02d-%02d %02d:%02d:%02d", date_table.year, date_table.month, date_table.day,
        date_table.hour, date_table.min, date_table.sec)
    return date_str
end

---��ʱ���ת��Ϊ�ַ���ʱ�䣬������ָ����ʽ
---@param timestamp number ʱ���
---@param format string ��ʽ������ %Y-%m-%d %H:%M:%S
---@return string ʱ���ַ���
function lualib:Time2StrEx(timestamp, format)
    local date_str = os.date(format, timestamp)
    return date_str
end

---��ȡʱ�����������ʱ����
---@param timestamp number ʱ���
---@return number ��
---@return number ��
---@return number ��
---@return number ʱ
---@return number ��
---@return number ��
function lualib:TimeDetail(timestamp)
    local date_table = os.date("*t", timestamp)
    return date_table.year, date_table.month, date_table.day, date_table.hour, date_table.min, date_table.sec
end

---��ȡ��ǰʱ���
---@return number ʱ���
function lualib:Now()
    return os.time()
end

---��������
---@param player string ��Ҷ���
---@param id number ID
---@param name string ��ʾ����
---@param fun function ������(������ö��ŷָ�)
function lualib:AddBubble(player, id, name, fun)
    addbutshow(player, id, name, fun)
end

---ɾ������
---@param player string ��Ҷ���
---@param id number ID
function lualib:DelBubble(player, id)
    delbutshow(player, id)
end

---��ȡ��ͼ��ָ����Χ�ڵĶ���
---@param MapId string ��ͼID
---@param X number ����X
---@param Y number ����Y
---@param range number ��Χ
---@param flag number ���ֵ��������λ��ʾ��1-��ң�2-���4-NPC��8-��Ʒ��16-��ͼ�¼� 32-���ι� 64-Ӣ��,128-����
---@return table �����б�
function lualib:GetObjectInMap(MapId, X, Y, range, flag)
    return getobjectinmap(MapId, X, Y, range, flag)
end

---��ȡ�л���Ϣ
---@param guild string �л����
---@param index number ����0-�л�ID 1-�л����� 2-�лṫ�� 3-�л��Ա����������table�� 4-�л�����������
---@return string ���
function lualib:GetGuildInfo(guild, index)
    return getguildinfo(guild, index)
end

---��ȡ������ڵ��л����
---@param player string ��Ҷ���
---@return string �л����
function lualib:GetMyGuild(player)
    return getmyguild(player)
end

---��ȡ�ҵ��л���Ϣ
---@param player string ��Ҷ���
---@param index number ����0-�л�ID 1-�л����� 2-�лṫ�� 3-�л��Ա����������table�� 4-�л�����������
---@return string ���
function lualib:GetMyGuildInfo(player, index)
    local myGuild = lualib:GetMyGuild(player)
    if myGuild == "" or myGuild == "0" or myGuild == nil then
        return
    end
    return lualib:GetGuildInfo(myGuild, index)
end

---md5����
---@param str string �ַ���
---@return string ���
function lualib:MD5(str)
    -- û�нӿڣ���luaʵ��һ��md5����
end

---�������
---@param a string ����a
---@param b string ����b
---@return string ���
function lualib:BigNumAdd(a, b)
    -- �������ʵ�֣��ַ������
    if type(a) ~= "string" or type(b) ~= "string" then
        return nil
    end
    local lena = string.len(a)
    local lenb = string.len(b)
    local len = lena > lenb and lena or lenb
    local result = ""
    local carry = 0
    for i = 1, len do
        local numa = lena - i + 1 > 0 and tonumber(string.sub(a, lena - i + 1, lena - i + 1)) or 0
        local numb = lenb - i + 1 > 0 and tonumber(string.sub(b, lenb - i + 1, lenb - i + 1)) or 0
        local num = numa + numb + carry
        if num >= 10 then
            carry = 1
            num = num - 10
        else
            carry = 0
        end
        result = tostring(num) .. result
    end
    if carry == 1 then
        result = "1" .. result
    end
    return result
end

---�������
---@param a string ����a
---@param b string ����b
---@return string ���
function lualib:BigNumSub(a, b)
    -- �������ʵ�֣��ַ������
    if type(a) ~= "string" or type(b) ~= "string" then
        return nil
    end
    local lena = string.len(a)
    local lenb = string.len(b)
    local len = lena > lenb and lena or lenb
    local result = ""
    local carry = 0
    for i = 1, len do
        local numa = lena - i + 1 > 0 and tonumber(string.sub(a, lena - i + 1, lena - i + 1)) or 0
        local numb = lenb - i + 1 > 0 and tonumber(string.sub(b, lenb - i + 1, lenb - i + 1)) or 0
        local num = numa - numb - carry
        if num < 0 then
            carry = 1
            num = num + 10
        else
            carry = 0
        end
        result = tostring(num) .. result
    end
    if carry == 1 then
        result = "1" .. result
    end
    return result
end

---�������
---@param a string ����a
---@param b string ����b
---@return string ���
function lualib:BigNumMul(a, b)
    -- �������ʵ�֣��ַ������
    if type(a) ~= "string" or type(b) ~= "string" then
        return nil
    end
    local lena = string.len(a)
    local lenb = string.len(b)
    local result = ""
    for i = 1, lena do
        local numa = lena - i + 1 > 0 and tonumber(string.sub(a, lena - i + 1, lena - i + 1)) or 0
        local carry = 0
        local temp = ""
        for j = 1, lenb do
            local numb = lenb - j + 1 > 0 and tonumber(string.sub(b, lenb - j + 1, lenb - j + 1)) or 0
            local num = numa * numb + carry
            if num >= 10 then
                carry = math.floor(num / 10)
                num = num % 10
            else
                carry = 0
            end
            temp = tostring(num) .. temp
        end
        if carry > 0 then
            temp = tostring(carry) .. temp
        end
        for j = 1, i - 1 do
            temp = temp .. "0"
        end
        result = lualib:BigNumAdd(result, temp)
    end
    return result
end

---�ͻ��˵��������б���� ���ӣ�lualib:ShowRewards(player, { { 5, 10 }, {7,100000}, {7,100000}, {7,100000}, {7,100000}, {7,100000} })
---@param player number ��Ҷ���
---@param tAwards table �����б�
---@return void
function lualib:ShowRewards(player, tAwards)
    if type(tAwards) ~= "table" then
        return
    end

    if next(tAwards) == nil then
        return
    end
    self:ShowFormWithContent(player, "sys/RewardItems", { list = tAwards })
end

---��������Ʒ�ͻ��� {��Ʒ������Ʒ������id=id}
---@param player string ��Ҷ���
---@param itemTb table �����б�
---@param desc string ����,�����ڻ���
---@param rule string ����
function lualib:AddBatchItem(player, itemTb, desc, rule)
    for i = 1, #itemTb do
        local item = itemTb[i]
        if item.type then
            if item.type == "�ƺ���Ʒ" then
                lualib:AddTitleEx(player, item[1])
            end
        else
            local stdMode = self:GetStdItemInfo(item[1], 2)
            if stdMode == 41 then
                self:SetMoneyEx(player, item[1], "+", item[2], desc, true)
            else
                self:AddItem(player, item[1], item[2], rule, desc)
            end
        end
    end
end

---��ȡ����pk�ȼ�
---@param player string ��Ҷ���
---@return number pk�ȼ�0.����;1.����;2.����;3.����
function lualib:GetPkLevel(player)
    return getpklevel(player)
end

---��ȡ��ɫ����buff
---@param player string ��Ҷ���
---@return table buff�б�
function lualib:GetAllBuffId(player)
    return getallbuffid(player)
end

---����ͼ�߼���
---@param mapid number ��ͼid
---@param x number x����
---@param y number y����
---@param type number �߼������� 1.�ܷ񵽴�; 2.��ȫ��; 3.������;
---@return boolean �Ƿ���ͬ
function lualib:CheckGridAttr(mapid, x, y, type)
    return checkgridattr(mapid, x, y, type)
end

---��������������Ʒװ������
---@param player string ��Ҷ���
---@param itemPos number װ��λ��
---@param itemName string װ������
---@return void
function lualib:SetItemName(player, itemPos, itemName)
    changeitemname(player, itemPos, itemName)
end

---����ɱ����ɫ
---@param player string ��Ҷ���
---@param attacker string ������
---@return void
function lualib:Kill(player, attacker)
    kill(player, attacker)
end

---MD5����
---@param str string ��Ҫ���ܵ��ı�
---@return string MD5����ֵ
function lualib:MD5(str)
    return md5(str)
end

---���ݵ�ͼid���ص�ͼ��
---@param mapid number ��ͼId���������ֵ�
---@return string ��ͼ��
function lualib:GetMapNameById(player)
    return getmapid(player)
end

---���Ϳͻ��˵�����Ϣ
---@param player string ��Ҷ���
---@param _text string ��Ϣ����
---@param _x number x����
---@param _y number y����
---@param _time number ��Ϣ����ʱ��
---@param _size number �����С
---@param _color string ������ɫ
---@param _outline number ��ߴ�С
---@param _outlineColor string �����ɫ
function lualib:SendFadeOutMsg(player, _text, _x, _y, _time, _size, _color, _outline, _outlineColor)
    lualib:DoClientUIMethod(player, "CL_SendFadeOutMsg", _text, _x, _y, _time, _size, _color, _outline, _outlineColor)
end

---�������ַ�����������תΪ��ȷ����������
---@param _tb table ��
function lualib:ChangeTableIndexToNumber(_tb)
    for k, v in pairs(_tb) do
        if type(k) == "string" and tonumber(k) then
            _tb[tonumber(k)] = v
            _tb[k] = nil
        end
        if type(v) == "table" then
            lualib:ChangeTableIndexToNumber(v)
        end
    end
end

---װ������
---@param player string ��Ҷ���
---@param item string װ������
---@param holejson string ������أ�json�ַ�����֧��0~9��10����
function lualib:SetEquipDrillHole(player, item, holejson)
    drillhole(player, item, holejson)
end

---��ȡװ����������
---@param player string ��Ҷ���
---@param item string װ������
---@return string ������أ�json�ַ�����֧��0~9��10����
function lualib:GetEquipDrillHole(player, item)
    return getdrillhole(player, item)
end

---װ����Ƕ��ʯ
---@param player string ��Ҷ���
---@param item string װ������
---@param hole number װ��������ţ�0~9
---@param itemIndex number ��Ƕ��ʯ��index��װ�����ܵ�Index��
function lualib:SetEquipSocket(player, item, hole, itemIndex)
    socketableitem(player, item, hole, itemIndex)
end

---��ȡװ����ʯ��Ƕ���
---@param player string ��Ҷ���
---@param item string װ������
---@return string ������أ�json�ַ�����֧��0~9��10����
function lualib:GetEquipSocket(player, item)
    return getsocketableitem(player, item)
end

---��ȡ�����Զ�������ֵ
---@param player string ��Ҷ���
---@param attrId number ����ID
---@return number ����ֵ
function lualib:GetCustomAttr(player, attrId)
    return getbaseinfo(player, 51, attrId)
end

---�Զ���Ⱥ���и�
---@param player string ��Ҷ���
---@param _attackNum number ����ֵ
---@param _X number ����X
---@param _Y number ����Y
---@param _Range number �иΧ
---@param _Type number ���ֵ��������λ��ʾ��1-��ң�2-����4-NPC��8-��Ʒ 16-��ͼ�¼� 32-���ι� 64-Ӣ�� 128-����
---@param _MaxNum number �������
---@param _Magic number ��Чid
---@param _CutTextId number �и�����id
function lualib:RangeHarmCustom(player, _attackNum, _X, _Y, _Range, _Type, _MaxNum, _Magic, _CutTextId)
    local mapId = lualib:GetMapId(player)
    local backList = getobjectinmap(mapId, _X, _Y, _Range, _Type)
    _MaxNum = _MaxNum or 1
    for i = 1, _MaxNum do
        local target = backList[i]
        lualib:SetHp(target, "-", _attackNum, _CutTextId, 0, player)
        playeffect(target, _Magic, 0, 0, 1, 0, 0)
    end
end

---����ID�жϲ����Ƿ����
---@param player string ��Ҷ���
---@param moneyID number ���һ����ID
---@param Num number ����
function lualib:isByIDMoneyEnough(player, moneyID, Num)
    Num = tonumber(Num) or 9999999999999
    if getstditeminfo(moneyID, ConstCfg.stditeminfo.stdmode) == 41 then
        if querymoney(player, moneyID) < Num then
            return false
        end
    else
        if self.ItemCountBag(player, self:GetStdItemInfo(moneyID, ConstCfg.stditeminfo.name)) < Num then
            return false
        end
    end
    return true
end

---���������жϲ����Ƿ����
---@param player string ��Ҷ���
---@param moneyID string ���һ��������
---@param Num number ����
function lualib:isByNameMoneyEnough(player, moneyName, Num)
    Num = tonumber(Num) or 9999999999999
    if getstditeminfo(moneyName, ConstCfg.stditeminfo.stdmode) == 41 then
        if querymoney(player, getstditeminfo(moneyName.ConstCfg.stditeminfo.idx)) < Num then
            return false
        end
    else
        if lualib:ItemCountBag(player, moneyName) < Num then
            return false
        end
    end
    return true
end

---�������ֻ�ID�жϲ����Ƿ����
---@param player string ��Ҷ���
---@param moneyID string ��ƷID������
---@param Num number ����
-- function lualib:zsf_isMoneyEnough(player, moneyName_or_ID, Num)
--     Num = tonumber(Num) or 9999999999999
--     if type(moneyName_or_ID) == "number" then
--         return isByIDMoneyEnough(player, moneyName_or_ID, Num)
--     else
--         return isByNameMoneyEnough(player, moneyName_or_ID, Num)
--     end
-- end

---���һ������ķ�Χ
---@param obj string ����
---@param x number X����
---@param y number Y����
---@param range number ��Χֵ�������Ƿ��������Χ�ڣ�
function lualib:FCheckRange(obj, x, y, range)
    local cur_x, cur_y = getbaseinfo(obj, ConstCfg.gbase.x), getbaseinfo(obj, ConstCfg.gbase.y)
    local min_x, max_x = x - range, x + range
    local min_y, max_y = y - range, y + range

    if (cur_x >= min_x) and (cur_x <= max_x) and (cur_y >= min_y) and (cur_y <= max_y) then
        return true
    end

    return false
end

---����Ʒ
---@param player string ��Ҷ���
---@param idx_or_name number/string ��ƷID����Ʒ��
---@param num number ����
---@param bind number ��Ʒ����
function lualib:FGiveItem(player, idx_or_name, num, bind)
    num = num or 1
    if type(idx_or_name) == "number" then
        idx_or_name = getstditeminfo(idx_or_name, ConstCfg.stditeminfo.name)
    end
    return giveitem(player, idx_or_name, num, bind)
end

--������Ʒ
---@param player string ��Ҷ���
---@param idx_or_name number/string ��ƷID����Ʒ��
---@param num number ����
function lualib:FTakeItem(player, idx_or_name, num)
    num = num or 1
    if type(idx_or_name) == "number" then
        idx_or_name = getstditeminfo(idx_or_name, ConstCfg.stditeminfo.name)
    end
    return takeitem(player, idx_or_name, num)
end

--������Ʒ(ͨ����Ʒ����)
---@param player string ��Ҷ���
---@param itemobj string ��Ʒ����
---@param num number ����
function lualib:FTakeItemEX(player, itemobj, num)
    if itemobj ~= '0' then
        local onlyID = getiteminfo(player, itemobj, ConstCfg.iteminfo.id)
        return delitembymakeindex(player, onlyID, num)
    else
        return false
    end
end

---������Ʒ������Ʒid��ȡ��ƷDBԭʼ�ֶ�ֵ
---@param player string ��Ҷ���
---@param itemNameOrId string ��Ʒ����ID
---@param itemField string �ֶ���
function lualib:GetItemDBField(player, itemNameOrId, itemField)
    return getdbitemfieldvalue(player, itemNameOrId, itemField)
end

---�����ı��ļ�
---@param path string �ļ�·��
function lualib:IO_CreateFile(path)
    createfile(path)
end

---д��ָ���ı��ļ�
---@param path string �ļ�·��
---@param str string д���ı�
---@param line string д������(0~65535)
function lualib:IO_AddTextList(path, str, line)
    addtextlist(path, str, line)
end

---��ȡ�ı��ļ�ָ���е��ַ���
---@param path string �ļ�·��
---@param line string ָ����(0~1000)
---@return string �ַ���
function lualib:IO_GetRandomText(path, line)
    return getrandomtext(path, line)
end

---��ȡ�ı��ļ�ָ���е�����[���ݷ��ŷָ�]
---@param path string �ļ�·��
---@param line string ָ����
---@param symbol string ����
---@return table �ַ����б�
function lualib:IO_GetListStringEx(path, line, symbol)
    return getliststringex(path, line, symbol)
end

---ȡ�ַ������б��е��±�
---@param path string �ļ�·��
---@param str string �ַ���
---@return number �ַ���������
function lualib:IO_GetStringPos(path, str)
    return getstringpos(path, str)
end

---ɾ���ı��ļ�������
---@param path string �ļ�·��
---@param line string ָ����
---@param model number ɾ��ģʽ 0=ɾ���� 1=����� 2=ɾ�������(����2ʧЧ)
function lualib:IO_DelTextList(path, line, model)
    deltextlist(path, line, model)
end

---����б�����
---@param path string �ļ�·��
function lualib:IO_ClearNameList(path)
    clearnamelist(path)
end

---����ַ����Ƿ���ָ���ļ���
---@param path string �ļ�·��
---@param str string �ַ���
---@return boolean true=���ļ��� false=�����ļ���
function lualib:IO_CheckTextList(path, str)
    return checktextlist(path, str)
end

---����ַ����Ƿ���ָ���ļ���
---@param path string �ļ�·��
---@param str string �ַ���
---@param model number ���ģʽ 0=�б���,�Ƿ�����������ַ� 1=�������ַ��Ƿ�����б��е�ĳһ������
---@return boolean true=���ļ��� false=�����ļ���
function lualib:IO_CheckContainsTextList(path, str, model)
    return checkcontainstextlist(path, str, model)
end

---����ͨ���ı�
---@param fileName string �ļ���
function lualib:Tong_CreateFile(fileName)
    tongfile(0, fileName)
end

---ɾ��ͨ���ı�
---@param fileName string �ļ���
function lualib:Tong_DeleteFile(fileName)
    tongfile(1, fileName)
end

---ͨ��ͬ���ı�
---@param remoteFileName string Զ���ļ���
---@param fileName string ͬ�����ļ���
function lualib:Tong_UpdateFile(remoteFileName, fileName)
    updatetongfile(remoteFileName, fileName)
end

---����ͨ���ļ�����
---@param path string �ı�·��
---@param str string ����(���64�����ַ�)
---@param line string ָ��������
---@param model string 0=�ļ�β׷������(��) 1 =�������ݵ�ָ���� 2=�滻���ݵ�ָ���� 3=ɾ��ָ�������� 4=��������ļ�����
function lualib:Tong_ChangeFile(path, str, line, model)
    changetongfile(path, str, line, model)
end

---ͨ������ͬ��
---@param varName string ȫ�ֱ�����
function lualib:Tong_UpdateVar(varName)
    updatetongvar(varName)
end

---����ִ��,���Ӵ����ļ�
---@param varName string ����ID
---@param model number 0=�����ļ� 1=ɾ���ļ�
---@param path string �ļ�·�� �� ��..\QuestDiary\996m2.txt��
function lualib:Tong_MainCreateFile(varName, model, path)
    maintongfile(varName, model, path)
end

---д��ָ����������
---@param serverID string ����ID
---@param path string �ļ�·�� �� ��..\QuestDiary\996m2.txt��
---@param key string �ֶ�
---@param value string ֵ
function lualib:Tong_WriteTongKey(serverID, path, key, value)
    writetongkey(serverID, path, key, value)
end

---��ȡָ����������
---@param serverID string ����ID
---@param path string �ļ�·�� �� ��..\QuestDiary\996m2.txt��
---@param key string �ֶ�
---@param varName string ����
function lualib:Tong_ReadTongKey(serverID, path, key, varName)
    readtongkey(serverID, path, key, varName)
end

---ִ�в�ѯͨ������
---@param serverID string ����ID
function lualib:Tong_CheckTongSvr(serverID)
    checktongsvr(serverID)
end

---����ִ�� ͬ���ļ� �������ļ�·��ͬ����������·��
---@param serverID string ����ID
---@param path string �ļ�·�� �� ��..\QuestDiary\996m2.txt��
function lualib:Tong_UpdateMainTongFile(serverID, path)
    updatemaintongfile(serverID, path)
end

---����ִ�� ��ȡ�ļ�
---@param serverID string ����ID
---@param filePath string �����ļ�·����..\QuestDiary\bbb.txt��
---@param path string Զ�̷�����·�� �� ��..\QuestDiary\996m2.txt��
function lualib:Tong_GetMainTongFile(serverID, filePath, path)
    getmaintongfile(serverID, filePath, path)
end

---���������Ʒ�ͻ���
---@param player string ��Ҷ���
---@param costTb table �����б�
---@return boolean �Ƿ��㹻
---@return string ��ʾ
function lualib:BatchCheckItem(player, costTb)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "����" .. costSSS[1] .. "����" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    return true
end

---�����۳���Ʒ�ͻ���
---@param player string ��Ҷ���
---@param costTb table �����б�
---@param costDesc string ��������
---@return boolean �Ƿ�ɹ�
---@return string ��ʾ
function lualib:BatchDelItem(player, costTb, costDesc)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "����" .. costSSS[1] .. "����" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            lualib:SetMoneyEx(player, costSSS[1], "-", costSSS[2], costDesc .. "��ȡ����", true)
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, costDesc .. "����") then
                return false, "���Ĳ���" .. costSSS[1] .. "����" .. costSSS[2]
            end
        end
    end
    return true
end

---���������������֮��ľ���
---@param position1 table ����1{x=1,y=1}
---@param position2 table ����2{x=100,y=100}
function lualib:Distance(position1, position2)
    local dx = position2.x - position1.x
    local dy = position2.y - position1.y
    return math.ceil(math.sqrt(dx * dx + dy * dy))
end

---�򿪽�����
---@param player string ��Ҷ���
---@param title string ����
---@param time number ʱ��
---@param cancelLink string ���� @click,�һ�����_stopCircle
---@param countLink string ���� @click,�һ�����_stopCircle
function lualib:OpenTimeCountDownWnd(player, title, time, cancelLink, countLink)
    time = time or 3
    title = title or "��������"
    local str =
        [[
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|bg=1|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|img=custom/1900000651_1.png>
        <CircleBar|x=425.0|y=120.0|show=4|endper=100|startper=0|time=]] ..
        time ..
        [[|loadingbar=private/TradingBankLayer/progress.png|loadingbg=private/TradingBankLayer/progressbg.png|offsetY=0|offsetX=0|link=]] ..
        countLink .. [[>
            <Button|ax=0|ay=0|x=520.0|y=345.0|width=100|height=30|color=103|size=20|pimg=custom/kb1.png|nimg=custom/kb1.png|text=���ȡ��|link=]] ..
        cancelLink .. [[>
            <RText|x=480.0|y=250.0|outlinecolor=0|color=249|outline=2|size=22|text=]] .. (tostring(title)) .. [[>
            <COUNTDOWN|a=0|x=545.0|y=195.0|size=30|color=103|time=]] .. time .. [[|count=1>
        ]]
    say(player, str)
end

return lualib, Constant
