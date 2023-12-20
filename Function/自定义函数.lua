module("lualib", package.seeall)
--[[
    package.seeall: 这是一个模块声明的修饰符，它告诉 Lua 在导入该模块时将其符号（变量和函数）全部导出到全局环境中。这意味着在其他 Lua 文件中导入了这个模块后，可以直接访问该模块中的所有变量和函数，而不需要使用模块名称前缀。
]]
-- lualib={}
local TSGMName = "杨天尊" -- 耗时EX接口使用，若不在线则无效
--瞬发调用函数
local function load_mainex_system(player, func)
    lualib:GoTo(player, func)
    return
end
--无限参数调用
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

--延时回调触发
function lualib:DelayCall(player, time, func) --延时时间 目录:函数名,参数 调用位置默认QuestDiary 1:MapQuest_def 2:Market_def
    local split = strsplit(func, ":")
    local file, func = split[1], split[2]
    include("QuestDiary/" .. file .. ".lua")
    delaygoto(player, time, func)
    return true
end

--延时回调触发
function lualib:GoToEx(player, time, func)
    delaygoto(player, time, func)
    return true
end

--延时回调触发调用瞬发
function lualib:GoToExs(player, time, func)
    delaygoto(player, time, "load_mainex_system," .. func)
    return true
end

--瞬发
function lualib:GoTo(player, func)
    -- assert(player, "player 参数为错误")
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

--自定义排序
function lualib:GetRank(var, playflag, sortflag, count, param) --变量名   0-所有玩家 1-在线玩家 2-行会   0-升序，1-降序   获取的数据量为空或0取所有，取前几名 是否传奇变量
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

---获取物品数量
---@param player userdata 玩家
---@param name string 物品名字
---@param bool boolean 是否获取身上物品
function lualib:ItemCount(player, name, bool) --物品名字 bool==nil 获取全部 bool==true 获取身上 bool==false 获取背包
    local num = 0
    if bool then
        num = lualib:ItemCountPlayer(player, name)
    else
        num = lualib:ItemCountBag(player, name)
    end
    return num
end

--获取背包物品数量
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

--获取身上物品数量
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

---获取身上的装备
---@param player userdata 玩家
---@return table 装备列表
function lualib:GetEquipList(player)
    local tb = {}
    -- 基础装备
    for i = 1, 41 do
        local equip = lualib:LinkBodyItem(player, i)
        if equip ~= "" and equip ~= nil and equip ~= "0" then
            table.insert(tb, equip)
        end
    end
    -- 自定义装备
    for i = 71, 120 do
        local equip = lualib:LinkBodyItem(player, i)
        if equip ~= "" and equip ~= nil and equip ~= "0" then
            table.insert(tb, equip)
        end
    end
    return tb
end

---获取背包物品列表
---@param player userdata 玩家
---@return table 背包物品列表
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

---发送邮件
---@param player userdata 玩家UserId，如果是玩家名，需要在前面加#，如:#张三
---@param mailId number 自定义邮件ID
---@param title string 邮件标题
---@param text string 邮件内容
---@param rewards string 附件内容：物品1#数量#绑定标记&物品2#数量#绑定标记，&分组，#分隔
---@return boolean
function lualib:SendMail(player, mailId, title, text, rewards)
    sendmail(getbaseinfo(player, 2), mailId, title, text, rewards)
    return true
end

---根据玩家名字发送邮件
---@param player userdata 玩家UserId，如果是玩家名，需要在前面加#，如:#张三
---@param mailId number 自定义邮件ID
---@param title string 邮件标题
---@param text string 邮件内容
---@param rewards string 附件内容：物品1#数量#绑定标记&物品2#数量#绑定标记，&分组，#分隔
---@return boolean
function lualib:SendMailEx(playerName, mailId, title, text, rewards)
    sendmail("#" .. playerName, mailId, title, text, rewards)
    return true
end

---获取服务器玩家对象
function lualib:GetGSPlayer()
    return getplayerlst()
end

--根据名称获取玩家对象
function lualib:GetPlayerByName(name) --没有返回nil
    return getplayerbyname(name)
end

--根据id获取玩家对象
function lualib:GetPlayerById(id)
    return getplayerbyid(id)
end

--调用触发
function lualib:GotoLabel(player, info, func, range) --触发模式：0-小组成员触发1-行会成员触发2-当前地图的人物触发3-以自己坐标为中心指定范围人物触发  跳转后的接口(Qf.lua) 触发模式=3时指定的范围大小
    gotolabel(player, info, func, range)
    return true
end

--获取怪物标识 标识(0-9) 注意返回string类型
function lualib:GetMobIndex(mob, var)
    local var = tostring(var)
    return getcurrent(mob, var)
end

--设置怪物标识  标识(0-9) 注意返回string类型
function lualib:SetMobIndex(mob, var, par)
    local var, par = tostring(var), tostring(par)
    setcurrent(mob, var, par)
    return true
end

---判断对象是否死亡
---@param player：玩家id
---@return boolean true:死亡 false:未死亡
function lualib:Die(player)
    return getbaseinfo(player, 0)
end

--设置进度条数据
function lualib:SetItemBar(player, item, index, open, show, name, color, img, cur, max, lv) --进度条编号0-2 open:0关1开  show:0-不显示数值1-百分比，2-数字 进度条文本  进度条颜色，0~255 imgcount:1 cur:当前值 max:最大值 level:级别(0~65535)
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

--设置装备标识
function lualib:SetItemIndex(player, item, int, par) --支持（1-32)lua 传奇对应(1-32)
    setitemaddvalue(player, item, 3, int, par)
    return true
end

--获取装备标识
function lualib:GetItemIndex(player, item, int) --支持（1-32)lua 传奇对应(1-32)
    return getitemaddvalue(player, item, 3, int)
end

---通知物品发送到前端刷新
---@param player：玩家id
---@param item：物品id
function lualib:NotifyItem(player, item)
    refreshitem(player, item)
    return true
end

---获取背包空格子数量
---@param player：玩家id
---@return number 获取背包空格子数量
function lualib:GetBagFree(player) --获取背包空格子数量  注意：快捷栏的6个格子也会计算上！
    return getbagblank(player)
end

--初始化行会自定义字符串变量
function lualib:FamilyStr(family, name, param)
    if param ~= nil then
        iniguildvar(family, "string", name)
    else
        iniguildvar(family, "string", "_FamilyStr" .. name)
    end
    return true
end

--初始化行会自定义数值型变量
function lualib:FamilyInt(family, name, param)
    if param ~= nil then
        iniguildvar(family, "integer", name)
    else
        iniguildvar(family, "integer", "_FamilyInt" .. name)
    end
    return true
end

--获取全局自定义字符变量
function lualib:GetFamilyStr(family, name, param)
    lualib:FamilyStr(family, name, param)
    if param ~= nil then
        return getguildvar(family, "_FamilyStr" .. name)
    else
        return getguildvar(family, name)
    end
end

--设置全局自定义字符变量
function lualib:SetFamilyStr(family, name, par, param)
    lualib:FamilyStr(family, name, param)
    if param ~= nil then
        setguildvar(family, name, par, 1)
    else
        setguildvar(family, "_FamilyStr" .. name, par, 1)
    end
    return true
end

--获取行会自定义数值变量
function lualib:GetFamilyInt(family, name, param)
    lualib:FamilyInt(family, name, param)
    if param ~= nil then
        return getguildvar(family, name)
    else
        return getguildvar(family, "_FamilyInt" .. name)
    end
end

--设置行会自定义数值变量
function lualib:SetFamilyInt(family, name, par, param)
    lualib:FamilyInt(family, name, param)
    if param ~= nil then
        setguildvar(family, name, par, 1)
    else
        setguildvar(family, "_FamilyInt" .. name, par, 1)
    end
    return true
end

--清理行会全部自定义变量
function lualib:ClearFamily(family_name) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
    if family_name == nil then
        clearguildcustvar(" ", '*')
    else
        clearguildcustvar(family_name, '*')
    end
    return true
end

--清理行会自定义数值变量
function lualib:ClearFamilyInt(family_name, str, param) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
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

--清理行会自定义字符变量
function lualib:ClearFamilyStr(family_name, str, param) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
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

--清理全局自定义变量
function lualib:ClearGlobal() --变量名, 多个变量用|分隔 *代表所有变量
    clearglobalcustvar("*")
    return true
end

--清理全局自定义字符变量
function lualib:ClearGlobalStr(str, param) --变量名, 多个变量用|分隔 *代表所有变量
    if param == nil then
        str = "_DBStr" .. str
        str = str:gsub("|", "|_DBStr")
    end
    clearglobalcustvar(str)
    return true
end

--清理全局自定义数值变量
function lualib:ClearGlobalNum(str, param) --变量名, 多个变量用|分隔 *代表所有变量
    if param == nil then
        str = "_DBNum" .. str
        str = str:gsub("|", "|_DBNum")
    end
    clearglobalcustvar(str)
    return true
end

--初始化全局自定义字符串变量
function lualib:SystemStr(name, param)
    if param ~= nil then
        inisysvar("string", name)
    else
        inisysvar("string", "_DBStr" .. name)
    end
    return true
end

--初始化全局自定义数值型变量
function lualib:SystemInt(name, param)
    if param ~= nil then
        inisysvar("string", name)
    else
        inisysvar("string", "_DBNum" .. name)
    end
    return true
end

--[[
初始化自定义变量
inisysvar

参数
参数名	必选	类型	说明
sVartype	是	string	变量类型(integer/string)
sVarName	是	string	变量名
itype	是	int	合区类型 默认0
0:保留主区
1:保留副区(多副区以最后一个为准)
2:取大（字符型不可用）
3:取小（字符型不可用）
4:相加（字符型不可用）
5:相连（整数型不可用）
6:删除
--]]
---初始化自定义变量
---@param sVartype string 变量类型(integer/string)
---@param sVarName string 变量名
---@param itype number 合区类型 默认0 0:保留主区 1:保留副区(多副区以最后一个为准) 2:取大（字符型不可用） 3:取小（字符型不可用） 4:相加（字符型不可用） 5:相连（整数型不可用） 6:删除
function lualib:InitDBVar(sVartype, sVarName, itype)
    if itype == nil then
        itype = 0
    end
    inisysvar(sVartype, sVarName, itype)
end

---获取全局自定义变量
---@param sVarName string 变量名
function lualib:GetDBVar(sVarName)
    return getsysvarex(sVarName)
end

---设置全局自定义变量
---@param sVarName string 变量名
---@param sVarValue string 变量值
---@param sVarType number 是否保存到数据库,0:不保存，1：保存
function lualib:SetDBVar(sVarName, sVarValue, sVarType)
    if sVarType == nil then
        sVarType = 1
    end
    setsysvarex(sVarName, sVarValue, sVarType)
end

---初始化个人自定义字符串变量
---@param player userdata 玩家对象
---@param name string 变量名
function lualib:PlayerStr(player, name)
    iniplayvar(player, "string", "HUMAN", name)
    return true
end

---初始化个人自定义数值型变量
---@param player userdata 玩家对象
---@param name string 变量名
function lualib:PlayerInt(player, name, param)
    iniplayvar(player, "integer", "HUMAN", name)
    return true
end

---获取个人自定义字符变量
---@param player userdata 玩家对象
---@param name string 变量名
function lualib:GetPlayerStr(player, name)
    lualib:PlayerStr(player, name, param)
    return getplayvar(player, "HUMAN", name)
end

---设置个人自定义字符变量
---@param player userdata 玩家对象
---@param name string 变量名
---@param par string 变量值
---@param param boolean 是否保存到数据库,0:不保存，1：保存
function lualib:SetPlayerStr(player, name, par)
    lualib:PlayerStr(player, name, param)
    setplayvar(player, "HUMAN", name, par, 1)
    return true
end

---获取个人自定义数值变量
---@param player userdata 玩家对象
---@param name string 变量名
function lualib:GetPlayerInt(player, name)
    lualib:PlayerInt(player, name)
    return getplayvar(player, "HUMAN", name)
end

---设置个人自定义数值变量
---@param player userdata 玩家对象
---@param name string 变量名
---@param par number 变量值
function lualib:SetPlayerInt(player, name, par)
    lualib:PlayerInt(player, name)
    setplayvar(player, "HUMAN", name, par, 1)
    return true
end

--获取玩家临时字符串变量
function lualib:GetStr(player, name)
    return getplaydef(player, "S$" .. name)
end

--设置玩家临时字符串变量
function lualib:SetStr(player, name, par)
    setplaydef(player, "S$" .. name, par)
    return true
