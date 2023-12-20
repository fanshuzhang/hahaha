---所有行会在当晚同时攻城
function addattacksabakall() end

---添加buff
---*  object: 玩家|怪物 对象
---*  buffid: buffid 10000以后
---*  time: 时间,对应buff表里维护的单位
---*  OverLap: 叠加层数,默认1
---*  objOwner: 施放者
---*  abil: 属性表 {[1]=200, [4]=20},属性id=值
---@param object userdata
---@param buffid number
---@param time? number
---@param OverLap? number
---@param objOwner? userdata
---@param abil? table
function addbuff(object,buffid,time,OverLap,objOwner,abil) end

---增加气泡
---*  actor: 玩家对象
---*  id: ID
---*  name: 显示名称
---*  func: 函数名(多参数用逗号分割)
---@param actor userdata
---@param id number
---@param name string
---@param func function
function addbutshow(actor,id,name,func) end

---增加自定义按钮
---*  actor: 玩家对象
---*  windowid: 主窗口ID
---*  name: 按钮ID
---*  func: 图标内容
---@param actor userdata
---@param windowid number
---@param buttonid number
---@param icon string
function addbutton(actor,windowid,buttonid,icon) end

---增加限次使用物品的次数
---*  actor: 玩家对象
---*  actor: 物品唯一ID
---*  actor: 次数
---@param actor userdata
---@param itemmakeid number
---@param num number
function addfunitemdura(actor,itemmakeid,num) end

---添加队员
---*  actor: 玩家对象
---*  userId: 组员UserId
---@param actor userdata
---@param userId string
function addgroupmember(actor,userId) end

---临时增加怪物爆出物品
---*  actor: 玩家对象
---*  mon: 怪物对象
---*  itemname: 物品名称
---@param actor userdata
---@param mon userdata
---@param itemname string
function additemtodroplist(actor,mon,itemname) end

---增加动态地图连接
function addmapgate(actor) end

---创建镜像地图
---*  oldMap: 原地图ID
---*  NewMap: 新地图ID
---*  NewName: 新地图名
---*  time: 有效时间(秒)
---*  BackMap: 回城地图
---@param oldMap userdata
---@param NewMap string
---@param NewName string
---@param time number
---@param BackMap string
function addmirrormap(oldMap,NewMap,NewName,time,BackMap) end

---增加宠物属性
---*  actor: 玩家对象
---*  idx: 宠物序号
---*  attrName: 自定义属性组名
---*  opt: 操作符 + - =
---*  attr: 属性字符串
---*  type: 0或空=计算套装属性增加1=增加固定值;不计算套装属性(属性加成类无效)
---@param actor userdata
---@param idx number
---@param attrName number
---@param opt string
---@param attr number
---@param type number
function addpetattlist(actor,idx,attrName,opt,attr,type) end

---增加宠物攻击表现
---*  actor: 玩家对象
---*  idx: 宠物序号或"X"表示当前宠物
---*  skillid: 增加的攻击表现ID
---@param actor userdata
---@param idx number
---@param skillid number
function addpetskill(actor,idx,skillid) end

---添加技能
---*  actor: 玩家对象
---@param actor userdata
---@param skillid number
---@param level number
function addskill(actor,skillid,level) end

---把行会添加到攻城列表
---*  name: 行会名
---*  day: 天数
---@param name string
---@param day number
function addtocastlewarlist(name,day) end

---强制把行会添加到攻城列表
---*  name: 行会名
---*  day: 天数
---@param name string
---@param day number
function addtocastlewarlistex(name,day) end

---本服通知触发跨服QF
function bfbackcall() end

---创建行会
---*  actor: 玩家对象
---*  name: 行会名
---@param actor userdata
---@param name string
function buildguild(actor,name) end

---调用其他NPC的lua函数
---*  actor: 玩家对象
---*  npcidx: NPC索(NPC配置表中的ID)
---*  delaytime: 延迟时间ms,0立即执行
---*  func: 函数名
---*  sParam: 	参数
---@param actor userdata
---@param npcidx number
---@param delaytime number
---@param func string
---@param sParam string
function callfunbynpc(actor,npcidx,delaytime,func,sParam) end

---调用TXT脚本命令
---*  actor: 玩家对象
---*  filename: 文件名
---*  label: 标签
---@param actor userdata
---@param filename string
---@param label string
function callscript(actor,filename,label) end

---调用传奇脚本命令
---*  actor: 玩家对象
---*  scriptname: 脚本接口
---*  ...: 参数1~参数10
---@param actor userdata
---@param scriptname string
---@param ... any
function callscriptex(actor,scriptname,...) end

---调用传奇脚本命令2
---*  actor: 玩家对象
---@param actor userdata
function callcheckscriptex(actor) end

---获取玩家沙巴克身份
---*  actor: 玩家对象
---*  return: 返回值 0-非沙巴克成员1-沙巴克成员2-沙巴克老大
---@param actor userdata
function castleidentity(actor) end

---沙巴克基本信息
---*  nID: 信息索引 1=沙城名称,返回string; 2=沙城行会名称,返回string; 3=沙城行会会长名字,返回string; 
---*  nID: 信息索引 4=占领天数,返回number; 5=当前是否在攻沙状态,返回Bool; 6=沙城行会副会长名字列表,返回table
---@param nID number
function castleinfo(nID) end

---修改攻击模式
---*  actor: 玩家对象
---*  attackmode: 0-全体攻击
---*  attackmode: 1-和平攻击
---*  attackmode: 2-夫妻攻击
---*  attackmode: 3-师徒攻击
---*  attackmode: 4-编组攻击
---*  attackmode: 5-行会攻击
---*  attackmode: 6-红名攻击
---*  attackmode: 7-国家攻击
---@param actor userdata
---@param attackmode number
function changeattackmode(actor,attackmode) end

---绑定自定义装备属性
---*  actor: 玩家对象
---*  item: 物品对象
---*  attrindex: 属性位置(0~9)
---*  bindindex: 绑定类型(0~4)
---*  bindvalue: 绑定的值
---*  group: 显示分类位置(0~2 ;为空默认为0)
---@param actor userdata
---@param item userdata
---@param attrindex number
---@param bindindex number
---@param bindvalue number
---@param group? number
function changecustomitemabil(actor,item,attrindex,bindindex,bindvalue,group) end

---增加和修改自定义属性分类名称
---*  actor: 玩家对象
---*  item: 物品对象
---*  typename: 分类名称(-1为清空)
---*  group: 显示分类位置(0~2 ;为空默认为0)
---@param actor userdata
---@param item userdata
---@param typename userdata
---@param group? number
function changecustomitemtext(actor,item,typename,group) end

---增加和修改分类名称颜色
---*  actor: 玩家对象
---*  item: 物品对象
---*  color: 分类颜色(0~255)
---*  group: 显示分类位置(0~2 ;为空默认为0)
---@param actor userdata
---@param item userdata
---@param color number
---@param group? number
function changecustomitemtextcolor(actor,item,color,group) end

---修改自定义属性值
---*  actor: 玩家对象
---*  item: 物品对象
---*  attrindex: 属性位置(0~9)每个装备可以自定义10个属性
---*  operate: 操作符:+、-、=
---*  value: 属性值
---*  group: 显示分类位置(0~2 ;为空默认为0)
---@param actor userdata
---@param item userdata
---@param attrindex number
---@param operate string
---@param value number
---@param group? number
function changecustomitemvalue(actor,item,attrindex,operate,value,group) end

---修改武器、衣服特效
---*  actor: 玩家对象
---*  where: 位置 0 1
---*  EffId: 特效ID
---*  selfSee: 玩家对象
---@param actor userdata
---@param where number
---@param EffId number
---@param selfSee number
function changedresseffect(actor,where,EffId,selfSee) end

---设置人物经验值
---*  actor: 玩家对象
---*  opt: 玩家对象
---*  count: 玩家对象
---*  addexp: 玩家对象
---@param actor userdata
---@param opt string
---@param count number
---@param addexp number
function changeexp(actor,opt,count,addexp) end

---设置行会成员人数上限
---*  actor: 玩家对象
---@param actor userdata
function changeguildmemberlimit(actor) end

---调整人物属性
---*  actor: 玩家对象
---*  id: 属性ID 1-20
---*  time: 属性值
---*  value: 时间(秒)
---@param actor userdata
---@param id number
---@param value number
---@param time number
function changehumability(actor,id,value,time) end

---修改人物名称
---*  actor: 玩家对象
---*  name: 要查询的名字
---@param actor userdata
---@param name userdata
function changehumname(actor,name) end


---清除人物身上播放的特效
---*  actor: 玩家对象
---*  effectid: 特效ID
---@param actor userdata
---@param effectid number
function clearplayeffect(actor,effectid) end

---清空所有技能
---*  actor: 玩家对象
---@param actor userdata
function clearskill(actor) end

---关闭当前的NPC对话框
---*  actor: 玩家对象
---@param actor userdata
function close(actor) end

---召唤拾取小精灵
---*  actor: 玩家对象
---*  monName: 精灵名称 精灵需要在cfg_monster.xls怪物表配置:Race=216
---@param actor userdata
---@param monName string
function createsprite(actor,monName) end

---删除英雄
---*  actor: 玩家对象
---@param actor userdata
function delhero(actor) end

---删除Ini文件配置项
---*  actor: 玩家对象
---@param actor userdata
function deliniitem(actor) end

---删除Ini文件配置项(带Cache)
---*  actor: 玩家对象
---@param actor userdata
function deliniitembycache(actor) end

---删除Ini文件配置区
---*  actor: 玩家对象
---@param actor userdata
function delinisection(actor) end

---删除Ini文件配置区 带Cache
---*  actor: 玩家对象
---@param actor userdata
function delinisectionbycache(actor) end

---通过物品唯一id拿走物品
---*  actor: 玩家对象
---*  makeindx: 物品唯一ID,逗号(,)串联
---*  count: 玩家对象
---@param actor userdata
---@param makeindx string|number
---@param count? number
function delitembymakeindex(actor,makeindx,count) end

---删除地图特效
---*  Id: 特效播放ID
---@param Id number
function delmapeffect(Id) end

---删除动态地图连接
---*  actor: 玩家对象
---*  MapId: 玩家对象
---@param actor userdata
---@param MapId string|number
function delmapgate(actor,MapId) end

---删除镜像地图
---*  MapId: 地图ID
---@param MapId string
function delmirrormap(MapId) end

---删除国家
---*  nIdx: 国家ID
---@param nIdx number
function delnation(nIdx) end

---删除非本职业技能
---*  actor: 玩家对象
---@param actor userdata
function delnojobskill(actor) end

---删除NPC
---*  name: NPC名称
---*  map: 地图编号
---@param name userdata
---@param map userdata
function delnpc(name,map) end

---删除NPC特效
---*  actor: 玩家对象
---*  NPCIndex: NPC索引 NPC配置表中的ID
---@param actor userdata
---@param NPCIndex number
function delnpceffect(actor,NPCIndex) end

---删除宠物
---*  actor: 玩家对象
---*  idx: 宠物序号
---@param actor userdata
---@param idx number
function delpet(actor,idx) end

---删除技能
---*  actor: 玩家对象
---*  skillid: 技能ID
---@param actor userdata
---@param skillid number
function delskill(actor,skillid) end

---根据唯一ID删除仓库物品
---*  actor: 玩家对象
---*  itemmakeid: 删除唯一ID物品
---@param actor userdata
---@param itemmakeid number
function delstorageitem(actor,itemmakeid) end

---根据idx删除仓库物品
---*  actor: 玩家对象
---*  itemidx: 删除所有Idx物品
---@param actor userdata
---@param itemidx number
function delstorageitembyidx(actor,itemidx) end

---删除称号
---*  actor: 玩家对象
---*  name: 称号物品名称
---@param actor userdata
---@param name string
function deprivetitle(actor,name) end

---使用脚本命令解毒(红绿毒)
---*  actor: 玩家对象
---*  opt: -1,解所有毒;0,绿毒;1,红毒;3,紫毒;5,麻痹;6,冰冻;7,蛛网
---@param actor userdata
---@param opt string
function detoxifcation(actor,opt) end

---下马
---*  actor: 玩家对象
---@param actor userdata
function dismounthorse(actor) end

---停止摆摊
---*  actor: 玩家对象
---@param actor userdata
function forbidmyshop(actor) end

---获取角色所有buff
---*  actor: 玩家对象
---@param actor userdata
function getallbuffid(actor) end

---获取所有行会对象
function getallguild() end

---获取当前攻击模式
---*  actor: 玩家对象
---@param actor userdata
function getattackmode(actor) end

---获取背包剩余空格数
---*  actor: 玩家对象
---@param actor userdata
function getbagblank(actor) end

---获取背包物品数量
---*  actor: 玩家对象
---*  itemname: 物品名称
---@param actor userdata
---@param itemname string
function getbagitemcount(actor,itemname) end

---获取背包所有物品
---*  actor: 玩家对象
---@param actor userdata
function getbagitems(actor) end

---获取 人物|怪物 相关信息
---*  object: 玩家|怪物 对象
---*  nID: 类型 (详见说明书)
---*  param3: 参数3 (仅ID=1时可用)
---@param object userdata
---@param nID number
---@param param3? number
---@return any
function getbaseinfo(object,nID,param3) end

---获取人物通用货币数量(多货币计算)
---*  actor: 玩家对象
---@param actor userdata
function getbindmoney(actor) end

---获取buff信息
---*  actor: 玩家对象
---@param actor userdata
function getbuffinfo(actor) end

---获取常量
---*  actor: 玩家对象
---*  varname: 常量名称,详见txt说明书
---@param actor userdata
---@param varname userdata
function getconst(actor,varname) end

---获取标记值
---*  object: 人物|怪物对象
---*  index: 下标ID 0-9
---@param object userdata
---@param index userdata
function getcurrent(object,index) end

---根据物品获取Json
---*  item: 物品对象
---@param item userdata
function getitemjson(item) end

---检测装备名字的颜色
---*  item: 物品对象
---@param item userdata
function getitemnamecolor(item) end

---获取当前唯一ID物品的星星数量
---*  actor: 玩家对象
---*  itemmakeid: 物品唯一ID
---@param actor userdata
---@param itemmakeid number
function getitemstars(actor,itemmakeid) end

---获取指定地图玩家数量
---*  actor: 玩家对象
---*  MapId: 地图ID
---*  isAllgain: 是否全部获取 0=全部获取 1=排除已死亡的
---@param actor userdata
---@param MapId userdata
---@param isAllgain userdata
function getplaycountinmap(actor,MapId,isAllgain) end

---获取玩家变量
---*  actor: 玩家对象
---*  varName: 变量名
---@param actor userdata
---@param varName string
function getplaydef(actor,varName) end

---根据玩家唯一ID获取玩家对象
---*  userdata: 玩家唯一ID
---@param makeindex string
function getplayerbyid(makeindex)  end

---根据玩家名获取玩家对象
---*  name: 玩家名字
---@param name string
function getplayerbyname(name) end

---获取所有在线玩家列表
---@return table
function getplayerlst() end

---获取行会成员在行会中的职位
---*  actor: 玩家对象
---@param actor userdata
function getplayguildlevel(actor) end

---获取自定义变量
---*  actor: 玩家对象
---*  varName: 变量名
---@param actor userdata
---@param varName string
---@return any
function getplayvar(actor,varName) end

---获取仓库剩余格子数
---*  actor: 玩家对象
---@param actor userdata
function getsblank(actor) end

---获取技能初始冷却时间
---*  skillname: 玩家对象
---@param skillname string
function getskillcscd(skillname) end

---获取当前技能冷却时间
---*  actor: 玩家对象
---*  skillname: 技能名称
---@param actor userdata
---@param skillname string
function getskilldqcd(actor,skillname) end

---根据技能id获取技能名字
---*  skillname: 技能名称
---@param skillname string
function getskillindex(skillname) end

---获取技能信息
---*  actor: 玩家对象
---*  skillid: 技能ID
---*  type: 获取类型:1:等级;2:强化等级;3:熟练度;4:熟练度上限;
---@param actor userdata
---@param skillid number
---@param type number
function getskillinfo(actor,skillid,type) end

---获取技能等级
---*  actor: 玩家对象
---*  skillid: 技能ID
---@param actor userdata
---@param skillid number
function getskilllevel(actor,skillid)  end

---获取技能强化等级
---*  actor: 玩家对象
---*  skillid: 技能ID
---@param actor userdata
---@param skillid number
function getskilllevelup(actor,skillid)  end

---根据技能id获取技能名字
---*  actor: 玩家对象
---*  skillname: 技能名称
---@param actor userdata
---@param skillname string
function getskillname(actor,skillname) end

---获取技能熟练度
---*  actor: 玩家对象
---@param actor userdata
---@param skillid number
function getskilltrain(actor,skillid) end

---根据宝宝索引获取角色宝宝对象
---*  actor: 玩家对象
---@param actor userdata
---@param nIndex number
function getslavebyindex(actor,nIndex) end


---获取装备钻石镶嵌情况
---*  actor: 玩家对象
---*  item: 装备对象
---@param actor userdata
---@param item userdata
function getsocketableitem(actor,item) end

---获取玩家仓库最大格子数
---*  actor: 玩家对象
---@param actor userdata
function getssize(actor) end

---获取buff模板信息
---*  buffinfo: buffID/buff名称
---*  id: 0:idx1:名称;2.组别;3.配置时间;4.配置属性;
---@param buffinfo number|string
---@param id number
function getstdbuffinfo(buffinfo,id) end

---获取物品基础属性
---*  itemid: 物品ID
---@param itemid number
---@param id number
function getstditematt(itemid,id) end

---获取物品基础信息
---*  item: 物品ID/物品名称
---*  id:见说明书
---@param item number|string
---@param id number
---@return any
function getstditeminfo(item,id) end

---获取仓库所有物品列表
---*  actor: 玩家对象
---@param actor userdata
function getstorageitems(actor) end

---获取人物伤害吸收
---*  actor: 玩家对象
---@param actor userdata
function getsuckdamage(actor) end

---获取全局变量
---*  varName: 变量名
---@param varName string
function getsysvar(varName) end

---获取全局自定义变量
---*  varName: 变量名
---@param varName string
function getsysvarex(varName) end

---获取服务器上64位时间戳
function gettcount64() end

---获取物品来源
---*  actor: 玩家对象
---*  item: 物品对象
---@param actor userdata
---@param item userdata
function getthrowitemly(actor,item) end

---获取角色所有称号
---*  actor: 玩家对象
---@param actor userdata
function gettitlelist(actor) end

---获取人物永久属性
---*  actor: 玩家对象
---*  nIndex: 	索引
---@param actor userdata
---@param nIndex userdata
function getusebonuspoint(actor,nIndex) end

---给物品
---*  actor: 玩家对象
---*  itemname: 物品名称
---*  num: 	数量
---*  bind: 物品规则
---@param actor userdata
---@param itemname string
---@param num number
---@param bind? number
function giveitem(actor,itemname,num,bind) end

---根据json字符串给物品
---*  actor: 玩家对象
---*  json: json字符串
---@param actor userdata
---@param json userdata
function giveitembyjson(actor,json) end

---给物品,并直接穿戴
---*  actor: 玩家对象
---*  where: 装备位置
---*  itemname: 物品名称
---*  num: 数量
---*  bind: 物品规则
---@param actor userdata
---@param where number
---@param itemname string
---@param num number
---@param bind number
function giveonitem(actor,where,itemname,num,bind) end

---获取全局信息
---*  id: 见说明书
---@param id number
function globalinfo(id) end

---执行GM命令
---*  actor: 玩家对象
---*  GM: GM命令
---*  ...: 命令参数
---@param actor userdata
---@param GM string
---@param ... any
function gmexecute(actor,GM,...) end

---回到最近经过的城市安全区
---*  actor: 玩家对象
---@param actor userdata
function gohome(actor) end

---调用触发
---*  actor: 玩家对象
---*  type: 触发模式
---*  label: 跳转后的接口
---*  range: 触发模式=3时指定的范围大小
---@param actor userdata
---@param type number
---@param label string
---@param range number
function gotolabel(actor,type,label,range) end

---导航玩家到指定位置
---*  actor: 玩家对象
---*  x: X坐标
---*  y: Y坐标
---@param actor userdata
---@param x number
---@param y number
function gotonow(actor,x,y) end

---检测地图逻辑格
---*  mapid: 地图Id
---*  x: X坐标
---*  y: Y坐标
---@param mapid userdata
---@param x number
---@param y number
---@param type number
---@param result boolean
function gridattr(mapid,x,y,type,result) end

---获取全局信息
---*  id: 见说明书
---@param id number
---@return any
function grobalinfo(id) end

---编组地图传送
---*  actor: 玩家对象
---*  mapid: 地图Id
---*  x: X坐标
---*  y: Y坐标
---*  level: 可以传送最低等级(可以为空 为空时不检测队员的等级直接传送)
---*  value: 传送范围。(以队长为中心传送队友 0为不需要范围)
---*  obj: 触发字段(可以为空)
---@param actor userdata
---@param mapid userdata
---@param x number
---@param y number
---@param level number
---@param value number
---@param obj userdata
function groupmapmove(actor,mapid,x,y,level,value,obj) end

---发送自定义颜色的文字信息
---*  actor: 玩家对象
---*  FColor: 地图Id
---*  BColor: X坐标
---*  Msg: Y坐标
---*  flag: 可以传送最低等级(可以为空 为空时不检测队员的等级直接传送)
---@param actor userdata
---@param FColor userdata
---@param BColor number
---@param Msg number
---@param flag number
function guildnoticemsg(actor,FColor,BColor,Msg,flag) end

---是否有buff
---*  actor: 玩家对象
---*  buffid: 玩家对象
---@param actor userdata
---@param buffid userdata
function hasbuff(actor,buffid) end

---是否有英雄
---*  actor: 玩家对象
---@param actor userdata
function hashero(actor) end

---刷新血量/蓝量
---*  object: 玩家/怪物对象
---@param object userdata
function healthspellchanged(object) end

---数据消息上报
---*  actor: 玩家对象
---@param actor userdata
function httppost(actor) end

---修改人物当前血量
---*  actor: 玩家对象
---*  operate: 操作符号 [+增加][-减少][=等于]
---*  nvalue: HP点数
---*  effid: 素材ID
---@param actor userdata
---@param operate string
---@param nvalue number
---@param effid? number
function humanhp(actor,operate,nvalue,effid) end

---修改人物当前MP
---*  actor: 玩家对象
---*  operate: 操作符号 [+增加][-减少][=等于]
---*  nvalue: MP点数
---@param actor userdata
---@param operate string
---@param nvalue number
function humanmp(actor,operate,nvalue) end

---取自定义数字变量名位置
---*  actor: 玩家对象
---*  varName: 排序变量名
---*  playflag: 0-所有玩家 1-在线玩家
---*  sortflag: 0-升序 1-降序
---@param actor userdata
---@param varName string
---@param playflag number
---@param sortflag number
function humvarrank(actor,varName,playflag,sortflag) end