end

--获取玩家临时数值型变量
function lualib:GetInt(player, name)
    return getplaydef(player, "N$" .. name)
end

--设置玩家临时数值型变量
function lualib:SetInt(player, name, par)
    setplaydef(player, "N$" .. name, par)
    return true
end

--获取分辨率
function lualib:GetPx(player)
    return tonumber(parsetext("<$SCREENWIDTH>", player)), tonumber(parsetext("<$SCREENHEIGHT>", player))
end

--服务器名称
function lualib:ServerName(player)
    return parsetext("<$SERVERNAME>", player)
end

---根据唯一id删除物品
---@param player userdata 玩家对象
---@param makeIndex string 物品唯一ID，逗号串联
---@param count number 物品数量
function lualib:DelItemByMakeIndex(player, makeIndex, count)
    if delitembymakeindex(player, makeIndex, count) then
        return true
    else
        return false
    end
end

---根据唯一id删除物品
---@param player userdata 玩家对象
---@param id string 物品唯一ID，逗号串联
function lualib:DestroyItem(player, id) --物品唯一ID，逗号串联
    if delitembymakeindex(player, id) then
        return true
    else
        return false
    end
end

--发送前端数据
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

--发送脚本表单
function lualib:Invoke(player, func, p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF)
    if not lualib:IsPlayer(player) then return "" end
    if type(func) ~= "string" or func == "" then
        print("Invoke函数调用失败，函数名传递错误！")
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
            print("Invoke函数调用错误，函数类型参数不支持！")
        else
            print("Invoke函数调用错误，未知的参数类型！")
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
    lualib:ShowFrom(player, "脚本表单", script)
    return true
end

--传送
--function lualib:MapMove(player,maps,x,y,r) --传送地图 x坐标 y坐标 范围
--    if maps == nil then return"" end
--    if x==nil then
--        map(player,maps)
--    else
--        mapmove(player,maps,x,y,r)
--    end
--    return true
--end
---弹框
---@param player void 玩家id
---@param str string 内容
---@param confirmFunc string 确认函数@confirm
---@param cancelFunc string 取消函数@cancel
function lualib:MsgBox(player, str, confirmFunc, cancelFunc)
    confirmFunc = confirmFunc or ""
    cancelFunc = cancelFunc or ""
    messagebox(player, str, confirmFunc, cancelFunc)
    return true
end

---操作玩家的血量
---@param player void 玩家id
---@param operate void 操作类型'+''-''='
---@param hp void 血量
---@param id void 素材id
---@param delay void 延迟支持小数
---@param hiter void 伤害来源对象
function lualib:SetHp(player, operate, hp, effid, delay, hiter)
    return humanhp(player, operate, hp, effid, delay, hiter)
end

---操作玩家的蓝量
---@param player void 玩家id
---@param operate void 操作类型'+''-''='
---@param mp void 蓝量
function lualib:SetMp(player, operate, mp)
    return humanmp(player, operate, mp)
end

---操作玩家的血量百分比
---@param player void 玩家id
---@param operate void 操作类型'+''-''='
---@param percent void 血量百分比
function lualib:SetHpEx(player, operate, percent)
    callscriptex(player, "AddhpPer", operate, percent)
end

---操作玩家的蓝量百分比
---@param player void 玩家id
---@param operate void 操作类型'+''-''='
---@param percent void 蓝量百分比
function lualib:SetMpEx(player, operate, percent)
    callscriptex(player, "AddmpPer", operate, percent)
end

---获取生命值百分比
---@param player void 玩家id
function lualib:HpEx(player)
    return math.ceil((lualib:Hp(player, false) / lualib:Hp(player, true)) * 100)
end

---获取魔法值百分比
---@param player void 玩家id
function lualib:MpEx(player)
    return math.ceil((lualib:Mp(player, false) / lualib:Mp(player, true)) * 100)
end

---是否在安全区
---@param player void 玩家id
function lualib:IsSafeArea(player)
    return getbaseinfo(player, 48)
end

---设置游戏速度
---@param player void 玩家id
---@param par void 速度类型'1-移动速度2-攻击速度3-施法速度'
---@param var void 速度等级'-10-10'
function lualib:ChangeSpeed(player, par, var)
    changespeed(player, par, var)
    return true
end

---添加技能
---@param player void 玩家id
---@param skill void 技能id
---@param lv void 技能等级
function lualib:AddSkill(player, skill, lv)
    if getskillinfo(player, skill, 1) then
        Message:Msg9(player, "已学习该技能！")
        return
    end
    addskill(player, skill, lv)

    GameEvent.push(EventCfg.onAddSkill, player, skill, lv)
end

---删除技能
---@param player void 玩家id
---@param skill void 技能id
function lualib:DelSkill(player, skill)
    delskill(player, skill)
    GameEvent.push(EventCfg.onDelSkill, player, skill)
end

---设置技能等级
---@param player void 玩家id
---@param skillid void 技能id
---@param flag void 类型 1-技能等级 2-强化等级 3-熟练度
---@param point void 等级或点数
function lualib:SetSkillInfo(player, skillid, flag, point)
    setskillinfo(player, skillid, flag, point)
    GameEvent.push(EventCfg.onSetSkillInfo, player, skillid, flag, point)
end

---获取背包内某物品数量
---@param player void 玩家id
---@param itemName void 物品名称
---@return number 物品数量
function lualib:GetBagItemCount(player, itemName)
    return getbagitemcount(player, itemName)
end

---添加物品
---@param player void 玩家id
---@param item_n void 物品名称
---@param item_m void 物品数量
---@param item_b void 物品规则
---@param desc void 物品描述
function lualib:AddItem(player, item_n, item_m, item_b, desc) --道具名称  道具数量 道具规则 (最后一个物品对象)，不建议使用在叠加物品，一次性给多个物品的情况，此物品在添加背包触发后，注意可能被回收的情况
    item_b = item_b or 0
    local item = giveitem(player, item_n, item_m, item_b)
    if desc then
        logact(player, 10001, table.concat({ desc, "：", item_n, " * ", item_m }))
    else
        logact(player, 10001, table.concat({ "消耗：", item_n, " * ", item_m }))
    end
    return item
end

---是否拥有物品
---@param player void 玩家id
---@param item_n void 物品名称
function lualib:HasItem(player, item)
    return hasitem(player, item)
end

---添加装备并装备
---@param player void 玩家id
---@param where void 装备位置
---@param item_n void 物品名称
---@param item_b void 物品规则 可为空
function lualib:AddAndEquipItem(player, where, itemName, item_b)
    if item_b == nil then
        item_b = 0
    end
    return giveonitem(player, where, itemName, 1, item_b)
end

---删除物品
---@param player void 玩家id
---@param item_n void 物品名称
---@param item_m void 物品数量
---@param item_j void 是否忽略极品
---@param desc void 物品描述
function lualib:DelItem(player, item_n, item_m, item_j, desc, logId) --名称 数量 忽略极品（0不1是）
    item_j = item_j or 0
    logId = logId or 10002
    if item_m == 0 then
        return true
    end
    if takeitem(player, item_n, item_m, item_j) then
        if desc then
            logact(player, logId, table.concat({ desc, "：", item_n, " * ", item_m }))
        else
            logact(player, logId, table.concat({ "消耗：", item_n, " * ", item_m }))
        end
        return true
    else
        return false
    end
end

---是否在攻城
function lualib:IsCastle()
    return castleinfo(5)
end

---强制攻击模式
---@param player void 玩家id
---@param par void 攻击模式'0-全体攻击1-和平攻击2-夫妻攻击3-师徒攻击4-编组攻击5-行会攻击6-红名攻击7-国家攻击'
---@param time void 持续时间
function lualib:SetAttackMode(player, par, time)
    setattackmode(player, par, time)
    return true
end

---获取攻击模式
---@param player void 玩家id
---@return number 攻击模式'0-全体攻击1-和平攻击2-夫妻攻击3-师徒攻击4-编组攻击5-行会攻击6-红名攻击7-国家攻击'
function lualib:GetAttackMode(player)
    return getattackmode(player)
end

---获取玩家沙巴克身份
---@param player void 玩家id
---@return number 沙巴克身份'0-非沙巴克成员1-沙巴克成员2-沙巴克老大'
function lualib:GetCastleIdentity(player)
    return castleidentity(player)
end

-- 禁止频繁触发  禁止变量  禁止秒数 单位:秒
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

---修改人物模式
---@param player void 玩家id
---@param idx void 模式1~24
---@param time void 时间(秒)
---@param par void 参数1,12-13，18，20，21代表几率，其余代表属性值
---@param pars void 参数2，代表属性值
function lualib:ChangeMode(player, idx, time, par, pars) --建议看后端说明书..
    changemode(player, idx, time, par, pars)
    return true
end

---增加附加伤害效果
---@param player void 玩家id
---@param x void x坐标
---@param y void y坐标
---@param r void 半径
---@param pow void 威力
---@param addtype void 附加类型
---@param addvalue void 附加属性值：
---@param checkstate void 检查类型 0=玩家 1=怪物 2=玩家和怪物
---@param targettype void 目标类型(0或空=所有目标;1=仅人物;2=仅怪物)
---@param effectid number 特效id
---@param harmNum number 群体伤害目标个数
function lualib:RangeHarm(player, x, y, r, pow, addtype, addvalue, checkstate, targettype, effectid, harmNum)
    rangeharm(player, x, y, r, pow, addtype, addvalue, checkstate, targettype, effectid, harmNum)
    return true
end

---修改人物怪物状态
---@param player void 玩家id
---@param par void 状态id 类型(0=绿毒 1=红毒 5=麻痹 12=冰冻 13= 蛛网 其他无效) 时间（秒） 威力，只针对绿毒有用
---@param time void 持续时间
---@param value void 威力
function lualib:MakePoison(player, param, time, value)
    makeposion(player, param, time, value)
end

-- 解毒
function lualib:Detox(player)
    if not lualib:IsPlayer(player) then return "" end
    callscriptex(player, "DETOXIFCATION")
    return true
end

--修改人物临时属性
function lualib:SetValue(player, att_id, par, time) --属性id 属性值 持续时间
    if not lualib:IsPlayer(player) then return "" end
    changehumnewvalue(player, att_id, par, time)
    recalcabilitys(player)
    return true
end

--获取人物临时属性
function lualib:GetValue(player, att_id)
    if not lualib:IsPlayer(player) then return "" end
    return gethumnewvalue(player, att_id)
end

--获取人物自定义属性
function lualib:GetValueEx(player, att_id)
    if not lualib:IsPlayer(player) then return "" end
    recalcabilitys(player)
    return tonumber(getconst(player, "<$CUSTABIL[" .. att_id .. "]>"))
end

---设置物品属性
---@param player void 玩家id
---@param item void 物品id
---@param att void 属性id 0.AC1.MAC2.DC3.MC4.SC5.幸运6.准确7.敏捷8.攻击速度9.魔法躲避10.毒物躲避11.体力恢复12.魔法恢复13.中毒恢复15.沙巴克武器升级标记20.物理伤害减少21.魔法伤害减少22.忽视目标防御23.所有伤害反弹24.人物体力增加25.人物魔力增加26.增加目标爆率27.神 圣28.强 度29.诅 咒30.暴击率31.暴击伤害32.攻击伤害 40~44. 脚本使用
function lualib:SetItemValue(player, item, att, par)
    setitemaddvalue(player, item, 1, att, par)
    return true
end

---获取物品属性
---@param player void 玩家id
---@param item void 物品id
---@param att number 属性id 0.AC1.MAC2.DC3.MC4.SC5.幸运6.准确7.敏捷8.攻击速度9.魔法躲避10.毒物躲避11.体力恢复12.魔法恢复13.中毒恢复15.沙巴克武器升级标记20.物理伤害减少21.魔法伤害减少22.忽视目标防御23.所有伤害反弹24.人物体力增加25.人物魔力增加26.增加目标爆率27.神 圣28.强 度29.诅 咒30.暴击率31.暴击伤害32.攻击伤害 40~44. 脚本使用
function lualib:GetItemValue(player, item, att)
    return getitemaddvalue(player, item, 1, att)
end

--让怪物再爆(注意:在后面的对象会实现)
function lualib:MonItem(player, par) --怪物名称 可爆次数(最大20次)
    monitems(player, par)
    return true
end

--让怪物再爆
function lualib:MonItemex(player, mob, par, time) --怪物名称 可爆次数(最大20次) 延迟毫秒数(默认不延迟)
    callscriptex(player, "MonItemsex", mob, par, time)
    return true