---引用文件
---*  path: 路径名称(起始目录Envir)
---@param path string
function include(path) end

---初始化行会自定义变量
---*  guil: 行会对象
---*  varType: 变量类型
---*  varName: 变量名
---@param guil userdata
---@param varType string
---@param varName string
function iniguildvar(guil,varType,varName) end

---初始化个人自定义变量
---*  actor: 玩家对象
---*  varType: 变量类型(number/string)
---*  varRage: 变量范围(HUMAN/GUILD) HUMAN指个人变量 GUILD指行会变量
---*  varName: 变量名
---@param actor userdata
---@param varType string
---@param varRage string
---@param varName string
function iniplayvar(actor,varType,varRage,varName) end

---初始化全局自定义变量
---*  type: 变量类型(number/string)
---*  varName: 变量名
---@param type string
---@param varName string
function inisysvar(type,varName) end

---判断地图坐标是否为空
---*  mapname: 地图名称
---*  nX: 地图x坐标
---*  nY: 地图y坐标
---@param mapname userdata
---@param nX userdata
---@param nY userdata
function isemptyinmap(mapname,nX,nY) end



---判断英雄是否为唤出状态
---*  actor: 玩家对象
---@param actor userdata
function isherorecall(actor) end



---监测国家战争状态
---*  actor: 玩家对象
---@param actor userdata
function isnationswar(actor) end

---对象是否存在
---*  actor: 玩家对象
---@param actor userdata
function isnotnull(actor) end


---判断对象是否可被攻击
---*  Hiter: 攻击对象(玩家/英雄/怪物)
---*  Target: 被攻击对象(玩家/英雄/怪物)
---@param Hiter userdata
---@param Target userdata
function ispropertarget(Hiter,Target) end

---加入/退出国家
---*  actor: 玩家对象
---*  nIdx: 国家ID (1~100),填0退出国家
---*  jobIdx: 职位编号 0-9 不填 默认为0 
---@param actor userdata
---@param nIdx number
---@param jobIdx number
function joinnational(actor,nIdx,jobIdx) end

---字符串转换成表格
---*  str: 玩家对象
---@param str string
function json2tbl(str) end

---跨服通知触发本服QF
---*  id: 消息id 1-99
---*  userid: 玩家userid
---*  parama: 传递的字符串1(字符串)
---*  paramb: 传递的字符串2(字符串)
---@param id number
---@param userid string
---@param parama string
---@param paramb string
function kfbackcall(id,userid,parama,paramb) end

---人物强制掉线
---*  actor: 玩家对象
---@param actor userdata
function kick(actor) end

---立即杀死角色
---*  play: 角色的对象
---*  actor: 凶手的对象
---@param play userdata
---@param strKiller userdata
function kill(actor,strKiller) end

---脚本设置防秒杀功能
---*  actor: 玩家对象
---@param actor userdata
function killedprotect(actor) end

---在指定位置优先打指定打怪
---*  actor: 玩家对象
---*  map: 地图
---*  X: 	X坐标
---*  Y: 	Y坐标
---*  MonName: 优先攻击的怪物名称支持多个怪物名称,怪物名称中间用 | 分隔
---@param actor userdata
---@param map string
---@param X number
---@param Y number
---@param MonName? string
function killmobappoint(actor,map,X,Y,MonName) end

---杀怪2
---*  actor: 玩家对象
---*  mon: 怪物对象
---*  drop: 是否掉落物品 true掉落|false不掉落
---*  trigger: 是否触发killmon
---*  showdie: 是否显示死亡动画
---@param actor userdata
---@param mon userdata
---@param drop boolean
---@param trigger boolean
---@param showdie boolean
function killmonbyobj(actor,mon,drop,trigger,showdie) end

---杀怪1
---*  mapid: 地图id
---*  monname: 怪物全名 填 nil|* 杀死全部
---*  count: 数量 填0杀死所有
---*  drop: 是否掉落物品
---@param mapid string
---@param monname string
---@param count number
---@param drop boolean
function killmonsters(actor,mapid,monname,count,drop) end

---所有跨服玩家回本服 根据执行区服自行处理
function kuafuusergohome() end

---关联装备物品
---*  actor: 玩家对象
---*  where: 装备位置
---@param actor userdata
---@param where number
function linkbodyitem(actor,where) end

---关联正在操作的物品 捡取 丢弃 ,废弃!!!!!!!!!!
function linkpickupitem() end


---改变 人/怪物 状态
---*  object: 玩家/怪物 对象
---*  type: 类型(0=绿毒 1=红毒 5=麻痹 12=冰冻 13= 蛛网 其他无效)
---*  time: 时间(秒)
---*  actor: 威力 只针对绿毒有用
---@param object userdata
---@param type number
---@param time number
---@param value number
function makeposion(object,type,time,value) end

---跳转地图(随机坐标)
---*  actor: 玩家对象
---*  mapname: 地图名
---@param actor userdata
---@param mapname string
function map(actor,mapname) end

---添加地图特效
---*  Id: 	特效播放ID 用于区分多个地图特效
---*  MapId: 地图ID
---*  X: 坐标X
---*  Y: 坐标Y
---*  effId: 特效ID
---*  time: 持续时间(秒)
---*  mode: 模式:(0~4 0所有人可见 1自己可见 2组队可见 3行会成员可见 4敌对可见)
---@param Id number
---@param MapId string
---@param X number
---@param Y number
---@param effId number
---@param time number
---@param mode number
function mapeffect(Id,MapId,X,Y,effId,time,mode) end

---设置地图杀怪经验倍数
---*  actor: 玩家对象
---*  MapId: 地图id( * 号表示所有地图)
---*  much: 倍率 为杀怪经验倍数 倍数除以100为真正的倍率(200 为 2 倍经验 150 为1.5倍,0表示关闭地图的杀怪经验倍数)
---@param actor userdata
---@param MapId string
---@param much number
function mapkillmonexprate(actor,MapId,much) end

---飞地图(指定坐标)
---*  actor: 玩家对象
---*  mapname: 地图名
---*  nX: X坐标
---*  nY: Y坐标
---*  nRange: 	范围
---@param actor userdata
---@param mapname number|string
---@param nX number
---@param nY number
---@param nRange? number
function mapmove(actor,mapname,nX,nY,nRange) end

---MD5加密
---*  str: 需要加密的文本
---@param str string
function md5str(str) end

---弹出窗口消息
---*  actor: 玩家对象
---*  info: 弹出内容
---*  flag1: 确定后跳转的接口
---*  flag2: 取消后跳转的接口
---@param actor userdata
---@param info string
---@param flag1 string
---@param flag2 string
function messagebox(actor,info,flag1,flag2) end

---客户端复制
---*  actor: 玩家对象
---*  str: 文本内容
---@param actor userdata
---@param str string
function mircopy(actor,str) end

---获取/设置 镜像地图剩余时间
---*  actor: 玩家对象
---@param actor userdata
function mirrormaptime(actor) end

---播放光环效果
---*  actor: 玩家对象
---*  mapid: 地图id
---*  x: 坐标x
---*  y: 坐标y
---*  type: 光环类型
---*  time: 时间(秒)
---*  behind: 播放模式-0-前面-1-后面
---*  selfshow: 仅自己可见0-否 视野内均可见 1-是
---@param actor userdata
---@param mapid number|string
---@param x number
---@param y number
---@param type number
---@param time number
---@param behind? number
---@param selfshow? number
function mobfireburn(actor,mapid,x,y,type,time,behind,selfshow) end

---杀怪物品再爆
---*  actor: 玩家对象
---*  count: 怪物物品掉落增加次数
---@param actor userdata
---@param count number
function monitems(actor,count) end

---把某个地图中的玩家全部移动到另外一个地图
---*  actor: 玩家对象
---*  aMapId: 移动前地图Id
---*  bMapId: 移动后地图Id
---*  x: x坐标
---*  y: y坐标
---@param actor userdata
---@param aMapId userdata
---@param bMapId userdata
---@param x userdata
---@param y userdata
function movemapplay(actor,aMapId,bMapId,x,y) end

---国家宣战
---*  actor: 玩家对象
---@param actor userdata
function nationswar(actor) end

---新手界面引导功能
---*  actor: 玩家对象
---*  NPCIdx: 界面ID
---*  BtnIdx: 按钮索引
---*  sMsg: 显示的内容
---@param actor userdata
---@param NPCIdx number
---@param BtnIdx number
---@param sMsg string
function navigation(actor,NPCIdx,BtnIdx,sMsg) end

---刷新进行中任务状态
---*  actor: 玩家对象
---*  nId: 界面ID
---*  ...:参数1~参数10
---@param actor userdata
---@param nId number
---@param ... any
function newchangetask(actor,nId,...) end

---完成任务
---*  actor: 玩家对象
---*  nId: 任务
---@param actor userdata
---@param nId number
function newcompletetask(actor,nId) end

---删除任务
---*  actor: 玩家对象
---*  nId: 任务
---@param actor userdata
---@param nId number
function newdeletetask(actor,nId) end

---读取表里面的第几行第几列内容(0行0列开始)
---*  filename: 玩家对象
---*  row: 玩家对象
---*  col: 玩家对象
---@param filename userdata
---@param row userdata
---@param col userdata
function newdqcsv(filename,row,col) end


---新建任务
---*  actor: 玩家对象
---*  nId: 	任务ID
---*  ...: 参数1~参数10 用来替换任务内容里的%s
---@param actor userdata
---@param nId number
---@param ... string
function newpicktask(actor,nId,...) end

---加载csv表格内容
---*  filename: 文件名
---@param filename string
function newreadcsv(filename) end

---是否满足指定条件购买 CanBuyShopItem触发中使用 
---*  actor: 玩家对象
---*  canbuy: 1-不允许购买 0-允许购买
---@param actor userdata
---@param canbuy number
function notallowbuy(actor,canbuy) end

---是否满足指定条件显示 CanShowShopItem触发中使用 
---*  actor: 玩家对象
---*  canbuy: 1-不显示 0-显示
---@param actor userdata
---@param canshow number
function notallowshow(actor,canshow) end

---关闭指定装备对比提示
---*  actor: 玩家对象
---*  order: 1=物品唯一ID 2=物品IDX 3=物品名称
---*  str: 	对应参数2的属性值
---@param actor userdata
---@param order number
---@param str string
function nothintitem(actor,order,str) end

---离线挂机
---*  actor: 玩家对象
---*  time: 离线时间(分)
---@param actor userdata
---@param time number
function offlineplay(actor,time) end

---调用游戏面板
---*  actor: 玩家对象
---*  nId: 	面板ID
---*  nState: 0=打开 1=打开面板重复点按钮不会关闭,除非主动点关闭按钮(一般做任务配合新手引导用到) 2=关闭当前面板ID
---@param actor userdata
---@param nId number
---@param nState number
function openhyperlink(actor,nId,nState) end

---打开NPC大窗口
---*  path: 玩家对象
---*  pos: 玩家对象
---*  x: 玩家对象
---*  y: 玩家对象
---*  height: 玩家对象
---*  width: 玩家对象
---*  bool: 玩家对象
---*  closeX: 玩家对象
---*  closeY: 玩家对象
---*  isMove: 玩家对象
---@param path string
---@param pos number
---@param x number
---@param y number
---@param height number
---@param width number
---@param bool number
---@param closeX number
---@param closeY number
---@param isMove number
function openmerchantbigdlg(path,pos,x,y,height,width,bool,closeX,closeY,isMove) end

---打开指定NPC面板
---*  actor: 玩家对象
---*  NPCIndex: NPC索引 NPC配置表中的ID
---*  nRange: 范围值 在此范围内允许打开
---@param actor userdata
---@param NPCIndex number
---@param nRange number
function opennpcshow(actor,NPCIndex,nRange) end

---移动到指定NPC附近
---*  actor: 玩家对象
---*  NPCIndex: NPC索引 NPC配置表中的ID 
---*  nRange: 范围值 不在此范围内则移动到NPC附近
---*  actor: 范围值2 移动到NPC附近的范围内
---@param actor userdata
---@param NPCIndex number
---@param nRange number
---@param nRange2 number
function opennpcshowex(actor,NPCIndex,nRange,nRange2) end

---打开仓库面板
---*  actor: 玩家对象
---@param actor userdata
function openstorage(actor) end

---打开OK框
---*  actor: 玩家对象
---*  title: OK框标题
---@param actor userdata
---@param title string
function openupgradedlg(actor,title) end

---游戏中打开网站
---*  actor: 玩家对象
---*  url: 网站
---@param actor userdata
---@param url string
function openwebsite(actor,url) end

---查看自己面板
---*  actor: 玩家对象
---*  winID: 101=装备 102=状态 103=属性 104=技能 105=生肖 106=称号 1011=时装
---@param actor userdata
---@param winID number
function openwindows(actor,winID) end

---解析文本
---*  text: 	文本内容
---*  actor: 玩家对象
---@param text string
---@param actor userdata
function parsetext(text,actor) end

---置换宠物属性 *只置换基础属性:形象、怪物表配置 原宠物其它属性全部保留 包括序号
---*  actor: 玩家对象
---*  idx: 	宠物序号
---*  monidx: 	怪物IDX
---@param actor userdata
---@param idx number
---@param monidx number
function petmon(actor,idx,monidx) end

---获取宠物状态
---*  actor: 玩家对象
---*  idx: 宠物序号
---@param actor userdata
---@param idx number
function petstate(actor,idx) end

---宠物脱装备 此接口不扣减物品 仅扣减宠物身上对应装备属性。
---*  actor: 玩家对象
---*  idx: 宠物序号
---*  item: 装备名称 多个装备用#分隔 -1表示脱下全部装备
---@param actor userdata
---@param idx number
---@param item string
function pettakeoff(actor,idx,item) end

---宠物穿装备 此接口不会增加物品 仅将物品的属性添加到宠物身上 并保存到数据库。
---*  actor: 玩家对象
---*  idx: 宠物序号
---*  item: 装备名称 多个装备用#分隔
---@param actor userdata
---@param idx number
---@param item string
function pettakeon(actor,idx,item) end

---拾取模式
---*  actor: 玩家对象
---*  mode: 模式 0=以人物为中心捡取 1=以小精灵为中心捡取
---*  Range: 范围
---*  interval: 间隔 最小500ms
---@param actor userdata
---@param mode number
---@param Range number
---@param interval number
function pickupitems(actor,mode,Range,interval) end

---在人物身上播放特效
---*  actor: 玩家对象
---*  actor: 特效ID
---*  actor: 相对于人物偏移的X坐标
---*  actor: 相对于人物偏移的Y坐标
---*  actor: 播放次数 填0则一直播放
---*  actor: 播放模式0-前面1-后面
---*  actor: 仅自己可见 0-否(视野内均可见) 1-是
---@param actor userdata
---@param effectid number
---@param offsetX number
---@param offsetY number
---@param times number
---@param behind number
---@param selfshow number
function playeffect(actor,effectid,offsetX,offsetY,times,behind,selfshow) end

---播放音乐声音
---*  actor: 玩家对象
---*  index: 播放文件的索引 对应声音配置表id(cfg_sound.xls)
---*  times: 循环播放次数
---*  flag: 播放模式:0.播放给自己 1.播放给全服 2.播放给同一地图 4.播放给同屏人物
---@param actor userdata
---@param index userdata
---@param times userdata
---@param flag userdata
function playsound(actor,index,times,flag) end

---设置人物攻击威力
---*  actor: 玩家对象
---*  rate: 攻击威力比率 100=100%
---*  time: 有效时间 超过时间恢复正常
---@param actor userdata
---@param rate number
---@param time number
function powerrate(actor,rate,time) end

---拉取客户端充值接口
---*  actor: 玩家对象
---*  money: 金额
---*  type: 充值方式 1-支付宝 2-花呗 3-微信
---*  flagid: 玩家对象
---@param actor userdata
---@param money number
---@param type number
---@param flagid number
function pullpay(actor,money,type,flagid) end

---查询人物名称是否存在
---*  actor: 玩家对象
---*  name: 要查询的名字
---@param actor userdata
---@param name string
function queryhumnameexist(actor,name) end

---查询人物货币
---*  actor: 玩家对象
---*  id: 货币ID 1-100 
---@param actor userdata
---@param id number
function querymoney(actor,id) end

---随机杀死地图中的怪物
---*  mapid: 玩家对象
---*  name: 怪物名字
---*  num: 数量(1-255)
---*  drop: 是否掉落 0=掉落 1=不掉落
---@param mapid string
---@param name number
---@param num number
---@param drop number
function randomkillmon(mapid,name,num,drop) end

---增加附加伤害效果
---*  actor: 玩家对象
---*  targetX: X坐标
---*  targetY: Y坐标
---*  range: 影响范围
---*  power: 攻击力
---*  addtype: 附加类型,见说明书
---*  addvalue: 附加属性值,见说明书
---*  checkstate: 是否检查防冻结/麻痹/石化/冰冻/蛛网/红毒/绿毒属性0=直接设置状态;1=检查后设置状态)
---*  targettype: 目标类型(0或空=所有目标;1=仅人物;2=仅怪物)
---*  effectid: 目标身上播放的特效ID
---@param actor userdata
---@param targetX number
---@param targetY number
---@param range number
---@param power number
---@param addtype number
---@param addvalue number
---@param checkstate number
---@param targettype number
---@param effectid number
function rangeharm(actor,targetX,targetY,range,power,addtype,addvalue,checkstate,targettype,effectid) end

---读取Ini文件中的字段值
---*  actor: 玩家对象
---*  section: 配置项区
---*  item: 配置项
---@param actor userdata
---@param section string
---@param item string
function readini(actor,section,item) end

---读取Ini文件中的字段值 带Cache
---*  actor: 玩家对象
---*  section: 配置项区
---*  item: 配置项
---@param actor userdata
---@param section string
---@param item string
function readinibycache(actor,section,item) end

---复活
---*  actor: 玩家对象
---@param actor userdata
function realive(actor) end

---返回复活的宠物对象
---*  actor: 玩家对象
---*  idx: 宠物序号
---*  nHp: 复活后的HP量
---*  type: 0-绝对值 1-百分比
---@param actor userdata
---@param idx number
---@param nHp number
---@param type number
function realivepet(actor,idx,nHp,type) end

---刷新人物属性
---*  actor: 玩家对象
---@param actor userdata
function recalcabilitys(actor) end

---召唤英雄
---*  actor: 玩家对象
---@param actor userdata
function recallhero(actor) end

---召唤宝宝
---*  actor: 玩家对象
---*  monName: 怪物名称
---*  level: 宝宝等级(最高为7)
---*  time: 叛变时间(分钟)
---*  param1: 预留(填0)
---*  param2: 预留(填0)
---*  param3: 设置大于0 检测时不计算该宝宝数量(仅M2控制的召唤数量)
---@param actor userdata
---@param monName string
---@param level number
---@param time number
---@param param1 number
---@param param2 number
---@param param3 number
function recallmob(actor,monName,level,time,param1,param2,param3) end

---返回召唤的宠物对象
---*  actor: 玩家对象
---*  idx: 玩家对象
---@param actor userdata
---@param idx number
function recallpet(actor,idx) end

---返回OK框物品到背包
---*  actor: 玩家对象
---@param actor userdata
function reclaimitem(actor) end

---整理背包里的物品
---*  actor: 玩家对象
---@param actor userdata
function refreshbag(actor) end

---刷新物品信息到前端
---*  actor: 玩家对象
---*  item: 物品对象
---@param actor userdata
---@param item userdata
function refreshitem(actor,item) end

---给NPC注册Lua消息
---*  msgId: 消息ID
---*  NPCIndex: NPC索引 NPC配置表中的ID
---@param msgId number
---@param NPCIndex number
function regnpcmsg(msgId,NPCIndex) end

---用脚本命令释放技能
---*  actor: 玩家对象
---*  skillid: 	技能ID
---*  type: 类型 1-普通技能2-强化技能
---*  level: 技能等级
---*  target: 技能对象: 1-攻击目标 2-自身
---*  flag: 是否显示施法动作 0-不显示 1-显示
---@param actor userdata
---@param skillid number
---@param type number
---@param level number
---@param target number
---@param flag number
function releasemagic(actor,skillid,type,level,target,flag) end

---回收
---*  actor: 玩家对象
---@param actor userdata
function releasesprite(actor) end

---打印消息到控制台 引擎开发模式 会输出到控制台上 线上模式 会记录到ScriptXX文件里 可以用于排查错误
---@param ... any
function release_print(...) end

---人物转生控制
---*  actor: 玩家对象
---*  rlevel: 转生次数一次转多少级(数值范围为1-255)
---*  level: 转生后等级代表转生后人物的等级 0为不改变人物当前等级
---*  num: 分配点数转生后可以得到的点数 此点数可能按比例换成人物属性点(数值范围 1 - 20000)
---@param actor userdata
---@param rlevel userdata
---@param level userdata
---@param num userdata
function renewlevel(actor,rlevel,level,num) end

---修复所有装备
---*  actor: 玩家对象
---@param actor userdata
function repairall(actor) end

---引用文件
---*  path: 路径名称
---@param path string
function require(path) end

---收回宠物
---*  actor: 玩家对象
---@param actor userdata
function retractpettoitem(actor) end

---上马
---*  actor: 玩家对象
---*  HorseAppr: 玩家对象
---*  HorseEff: 玩家对象
---*  HorseFature: 玩家对象
---*  Type: 玩家对象
---@param actor userdata
---@param HorseAppr number
---@param HorseEff number
---@param HorseFature number
---@param Type number
function ridehorse(actor,HorseAppr,HorseEff,HorseFature,Type) end

---NPC界面文本发送
---*  actor: 玩家对象
---*  msg: 界面文本内容
---@param actor userdata
---@param msg string
function say(actor,msg) end

---屏幕震动
---*  actor: 玩家对象
---*  type: 模式(0~4)0.仅自己;1.在线所有人;2屏幕范围内人物;3.当前地图上所有人;4.指定地图上所有人;
---*  level: 震级(1~3)
---*  num: 	次数
---*  mapid: 地图ID(模式等于4时 需要该参数)
---@param actor userdata
---@param type number
---@param level number
---@param num number
---@param mapid number
function scenevibration(actor,type,level,num,mapid) end

---播放屏幕特效
---*  actor: 玩家对象
---*  id: 模式(0~4)0.仅自己;1.在线所有人;2屏幕范围内人物;3.当前地图上所有人;4.指定地图上所有人;
---*  effectid: 震级(1~3)
---*  X: 次数
---*  Y: 地图ID(模式等于4时 需要该参数)
---*  speed: 次数
---*  times: 地图ID(模式等于4时 需要该参数)
---*  type: 地图ID(模式等于4时 需要该参数)
---@param actor userdata
---@param id number
---@param effectid number
---@param X number
---@param Y number
---@param speed number
---@param times number
---@param type number
function screffects(actor,id,effectid,X,Y,speed,times,type) end