end

-- 临时增加怪物爆率
function lualib:MobItemsList(player, mob, item) --多个物品使用|分隔；增加爆出物品，需要在KillMon触发中使用，仅一次有效。
    additemtodroplist(player, mob, item)
    return true
end

--设置怪物爆率
function lualib:SetMobAtt(player, par, time)
    -- setbaseinfo(player,43,par)
    callscriptex(player, "KILLMONBURSTRATE", par, time)
    return true
end

--设置人物神力倍攻
function lualib:SetPlayerPower(player, par, time)
    powerrate(player, par, time)
    return true
end

--获取称号列表
function lualib:Title_Tb(player)
    return gettitlelist(player)
end

---顶戴花翎
---@param player void 玩家id
---@param where void 位置(0-9)
---@param effType void 播放效果(0图片名称 1特效ID)
---@param resNameOrId void 特效id
---@param x void X坐标 (为空时默认X=0)
---@param y void Y坐标 (为空时默认Y=0)
---@param drop void 自动补全空白位置0,1(0=掉 1=不掉)
---@param selfsee void 是否只有自己看见(0=所有人都可见 1=仅仅自己可见)
---@param posM number 播放位置(不填默认为0)0=在角色之上;1=在角色之下;
function lualib:SetIcon(player, where, effType, resNameOrId, x, y, drop, selfsee, posM)
    seticon(player, where, effType, resNameOrId, x, y, drop, selfsee, posM)
    return true
end

---人物特效
---@param player void  玩家id
---@param effectid number  特效id
---@param x number  相对于人物偏移的X坐标
---@param y number  相对于人物偏移的Y坐标
---@param times number  播放次数0-一直播放
---@param behind number  播放模式0-前面1-后面
---@param selfshow number  仅自己可见0-否，视野内均可见，1-是
function lualib:PlayerEffect(player, effectid, x, y, times, behind, selfshow)
    playeffect(player, effectid, x, y, times, behind, selfshow)
    return true
end

---删除人物特效
---@param player void  玩家id
---@param txid number  特效id
function lualib:ClearPlayerEffect(player, txid)
    clearplayeffect(player, txid)
    return true
end

---获取pk值
---@param player void  玩家id
function lualib:Pk(player)
    return getbaseinfo(player, 46)
end

---设置pk值
---@param player void  玩家id
---@param par void  pk值
function lualib:SetPk(player, par)
    setbaseinfo(player, 46, par)
    recalcabilitys(player)
end

---获取合区次数
function lualib:GetConvertCount()
    return grobalinfo(3)
end

-- 获取地图怪物数量
function lualib:GetMapMobs(map, mob, x, y, r) --怪物名，为空 or * 为检测所有怪
    return checkrangemoncount(map, mob, x, y, r)
end

--清理怪物
function lualib:ClearMapMob(map) --地图代码
    -- killmonsters(map,mob,0,false)
    callscriptex(nil, "CLEARMAPMON", map)
    return true
end

---刷怪
---@param map void  地图代码
---@param x void  x坐标
---@param y void  y坐标
---@param r void  范围
---@param mob void  怪物名称
---@param num void  怪物数量
---@param color void  怪物名字颜色
function lualib:GenMon(map, x, y, r, mob, num, color) --地图代码 x坐标 y坐标 范围 怪物名称 怪物数量 怪物名字颜色
    local tb = genmon(map, x, y, mob, r, num, color)
    return tb
end

---自动拾取
---@param player void  玩家id
---@param mode number  模式（0=以人物为中心捡取，1=以小精灵为中心捡取）
---@param range number  范围
---@param time number  间隔，最小500ms
function lualib:PickupItems(player, mode, range, time)
    pickupitems(player, mode, range, time)
end

---停止拾取
---@param player void  玩家id
function lualib:StopPickupItems(player)
    stoppickupitems(player)
end

--所有行会今晚攻城
function lualib:AddAttackSabukAll()
    addattacksabakall()
    callscriptex(nil, "AddAttackSabukAll", 0)
    return true
end

--获取NPC对象
function lualib:Npc(npcidx)
    getnpcbyindex(npcidx)
    return true
end

-- 获取物品来源
function lualib:GetItemJosnLy(player, item)
    local str_tb = getthrowitemly(player, item)
    str_tb = cjson.decode(str_tb)
    return str_tb
end

-- 获取物品变量
function lualib:GetItemInt(player, item, var)
    return getitemaddvalue(player, item, 1, 40 + var)
end

-- 设置物品变量
function lualib:SetItemInt(player, item, var, par)
    setitemaddvalue(player, item, 1, 40 + var, par)
    return true
end

--获取微信验证码
function lualib:WeChatKey(player, par) --1获取绑定KEY 2获取解绑KEY 3获取验证KEY
    callscriptex(player, "BindWeChat", par)
    return true
end

--清除公众号所有常量
function lualib:ClearWeChat(player)
    callscriptex(player, "ClearWeChat")
    return true
end

---创建进度条
function lualib:Star_Show(player, time, fun, str, int, funs) --进度条时间秒 成功函数 提示消息 是否可中断（0,1） 中断函数
    showprogressbardlg(player, time, fun, str, int, funs)
    return true
end

--创建界面
function lualib:CreateWnd(player, w, h, img) --宽 高 图片
    local w, h = tonumber(w), tonumber(h)
    lualib:SetInt(player, "界面宽度", w)
    lualib:SetInt(player, "界面高度", h)
    lualib:SetInt(player, "开启引导", 0)
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

---关闭界面
function lualib:WndClose(player)
    close(player)
    return true
end

---踢下线
function lualib:Kick(player)
    kick(player)
    return true
end

-- 在控制台打印消息
function lualib:Warn(message)
    release_print(message)
end

---发送聊天框消息
---@param player string 玩家id
---@param Msg string 消息内容
---@return void 无
function lualib:SysWarnMsg(player, Msg) --发送对象：1-自己，
    local msgT = table.deepCopy(ConstCfg.WARN_MSG_TB, msgT)
    msgT.Msg = Msg
    local msg = tbl2json(msgT)
    sendmsg(player, 1, msg)
    return true
end

--发送聊天框消息
function lualib:SysWarn(player, Msg) --发送对象：1-自己，
    local msgT = table.deepCopy(ConstCfg.WARN_MSG_TB, msgT)
    msgT.Msg = Msg
    local msg = tbl2json(msgT)
    sendmsg(player, 1, msg)
    return true
end

-- 初始化自定义变量
function lualib:InitPlayerVar(player, varType, varArea, varName)
    return iniplayvar(player, varType, varArea, varName)
end

---初始化int类型的自定义变量(HUMAN)
---@param player void 玩家id
---@param varName void 变量名
function lualib:InitPlayerIntHumVar(player, varName)
    return iniplayvar(player, "integer", "HUMAN", varName)
end

---初始化string类型的自定义变量(HUMAN)
---@param player void 玩家id
---@param varName void 变量名
function lualib:InitPlayerStrHumVar(player, varName)
    return iniplayvar(player, "string", "HUMAN", varName)
end

---自定义变量排序(HUMAN)
---@param varName void 变量名
---@param playerFlag void 玩家标识 0-所有玩家 1-当前玩家 2-行会
---@param sortFlag void 排序标识 0-升序 1-降序
---@param count void 数量
---@return table
function lualib:SortHumanVar(varName, playerFlag, sortFlag, count)
    return sorthumvar(varName, playerFlag, sortFlag, count)
end

---取自定义数字变量名位置
---@param player void 玩家id
---@param varName void 变量名
---@param playerFlag void 玩家标识 0-所有玩家 1-当前玩家 2-行会
---@param sortFlag void 排序标识 0-升序 1-降序
---@return number 玩家名次
function lualib:humanVarRank(player, varName, playFlag, sortFlag)
    return humvarrank(player, varName, playFlag, sortFlag)
end

---清理个人自定义变量
---@param player void 玩家id传入*为清理所有玩家
---@param varName void 变量名 传入*为清理所有变量
function lualib:ClearHumanCusVar(player, varName)
    clearhumcustvar(player, varName)
end

---获取玩家GUID
---@param player void 玩家GUID
function lualib:Name2GUID(playerName)
    return getplayerbyname(playerName)
end

---根据玩家id获取玩家GUID
---@param playerId void 玩家id
function lualib:ID2GUID(playerId)
    return getplayerbyid(playerId)
end

---清理玩家身上的特效
---@param player void 玩家GUID
function lualib:DelEffectOfPlayer(player, magicID)
    return clearplayeffect(player, magicID)
end

---给玩家身上播放特效
---@param player void 玩家GUID
function lualib:AddEffectOfPlayer(player, magicID, offsetX, offsetY, times, behind, showType)
    return playeffect(player, magicID, offsetX, offsetY, times, behind, showType)
end

---给玩家添加称号
---@param player void 玩家GUID
---@param titleName void 称号名称
function lualib:AddTitle(player, titleName)
    return confertitle(player, titleName, 0)
end

---给玩家添加称号并激活
---@param player void 玩家GUID
---@param titleName void 称号名称
function lualib:AddTitleEx(player, titleName)
    return confertitle(player, titleName, 1)
end

---玩家删除称号
---@param player void 玩家GUID
---@param titleName void 称号名称
function lualib:DelTitle(player, titleName)
    return deprivetitle(player, titleName)
end

---玩家显示称号
---@param player void 玩家GUID
---@param titleName void 称号名称
function lualib:ApplyTitle(player, titleName)
    return setranklevelname(player, titleName)
end

---检测玩家称号
---@param player void 玩家GUID
---@param titleName void 称号名称
function lualib:HasTitle(player, titleName)
    return checktitle(player, titleName)
end

---获取玩家货币
---@param player string 玩家GUID
---@param coinId number 货币id
function lualib:GetMoney(player, coinId)
    return querymoney(player, coinId)
end

---获取玩家货币根据货币名字
---@param player void 玩家GUID
---@param coinName string 货币名字 如：元宝
function lualib:GetMoneyEx(player, coinName)
    local coinId = self:GetStdItemInfo(coinName, 0)
    return querymoney(player, coinId)
end

---设置玩家货币
---@param player void 玩家GUID
---@param coinId void 货币类型
---@param opt void 操作符 '+ - ='
---@param count void 数量
---@param desc void 描述
---@param send void 是否发送消息
function lualib:SetMoney(player, coinId, opt, count, desc, send)
    return changemoney(player, coinId, opt, count, desc, send)
end

---设置玩家货币根据货币名字
---@param player void 玩家GUID
---@param coinName string 货币名字 如：元宝
---@param opt void 操作符 '+ - ='
---@param count void 数量
---@param desc void 描述
---@param send void 是否发送消息
---@return boolean 是否成功
function lualib:SetMoneyEx(player, coinName, opt, count, desc, send)
    local coinId = self:GetStdItemInfo(coinName, 0)
    return changemoney(player, coinId, opt, count, desc, send)
end

---添加玩家货币
---@param player void 玩家GUID
---@param coinId void 货币类型
---@param count void 数量
---@param desc void 描述
function lualib:AddMoney(player, coinId, count, desc)
    return changemoney(player, coinId, "+", count, desc, true)
end

---扣除玩家货币
---@param player void 玩家GUID
---@param coinId void 货币类型
---@param count void 数量
---@param desc void 描述
function lualib:SubMoney(player, coinId, count, desc)
    return changemoney(player, coinId, "-", count, desc, true)
end

--[[
M0-M99 个人数字变量（100个），下线不保存
D0-D99 个人数字变量（100个），下线不保存
N0-N99 个人数字变量（100个），下线不保存
U0-U254 个人数字变量（255个），可保存
S0-S99 个人字符变量（100个），下线不保存
T0-T254 个人字符变量（255个），下线保存
支持自定义临时变量
格式：1.自定义数字变量，以N$为头标志；
2.自定义字符变量，以S$为头标志
--]]
---获取变量
---@param player void 玩家GUID 此处若player为nil则为系统变量
---@param varName void 变量名
---@return void 变量值
function lualib:GetVar(player, varName)
    if player == nil or player == "0" or player == 0 then
        return getsysvar(varName)
    else
        return getplaydef(player, varName)
    end
end

---设置变量
---@param player void 玩家GUID 此处若player为nil则为系统变量
---@param varName void 变量名
---@param varValue void 变量值
function lualib:SetVar(player, varName, varValue)
    --限制改变职业
    -- if VarCfg["人物职业"] and varName == VarCfg["人物职业"] and self.GetVar(player, VarCfg["人物职业"]) ~= 0 then
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