---遍历背包勾选物品
---*  actor: 玩家对象
---*  makeindex: 选中的物品唯一ID多个物品用","分隔
---@param actor userdata
---@param makeindex userdata
function selectbagitems(actor,makeindex) end

---人物飘血飘字特效
---*  target: 飘血飘字的主体 一般为受攻击者
---*  type: 显示类型 1- 伤害 2- 暴击伤害 3- 弯腰效果 4- 加HP 5- 格挡 8- 扣减HP和MP 9- 伤害 10-扣减MP 11- 致命一击
---*  damage: 显示的点数
---*  hitter: 可看到飘血飘字的主体 一般为攻击者
---@param target userdata
---@param type number
---@param damage number
---@param hitter? userdata
function sendattackeff(target,type,damage,hitter) end

---发送屏幕中间大字体信息
---*  actor: 玩家对象
---*  FColor: 前景色
---*  BColor: 	背景色
---*  Msg: 发送对象
---*  flag: 玩家对象
---*  time: 显示时间
---*  func: 倒计时结束后触发回调
---@param actor userdata
---@param FColor number
---@param BColor number
---@param Msg string
---@param flag string
---@param time number
---@param func string
function sendcentermsg(actor,FColor,BColor,Msg,flag,time,func) end

---屏幕任意坐标发送公告信息
---*  actor: 玩家对象
---*  type: 消息类型0-全服 1-自己 2-组队 3-行会 4-当前地图
---*  msg: 消息内容
---*  FColor: 前景色
---*  BColor: 背景色
---*  X: X坐标
---*  Y: Y坐标
---@param actor userdata
---@param type number
---@param msg string
---@param FColor number
---@param BColor number
---@param X number
---@param Y number
function sendcustommsg(actor,type,msg,FColor,BColor,X,Y) end

---显示倒计时信息提示
---*  actor: 玩家对象
---*  msg: 消息内容
---*  time: 时间 秒
---*  FColor: 字体景色
---*  mapdelete: 换地图是否删除 0-不删除 1-删除
---*  func: 跳转的函数
---*  Y: Y坐标
---@param actor userdata
---@param msg string
---@param time number
---@param FColor number
---@param mapdelete number
---@param func string
---@param Y number
function senddelaymsg(actor,msg,time,FColor,mapdelete,func,Y) end

---发送消息
---*  actor:    玩家对象
---*  msgid:    消息ID
---*  param1: 	参数1
---*  param2: 	参数2
---*  param3: 	参数3
---*  sMsg: 	消息体
---@param actor userdata
---@param msgid number
---@param param1? number
---@param param2? number
---@param param3? number
---@param sMsg? string
function sendluamsg(actor,msgid,param1,param2,param3,sMsg) end

---发送邮件
---*  userid: 家UserId 如果是玩家名 需要在前面加#(如:#张三)
---*  id: 自定义邮件ID
---*  title: 邮件标题
---*  memo: 邮件内容
---*  rewards: 附件内容: 物品1#数量#绑定标记&物品2#数量#绑定标记 &分组 #分隔
---@param userid string
---@param id number
---@param title string
---@param memo string
---@param rewards string
function sendmail(userid,id,title,memo,rewards) end

---发送屏幕滚动信息
---*  actor: 玩家对象
---*  type: 模式 发送对象 0-自己 1-所有人 2-行会 3-当前地图 4-组队
---*  FColor: 字体景色
---*  BColor: 背景色
---*  Y: Y坐标
---*  scroll: 滚动次数
---*  msg: 	消息内容
---@param actor userdata
---@param type number
---@param FColor number
---@param BColor number
---@param Y number
---@param scroll number
---@param msg number
function sendmovemsg(actor,type,FColor,BColor,Y,scroll,msg) end

---发送聊天框消息
---*  actor: 玩家对象
---*  type: 玩家对象
---*  msg: 玩家对象
---@param actor userdata|nil
---@param type number
---@param msg string
function sendmsg(actor,type,msg) end

---主屏幕弹出公告
---*  actor: 玩家对象
---*  FColor: 前景色
---*  BColor: 背景色
---*  msg: 公告内容
---*  type: 模式 发送对象 0-自己 1-所有人 2-行会 3-当前地图 4-组队
---*  time: 显示时间
---@param actor userdata
---@param FColor number
---@param BColor number
---@param msg string
---@param type number
---@param time number
function sendmsgnew(actor,FColor,BColor,msg,type,time) end

---发送视野内广播消息
---*  actor:    玩家对象
---*  msgid:    消息ID
---*  param1: 	参数1
---*  param2: 	参数2
---*  param3: 	参数3
---*  sMsg: 	消息体
---@param actor userdata
---@param msgid number
---@param param1? number
---@param param2? number
---@param param3? number
---@param sMsg? string
function sendrefluamsg(actor,msgid,param1,param2,param3,sMsg) end

---发送聊天框固顶信息
---*  actor: 玩家对象
---*  type: 模式 发送对象 0-自己 1-所有人 2-行会 3-当前地图 4-组队
---*  FColor: 前景色
---*  BColor: 背景色
---*  time: 显示时间
---*  msg: 公告内容
---*  showflag: 是否显示人物名称 0-是 1-否
---@param actor userdata
---@param type number
---@param FColor number
---@param BColor number
---@param time number
---@param msg string
---@param showflag number
function sendtopchatboardmsg(actor,type,FColor,BColor,time,msg,showflag) end

---设定人物攻击飘血飘字类型
---*  actor: 玩家对象
---*  actor: 显示类型 见说明书
---@param actor userdata
---@param type number
function setattackefftype(actor,type) end

---强制修改攻击模式
---*  actor: 玩家对象
---*  mode: 攻击模式
---*  time: 强制切换时间时间
---@param actor userdata
---@param mode number
---@param time number
function setattackmode(actor,mode,time) end

---在线泡点经验
---*  actor: 玩家对象
---*  evetime: 时间
---*  experience: 	经验
---*  isSafe: 是否安全区(填0为任何地方)
---*  mapid: 地图号(任何地图使用*号)
---*  opt: 聚灵珠是否能获取经验(0=不可以 1= 可以)
---*  alltime: 时间:秒(泡点获得经验的时间)
---*  level: 等级(多少级以下获得经验)
---@param actor userdata
---@param evetime number
---@param experience number
---@param isSafe number
---@param mapid number
---@param opt number
---@param alltime number
---@param level number
function setautogetexp(actor,evetime,experience,isSafe,mapid,opt,alltime,level) end

---设置人物背包格子数
---*  actor: 玩家对象
---*  count: 格子大小 *不小于46 不大于126
---@param actor userdata
---@param count number
function setbagcount(actor,count) end

---设置人物/怪物相关信息
---*  actor: 玩家对象
---*  nID: 类型(详见说明)
---*  value: 属性值
---@param actor userdata
---@param nID number
---@param value number
function setbaseinfo(actor,nID,value) end

---人物变色
---*  actor: 玩家对象
---*  color: 颜色(0~255); 255时清除颜色; -1则为转生设置的颜色在人物身体上进行变色
---*  time: 改变时长(秒)
---@param actor userdata
---@param color number
---@param time number
function setbodycolor(actor,color,time) end

---设置聊天前缀
---*  actor: 玩家对象
---*  Prefix: 前缀信息 空则清除聊天前缀
---*  color: 背景色
---@param actor userdata
---@param Prefix string
---@param color number
function setchatprefix(actor,Prefix,color) end

---设置标记值
---*  object: 人物、怪物对象
---*  index: 下标ID 0-9
---*  value: 标记值
---@param object userdata
---@param index number
---@param value number
function setcurrent(object,index,value) end

---设置自定义进度条参数
---*  actor: 玩家对象
---*  item: 装备对象
---*  index: 装备精度条索引 0~2
---*  json: 进度条内容 json字符串
---@param actor userdata
---@param item userdata
---@param index number
---@param json string
function setcustomitemprogressbar(actor,item,index,json) end

---修改物品持久度
---*  actor: 玩家对象
---*  itemmakeid: 玩家对象
---*  char: 玩家对象
---*  dura: 玩家对象
---@param actor userdata
---@param itemmakeid number
---@param char string
---@param dura number
function setdura(actor,itemmakeid,char,dura) end

---关闭地图计时器
---*  MapId: 地图ID
---*  Idx: 计时器ID
---@param MapId number|string
---@param Idx number
function setenvirofftimer(MapId,Idx) end

---设定地图计时器
---*  MapId: 地图ID
---*  Idx: 计时器ID
---*  second: 时长(秒)
---*  func: 触发跳转的函数
---@param MapId number|string
---@param Idx number
---@param second number
---@param func string
function setenvirontimer(MapId,Idx,second,func) end

---设置人物标记/标识值
---*  actor: 玩家对象
---*  nIndex: 索引 0-800
---*  nvalue: 对应属性值
---@param actor userdata
---@param nIndex number
---@param nvalue number
function setflagstatus(actor,nIndex,nvalue) end

---设置玩家GM权限值
---*  actor: 玩家对象
---*  gmlevel: GM权限值
---@param actor userdata
---@param gmlevel number
function setgmlevel(actor,gmlevel) end

---设置行会信息
---*  actor: 玩家对象
---*  index: 索引   0-行会公告
---*  value: 属性值
---@param actor userdata
---@param index userdata
---@param value userdata
function setguildinfo(actor,index,value) end

---给行会自定义变量赋值
---*  guild: 玩家对象
---*  varName: 变量名
---*  value: 变量值
---*  isSave: 是否保存到数据库(0/1)
---@param guild userdata
---@param varName string
---@param value number|string
---@param isSave? number
function setguildvar(guild,varName,value,isSave) end

---顶戴花翎
---*  actor: 玩家对象
---*  where: 位置 0-9
---*  effType: 播放效果(0图片名称 1特效ID)
---*  resName: X坐标 (为空时默认X=0)
---*  x: Y坐标 (为空时默认Y=0)
---*  y: Y坐标 (为空时默认Y=0)
---*  autoDrop: 自动补全空白位置0,1(0=掉 1=不掉)
---*  selfSee: 是否只有自己看见0=所有人都可见;1=仅仅自己可见;
---*  posM: 播放位置(不填默认为0)0=在角色之上;1=在角色之下;
---@param actor userdata
---@param where userdata
---@param effType userdata
---@param resName userdata
---@param x? userdata
---@param y? userdata
---@param autoDrop? userdata
---@param selfSee? userdata
---@param posM? userdata
function seticon(actor,where,effType,resName,x,y,autoDrop,selfSee,posM) end

---设置物品记录信息
---*  actor: 玩家对象
---*  item: 物品对象
---*  type: [1,2]
---*  position: 当type=1,取值范围[0..49]type=2,取值范围[0..19]
---*  value: 设置物品对应位置值
---@param actor userdata
---@param item userdata
---@param type number
---@param position number
---@param value number
function setitemaddvalue(actor,item,type,position,value) end


---设置自定义属性
---*  actor: 玩家对象
---*  item: 物品对象
---*  value: Json字符串 自定义属性内容
---@param actor userdata
---@param item userdata
---@param value string
function setitemcustomabil(actor,item,value) end

---设置物品特效
---*  actor: 玩家对象
---*  index: 装备位置 -1~OK框中的物品
---*  bageffectid: 背包特效编号
---*  ineffectid: 内观特效编号
---@param actor userdata
---@param index number
---@param bageffectid number
---@param ineffectid number
function setitemeffect(actor,index,bageffectid,ineffectid) end