------------------------------------------------------------------------------------------------------------------------地图部分
---玩家飞地图随机点
---@param player void 玩家GUID
---@param mapId void 地图Id
function lualib:MapMove(player, mapId)
    return map(player, mapId)
end

---玩家飞地图指定地点
---@param player void 玩家GUID
---@param mapId void 地图的id
---@param x void x坐标
---@param y void y坐标
---@param r void 范围
function lualib:MapMoveXY(player, mapId, x, y, r)
    if x and y then
        return mapmove(player, mapId, x, y, r)
    else
        return move(player, mapId)
    end
end

---获取客户端类型
---@param player void 玩家GUID
---@return number type= 1:PC 2:移动
function lualib:GetClientType(player)
    return tonumber(getconst(player, "<$CLIENTFLAG>"))
end

---用于获取多个children id描述
---比如: 背景1,背景2,背景3
---则用  lualib:GetConcatArrTbStr(3, "背景", ",")
---@param count number 需要链接的数量
---@param prefix string 每个str的前缀其后缀默认为序号
---@param cat string 连接符 默认为","
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

---用于获取多个children id描述
---比如: 背景1,背景2,背景3
---则用  lualib:GetConcatArrTbStr(3, "背景", ",")
---@param count number 需要链接的数量
---@param prefix table 每个str的前缀其后缀默认为序号
---@param cat string 连接符 默认为","
function lualib:GetConcatArrTbStrEx(count, prefixTb, cat)
    local str = ""
    local tempTb = {}
    for i = 1, #prefixTb do
        table.insert(tempTb, self:GetConcatArrTbStr(count, prefixTb[i], cat))
    end
    return table.concat(tempTb, ",")
end

---根据权重获取一个随机元素值
---根据权重随机获取一个元素的索引
--[[
    表实例
    local weights = {
        {n="XX", weight=6},
        {n="XXX", weight=94},
    }
--]]
---根据权重表随机获取一个元素和索引
---@param weights：权重表
---@return table 随机到的元素
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

---用Lua做面板时虽然客户端可以进行一些常规的检测判断，但服务端也必须要同时做判断，因客户端是可修改的就像微信可以改变任意余额一样，所以在客户端满足的情况下服务端也要同时判断
---输入框中请必须判断是否包含“<,>,/,\,@”符号，如有请禁止
---@param input：输入的内容
function lualib:CheckInput(input)
    local pattern = "[<>/%@\\]"
    if string.find(input, pattern) then
        -- 包含指定符号，禁止输入
        return false
    else
        -- 不包含指定符号，允许输入
        return true
    end
end

---重新封装sendmsg
---实际使用时，只需要传入player, sendTarget, msg, Type
---lualib:SendMsg(player, sendTarget, msg, Type)
---其他参数可选
---@param player void 玩家id
---@param sendTarget void 发送目标 1-自己，2-全服 3-行会，4-当前地图 5-组队
---@param msg void 消息内容
---@param Type void 消息类型
---@param FColor void 字体颜色
---@param BColor void 背景颜色
---@param Time void 消息显示时间
---@param SendName void 发送者名称
---@param SendId void 发送者id
---@return ：无返回值
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

---查找目标字符串中是否包含指定字符串
---@param str void 目标字符串
---@param findStr void 指定字符串
---@param isCase void 是否区分大小写
function lualib:FindStr(str, findStr, isCase)
    local b, e
    if isCase then
        b, e = string.find(str, findStr)
    else
        b, e = string.find(string.lower(str), string.lower(findStr))
    end
    if b then return true else return false end
end

---复活玩家
---@param player void 玩家id
---@param percent void 复活百分比(可选)
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