---修改装备内观Looks值
---*  actor: 玩家对象
---*  pos: 装备位置 (-1时是OK框中的装备0~16 17~46 55)
---*  char: 操作符(+ - =)
---*  actor: 内观图片
---@param actor userdata
---@param pos number
---@param char string
---@param pictrue number
function setitemlooks(actor,pos,char,pictrue) end

---设置物品绑定状态
---*  item: 物品对象
---*  bind: 绑定类型(0-8)
---*  state: 绑定状态(0为正常,1为绑定)
---@param item userdata
---@param bind userdata
---@param state userdata
function setitemstate(item,bind,state) end

---增加技能防御力
---*  actor: 玩家对象
---*  skillname: 玩家对象
---*  value: 玩家对象
---*  type: 玩家对象
---@param actor userdata
---@param skillname userdata
---@param value userdata
---@param type userdata
function setmagicdefpower(actor,skillname,value,type) end

---增加技能威力
---*  actor: 玩家对象
---*  skillname: 技能名称
---*  actor: 威力值
---*  type: 计算方式(0按点数计算,1按百分比计算)
---@param actor userdata
---@param skillname userdata
---@param value userdata
---@param type userdata
function setmagicpower(actor,skillname,value,type) end

---把怪物设置成宝宝
---*  mon: 怪物对象
---*  actor: 玩家对象
---@param mon userdata
---@param actor userdata
function setmonmaster(mon,actor) end

---设置当前人物在国家的职位格式
---*  actor: 玩家对象
---*  jobIdx: 职位编号
---@param actor userdata
---@param jobIdx userdata
function setnationking(actor,jobIdx) end

---修改国家职位名称
---*  actor: 玩家对象
---*  nIdx: 国家ID (1~100)
---*  jobIdx: 职位编号
---*  jobName: 职位名称
---@param actor userdata
---@param nIdx userdata
---@param jobIdx userdata
---@param jobName userdata
function setnationrank(actor,nIdx,jobIdx,jobName) end

---设置装备的元素属性
---*  actor: 玩家对象
---*  where: 装备位置-1-OK框中的装备 0~55-身上的装备
---*  iAttr: 玩家对象
---*  sFlag: 玩家对象
---*  iValue: 玩家对象
---@param actor userdata
---@param where userdata
---@param iAttr userdata
---@param sFlag userdata
---@param iValue userdata
function setnewitemvalue(actor,where,iAttr,sFlag,iValue) end

---设置NPC特效
---*  actor: 玩家对象
---*  NPCIndex: NPC索引 NPC配置表中的ID
---*  Effect: 特效ID 5055-感叹号 5056-问号
---*  X: X坐标
---*  Y: Y坐标
---@param actor userdata
---@param NPCIndex userdata
---@param Effect userdata
---@param X userdata
---@param Y userdata
function setnpceffect(actor,NPCIndex,Effect,X,Y) end

---移除全局定时器
---*  id: 定时器ID
---@param id number
function setofftimerex(id) end

---移除个人定时器
---*  actor: 玩家对象
---*  id: 定时器ID
---@param actor userdata
---@param id number
function setofftimer(actor,id,RunTick,RunTime,kf) end

---添加个人定时器
---*  actor: 玩家对象
---*  id: 定时器ID
---*  RunTick: 执行间隔 秒
---*  RunTime: 执行次数 >0执行完成后 自动移除
---*  kf: 跨服是否继续执行 1:继续
---@param actor userdata
---@param id number
---@param RunTick number
---@param RunTime? number
---@param kf? number
function setontimer(actor,id,RunTick,RunTime,kf) end

------添加全局定时器
---*  id: 定时器ID
---*  tick: 执行间隔 秒
---*  count: 执行次数 为0时不限次数
---@param id number
---@param tick number
---@param count? number
function setontimerex(id,tick,count) end

---获取宠物蛋等级
---*  actor: 玩家对象
---*  itemmakeid: 物品MakeIndex
---*  level: 等级: -1表示不修改值
---*  zlevel: 转生等级: -1表示不修改值
---*  exp: 经验值: -1表示不修改值
---@param actor userdata
---@param itemmakeid number
---@param level number
---@param zlevel number
---@param exp number
function setpetegglevel(actor,itemmakeid,level,zlevel,exp) end

---设置宠物模式
---*  actor: 玩家对象
---*  mode: 宠物模式:1-跟随;2-攻击;3-被动(被攻击时才设定目标);4-休息
---@param actor userdata
---@param mode number
function setpetmode(actor,mode) end

---设置玩家变量
---*  actor: 玩家对象
---*  varName: 变量名
---*  varValue: 变量值
---@param actor userdata
---@param varName string
---@param varValue string|number
function setplaydef(actor,varName,varValue) end

---设置行会成员在行会中的职位;
---*  actor: 玩家对象
---*  pos: 在行会中的职位 0:会长;1:副会长;2:行会成员1;3:行会成员2;4:行会成员3;
---@param actor userdata
---@param pos number
function setplayguildlevel(actor,pos) end

---给玩家自定义变量赋值
---*  actor: 玩家对象
---*  varType: 变量范围(HUMAN/GUILD)
---*  varName: 变量名
---*  varValue: 变量值
---*  isSave: 是否保存到数据库(0/1)
---@param actor userdata
---@param varType string
---@param varName string
---@param varValue string|number
---@param isSave? number
function setplayvar(actor,varType,varName,varValue,isSave) end

---显示人物的称号
---*  actor: 玩家对象
---*  levelname: 称号文本: 和名字一起显示
---@param actor userdata
---@param levelname string
function setranklevelname(actor,levelname) end

---减少技能CD冷却时间
---*  actor: 玩家对象
---*  skillname: 技能名称
---*  char: 操作符(+/-/=)=0就是还原技能CD
---*  time: 时间 秒
---@param actor userdata
---@param skillname string
---@param char string
---@param time number
function setskilldeccd(actor,skillname,char,time) end

---设置技能等级
---*  actor: 玩家对象
---*  skillid: 技能ID
---*  flag: 类型: 1-技能等级 2-强化等级 3-熟练度
---*  point: 属性值
---@param actor userdata
---@param skillid number
---@param flag number
---@param point number
function setskillinfo(actor,skillid,flag,point) end

---开/关首饰盒
---*  actor: 玩家对象
---*  bState: 0:关闭: 1:开启
---@param actor userdata
---@param bState number
function setsndaitembox(actor,bState) end

---设置人物伤害吸收
---*  actor: 玩家对象
---*  operate: 操作符号 "+"增加 "-"减少 "="等于
---*  sum: 总吸收量
---*  rate: 吸收比率千分比 1=0.1%100=10%
---*  success: 吸收成功率
---@param actor userdata
---@param operate string
---@param sum number
---@param rate number
---@param success number
function setsuckdamage(actor,operate,sum,rate,success) end

---设置全局变量
---*  varName: 变量名
---*  varValue: 变量值
---@param varName string
---@param varValue string|number
function setsysvar(varName,varValue) end

---给全局自定义变量赋值
---*  varName: 变量名
---*  varValue: 变量值
---*  isSave: 是否保存(0/1)
---@param varName string
---@param varValue string|number
---@param isSave number
function setsysvarex(varName,varValue,isSave) end

---设置当前攻击目标
---*  Hiter: 攻击者(玩家/英雄/怪物)
---*  Target: 被攻击者(玩家/英雄/怪物)
---@param Hiter userdata
---@param Target userdata
function settargetcert(Hiter,Target) end

---设置物品来源
---*  jsonStr: 玩家对象
---@param jsonStr string
function setthrowitemly(jsonStr) end

---设置物品来源(使用物品对象)
---*  actor: 玩家对象
---*  item: 物品对象
---*  jsonStr: json字符串
---@param actor userdata
---@param item userdata
---@param jsonStr string
function setthrowitemly2(actor,item,jsonStr) end

---设置人物永久属性
---*  actor: 玩家对象
---*  nIndex: 索引 见说明书
---*  nvalue: 对应属性值
---@param actor userdata
---@param nIndex number
---@param nvalue number
function setusebonuspoint(actor,nIndex,nvalue) end

---采集挖矿等进度条操作
---*  actor: 玩家对象
---*  time: 进度条时间 秒
---*  succ: 成功后跳转的函数
---*  msg: 提示消息
---*  canstop: 能否中断 0-不可中断 1-可以中断
---*  fail: 中断触发的函数
---@param actor userdata
---@param time userdata
---@param succ userdata
---@param msg userdata
---@param canstop userdata
---@param fail userdata
function showprogressbardlg(actor,time,succ,msg,canstop,fail) end

---装备镶嵌钻石
---*  actor: 玩家对象
---*  item: 装备对象
---*  hole: 装备开孔序号 0~9
---*  index: 镶嵌钻石的index 装备表总的Index
---@param actor userdata
---@param item userdata
---@param hole number
---@param index number
function socketableitem(actor,item,hole,index) end

---自定义变量排序
---*  varName: 玩家对象
---*  playflag: 0-所有玩家 1-在线玩家 2-行会
---*  sortflag: 0-升序 1-降序
---*  count: 获取的数据量 为空或0取所有 取前几名
---@param varName userdata
---@param playflag userdata
---@param sortflag userdata
---@param count userdata
function sorthumvar(varName,playflag,sortflag,count) end

---开启自动挂机
---*  actor: 玩家对象
---@param actor userdata
function startautoattack(actor) end

---停止执行
---*  actor: 玩家对象
---@param actor userdata
function stop(actor) end

---停止自动挂机
---*  actor: 玩家对象
---@param actor userdata
function stopautoattack(actor) end

---停止拾取
---*  actor: 玩家对象
---@param actor userdata
function stoppickupitems(actor) end

---跨服变量传递
---*  itype: 变量类型 1=全局G变量 2=全局A变量 3=全局自定义变量 4=行会变量
---*  astr: 跨服全局变量
---*  bstr: 存入本服全局变量
---*  id: 消息id
---@param itype number
---@param astr string
---@param bstr string
---@param id number
function synzvar(itype,astr,bstr,id) end

---回收OK框物品
---*  actor: 玩家对象
---*  count: 数量 (针对叠加物品有效)
---@param actor userdata
---@param count number
function takedlgitem(actor,count) end

---拿物品
---*  actor: 玩家对象
---*  itemname: 物品名称
---*  qty: 数量
---*  IgnoreJP: 忽略极品0 所有都扣除1 极品不扣除
---@param actor userdata
---@param itemname string
---@param qty number
---@param IgnoreJP number
function takeitem(actor,itemname,qty,IgnoreJP) return boolean end

---脱下装备
---*  actor: 玩家对象
---*  where: 位置
---*  makeindex: 物品唯一ID
---@param actor userdata
---@param where number
---@param makeindex number
function takeoffitem(actor,where,makeindex) end

---穿戴装备
---*  actor: 玩家对象
---*  where: 位置
---*  makeindex: 物品唯一ID
---@param actor userdata
---@param where number
---@param makeindex number
function takeonitem(actor,where,makeindex) end

---任务置顶显示
---*  actor: 玩家对象
---*  nId: 任务ID
---@param actor userdata
---@param nId number
function tasktopshow(actor,nId) end

---表格转换成字符串
---*  tbl: 玩家对象
---@param tbl table
function tbl2json(tbl) end

---剔除离线挂机角色
---*  mapID: 地图号 “*”表示全部地图
---*  level: 剔除等级 低于此等级均剔除“*”表示所有
---*  count: 最大剔除玩家数 “*”表示所有
---@param mapID string|number
---@param level string|number
---@param count string|number
function tdummy(mapID,level,count) end

---设置玩家穿人穿怪
---*  actor: 玩家对象
---*  type: 模式 0-恢复默认 1-穿人 2-穿怪 3-穿人穿怪
---*  time: 时间(秒)
---*  objtype: 对象  0-玩家 1-宝宝
---@param actor userdata
---@param type userdata
---@param time userdata
---@param objtype userdata
function throughhum(actor,type,time,objtype) end

---在地图上放置物品
---*  actor: 玩家对象
---*  MapId: 	地图ID
---*  X: 坐标X
---*  Y: 坐标Y
---*  range: 范围
---*  itemName: 物品名
---*  count: 数量
---*  time: 时间(秒)
---*  hint: true-掉落提示
---*  take: true-立即拾取
---*  onlyself: true-仅自己拾取
---*  xyinorder: true-按位置顺序 false-随机位置
---@param actor userdata
---@param MapId string|number
---@param X number
---@param Y number
---@param range number
---@param itemName string
---@param count number
---@param time number
---@param hint boolean
---@param take boolean
---@param onlyself boolean
---@param xyinorder boolean
function throwitem(actor,MapId,X,Y,range,itemName,count,time,hint,take,onlyself,xyinorder) end

---收回英雄
---*  actor: 玩家对象
---@param actor userdata
function unrecallhero(actor) end

---返回收回的宠物对象
---*  actor: 玩家对象
---*  idx: 宠物序号
---@param actor userdata
---@param idx userdata
function unrecallpet(actor,idx) end

---给人物装备面板加特效
---*  actor: 玩家对象
---*  effectid: 特效ID  0-删除特效
---*  position: 显示位置 0-前面 1-后面
---@param actor userdata
---@param effectid number
---@param position number
function updateequipeffect(actor,effectid,position) end

---查看别人面板信息
---*  actor: 玩家对象
---*  userid: 其他玩家的UserID
---*  winID: 面板ID 101-装备 106-称号 1011-时装
---@param actor userdata
---@param userid userdata
---@param winID userdata
function viewplayer(actor,userid,winID) end

---写入Ini文件中的字段值
---*  filename: 文件名
---*  section: 配置项区
---*  item: 配置项
---*  value: 配置项值
---@param filename userdata
---@param section userdata
---@param item userdata
---@param value userdata
function writeini(filename,section,item,value) end

---写入Ini文件中的字段值 带Cache
---*  filename: 文件名
---*  section: 配置项区
---*  item: 配置项
---*  value: 配置项值
---@param filename userdata
---@param section userdata
---@param item userdata
---@param value userdata
function writeinibycache(filename,section,item,value) end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

---获取动态地图连接
---*  actor: 玩家对象
---*  mapID: 地图ID
---@param actor userdata
---@param mapID string|number
function getmapgate(actor,mapID) end

---根据名称获取地图基础信息
---*  mapname: 地图名称
---*  nIndex: 0:地图宽 1:地图高
---@param mapname userdata
---@param nIndex number
function getmapinfo(mapname,nIndex) end

---获取地图指定范围内的怪物对象列表
---*  mapID: 地图ID
---*  monName: 地图名称
---*  nIndex: 怪物名 为空 or * 为检测所有怪
---*  nx: 坐标X
---*  ny: 坐标Y
---*  nRange: 范围
---@param mapID string|number
---@param monName userdata
---@param nx number
---@param ny number
---@param nRange number
function getmapmon(mapID,monName,nx,ny,nRange) end

---根据地图id返回地图名
---*  mapID: 地图ID
---@param mapID string|number
function getmapname(mapID) end

---返回怪物基础信息
---*  monidx: 怪物idx
---*  id: id取值:1-怪物名称;2-怪物名字颜色;3-杀死怪物获得的经验值;
---@param monidx userdata
---@param id userdata
function getmonbaseinfo(monidx,id) end

---根据UserId返回怪物对象
---*  mapID: 地图ID
---*  monUserId: 怪物userid
---@param mapID string|number
---@param monUserId string
function getmonbyuserid(mapID,monUserId) end

---获取指定地图怪物数量
---*  mapID: 地图ID
---*  MonId: 怪物idx
---*  isAllMon: 是否忽略宝宝
---@param mapID string|number
---@param MonId number
---@param isAllMon boolean
function getmoncount(mapID,MonId,isAllMon) end

---获取怪物位置及复活时间（仅支持小地图上提示的怪物）
---*  mapID: 地图ID
---@param mapID string|number
function getmonrefresh(mapID) end

---获取玩家所在的行会对象
---*  actor: 玩家对象
---@param actor userdata
function getmyguild(actor) end

---获取物品的附加属性
---*  item: 玩家对象
---*  value: 元素属性 见说明书
---@param item userdata
---@param value number
function getnewitemaddvalue(item,value) end

---根据ID获取NPC对象
---*  npcIdx: NPC表内的idx
---@param npcIdx number
function getnpcbyindex(npcIdx) end

---获取NPC对象的Idx
---*  npc: npc对象
---@param npc userdata
function getnpcindex(npc) end

---获取地图上指定范围内的对象
---*  mapID: 地图ID
---*  X: 坐标X
---*  Y: 坐标Y
---*  range: 范围
---*  flag: 标记值 二进制位表示 1-玩家 2-怪物4-NPC 8-物品16-地图事件
---@param mapID string|number
---@param X number
---@param Y number
---@param range number
---@param flag number
function getobjectinmap(mapID,X,Y,range,flag) end

---获取对面人物的名字
---*  actor: 玩家对象
---@param actor userdata
function getoppositeobj(actor) end

---获取宠物
---*  actor: 玩家对象
---*  idx: 宠物序号或""X"表示当前宠物
---@param actor userdata
---@param idx number
function getpet(actor,idx) end

---获取宠物身上装备列表
---*  idx: 宠物序号
---@param actor userdata
---@param idx number
function getpetbodyitem(actor,idx) end

---获取宠物蛋信息
---*  actor: 玩家对象
---*  itemmakeid: 物品MakeIndex
---*  type: 需要返回的数值1-转生等级;2-等级;3-经验;0-同时返回三个值
---@param actor userdata
---@param itemmakeid number
---@param type number
function getpetegglevel(actor,itemmakeid,type) end

---获取玩家pk等级
---*  actor: 玩家对象
---@param actor userdata
function getpklevel(actor) end

---获取当前NPC对象
---*  actor: 玩家对象
---@param actor userdata
function getcurrnpc(actor) end

---获取自定义进度条参数
---*  actor: 玩家对象
---*  item: 装备对象
---*  actor: 装备精度条索引 0~2
---@param actor userdata
---@param item userdata
---@param index number
function getcustomitemprogressbar(actor,item,index) end

---获取装备开孔数据
---*  actor: 玩家对象
---*  item: 装备对象
---@param actor userdata
---@param item userdata
function getdrillhole(actor) end


---获取Envir文件夹下文件列表
function getenvirfilelist() end

---获取人物标记/标识值
---*  actor: 人物对象
---*  index:  索引 0-800
---@param actor userdata
---@param index number
function getflagstatus(actor,index) end

---获取玩家好友列表
---*  actor: 玩家对象
---@param actor userdata
function getfriendnamelist(actor) end

---取字符串在csv表格中的行号
function getgjcsv() end

---获取玩家GM权限值
---*  actor: 玩家对象
---@param actor userdata
function getgmlevel(actor) end

---获取队员列表
---*  actor: 玩家对象
---@param actor userdata
function getgroupmember(actor) end

---获取行会信息
---*  actor: 玩家对象
---@param actor userdata
function getguildinfo(actor) end

---获取人物所在行会成员数量
---*  actor: 玩家对象
---@param actor userdata
function getguildmembercount(actor) end

---获取行会自定义变量
---*  guild: 行会对象
---*  index: 索引 0-行会ID1-行会名称2-行会公告3-行会成员名单（返回table）4-行会掌门人名称
---@param guild userdata
---@param index userdata
function getguildvar(guild,index) end

---获取英雄对象
---*  actor: 玩家对象
---@param actor userdata
function gethero(actor) end

---获取当前表格最大行数、和获取表格最大列数
---*  filename: 文件名
---*  type: 读取目标：0-行数 1-列数
---@param filename string
---@param type number
function gethlcsv(filename,type) end

---获取人物属性
---*  actor: 玩家对象
---*  actor: 属性ID（1-20）
---@param actor userdata
---@param id number
function gethumability(actor,id) end

---获取人物临时属性
---*  actor: 玩家对象
---*  nWhere: 位置 对应cfg_att_score 属性ID
---@param actor userdata
---@param nWhere userdata
function gethumnewvalue(actor,nWhere) end

---获取物品记录信息
---*  actor: 玩家对象
---*  item: 物品对象
---*  type: [1,2,3]
---*  position: 当type=1,取值范围[0..49] type=2,取值范围[0..19]
---@param actor userdata
---@param item userdata
---@param type number
---@param position number
function getitemaddvalue(actor,item,type,position) end

---根据物品唯一ID获得物品对象
---*  actor: 玩家对象
---*  makeindex: 物品唯一ID
---@param actor userdata
---@param makeindex number
function getitembymakeindex(actor,makeindex) end

---获取自定义属性
---*  actor: 玩家对象
---*  item: 物品对象
---@param actor userdata
---@param item userdata
function getitemcustomabil(actor,item) end

---获取物品信息
---*  actor: 玩家对象
---*  item: 物品对象
---*  id: 1:唯一ID2:物品ID3:剩余持久4:最大持久5:叠加数量6:绑定状态
---@param actor userdata
---@param item userdata
---@param id number
---@return any
function getiteminfo(actor,item,id) end

---根据索引返回背包物品信息
---*  actor: 玩家对象
---*  index: 索引号,0开始
---@param actor userdata
---@param index number
function getiteminfobyindex(actor,index) end

---嘲讽怪物
---*  actor: 玩家对象
---*  distance: 距离人物格子数
---*  grade: 受嘲讽影响的怪物等级上限
---@param actor userdata
---@param distance number
---@param grade number
function dotaunt(actor,distance,grade) end

---装备开孔
---*  actor: 玩家对象
---*  item: 装备对象
---*  holejson: 开孔相关 json字符串 支持0~9共10个孔
---@param actor userdata
---@param item userdata
---@param holejson string
function drillhole(actor,item,holejson) end

---使用物品（吃药、使用特殊物品等）
---*  actor: 玩家对象
---*  itemname: 物品名称
---*  count: 玩家对象
---@param actor userdata
---@param itemname string
---@param count number
function eatitem(actor,itemname,count) end

---敏感词汇检测
---*  str: 要检测的文本
---@param str string
function exisitssensitiveword(str) end

---过滤全服提示信息
---*  actor: 玩家对象
---*  flag: 是否过滤0-不过滤1-过滤
---@param actor userdata
---@param flag userdata
function filterglobalmsg(actor,flag) end

---搜索行会
---*  index: 搜索关键词 0-行会ID 1-行会名称
---*  key: 	搜索关键词
---@param index number
---@param key string
function findguild(index,key) end

---清除宠物属性
---*  actor: 玩家对象
---*  idx: 	宠物序号
---*  attrName: 清空对应属性组的属性;nil清除所有属性组
---@param actor userdata
---@param idx number
---@param attrName? number
function delpetattlist(actor,idx,attrName) end

---删除宠物攻击表现
---*  actor: 玩家对象
---*  idx: 宠物序号或"X"表示当前宠物
---*  skillid: 增加的攻击表现ID 为cfg_monattack表中的ID
---@param actor userdata
---@param idx number
---@param skillid number
function delpetskill(actor,idx,skillid) end