---获取物品List表的展示控件str
---@param list void 物品列表
---@param prefix void 控件前缀
---@param beginX void 起始X坐标
---@param beginY void 起始Y坐标
---@param lWidth void 控件宽度
---@param lHeight void 控件高度
---@param margin void 控件间距 table类型，{30, 30}
---@param scale void 控件缩放比例
---@param column void 列数
---@param centerFlag void 是否居中显示 nil则不居中，其它则居中
---@return ：拼接完的list字符串
function lualib:GetListItemShowStr(list, prefix, beginX, beginY, lWidth, lHeight, margin, scale, column, centerFlag,
                                   bkData, magicData)
    local str = ""
    local pw, ph = math.floor(56 * scale), math.floor(56 * scale)
    local marginW, marginH = margin[1], margin[2]
    local tc = #list
    if column then
        -- 以list制作一个列表，其每行有column个元素，行数为row行
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
            self:GetConcatArrTbStr(#tempList, prefix .. "行", ",") ..
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
                childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "背景图" .. i, ",") .. ","
            end
            if magicData then
                childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "特效" .. i, ",") .. ","
            end
            childrenStr = childrenStr .. self:GetConcatArrTbStr(#tempRow, prefix .. "物品展示" .. i, ",") .. ","

            str = str ..
                "<Layout|id=" .. prefix .. "行" .. i .. "|children={" .. childrenStr ..
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
                        "背景图" ..
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
                    "物品展示" ..
                    i .. j .. "|x=" .. (posX) ..
                    "|y=0|bgtype=0|itemcount=" .. itemNum .. "|itemid=" .. itemId .. "|scale=" .. scale .. ">"
                if magicData then
                    str = str ..
                        "<Effect|id=" ..
                        prefix ..
                        "特效" ..
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
                prefix .. "背景图" .. i .. "," .. prefix .. "特效" ..
                i .. "," .. prefix .. "物品框" .. i .. "}|width=" .. pw .. "|height=" .. ph .. ">"
            if bkData then
                str = str ..
                    "<Img|id=" ..
                    prefix ..
                    "背景图" ..
                    i ..
                    "|x=" .. bkData.x .. "|y=" ..
                    bkData.y .. "|width=" .. bkData.w .. "|height=" .. bkData.h .. "|img=" .. bkData.img .. ">"
            end
            if magicData then
                str = str ..
                    "<Effect|id=" ..
                    prefix ..
                    "特效" ..
                    i ..
                    "|x=" ..
                    magicData.x ..
                    "|y=" ..
                    magicData.y .. "|effectid=" .. magicData.id .. "|effecttype=0|scale=" .. magicData.scale .. ">"
            end
            str = str ..
                "<ItemShow|id=" ..
                prefix ..
                "物品框" .. i .. "|bgtype=0|itemcount=" .. itemNum .. "|itemid=" .. itemId .. "|scale=" .. scale ..
                ">"
        end
    end
    return str
end

---获取当前地图名称
---@param obj void 玩家id,怪物id
---@return ：地图名称
function lualib:GetMapId(obj)
    return getbaseinfo(obj, 3)
end

---获取当前地图名称
---@param obj void 玩家id,怪物id
---@return ：地图名称
function lualib:GetMapName(obj)
    return getbaseinfo(obj, 45)
end

---获取当前所在地图的X坐标
---@param obj void 玩家id,怪物id
---@return ：X坐标
function lualib:X(obj)
    return getbaseinfo(obj, 4)
end

---获取当前所在地图的Y坐标
---@param obj void 玩家id,怪物id
---@return ：Y坐标
function lualib:Y(obj)
    return getbaseinfo(obj, 5)
end

---获取对象的名字
---@param obj void 玩家id,怪物id
---@return ：对象名字
function lualib:Name(obj)
    return getbaseinfo(obj, 1)
end

---判断对象是否是玩家
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:IsPlayer(obj)
    return isplayer(obj)
end

---判断对象是否是怪物
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:IsMonster(obj)
    return ismon(obj)
end

---判断对象是否是宠物
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:IsPet(obj)
    return ismob(obj)
end

---判断对象是否是假人
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:IsDummy(obj)
    return callcheckscriptex(obj, "IsDummy")
end

---获取对象的userid
---@param obj void 玩家id,怪物id
---@return ：userid
function lualib:UserId(obj)
    return getbaseinfo(obj, 2)
end

---获取对象的等级
---@param obj void 玩家id,怪物id
---@return ：等级
function lualib:Level(obj)
    return getbaseinfo(obj, 6)
end

---设置对象的等级
---@param player void 玩家id,怪物id
---@param level void 等级
function lualib:SetLevel(player, level)
    setbaseinfo(player, 6, level)
    recalcabilitys(player)
end

---获取对象的职业
---@param obj void 玩家id,怪物id
---@return ：职业 0战 1法 2道
function lualib:Job(obj)
    return getbaseinfo(obj, 7)
end

---设置对象的职业
---@param obj void 玩家id,怪物id
---@param job void 职业 0战 1法 2道
function lualib:SetJob(player, job)
    setbaseinfo(player, 7, job)
    recalcabilitys(player)
end

---获取对象的性别
---@param obj void 玩家id,怪物id
---@return ：性别 0男 1女
function lualib:Gender(obj)
    return getbaseinfo(obj, 8)
end

---设置对象的性别
---@param player void 玩家id,怪物id
---@param job void 性别 0男 1女
function lualib:SetGender(player, gender)
    setbaseinfo(player, 8, gender)
    recalcabilitys(player)
end

---获取对象的血量
---@param obj void 玩家id,怪物id
---@param valueType void nil 当前血量 任意非nil 最大血量
---@return ：血量
function lualib:Hp(obj, valueType)
    if not valueType then
        return getbaseinfo(obj, 9)
    else
        return getbaseinfo(obj, 10)
    end
end

---获取对象的魔法值
---@param obj void 玩家id,怪物id
---@param valueType void nil 当前魔法值 任意非nil 最大魔法值
---@return ：魔法值
function lualib:Mp(obj, valueType)
    if not valueType then
        return getbaseinfo(obj, 11)
    else
        return getbaseinfo(obj, 12)
    end
end

---获取对象的经验值
---@param obj void 玩家id
---@param valueType void nil 当前靖雁值 任意非nil 最大经验值
---@return ：经验值
function lualib:Exp(obj, valueType)
    if valueType == nil then
        return getbaseinfo(obj, 13)
    else
        return getbaseinfo(obj, 14)
    end
end

---获取对象的转生等级
---@param obj void 玩家id
---@return ：转生等级
function lualib:ReLevel(obj)
    return getbaseinfo(obj, 39)
end

---人物转生
---@param obj void 玩家id
---@param reLevel void 转生等级
---@param toLevel void 转生后人物等级
---@param num void 转生后分配的属性
function lualib:ReLevel(player, reLevel, toLevel, num)
    renewlevel(player, reLevel, toLevel, num)
end

---设置对象的转生等级
---@param player void 玩家id
---@param reLevel void 转生等级
function lualib:SetReLevel(player, reLevel)
    self:ReLevel(player, reLevel, 0, 0)
end

---设置对象的转生等级
---@param player void 玩家id
---@param reLevel void 转生等级
function lualib:SetReLevelEX(player, reLevel)
    setbaseinfo(player, 39, reLevel)
end

---判断是不是人
---@param obj void 玩家id
---@return ：true/false
function lualib:IsPlayer(player)
    return getbaseinfo(player, -1)
end

---判断当前攻击对象是否是英雄(消耗时间太大了，不建议用)
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:Attack_IsPlayer(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 0)
end

---判断当前攻击对象是否是怪物(消耗时间太大了，不建议用)
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:Attack_IsMonster(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 1)
end

---判断当前攻击对象是否是英雄(消耗时间太大了，不建议用)
---@param obj void 玩家id,怪物id
---@return ：true/false
function lualib:Attack_IsHero(player)
    return callcheckscriptex(player, "CHECKCURRTARGETRACE", "=", 2)
end

---耗时测试开始
---@param obj void 玩家id,怪物id
function lualib:TestBegin(player)
    printusetime(player, 1)
end

---耗时测试结束
---@param obj void 玩家id,怪物id
function lualib:TestEnd(player)
    printusetime(player, 2)
end

---耗时测试开始
function lualib:TestBeginEx()
    local player = lualib:GetPlayerByName(TSGMName)
    if player ~= "0" and player ~= nil and player ~= "" then
        callscriptex(player, "PRINTUSETIME", 1)
    end
end

---耗时测试结束
function lualib:TestEndEx()
    local player = lualib:GetPlayerByName(TSGMName)
    if player ~= "0" and player ~= nil and player ~= "" then
        callscriptex(player, "PRINTUSETIME", 2)
    end
end

---随机字符串 (相比于直接列表太慢了，不建议用)
---@param weightStr void 随机字符串 格式：测试1#2000|测试2#1000|测试3#5000
function lualib:GetRandomStr(weightStr)
    -- 先用|分割
    local strList = string.split(weightStr, "|")
    -- 制作权重表
    local weightList = {}
    for i = 1, #strList do
        local str = strList[i]
        local strInfo = string.split(str, "#")
        table.insert(weightList, { strInfo[1], weight = tonumber(strInfo[2]) })
    end
    -- 获取随机结果
    local result = self:GetRndItemByWeight(weightList)
    return result[1], result.weight
end

---获取物品信息
---@param player number 玩家id
---@param item number 物品对象
---@param idx number 物品属性id'1-唯一id 2-物品id 3-剩余持久 4-最大持久 5-叠加数量 6-绑定状态 '
---@return number ：物品属性值
function lualib:GetItemInfo(player, item, idx)
    if idx == 5 then
        return (getiteminfo(player, item, idx) == 0) and 1 or getiteminfo(player, item, idx)
    else
        return getiteminfo(player, item, idx)
    end
end

---获取物品基础信息
---@param itemid/itemName number/string 物品id/物品名称
---@param idx number 物品属性idx'0:idx 1:名称 2:StdMode 3:Shape 4:重量 5:AniCount 6:最大持久 7:叠加数量 8:价格（price） 9:使用条件 10:使用等级 11:道具表自定义常量(29列)12 void道具表自定义常量（30列）'13[获取物品颜色];
function lualib:GetStdItemInfo(itemid, idx)
    return getstditeminfo(itemid, idx)
end

---获取对象基础信息
---@param obj void 玩家id,怪物id
---@param idx void 0=是否死亡(true:死亡状态) 1=角色名 2=角色唯一ID = userid 3=角色当前地图ID 4=角色X坐标 5=角色Y坐标 6=角色等级 7=角色职业(0-战 1-法 2-道） 8=角色性别 9=角色当前HP 10=角色当前MAXHP 11=角色当前MP 12=角色当前MAXMP 13=角色当前Exp 14=角色当前MaxExp
---@param idx2 void '当对象为怪物时，param3=0或缺省，返回怪物显示名（即去除了尾部的数字），'
function lualib:GetBaseInfo(obj, idx, idx2)
    return getbaseinfo(obj, idx, idx2)
end

---设置对象基础信息
---@param obj void 玩家id,怪物id
---@param idx void 0=是否死亡(true:死亡状态) 1=角色名 2=角色唯一ID = userid 3=角色当前地图ID 4=角色X坐标 5=角色Y坐标 6=角色等级 7=角色职业(0-战 1-法 2-道） 8=角色性别 9=角色当前HP 10=角色当前MAXHP 11=角色当前MP 12=角色当前MAXMP 13=角色当前Exp 14=角色当前MaxExp
---@param value void 属性值
function lualib:SetBaseInfo(obj, idx, value)
    setbaseinfo(obj, idx, value)
    recalcabilitys(obj)
end

---获取怪物的索引名
---@param obj void 怪物id
function lualib:GetMobKeyName(obj)
    return getbaseinfo(obj, 1, 1)
end

---获取攻城状态
---@param idx number 1=沙城名称，返回string 2=沙城行会名称，返回string 3=沙城行会会长名字，返回string 4=占领天数，返回number 5=当前是否在攻沙状态，返回Bool 6=沙城行会副会长名字列表，返回table
function lualib:CastleInfo(idx)
    return castleinfo(idx)
end

---在地图上播放特效
---@param id number 特效播放id
---@param mapid string 地图id
---@param x number x坐标
---@param y number y坐标
---@param effId number 特效id
---@param time number 播放时间
---@param mode number 模式:(0~4，0所有人可见，1自己可见，2组队可见，3行会成员可见，4敌对可见)
function lualib:MapEffect(id, mapid, x, y, effId, time, mode)
    mapeffect(id, mapid, x, y, effId, time, mode)
end

---删除地图上播放的特效
---@param id number 特效播放id
function lualib:RemoveMapEffect(id)
    delmapeffect(id)
end

---获取玩家标识
---@param player number 玩家id
---@param idx number 标识id
---@return number ：标识值
function lualib:GetFlagStatus(player, idx)
    return getflagstatus(player, idx)
end

---设置玩家标识
---@param player number 玩家id
---@param idx number 标识id
---@param value number 标识值
function lualib:SetFlagStatus(player, idx, value)
    setflagstatus(player, idx, value)
    if CSDataSyncUtil and CSDataSyncUtil.setSyncFlag then
        CSDataSyncUtil.setSyncFlag(player, idx, value)
    end
end

---绑定自定义装备属性
---@param play string 玩家对象
---@param item string 物品对象
---@param attrindex number 属性位置(0~9）每个装备可以自定义10个属性
---@param bindindex number 绑定类型(0~4)
---@param bindvalue number 绑定的值
---@param group number 显示分类位置(0~2 ;为空默认为0)
---@return boolean
function lualib:ChangeCustomItemAbil(play, item, attrindex, bindindex, bindvalue, group)
    return changecustomitemabil(play, item, attrindex, bindindex, bindvalue, group)
end

---修改自定义属性值
---@param play string 玩家对象
---@param item string 物品对象
---@param attrindex number 属性位置(0~9）每个装备可以自定义10个属性
---@param operate string 操作符：+、-、=
---@param value number 属性值
---@param group number 显示分类位置(0~2 ;为空默认为0)
---@return void
function lualib:ChangeCustomItemValue(play, item, attrindex, operate, value, group)
    return changecustomitemvalue(play, item, attrindex, operate, value, group)
end

---增加和修改自定义属性分类名称
---@param play string 玩家对象
---@param item string 物品对象
---@param typename string 分类名称(-1为清空)
---@param group number 显示分类位置(0~2 ;为空默认为0)
---@return void
function lualib:ChangeCustomItemText(play, item, typename, group)
    return changecustomitemtext(play, item, typename, group)
end

---增加和修改分类名称颜色
---@param play string 玩家对象
---@param item string 物品对象
---@param color number 分类颜色(0~255)
---@param group number 显示分类位置(0~2 ;为空默认为0)
---@return void
function lualib:ChangeCustomItemTextColor(play, item, color, group)
    return changecustomitemtextcolor(play, item, color, group)
end

---清理物品自定义属性
---@param play string 玩家对象
---@param item string 物品对象
---@param group number 组别，-1：所有组，0~5：对应组别
---@return void
function lualib:ClearItemCustomAbil(play, item, group)
    return clearitemcustomabil(play, item, group)
end

---刷新物品信息到前端
---@param play string 玩家对象
---@param item string 物品对象
---@return void
function lualib:RefreshItem(play, item)
    return refreshitem(play, item)
end

---关联玩家身上的装备
---@param play string 玩家对象
---@param where number 装备位置
---@return string 返回物品对象
function lualib:LinkBodyItem(play, where)
    return linkbodyitem(play, where)
end

---关联玩家身上的装备
---@param play string 玩家对象
---@param where number 装备位置
---@return string 返回物品对象
function lualib:GetEquipItem(play, where)
    return linkbodyitem(play, where)
end

---获取自定义进度条参数
---@param play string 玩家对象
---@param item string 装备对象
---@param index number 装备精度条索引（0~2）
---@return string 返回进度条内容，json字符串  {open:1,  //0-关闭，1-打开 show:1,  //0-不显示数值，1-百分比，2-数字name:"锻造",  //进度条文本color:3,  //进度条颜色，0~255imgcount:0,  //0-不循环绘制，1-图片循环绘制cur:0,  //当前值max:100,  //最大值level:0  //级别(0~65535)}
function lualib:GetCustomItemProgressBar(play, item, index)
    return getcustomitemprogressbar(play, item, index)
end

---设置自定义进度条参数
---@param play string 玩家对象
---@param item string 装备对象
---@param index number 装备精度条索引（0~2）
function lualib:SetCustomItemProgressBar(play, item, index, json)
    return setcustomitemprogressbar(play, item, index, json)
end

---获取玩家账号id
---@param player string 玩家对象
---@return string 返回玩家账号id
function lualib:UserId(player)
    return self:GetBaseInfo(player, 2)
end

---将传入的数字用中文输入如10000改1万
---@param num number 数字
---@return string 返回中文数字
function lualib:NumToChinese(num)
    -- 实现
    local str = ""
    local numStr = tostring(num)
    local len = string.len(numStr)
    local numTable = {}
    for i = 1, len do
        local n = string.sub(numStr, i, i)
        table.insert(numTable, n)
    end
    local unit = { "", "十", "百", "千", "万", "十万", "百万", "千万", "亿", "十亿", "百亿", "千亿" }
    local num = { [0] = "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" }
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

---将传入的数字用中文输入如10000改1万，100000改10万注意，起步更改是万，需要实现1万，100万，1000万，1亿，10亿，
---@param num number 数字
---@return string 返回中文数字
function lualib:NumToChinese2(n)
    local units = { "", "万", "亿" }
    local result = ""
    local unit_index = 1

    while n > 0 do
        local part = n % 10000 -- 取余
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

---计算物品规则
---规则表 1.禁止扔 2.禁止交易 3.禁止存 4.禁止修 5.禁止出售 6.禁止爆出 7.丢弃消失 8.死亡必爆 9.禁止拍卖 10.禁止挑战
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

---计算物品规则(只需要填入需要的规则)
---规则表 1.禁止扔 2.禁止交易 3.禁止存 4.禁止修 5.禁止出售 6.禁止爆出 7.丢弃消失 8.死亡必爆 9.禁止拍卖 10.禁止挑战
---@param ruleTb table
function lualib:CalItemRuleCountEx(ruleTb)
    local count = 0
    for i = 1, #ruleTb do
        count = count + math.pow(2, ruleTb[i] - 1)
    end
    return count
end

---通过结果值反推出物品规则
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

---获取服务器的系统时间戳
---@return number 返回服务器的系统时间戳
function lualib:GetAllTime()
    return os.time()
end

---获取字符串居中所需的x
---@param str string 字符串
---@param width number 宽度
---@param font number 字体大小
---@return number 返回字符串居中所需的x
function lualib:GetFontCenterX(str, width, font)
    local len = string.len(str)
    local w = len * (font / 2)
    return (width - w) / 2
end

---拉起客户端的支付
---比如:你后台配置的flagid为  1:10元宝，对应的ID为2，那么下面的拉起充值填写flagid 必须为2
---@param player string 玩家对象
---@param money number 金额
---@param type number 充值方式：1-支付宝，2-花呗，微信
---@param flagid number 充值货币ID
---@return void
function lualib:Pay(player, money, type, flagid)
    return pullpay(player, money, type, flagid)
end

---发送滚动消息
---@param player string 玩家对象
---@param type number 模式，发送对象 0-自己 1-所有人 2-行会 3-当前地图 4-组队
---@param FColor number 字体景色
---@param BColor number 背景色
---@param Y number Y坐标
---@param scroll number 滚动次数
---@param msg string 消息内容
function lualib:SendMoveMsg(player, type, FColor, BColor, Y, scroll, msg)
    return sendmovemsg(player, type, FColor, BColor, Y, scroll, msg)
end

---整理背包
---@param player string 玩家对象
function lualib:RefreshBag(player)
    refreshbag(player)
end

---通知客户端打开界面     --lualib:ShowFormWithContent(player, "npc/装备升星", { "你好，客户端，我是服务端的装备升星", {"哈哈表"} })
---@param player string 玩家对象
---@param methodStr string 方法名
---@param content string 内容
function lualib:ShowFormWithContent(player, relativePath, contentTb, p1, p2, p3)
    contentTb = contentTb or {}
    -- contentTb是一个表，从1开始，每个元素是一个任意值
    p1 = p1 or 0
    p2 = p2 or 0
    p3 = p3 or 0
    -- 将客户端目标方法存入表中
    contentTb.relativePath = relativePath
    Message.sendmsg(player, 730, p1, p2, p3, tbl2json(contentTb))
end

---调用自定义客户端UI脚本
---@param player string 玩家对象
---@param methodStr string 方法名
---@param content string 内容
function lualib:DoClientUIMethod(player, str, ...)
    if not str then
        return
    end
    funcType = funcType or 0
    -- 将客户端目标方法存入表中
    local contentTb = {}
    contentTb.script = str
    -- 将...中的参数存入表中
    contentTb.paramList = {}
    local arg = { ... }
    for i = 1, #arg do
        contentTb.paramList[i] = arg[i]
    end
    Message.sendmsg(player, 523, 0, 0, 0, tbl2json(contentTb))
end

---调用自定义客户端UI脚本扩展，可指定调用的方法类型如：和.注册的不同函数
---@param player string 玩家对象
---@param methodStr string 方法名
---@param funcType number 方法类型 0-.注册 1-:注册
---@param content string 内容
function lualib:DoClientUIMethodEx(player, str, funcType, ...)
    if not str then
        return
    end
    funcType = funcType or 0
    -- 将客户端目标方法存入表中
    local contentTb = {}
    contentTb.script = str
    -- 将...中的参数存入表中
    contentTb.paramList = {}
    local arg = { ... }
    for i = 1, #arg do
        contentTb.paramList[i] = arg[i]
    end
    Message.sendmsg(player, 523, funcType, 0, 0, tbl2json(contentTb))
end

---引导客户端内容
---@param player string 玩家对象
---@param _id string 界面ID
---@param content string 引导描述
---@param _pid string 主界面ID 0-主界面 1-左上 2-右上 3-左下 4-右下 5-最上
---@param _dir string 箭头方向 1 --左上 2 --中上 3 --右上 4 --左下 5 --中下 6 --右下
function lualib:GuideClient(player, _id, content, _pid, _dir)
    _pid = _pid or 0
    self:DoClientUIMethodEx(player, "CL_Guide", 1, "nil", _id, content, _pid, _dir)
end

---红点客户端
---@param player string 玩家对象
---@param _pid string 主界面ID 0-主界面 1-左上 2-右上 3-左下 4-右下 5-最上
---@param _id string 界面ID
---@param _x number x坐标
---@param _y number y坐标
function lualib:RedClient(player, _id, _x, _y, _pid)
    _pid = _pid or 0
    self:DoClientUIMethodEx(player, "CL_Red", 1, 0, 0, nil, _id, _x, _y, _pid)
end

---设置技能信息
---@param player string 玩家对象
---@param skillId number 技能id
---@param skillType number 技能类型 类型：1-技能等级 2-强化等级 3-熟练度 4-熟练度上限
---@return number 返回值(对应属性值) ,没有技能，返回-1
function lualib:GetSkillInfo(player, skillId, skillType)
    local result = getskillinfo(player, skillId, skillType)
    if not result then
        return -1
    else
        return result
    end
end

---设置技能信息
---@param player string 玩家对象
---@param skillId number 技能id
---@param skillType number 技能类型 类型：1-技能等级 2-强化等级 3-熟练度
---@param level number 技能等级
function lualib:SetSkillInfo(player, skillId, skillType, level)
    setskillinfo(player, skillId, skillType, level)
end

---设置人物倍攻百分比
---@param player string 玩家对象
---@param percent number 倍攻百分比
---@param time number 持续时间
function lualib:SetPowerRate(player, percent, time)
    powerrate(player, percent, time)
end

---设置人物属性
---@param player string 玩家对象
---@param id number 属性ID（1-20）1=防御下限 2=防御上限 3=魔御下限 4=魔御上限 5=攻击下限 6=攻击上限 7=魔法下限 8=魔法上限 9=道术下限 10=道术上限 11=MaxHP 12=MaxMP 13=HP恢复 14=MP恢复 15=毒恢复 16=毒躲避 17=魔法躲避 18=准确 19=敏捷 20= 幸运
---@param value number 属性值
---@param time number 时间(秒)
function lualib:SetPlayerAbility(player, id, value, time)
    changehumability(player, id, value, time)
end

---获取人物属性
---@param player string 玩家对象
---@param id number 属性ID（1-20）1=防御下限 2=防御上限 3=魔御下限 4=魔御上限 5=攻击下限 6=攻击上限 7=魔法下限 8=魔法上限 9=道术下限 10=道术上限 11=MaxHP 12=MaxMP 13=HP恢复 14=MP恢复 15=毒恢复 16=毒躲避 17=魔法躲避 18=准确 19=敏捷 20= 幸运
---@return number 属性值
function lualib:GetPlayerAbility(player, id)
    return gethumability(player, id)
end

---设置人物属性
---@param player string 玩家对象
---@param id number 属性ID 对应cfg_att_score表
---@param value number 属性值
---@param time number 时间(秒)
function lualib:SetPlayerTempAbility(player, id, value, time)
    changehumability(player, id, value, time)
end

---获取人物属性
---@param player string 玩家对象
---@param id number 属性ID 对应cfg_att_score表
---@return number 属性值
function lualib:GetPlayerTempAbility(player, id)
    return gethumability(player, id)
end

---设置人物永久属性
---@param player string 玩家对象
---@param id number 属性ID 1：攻击下限（0~65535） 2：攻击上限（0~65535） 3：魔法下限（0~65535） 4：魔法上限（0~65535） 5：道术下限（0~65535） 6：道术上限（0~65535） 7：防御下限（0~65535） 8：防御上限（0~65535） 9：魔防下限（0~65535） 10：魔防上限（0~65535） 11：生命值（支持21亿） 12：魔法值（支持21亿） 13：准确（支持21亿） 14：躲避（支持21亿） 15：防御下限（支持21亿） 16：防御上限（支持21亿） 17：魔防下限（支持21亿） 18：魔防上限（支持21亿）
---@param value number 属性值
function lualib:SetPlayerForeverAbility(player, id, value)
    setusebonuspoint(player, id, value)
end

---获取人物永久属性
---@param player string 玩家对象
---@param id number 属性ID 1：攻击下限（0~65535） 2：攻击上限（0~65535） 3：魔法下限（0~65535） 4：魔法上限（0~65535） 5：道术下限（0~65535） 6：道术上限（0~65535） 7：防御下限（0~65535） 8：防御上限（0~65535） 9：魔防下限（0~65535） 10：魔防上限（0~65535） 11：生命值（支持21亿） 12：魔法值（支持21亿） 13：准确（支持21亿） 14：躲避（支持21亿） 15：防御下限（支持21亿） 16：防御上限（支持21亿） 17：魔防下限（支持21亿） 18：魔防上限（支持21亿）
---@return number 属性值
function lualib:GetPlayerForeverAbility(player, id)
    return getusebonuspoint(player, id)
end

---根据json串给物品
---@param player string 玩家对象
---@param jsonInfo string json串
function lualib:GiveItemByJson(player, jsonInfo)
    giveitembyjson(player, jsonInfo)
end

---根据物品实体获取json
---@param item string 物品实体
---@return string json串
function lualib:GetItemJson(item)
    return getitemjson(item)
end

---添加镜像地图
---@param oldMap string 原地图ID
---@param NewMap string 新地图ID
---@param NewName string 新地图名
---@param time number 有效时间(秒)
---@param BackMap string 回城地图(有效时间结束后，传回去的地图)
---@param miniMapID number 返回小地图ID
---@param miniMapX number 返回小地图X坐标
---@param miniMapY number 返回小地图Y坐标
function lualib:AddMirrorMap(oldMap, NewMap, NewName, time, BackMap, miniMapID, miniMapX, miniMapY)
    addmirrormap(oldMap, NewMap, NewName, time, BackMap, miniMapID, miniMapX, miniMapY)
end

---删除镜像地图
---@param MapId string 地图ID
function lualib:DelMirrorMap(MapId)
    delmirrormap(MapId)
end

---获取镜像地图剩余时间
---@param MapId string 地图ID
---@param time number 设置地图有效时间
---@return number 剩余时间
function lualib:GetMirrorMapTime(MapId, time)
    return mirrormaptime(MapId, time)
end

---检测镜像地图是否存在
---@param MapId string 地图ID
---@return boolean 是否存在
function lualib:CheckMirrorMap(MapId)
    return checkmirrormap(MapId)
end

---给按钮增加红点
---@param player string 玩家对象
---@param btnId string 按钮名字
---@param x number x坐标
---@param y number y坐标
---@param wndId string 窗口ID
---@param model number 模型
---@param path string 路径 (空=原来模式 0=图片,1=特效)
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

---给按钮增加红点
---@param player string 玩家对象
---@param btnId string 按钮名字
---@param wndId string 窗口ID
function lualib:DelRedPoint(player, btnId, wndId)
    if not btnId then
        return
    end
    if not wndId then wndId = 0 end
    --callscriptex(player, "Reddel", wndId, btnId)
    reddel(player, wndId, btnId)
end

---屏幕震动
---@param player string 玩家对象
---@param type number 模式(0~4)0.仅自己;1.在线所有人;2屏幕范围内人物;3.当前地图上所有人;4.指定地图上所有人;
---@param level number 震级(1~3)
---@param num number 次数
---@param mapid number 地图ID(模式等于4时，需要该参数)
function lualib:ScreenShake(player, type, level, num, mapid)
    scenevibration(player, type, level, num, mapid)
end

---添加定时器
---@param id number 定时器ID
---@param tick number 执行间隔，秒
---@param count number 执行次数，为0时不限次数
function lualib:SetOnTimerEx(id, tick, count)
    setontimerex(id, tick, count)
end

---移除定时器
---@param id number 定时器ID
function lualib:SetOffTimerEx(id)
    setofftimerex(id)
end

---杀怪
---@param mapid string 地图ID
---@param monname string 怪物全名，空 或者 * 杀死全部
---@param count number 数量，0所有
---@param drop boolean 是否掉落物品，true掉落
function lualib:KillMonsters(mapid, monname, count, drop)
    killmonsters(mapid, monname, count, drop)
end

---在地图上放置物品
---@param play string 玩家对象
---@param MapId string 地图ID
---@param X number 坐标X
---@param Y number 坐标Y
---@param range number 范围
---@param itemName string 物品名
---@param count number 数量
---@param time number 时间（秒）
---@param hint boolean 是否掉落提示
---@param take boolean 是否立即拾取
---@param onlyself boolean 仅自己拾取
---@param xyinorder boolean 是-按位置顺序，否-随机位置
function lualib:ThrowItem(play, MapId, X, Y, range, itemName, count, time, hint, take, onlyself, xyinorder)
    throwitem(play, MapId, X, Y, range, itemName, count, time, hint, take, onlyself, xyinorder)
end

---根据左上坐标XY值和宽高获取边缘点
---@param x1 number 左上角X坐标
---@param y1 number 左上角Y坐标
---@param w number 宽
---@param h number 高
---@return table 边缘点坐标
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

---给定菱形的中心点和半径，获取菱形的边缘点
---@param x0 number 中心点X坐标
---@param y0 number 中心点Y坐标
---@param r number 半径
---@return table 边缘点坐标
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

---判断一个点是否在菱形内
---@param x number 点X坐标
---@param y number 点Y坐标
---@param x0 number 菱形中心点X坐标
---@param y0 number 菱形中心点Y坐标
---@param r number 菱形半径
function lualib:PointInDiamond(x, y, x0, y0, r)
    return math.abs(x - x0) + math.abs(y - y0) <= r
end

---刷新人物属性
---@param player string 玩家对象
function lualib:RefreshPlayer(player)
    recalcabilitys(player)
end

---开启引导
---@param player string 玩家对象
---@param NPCIdx number 界面ID
---@param BtnIdx number 按钮索引
---@param sMsg string 显示的内容
function lualib:Guide(player, NPCIdx, BtnIdx, sMsg)
    if not sMsg then
        sMsg = "点击"
    end
    navigation(player, NPCIdx, BtnIdx, sMsg)
end

---使用道具(道具需要具备双击使用的功能)
---@param player string 玩家对象
---@param itemname string 物品名称
---@param count number 数量
function lualib:EatItem(player, itemname, count)
    if not count then count = 1 end
    eatitem(player, itemname, count)
end

---打开系统界面
---@param player string 玩家对象
---@param type number 界面类型
function lualib:OpenGameWnd(player, param)
    param = tonumber(param)
    openhyperlink(player, param, 0)
end

---设置人物背包格子数
---@param player string 玩家对象
---@param count number 格子大小
function lualib:SetBagCount(player, count)
    setbagcount(player, count)
end

---打开仓库面板
---@param player string 玩家对象
function lualib:openStorage(player)
    openstorage(player)
end

---新解锁仓库格子
---@param player string 玩家对象
---@param nCount number 新解锁的格子数
function lualib:SetStorage(player, nCount)
    changestorage(player, nCount)
end

---设置发型
---@param player string 玩家对象
---@param hair number 发型ID
function lualib:SetHair(player, hair)
    setbaseinfo(player, 33, 0)
end

---开/关首饰盒 生肖
---@param player string 玩家对象
---@param bState number 0：关闭，1：开启
function lualib:SetAmuletBox(player, bState)
    setsndaitembox(player, bState)
end

---添加个人定时器
---@param player string 玩家对象
---@param id number 定时器ID
---@param RunTick number 执行间隔，秒
---@param RunTime number 执行次数，>0执行完成后，自动移除
---@param kf number 跨服是否继续执行 1：继续
function lualib:SetOnTimer(player, id, RunTick, RunTime, kf)
    if not kf then kf = 0 end
    setontimer(player, id, RunTick, RunTime, kf)
end

---移除个人定时器
---@param player string 玩家对象
---@param id number 定时器ID
function lualib:SetOffTimer(player, id)
    setofftimer(player, id)
end

---过滤全服玩家信息
---@param player string 玩家对象
---@param status string 是否过滤 0-不过滤 1-过滤
function lualib:FilterGlobalMsg(player, status)
    filterglobalmsg(player, status)
    --self:CallTxtScript(player, "FILTERGLOBALMSG " .. status)
end

---获取物品附加属性
---@param player string 玩家对象
---@param item string 物品对象
---@param type number [1,2,3]
---@param position number 位置
---@return number 附加属性值
function lualib:GetItemAddValue(player, item, type, position)
    return getitemaddvalue(player, item, type, position)
end

---设置物品附加属性
---@param player string 玩家对象
---@param item string 物品对象
---@param type number [1,2,3]
---@param position number 位置
---@param value number 附加属性值
function lualib:SetItemAddValue(player, item, type, position, value)
    setitemaddvalue(player, item, type, position, value)
    --lualib:RefreshItem(player, item)
end

---解毒技能
---@param player string 玩家对象
---@param par number 毒类型 1，解所有毒;0,绿毒;1,红毒;3,紫毒;5,麻痹;6,冰冻;7,蛛网
function lualib:RemovePoison(player, par)
    detoxifcation(player, par)
end

---修复所有装备
---@param player string 玩家对象
function lualib:RepairAll(player)
    repairall(player)
end

---设置人物伤害吸收
---@param player string 玩家对象
---@param operate string 操作符号
---@param sum number 总吸收量
---@param rate number 吸收比率，千分比 1=0.1%，100=10%
---@param success number 吸收成功率
function lualib:SetSuckDamage(player, operate, sum, rate, success)
    setsuckdamage(player, operate, sum, rate, success)
end

---延时触发
---@param player string 玩家对象
---@param time number 延时时间，单位毫秒
---@param func string 回调函数
---@param del number 换地图是否删除回调函数 0-不删除 1-删除
function lualib:DelayGoto(player, time, func, del)
    delaygoto(player, time, func, del)
end

---触发txt脚本
---@param player string 玩家对象
---@param txt string 脚本内容
function lualib:CallTxtScript(player, str)
    if not player then
        player = globalinfo(0)
    end
    local pt = string.split(str, " ")
    callscriptex(player, unpack(pt))
end

---开启自动挂机
---@param player string 玩家对象
function lualib:StartAutoAttack(player)
    startautoattack(player)
end

---停止自动挂机
---@param player string 玩家对象
function lualib:StopAutoAttack(player)
    stopautoattack(player)
end

---全局信息
---@param id number 信息ID 0: 全局玩家信息 1: 开服天数(后台维护) 2: 开服时间(后台维护) 3: 合服次数 4: 合服时间 5: 服务器IP 6: 玩家数量 7: 背包最大数量 8: 引擎版本号（以线上版本为准,测试版、本地版可能存在差异） 9：游戏id 10：服务器名称 11：服务器id
---@return string 信息内容
function lualib:GlobalInfo(id)
    return globalinfo(id)
end

---鞭尸
function lualib:MonItems(player, count)
    monitems(player, count)
end

---添加buff
---@param base string 玩家对象
---@param buffid number buff id，10000以后
---@param time number 时间,对应buff表里维护的单位
---@param OverLap number 叠加层数，默认1
---@param objOwner string 施放者
---@param Abil table 属性表 {[1]=200, [4]=20}，属性id=值
---@return boolean 是否添加成功
function lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    return addbuff(base, buffid, time, OverLap, objOwner, Abil)
end

---添加buff扩展
---@param base string 玩家对象
---@param buffid number buff id，10000以后
---@param time number 时间,对应buff表里维护的单位
---@param OverLap number 叠加层数，默认1
---@param objOwner string 施放者
---@param Abil table 属性表 {[1]=200, [4]=20}，属性id=值
---@return boolean 是否添加成功
function lualib:AddBuffEx(base, buffid, time, OverLap, objOwner, Abil)
    if lualib:HasBuff(base, buffid) then
        lualib:DelBuff(base, buffid)
        return lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    else
        return lualib:AddBuff(base, buffid, time, OverLap, objOwner, Abil)
    end
end

---删除buff
---@param base string 玩家对象
---@param buffid number buff id
function lualib:DelBuff(base, buffid)
    delbuff(base, buffid)
end

---是否有buff
---@param base string 玩家对象
---@param buffid number buff id
---@return boolean 是否有
function lualib:HasBuff(base, buffid)
    return hasbuff(base, buffid)
end

---获取buff信息
---@param base string 玩家对象
---@param buffid number buff id
---@param type number 类型，1:叠加层数 2:剩余时间(单位跟配置一致)
---@return number 返回值
function lualib:GetBuffInfo(base, buffid, type)
    return getbuffinfo(base, buffid, type)
end

---获取物品的名字
---@param item string 物品对象
---@return string 名字
function lualib:ItemName(player, item)
    return lualib:GetItemInfo(player, item, 7)
end

---获取物品的Shape
---@param item string 物品对象
---@return string Shape
function lualib:ItemShape(player, item)
    local id = lualib:GetItemInfo(player, item, 2)
    if id then
        return lualib:GetStdItemInfo(id, 3)
    else
        return nil
    end
end

---计算时间戳的初始时间距离现在已经过了多少天 1970-01-01 00:00:00
---@param timestamp number 时间戳
---@return number 天数
function lualib:GetAllDays()
    -- 北京时区的UTC偏移为8小时（8 * 60 * 60秒）
    local utcOffset = 8 * 60 * 60

    -- 将北京时间转换为UTC时间戳
    local utcTimestamp = os.time() + utcOffset

    -- 计算时间戳之差，并转换为天数
    local days = math.floor((utcTimestamp) / (86400))

    return days
end

---将字符串时间转换为时间戳
---@param date_str string 时间字符串，格式为 2019-01-01 00:00:00
---@return number 时间戳
function lualib:Str2Time(date_str)
    local y, m, d, H, M, S = date_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    local timestamp = os.time({ year = y, month = m, day = d, hour = H, min = M, sec = S })
    return timestamp
end

---将时间戳转换为字符串时间
---@param timestamp number 时间戳
---@return string 时间字符串，格式为 2019-01-01 00:00:00
function lualib:Time2Str(timestamp)
    local date_table = os.date("*t", timestamp)
    local date_str = string.format("%04d-%02d-%02d %02d:%02d:%02d", date_table.year, date_table.month, date_table.day,
        date_table.hour, date_table.min, date_table.sec)
    return date_str
end

---将时间戳转换为字符串时间，并可以指定格式
---@param timestamp number 时间戳
---@param format string 格式，例如 %Y-%m-%d %H:%M:%S
---@return string 时间字符串
function lualib:Time2StrEx(timestamp, format)
    local date_str = os.date(format, timestamp)
    return date_str
end

---获取时间戳的年月日时分秒
---@param timestamp number 时间戳
---@return number 年
---@return number 月
---@return number 日
---@return number 时
---@return number 分
---@return number 秒
function lualib:TimeDetail(timestamp)
    local date_table = os.date("*t", timestamp)
    return date_table.year, date_table.month, date_table.day, date_table.hour, date_table.min, date_table.sec
end

---获取当前时间戳
---@return number 时间戳
function lualib:Now()
    return os.time()
end

---增加气泡
---@param player string 玩家对象
---@param id number ID
---@param name string 显示名称
---@param fun function 函数名(多参数用逗号分割)
function lualib:AddBubble(player, id, name, fun)
    addbutshow(player, id, name, fun)
end

---删除气泡
---@param player string 玩家对象
---@param id number ID
function lualib:DelBubble(player, id)
    delbutshow(player, id)
end

---获取地图上指定范围内的对象
---@param MapId string 地图ID
---@param X number 坐标X
---@param Y number 坐标Y
---@param range number 范围
---@param flag number 标记值，二进制位表示：1-玩家，2-怪物，4-NPC，8-物品，16-地图事件 32-人形怪 64-英雄,128-分身
---@return table 对象列表
function lualib:GetObjectInMap(MapId, X, Y, range, flag)
    return getobjectinmap(MapId, X, Y, range, flag)
end

---获取行会信息
---@param guild string 行会对象
---@param index number 索引0-行会ID 1-行会名称 2-行会公告 3-行会成员名单（返回table） 4-行会掌门人名称
---@return string 结果
function lualib:GetGuildInfo(guild, index)
    return getguildinfo(guild, index)
end

---获取玩家所在的行会对象
---@param player string 玩家对象
---@return string 行会对象
function lualib:GetMyGuild(player)
    return getmyguild(player)
end

---获取我的行会信息
---@param player string 玩家对象
---@param index number 索引0-行会ID 1-行会名称 2-行会公告 3-行会成员名单（返回table） 4-行会掌门人名称
---@return string 结果
function lualib:GetMyGuildInfo(player, index)
    local myGuild = lualib:GetMyGuild(player)
    if myGuild == "" or myGuild == "0" or myGuild == nil then
        return
    end
    return lualib:GetGuildInfo(myGuild, index)
end

---md5加密
---@param str string 字符串
---@return string 结果
function lualib:MD5(str)
    -- 没有接口，用lua实现一个md5加密
end

---大数相加
---@param a string 大数a
---@param b string 大数b
---@return string 结果
function lualib:BigNumAdd(a, b)
    -- 大数相加实现，字符串相加
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

---大数相减
---@param a string 大数a
---@param b string 大数b
---@return string 结果
function lualib:BigNumSub(a, b)
    -- 大数相减实现，字符串相减
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

---大数相乘
---@param a string 大数a
---@param b string 大数b
---@return string 结果
function lualib:BigNumMul(a, b)
    -- 大数相乘实现，字符串相乘
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

---客户端弹出奖励列表界面 例子：lualib:ShowRewards(player, { { 5, 10 }, {7,100000}, {7,100000}, {7,100000}, {7,100000}, {7,100000} })
---@param player number 玩家对象
---@param tAwards table 道具列表
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

---批量给物品和货币 {物品名，物品数量，id=id}
---@param player string 玩家对象
---@param itemTb table 道具列表
---@param desc string 描述,仅用于货币
---@param rule string 规则
function lualib:AddBatchItem(player, itemTb, desc, rule)
    for i = 1, #itemTb do
        local item = itemTb[i]
        if item.type then
            if item.type == "称号物品" then
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

---获取人物pk等级
---@param player string 玩家对象
---@return number pk等级0.白名;1.黄名;2.红名;3.灰名
function lualib:GetPkLevel(player)
    return getpklevel(player)
end

---获取角色所有buff
---@param player string 玩家对象
---@return table buff列表
function lualib:GetAllBuffId(player)
    return getallbuffid(player)
end

---检测地图逻辑格
---@param mapid number 地图id
---@param x number x坐标
---@param y number y坐标
---@param type number 逻辑格类型 1.能否到达; 2.安全区; 3.攻城区;
---@return boolean 是否相同
function lualib:CheckGridAttr(mapid, x, y, type)
    return checkgridattr(mapid, x, y, type)
end

---设置人物身上物品装备名字
---@param player string 玩家对象
---@param itemPos number 装备位置
---@param itemName string 装备名字
---@return void
function lualib:SetItemName(player, itemPos, itemName)
    changeitemname(player, itemPos, itemName)
end

---立即杀死角色
---@param player string 玩家对象
---@param attacker string 攻击者
---@return void
function lualib:Kill(player, attacker)
    kill(player, attacker)
end

---MD5加密
---@param str string 需要加密的文本
---@return string MD5加密值
function lualib:MD5(str)
    return md5(str)
end

---根据地图id返回地图名
---@param mapid number 地图Id必须是数字的
---@return string 地图名
function lualib:GetMapNameById(player)
    return getmapid(player)
end

---发送客户端淡出消息
---@param player string 玩家对象
---@param _text string 消息内容
---@param _x number x坐标
---@param _y number y坐标
---@param _time number 消息持续时间
---@param _size number 字体大小
---@param _color string 字体颜色
---@param _outline number 描边大小
---@param _outlineColor string 描边颜色
function lualib:SendFadeOutMsg(player, _text, _x, _y, _time, _size, _color, _outline, _outlineColor)
    lualib:DoClientUIMethod(player, "CL_SendFadeOutMsg", _text, _x, _y, _time, _size, _color, _outline, _outlineColor)
end

---将表中字符串数字索引转为正确的数字索引
---@param _tb table 表
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

---装备开孔
---@param player string 玩家对象
---@param item string 装备对象
---@param holejson string 开孔相关，json字符串，支持0~9共10个孔
function lualib:SetEquipDrillHole(player, item, holejson)
    drillhole(player, item, holejson)
end

---获取装备开孔数据
---@param player string 玩家对象
---@param item string 装备对象
---@return string 开孔相关，json字符串，支持0~9共10个孔
function lualib:GetEquipDrillHole(player, item)
    return getdrillhole(player, item)
end

---装备镶嵌钻石
---@param player string 玩家对象
---@param item string 装备对象
---@param hole number 装备开孔序号，0~9
---@param itemIndex number 镶嵌钻石的index（装备表总的Index）
function lualib:SetEquipSocket(player, item, hole, itemIndex)
    socketableitem(player, item, hole, itemIndex)
end

---获取装备钻石镶嵌情况
---@param player string 玩家对象
---@param item string 装备对象
---@return string 开孔相关，json字符串，支持0~9共10个孔
function lualib:GetEquipSocket(player, item)
    return getsocketableitem(player, item)
end

---获取人物自定义属性值
---@param player string 玩家对象
---@param attrId number 属性ID
---@return number 属性值
function lualib:GetCustomAttr(player, attrId)
    return getbaseinfo(player, 51, attrId)
end

---自定义群体切割
---@param player string 玩家对象
---@param _attackNum number 攻击值
---@param _X number 坐标X
---@param _Y number 坐标Y
---@param _Range number 切割范围
---@param _Type number 标记值，二进制位表示：1-玩家，2-怪物4-NPC，8-物品 16-地图事件 32-人形怪 64-英雄 128-分身
---@param _MaxNum number 最大数量
---@param _Magic number 特效id
---@param _CutTextId number 切割文字id
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

---根据ID判断材料是否充足
---@param player string 玩家对象
---@param moneyID number 货币或材料ID
---@param Num number 数量
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

---根据名字判断材料是否充足
---@param player string 玩家对象
---@param moneyID string 货币或材料名字
---@param Num number 数量
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

---根据名字或ID判断材料是否充足
---@param player string 玩家对象
---@param moneyID string 物品ID或名字
---@param Num number 数量
-- function lualib:zsf_isMoneyEnough(player, moneyName_or_ID, Num)
--     Num = tonumber(Num) or 9999999999999
--     if type(moneyName_or_ID) == "number" then
--         return isByIDMoneyEnough(player, moneyName_or_ID, Num)
--     else
--         return isByNameMoneyEnough(player, moneyName_or_ID, Num)
--     end
-- end

---检查一个对象的范围
---@param obj string 对象
---@param x number X坐标
---@param y number Y坐标
---@param range number 范围值（对象是否在这个范围内）
function lualib:FCheckRange(obj, x, y, range)
    local cur_x, cur_y = getbaseinfo(obj, ConstCfg.gbase.x), getbaseinfo(obj, ConstCfg.gbase.y)
    local min_x, max_x = x - range, x + range
    local min_y, max_y = y - range, y + range

    if (cur_x >= min_x) and (cur_x <= max_x) and (cur_y >= min_y) and (cur_y <= max_y) then
        return true
    end

    return false
end

---给物品
---@param player string 玩家对象
---@param idx_or_name number/string 物品ID或物品名
---@param num number 数量
---@param bind number 物品规则
function lualib:FGiveItem(player, idx_or_name, num, bind)
    num = num or 1
    if type(idx_or_name) == "number" then
        idx_or_name = getstditeminfo(idx_or_name, ConstCfg.stditeminfo.name)
    end
    return giveitem(player, idx_or_name, num, bind)
end

--拿走物品
---@param player string 玩家对象
---@param idx_or_name number/string 物品ID或物品名
---@param num number 数量
function lualib:FTakeItem(player, idx_or_name, num)
    num = num or 1
    if type(idx_or_name) == "number" then
        idx_or_name = getstditeminfo(idx_or_name, ConstCfg.stditeminfo.name)
    end
    return takeitem(player, idx_or_name, num)
end

--拿走物品(通过物品对象)
---@param player string 玩家对象
---@param itemobj string 物品对象
---@param num number 数量
function lualib:FTakeItemEX(player, itemobj, num)
    if itemobj ~= '0' then
        local onlyID = getiteminfo(player, itemobj, ConstCfg.iteminfo.id)
        return delitembymakeindex(player, onlyID, num)
    else
        return false
    end
end

---根据物品名或物品id获取物品DB原始字段值
---@param player string 玩家对象
---@param itemNameOrId string 物品名或ID
---@param itemField string 字段名
function lualib:GetItemDBField(player, itemNameOrId, itemField)
    return getdbitemfieldvalue(player, itemNameOrId, itemField)
end

---创建文本文件
---@param path string 文件路径
function lualib:IO_CreateFile(path)
    createfile(path)
end

---写入指定文本文件
---@param path string 文件路径
---@param str string 写入文本
---@param line string 写入行数(0~65535)
function lualib:IO_AddTextList(path, str, line)
    addtextlist(path, str, line)
end

---获取文本文件指定行的字符串
---@param path string 文件路径
---@param line string 指定行(0~1000)
---@return string 字符串
function lualib:IO_GetRandomText(path, line)
    return getrandomtext(path, line)
end

---获取文本文件指定行的内容[根据符号分割]
---@param path string 文件路径
---@param line string 指定行
---@param symbol string 符号
---@return table 字符串列表
function lualib:IO_GetListStringEx(path, line, symbol)
    return getliststringex(path, line, symbol)
end

---取字符串在列表中的下标
---@param path string 文件路径
---@param str string 字符串
---@return number 字符串所在行
function lualib:IO_GetStringPos(path, str)
    return getstringpos(path, str)
end

---删除文本文件的内容
---@param path string 文件路径
---@param line string 指定行
---@param model number 删除模式 0=删除行 1=清空行 2=删除随机行(参数2失效)
function lualib:IO_DelTextList(path, line, model)
    deltextlist(path, line, model)
end

---清除列表内容
---@param path string 文件路径
function lualib:IO_ClearNameList(path)
    clearnamelist(path)
end

---检查字符串是否在指定文件中
---@param path string 文件路径
---@param str string 字符串
---@return boolean true=在文件中 false=不在文件中
function lualib:IO_CheckTextList(path, str)
    return checktextlist(path, str)
end

---检查字符串是否在指定文件中
---@param path string 文件路径
---@param str string 字符串
---@param model number 检测模式 0=列表中,是否包含被检测的字符 1=被检测的字符是否包含列表中的某一行内容
---@return boolean true=在文件中 false=不在文件中
function lualib:IO_CheckContainsTextList(path, str, model)
    return checkcontainstextlist(path, str, model)
end

---创建通区文本
---@param fileName string 文件名
function lualib:Tong_CreateFile(fileName)
    tongfile(0, fileName)
end

---删除通区文本
---@param fileName string 文件名
function lualib:Tong_DeleteFile(fileName)
    tongfile(1, fileName)
end

---通区同步文本
---@param remoteFileName string 远程文件名
---@param fileName string 同步的文件名
function lualib:Tong_UpdateFile(remoteFileName, fileName)
    updatetongfile(remoteFileName, fileName)
end

---更改通区文件内容
---@param path string 文本路径
---@param str string 内容(最大64中文字符)
---@param line string 指定操作行
---@param model string 0=文件尾追加内容(快) 1 =插入内容到指定行 2=替换内容到指定行 3=删除指定行内容 4=清空整个文件内容
function lualib:Tong_ChangeFile(path, str, line, model)
    changetongfile(path, str, line, model)
end

---通区变量同步
---@param varName string 全局变量名
function lualib:Tong_UpdateVar(varName)
    updatetongvar(varName)
end

---主区执行,增加创建文件
---@param varName string 区服ID
---@param model number 0=创建文件 1=删除文件
---@param path string 文件路径 例 ‘..\QuestDiary\996m2.txt’
function lualib:Tong_MainCreateFile(varName, model, path)
    maintongfile(varName, model, path)
end

---写入指定区服配置
---@param serverID string 区服ID
---@param path string 文件路径 例 ‘..\QuestDiary\996m2.txt’
---@param key string 字段
---@param value string 值
function lualib:Tong_WriteTongKey(serverID, path, key, value)
    writetongkey(serverID, path, key, value)
end

---读取指定区服配置
---@param serverID string 区服ID
---@param path string 文件路径 例 ‘..\QuestDiary\996m2.txt’
---@param key string 字段
---@param varName string 变量
function lualib:Tong_ReadTongKey(serverID, path, key, varName)
    readtongkey(serverID, path, key, varName)
end

---执行查询通区主服
---@param serverID string 区服ID
function lualib:Tong_CheckTongSvr(serverID)
    checktongsvr(serverID)
end

---主区执行 同步文件 将本地文件路径同步到服务器路径
---@param serverID string 区服ID
---@param path string 文件路径 例 ‘..\QuestDiary\996m2.txt’
function lualib:Tong_UpdateMainTongFile(serverID, path)
    updatemaintongfile(serverID, path)
end

---主区执行 拉取文件
---@param serverID string 区服ID
---@param filePath string 本地文件路径’..\QuestDiary\bbb.txt’
---@param path string 远程服务器路径 例 ‘..\QuestDiary\996m2.txt’
function lualib:Tong_GetMainTongFile(serverID, filePath, path)
    getmaintongfile(serverID, filePath, path)
end

---批量检测物品和货币
---@param player string 玩家对象
---@param costTb table 消耗列表
---@return boolean 是否足够
---@return string 提示
function lualib:BatchCheckItem(player, costTb)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "您的" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    return true
end

---批量扣除物品和货币
---@param player string 玩家对象
---@param costTb table 消耗列表
---@param costDesc string 消耗描述
---@return boolean 是否成功
---@return string 提示
function lualib:BatchDelItem(player, costTb, costDesc)
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            local myIntegral = lualib:GetMoneyEx(player, costSSS[1])
            if myIntegral < costSSS[2] then
                return false, "您的" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        else
            local myItem = lualib:GetBagItemCount(player, costSSS[1])
            if myItem < costSSS[2] then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    for i = 1, #costTb do
        local costSSS = costTb[i]
        local stdMode = lualib:GetStdItemInfo(costSSS[1], 2)
        if stdMode == 41 then
            lualib:SetMoneyEx(player, costSSS[1], "-", costSSS[2], costDesc .. "领取消耗", true)
        else
            if not lualib:DelItem(player, costSSS[1], costSSS[2], nil, costDesc .. "消耗") then
                return false, "您的材料" .. costSSS[1] .. "不足" .. costSSS[2]
            end
        end
    end
    return true
end

---根据坐标计算两者之间的距离
---@param position1 table 坐标1{x=1,y=1}
---@param position2 table 坐标2{x=100,y=100}
function lualib:Distance(position1, position2)
    local dx = position2.x - position1.x
    local dy = position2.y - position1.y
    return math.ceil(math.sqrt(dx * dx + dy * dy))
end

---打开进度条
---@param player string 玩家对象
---@param title string 标题
---@param time number 时间
---@param cancelLink string 链接 @click,挂机设置_stopCircle
---@param countLink string 链接 @click,挂机设置_stopCircle
function lualib:OpenTimeCountDownWnd(player, title, time, cancelLink, countLink)
    time = time or 3
    title = title or "即将发生"
    local str =
        [[
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|bg=1|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=5000|height=5000|img=custom/1900000651_1.png>
        <CircleBar|x=425.0|y=120.0|show=4|endper=100|startper=0|time=]] ..
        time ..
        [[|loadingbar=private/TradingBankLayer/progress.png|loadingbg=private/TradingBankLayer/progressbg.png|offsetY=0|offsetX=0|link=]] ..
        countLink .. [[>
            <Button|ax=0|ay=0|x=520.0|y=345.0|width=100|height=30|color=103|size=20|pimg=custom/kb1.png|nimg=custom/kb1.png|text=点击取消|link=]] ..
        cancelLink .. [[>
            <RText|x=480.0|y=250.0|outlinecolor=0|color=249|outline=2|size=22|text=]] .. (tostring(title)) .. [[>
            <COUNTDOWN|a=0|x=545.0|y=195.0|size=30|color=103|time=]] .. time .. [[|count=1>
        ]]
    say(player, str)
end

return lualib, Constant