---镖车自动寻路到指定坐标
---*  actor: 玩家对象
---*  aimX: 目标X坐标
---*  aimY: 目标Y坐标
---*  range: 人物离镖车距离内自动寻路取值范围 0-120-不检测
---@param actor userdata
---@param aimX number
---@param aimY number
---@param range number
function dartmap(actor,aimX,aimY,range) end

---人物下线 镖车存活设置
---*  actor: 玩家对象
---*  time: 镖车存活时间 秒
---*  isdie: 下线是否消失0-消失 1-时间到达消失
---@param actor userdata
---@param time number
---@param isdie number
function darttime(actor,time,isdie) end


---延时跳转
---*  actor: 玩家对象
---*  time: 时间(毫秒)
---*  func: 触发函数
---*  del: 换地图是否删除此延时 0或为空时=不删除 1=删除
---@param actor userdata
---@param time number
---@param func string
---@param del? number
function delaygoto(actor,time,func,del) end

---延时消息跳转
---*  actor: 玩家对象
---*  time: 时间(毫秒)
---*  func: 触发函数
---@param actor userdata
---@param time number
---@param func string
function delaymsggoto(actor,time,func) end

---删除buff
---*  actor: 玩家对象
---*  buffid: buffID
---@param actor userdata
---@param buffid number
function delbuff(actor,buffid) end

---删除气泡
---*  actor: 玩家对象
---*  id: 玩家对象
---@param actor userdata
---@param id number
function delbutshow(actor,id) end

---删除自定义按钮
---*  actor: 玩家对象
---*  windowid: 主窗口ID
---*  buttonid: 按钮ID
---@param actor userdata
---@param windowid number
---@param buttonid number
function delbutton(actor,windowid,buttonid) end

---关闭屏幕特效
---*  actor: 玩家对象
---*  id: 创建的特效编号
---*  type: 播放模式 0-自己 1-所有人
---@param actor userdata
---@param id number
---@param type number
function deleffects(actor,id,type) end

---删除队员
---*  actor: 玩家对象
---*  memberId: 组员UserId
---@param actor userdata
---@param memberId string
function delgroupmember(actor,memberId) end

---添加称号
---*  actor: 玩家对象
---*  name: 称号物品名称
---*  use: 开启激活 1激活
---@param actor userdata
---@param name string
---@param use number
function confertitle(actor,name,use) end

---扣除人物通用货币数量(多货币依次计算)
---*  actor: 玩家对象
---*  moneyname: 货币名称
---*  actor: 对应货币值
---@param actor userdata
---@param moneyname string
---@param count number
function consumebindmoney(actor,moneyname,count) end

---创建队伍
---*  actor: 玩家对象
---@param actor userdata
function creategroup(actor) end

---创建英雄
---*  actor: 玩家对象
---*  name: 英雄名称
---*  job: 	职业
---*  sex: 性别
---@param actor userdata
---@param name string
---@param job number
---@param sex number
function createhero(actor,name,job,sex) end

---创建国家
---*  actor: 玩家对象
---*  nIdx: 国家ID (1~100)
---*  maxNum: 限制人数
---@param actor userdata
---@param nIdx number
---@param maxNum number
function createnation(actor,nIdx,maxNum) end

---创建临时NPC
---*  actor: 玩家对象
---*  X: X坐标
---*  Y: Y坐标
---*  npcJosn: NPC信息 json字符串
---@param actor userdata
---@param X number
---@param Y number
---@param npcJosn string
function createnpc(actor,X,Y,npcJosn) end

---召唤宠物(无需宠物蛋)
---*  actor: 玩家对象
---*  monname: 自定义怪物名称
---*  level: 怪物等级
---@param actor userdata
---@param monname userdata
---@param level userdata
function createpet(actor,monname,level) end

---修改人物临时属性（带有效期）
---*  actor: 玩家对象
---*  nWhere: 位置 对应cfg_att_score 属性ID
---*  nValue: 对应属性值
---*  nTime: 有效时间 秒
---@param actor userdata
---@param nWhere userdata
---@param nValue userdata
---@param nTime userdata
function changehumnewvalue(actor,nWhere,nValue,nTime) end

---将物品唯一ID转换成道具表里对应的IDX物品
---*  actor: 玩家对象
---*  itemmakeid: 唯一ID
---*  itemidx: 	道具ID
---@param actor userdata
---@param itemmakeid number
---@param itemidx number
function changeitemidx(actor,itemmakeid,itemidx) end

---调整人物身上物品装备名字颜色
---*  actor: 玩家对象
---*  item: 物品对象
---*  color: 颜色(0-255)颜色=0时恢复默认颜色
---@param actor userdata
---@param item userdata
---@param color userdata
function changeitemnamecolor(actor,item,color) end

---修改武器、衣服外观
---*  actor: 玩家对象
---*  item: 物品对象
---*  looks: 外观值
---@param actor userdata
---@param item userdata
---@param looks number
function changeitemshape(actor,item,looks) end

---调整人物等级
---*  actor: 玩家对象
---*  opt: 操作符 + - =
---*  count: 数量
---@param actor userdata
---@param opt string
---@param count number
function changelevel(actor,opt,count) end

---修改宝宝属性值
---*  actor: 玩家对象
---*  mob: 	宝宝对象
---*  attr: 属性位置
---*  method: 操作符(+ - =)
---*  value: 属性值
---*  time: 有效时间
---@param actor userdata
---@param mob userdata
---@param attr number
---@param method string
---@param value number
---@param time number
function changemobability(actor,mob,attr,method,value,time) end

---改变人物模式
---*  actor: 玩家对象
---*  mode: 模式1~24
---*  time: 时间(秒)
---*  param1: 参数1,12-13 18 20 21代表几率 其余代表属性值
---*  param2: 参数2 代表属性值
---@param actor userdata
---@param mode number
---@param time number
---@param param1 number
---@param param2 number
function changemode(actor,mode,time,param1,param2) end

---设置人物货币
---*  actor: 玩家对象
---*  id: 货币ID 1-100
---*  opt: 	操作符 + - =
---*  count: 数量
---*  msg: 备注内容
---*  send: 是否推送到客户端
---@param actor userdata
---@param id number
---@param opt string
---@param count number
---@param msg string
---@param send boolean
function changemoney(actor,id,opt,count,msg,send) end

---修改宝宝名称
---*  mon: 宝宝对象
---*  name: 宝宝名字
---@param mon userdata
---@param name string
function changemonname(mon,name) end

---修改人物名字颜色
---*  actor: 玩家对象
---*  color: 颜色索引
---@param actor userdata
---@param color number
function changenamecolor(actor,color) end

---修改宝宝等级
---*  actor: 玩家对象
---*  mon: 宝宝对象
---*  opt: 操作符 + - =
---*  nLevel:等级
---@param actor userdata
---@param mon userdata
---@param opt string
---@param nLevel number
function changeslavelevel(actor,mon,opt,nLevel) end

---改变玩家速度
---*  actor: 玩家对象
---*  type: 速度类型 1-移动速度2-攻击速度3-施法速度
---*  level: 速度等级 -10~100-原始速度，-1时间间隔减少10%+1时间间隔增加10%
---@param actor userdata
---@param type number
---@param level number
function changespeed(actor,type,level) end

---新解锁仓库格子
---*  actor: 玩家对象
---*  nCount: 新解锁的格子数
---@param actor userdata
---@param nCount number
function changestorage(actor,nCount) end

---检查国家是否创建
---*  nIdx: 国家ID
---@param nIdx number
function checkation(nIdx) end

---设置英雄名称
---*  actor: 玩家对象
---*  name: 	英雄名称
---@param actor userdata
---@param name userdata
function checkheroname(actor,name) end

---检测 人/怪物 状态
---*  objcfg: 玩家/怪物 对象
---*  type: 类型 见说明书
---@param objcfg userdata
---@param type number
function checkhumanstate(objcfg,type) end

---检测当前人物是否在跨服的地图
---*  actor: 玩家对象
---@param actor userdata
function checkkuafu(actor) end

---检查跨服连接是否正常连接
function checkkuafuconnect() end

---检测当前服务器是否为跨服服务器
function checkkuafuserver() end

---检测镜像地图是否存在
---*  MapId: 地图ID
---@param MapId string|number
function checkmirrormap(MapId) end

---检测加入国家
---*  actor: 玩家对象
---*  nIdx: 国家编号 0~100 0代表没有加入国家
---@param actor userdata
---@param nIdx number
function checknational(actor,nIdx) end

---检查国家人物总数
---*  actor: 玩家对象
---*  sFlag: 比较符 =<>
---*  iValue: 	人数
---@param actor userdata
---@param sFlag string
---@param iValue number
function checknationhumcount(actor,sFlag,iValue) end

---检测装备的元素属性
---*  actor: 玩家对象
---*  where: 装备位置：-1-OK框中的装备 0~55-身上的装备
---*  iAttr: 属性
---*  sFlag: 比较符=<>
---*  iValue: 数值(1-100)，百分比
---@param actor userdata
---@param where number
---@param iAttr number
---@param sFlag string
---@param iValue number
function checknewitemvalue(actor,where,iAttr,sFlag,iValue) end

---是否在骑马
---*  actor: 玩家对象
---@param actor userdata
function checkonhorse(actor) end

---检测范围内怪物数量
---*  actor: 玩家对象
---*  monName: 怪物名，为空 or * 为检测所有怪
---*  nx: 坐标X
---*  ny: 坐标Y
---*  nRange: 范围
---@param actor userdata
---@param monName string
---@param nx number
---@param ny number
---@param nRange number
function checkrangemoncount(actor,monName,nx,ny,nRange) end

---检测拾取小精灵
---*  actor: 玩家对象
---*  monName: 精灵名称,为空 则检测全部
---@param actor userdata
---@param monName string
function checkspritelevel(actor,monName) end

---检测人物称号
---*  actor: 玩家对象
---*  title: 称号
---@param actor userdata
---@param title string
function checktitle(actor,title) end

---删除延迟
---*  actor: 玩家对象
---@param actor userdata
function cleardelaygoto(actor) end

---清理自定义全局变量
---*  varName: 变量名, * -所有变量
---@param varName string
function clearglobalcustvar(varName) end

---清理自定义行会变量
---*  guild: 行会名称,* -所有行会
---*  varName: 变量名,* -所有变量
---@param actor string
---@param varName string
function clearguildcustvar(actor,varName) end

---清理个人自定义变量
---*  actor: 要清理的人物对象 传入 * 表示清理所有玩家
---*  varName: 变量名,* -所有变量
---@param actor userdata|string
---@param varName string
function clearhumcustvar(actor,varName) end

---清理物品自定义属性
---*  actor: 玩家对象
---*  item: 物品对象
---*  group: 组别，-1 所有组 0~5对应组别
---@param actor userdata
---@param item userdata
---@param group number
function clearitemcustomabil(actor,item,group) end

---清理地图上指定名字的物品
---*  MapId: 玩家对象
---*  X: X坐标
---*  Y: Y坐标
---*  range: 范围
---*  itemName: 物品名
---@param MapId string|number
---@param X number
---@param Y number
---@param range number
---@param itemName string
function clearitemmap(MapId,X,Y,range,itemName) end

---刷怪
---*  mapid: 玩家对象
---*  X: X坐标
---*  Y: Y坐标
---*  monname: 怪物名称
---*  range: 范围
---*  count: 数量
---*  color: 颜色(0~255)
---@param mapid userdata
---@param X number
---@param Y number
---@param monname string
---@param range number
---@param count number
---@param color number
function genmon(mapid,X,Y,monname,range,count,color) end