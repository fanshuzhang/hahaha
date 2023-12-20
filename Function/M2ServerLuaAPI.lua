---�����л��ڵ���ͬʱ����
function addattacksabakall() end

---���buff
---*  object: ���|���� ����
---*  buffid: buffid 10000�Ժ�
---*  time: ʱ��,��Ӧbuff����ά���ĵ�λ
---*  OverLap: ���Ӳ���,Ĭ��1
---*  objOwner: ʩ����
---*  abil: ���Ա� {[1]=200, [4]=20},����id=ֵ
---@param object userdata
---@param buffid number
---@param time? number
---@param OverLap? number
---@param objOwner? userdata
---@param abil? table
function addbuff(object,buffid,time,OverLap,objOwner,abil) end

---��������
---*  actor: ��Ҷ���
---*  id: ID
---*  name: ��ʾ����
---*  func: ������(������ö��ŷָ�)
---@param actor userdata
---@param id number
---@param name string
---@param func function
function addbutshow(actor,id,name,func) end

---�����Զ��尴ť
---*  actor: ��Ҷ���
---*  windowid: ������ID
---*  name: ��ťID
---*  func: ͼ������
---@param actor userdata
---@param windowid number
---@param buttonid number
---@param icon string
function addbutton(actor,windowid,buttonid,icon) end

---�����޴�ʹ����Ʒ�Ĵ���
---*  actor: ��Ҷ���
---*  actor: ��ƷΨһID
---*  actor: ����
---@param actor userdata
---@param itemmakeid number
---@param num number
function addfunitemdura(actor,itemmakeid,num) end

---��Ӷ�Ա
---*  actor: ��Ҷ���
---*  userId: ��ԱUserId
---@param actor userdata
---@param userId string
function addgroupmember(actor,userId) end

---��ʱ���ӹ��ﱬ����Ʒ
---*  actor: ��Ҷ���
---*  mon: �������
---*  itemname: ��Ʒ����
---@param actor userdata
---@param mon userdata
---@param itemname string
function additemtodroplist(actor,mon,itemname) end

---���Ӷ�̬��ͼ����
function addmapgate(actor) end

---���������ͼ
---*  oldMap: ԭ��ͼID
---*  NewMap: �µ�ͼID
---*  NewName: �µ�ͼ��
---*  time: ��Чʱ��(��)
---*  BackMap: �سǵ�ͼ
---@param oldMap userdata
---@param NewMap string
---@param NewName string
---@param time number
---@param BackMap string
function addmirrormap(oldMap,NewMap,NewName,time,BackMap) end

---���ӳ�������
---*  actor: ��Ҷ���
---*  idx: �������
---*  attrName: �Զ�����������
---*  opt: ������ + - =
---*  attr: �����ַ���
---*  type: 0���=������װ��������1=���ӹ̶�ֵ;��������װ����(���Լӳ�����Ч)
---@param actor userdata
---@param idx number
---@param attrName number
---@param opt string
---@param attr number
---@param type number
function addpetattlist(actor,idx,attrName,opt,attr,type) end

---���ӳ��﹥������
---*  actor: ��Ҷ���
---*  idx: ������Ż�"X"��ʾ��ǰ����
---*  skillid: ���ӵĹ�������ID
---@param actor userdata
---@param idx number
---@param skillid number
function addpetskill(actor,idx,skillid) end

---��Ӽ���
---*  actor: ��Ҷ���
---@param actor userdata
---@param skillid number
---@param level number
function addskill(actor,skillid,level) end

---���л���ӵ������б�
---*  name: �л���
---*  day: ����
---@param name string
---@param day number
function addtocastlewarlist(name,day) end

---ǿ�ư��л���ӵ������б�
---*  name: �л���
---*  day: ����
---@param name string
---@param day number
function addtocastlewarlistex(name,day) end

---����֪ͨ�������QF
function bfbackcall() end

---�����л�
---*  actor: ��Ҷ���
---*  name: �л���
---@param actor userdata
---@param name string
function buildguild(actor,name) end

---��������NPC��lua����
---*  actor: ��Ҷ���
---*  npcidx: NPC��(NPC���ñ��е�ID)
---*  delaytime: �ӳ�ʱ��ms,0����ִ��
---*  func: ������
---*  sParam: 	����
---@param actor userdata
---@param npcidx number
---@param delaytime number
---@param func string
---@param sParam string
function callfunbynpc(actor,npcidx,delaytime,func,sParam) end

---����TXT�ű�����
---*  actor: ��Ҷ���
---*  filename: �ļ���
---*  label: ��ǩ
---@param actor userdata
---@param filename string
---@param label string
function callscript(actor,filename,label) end

---���ô���ű�����
---*  actor: ��Ҷ���
---*  scriptname: �ű��ӿ�
---*  ...: ����1~����10
---@param actor userdata
---@param scriptname string
---@param ... any
function callscriptex(actor,scriptname,...) end

---���ô���ű�����2
---*  actor: ��Ҷ���
---@param actor userdata
function callcheckscriptex(actor) end

---��ȡ���ɳ�Ϳ����
---*  actor: ��Ҷ���
---*  return: ����ֵ 0-��ɳ�Ϳ˳�Ա1-ɳ�Ϳ˳�Ա2-ɳ�Ϳ��ϴ�
---@param actor userdata
function castleidentity(actor) end

---ɳ�Ϳ˻�����Ϣ
---*  nID: ��Ϣ���� 1=ɳ������,����string; 2=ɳ���л�����,����string; 3=ɳ���л�᳤����,����string; 
---*  nID: ��Ϣ���� 4=ռ������,����number; 5=��ǰ�Ƿ��ڹ�ɳ״̬,����Bool; 6=ɳ���лḱ�᳤�����б�,����table
---@param nID number
function castleinfo(nID) end

---�޸Ĺ���ģʽ
---*  actor: ��Ҷ���
---*  attackmode: 0-ȫ�幥��
---*  attackmode: 1-��ƽ����
---*  attackmode: 2-���޹���
---*  attackmode: 3-ʦͽ����
---*  attackmode: 4-���鹥��
---*  attackmode: 5-�лṥ��
---*  attackmode: 6-��������
---*  attackmode: 7-���ҹ���
---@param actor userdata
---@param attackmode number
function changeattackmode(actor,attackmode) end

---���Զ���װ������
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  attrindex: ����λ��(0~9)
---*  bindindex: ������(0~4)
---*  bindvalue: �󶨵�ֵ
---*  group: ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@param actor userdata
---@param item userdata
---@param attrindex number
---@param bindindex number
---@param bindvalue number
---@param group? number
function changecustomitemabil(actor,item,attrindex,bindindex,bindvalue,group) end

---���Ӻ��޸��Զ������Է�������
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  typename: ��������(-1Ϊ���)
---*  group: ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@param actor userdata
---@param item userdata
---@param typename userdata
---@param group? number
function changecustomitemtext(actor,item,typename,group) end

---���Ӻ��޸ķ���������ɫ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  color: ������ɫ(0~255)
---*  group: ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@param actor userdata
---@param item userdata
---@param color number
---@param group? number
function changecustomitemtextcolor(actor,item,color,group) end

---�޸��Զ�������ֵ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  attrindex: ����λ��(0~9)ÿ��װ�������Զ���10������
---*  operate: ������:+��-��=
---*  value: ����ֵ
---*  group: ��ʾ����λ��(0~2 ;Ϊ��Ĭ��Ϊ0)
---@param actor userdata
---@param item userdata
---@param attrindex number
---@param operate string
---@param value number
---@param group? number
function changecustomitemvalue(actor,item,attrindex,operate,value,group) end

---�޸��������·���Ч
---*  actor: ��Ҷ���
---*  where: λ�� 0 1
---*  EffId: ��ЧID
---*  selfSee: ��Ҷ���
---@param actor userdata
---@param where number
---@param EffId number
---@param selfSee number
function changedresseffect(actor,where,EffId,selfSee) end

---�������ﾭ��ֵ
---*  actor: ��Ҷ���
---*  opt: ��Ҷ���
---*  count: ��Ҷ���
---*  addexp: ��Ҷ���
---@param actor userdata
---@param opt string
---@param count number
---@param addexp number
function changeexp(actor,opt,count,addexp) end

---�����л��Ա��������
---*  actor: ��Ҷ���
---@param actor userdata
function changeguildmemberlimit(actor) end

---������������
---*  actor: ��Ҷ���
---*  id: ����ID 1-20
---*  time: ����ֵ
---*  value: ʱ��(��)
---@param actor userdata
---@param id number
---@param value number
---@param time number
function changehumability(actor,id,value,time) end

---�޸���������
---*  actor: ��Ҷ���
---*  name: Ҫ��ѯ������
---@param actor userdata
---@param name userdata
function changehumname(actor,name) end


---����������ϲ��ŵ���Ч
---*  actor: ��Ҷ���
---*  effectid: ��ЧID
---@param actor userdata
---@param effectid number
function clearplayeffect(actor,effectid) end

---������м���
---*  actor: ��Ҷ���
---@param actor userdata
function clearskill(actor) end

---�رյ�ǰ��NPC�Ի���
---*  actor: ��Ҷ���
---@param actor userdata
function close(actor) end

---�ٻ�ʰȡС����
---*  actor: ��Ҷ���
---*  monName: �������� ������Ҫ��cfg_monster.xls���������:Race=216
---@param actor userdata
---@param monName string
function createsprite(actor,monName) end

---ɾ��Ӣ��
---*  actor: ��Ҷ���
---@param actor userdata
function delhero(actor) end

---ɾ��Ini�ļ�������
---*  actor: ��Ҷ���
---@param actor userdata
function deliniitem(actor) end

---ɾ��Ini�ļ�������(��Cache)
---*  actor: ��Ҷ���
---@param actor userdata
function deliniitembycache(actor) end

---ɾ��Ini�ļ�������
---*  actor: ��Ҷ���
---@param actor userdata
function delinisection(actor) end

---ɾ��Ini�ļ������� ��Cache
---*  actor: ��Ҷ���
---@param actor userdata
function delinisectionbycache(actor) end

---ͨ����ƷΨһid������Ʒ
---*  actor: ��Ҷ���
---*  makeindx: ��ƷΨһID,����(,)����
---*  count: ��Ҷ���
---@param actor userdata
---@param makeindx string|number
---@param count? number
function delitembymakeindex(actor,makeindx,count) end

---ɾ����ͼ��Ч
---*  Id: ��Ч����ID
---@param Id number
function delmapeffect(Id) end

---ɾ����̬��ͼ����
---*  actor: ��Ҷ���
---*  MapId: ��Ҷ���
---@param actor userdata
---@param MapId string|number
function delmapgate(actor,MapId) end

---ɾ�������ͼ
---*  MapId: ��ͼID
---@param MapId string
function delmirrormap(MapId) end

---ɾ������
---*  nIdx: ����ID
---@param nIdx number
function delnation(nIdx) end

---ɾ���Ǳ�ְҵ����
---*  actor: ��Ҷ���
---@param actor userdata
function delnojobskill(actor) end

---ɾ��NPC
---*  name: NPC����
---*  map: ��ͼ���
---@param name userdata
---@param map userdata
function delnpc(name,map) end

---ɾ��NPC��Ч
---*  actor: ��Ҷ���
---*  NPCIndex: NPC���� NPC���ñ��е�ID
---@param actor userdata
---@param NPCIndex number
function delnpceffect(actor,NPCIndex) end

---ɾ������
---*  actor: ��Ҷ���
---*  idx: �������
---@param actor userdata
---@param idx number
function delpet(actor,idx) end

---ɾ������
---*  actor: ��Ҷ���
---*  skillid: ����ID
---@param actor userdata
---@param skillid number
function delskill(actor,skillid) end

---����ΨһIDɾ���ֿ���Ʒ
---*  actor: ��Ҷ���
---*  itemmakeid: ɾ��ΨһID��Ʒ
---@param actor userdata
---@param itemmakeid number
function delstorageitem(actor,itemmakeid) end

---����idxɾ���ֿ���Ʒ
---*  actor: ��Ҷ���
---*  itemidx: ɾ������Idx��Ʒ
---@param actor userdata
---@param itemidx number
function delstorageitembyidx(actor,itemidx) end

---ɾ���ƺ�
---*  actor: ��Ҷ���
---*  name: �ƺ���Ʒ����
---@param actor userdata
---@param name string
function deprivetitle(actor,name) end

---ʹ�ýű�����ⶾ(���̶�)
---*  actor: ��Ҷ���
---*  opt: -1,�����ж�;0,�̶�;1,�춾;3,�϶�;5,���;6,����;7,����
---@param actor userdata
---@param opt string
function detoxifcation(actor,opt) end

---����
---*  actor: ��Ҷ���
---@param actor userdata
function dismounthorse(actor) end

---ֹͣ��̯
---*  actor: ��Ҷ���
---@param actor userdata
function forbidmyshop(actor) end

---��ȡ��ɫ����buff
---*  actor: ��Ҷ���
---@param actor userdata
function getallbuffid(actor) end

---��ȡ�����л����
function getallguild() end

---��ȡ��ǰ����ģʽ
---*  actor: ��Ҷ���
---@param actor userdata
function getattackmode(actor) end

---��ȡ����ʣ��ո���
---*  actor: ��Ҷ���
---@param actor userdata
function getbagblank(actor) end

---��ȡ������Ʒ����
---*  actor: ��Ҷ���
---*  itemname: ��Ʒ����
---@param actor userdata
---@param itemname string
function getbagitemcount(actor,itemname) end

---��ȡ����������Ʒ
---*  actor: ��Ҷ���
---@param actor userdata
function getbagitems(actor) end

---��ȡ ����|���� �����Ϣ
---*  object: ���|���� ����
---*  nID: ���� (���˵����)
---*  param3: ����3 (��ID=1ʱ����)
---@param object userdata
---@param nID number
---@param param3? number
---@return any
function getbaseinfo(object,nID,param3) end

---��ȡ����ͨ�û�������(����Ҽ���)
---*  actor: ��Ҷ���
---@param actor userdata
function getbindmoney(actor) end

---��ȡbuff��Ϣ
---*  actor: ��Ҷ���
---@param actor userdata
function getbuffinfo(actor) end

---��ȡ����
---*  actor: ��Ҷ���
---*  varname: ��������,���txt˵����
---@param actor userdata
---@param varname userdata
function getconst(actor,varname) end

---��ȡ���ֵ
---*  object: ����|�������
---*  index: �±�ID 0-9
---@param object userdata
---@param index userdata
function getcurrent(object,index) end

---������Ʒ��ȡJson
---*  item: ��Ʒ����
---@param item userdata
function getitemjson(item) end

---���װ�����ֵ���ɫ
---*  item: ��Ʒ����
---@param item userdata
function getitemnamecolor(item) end

---��ȡ��ǰΨһID��Ʒ����������
---*  actor: ��Ҷ���
---*  itemmakeid: ��ƷΨһID
---@param actor userdata
---@param itemmakeid number
function getitemstars(actor,itemmakeid) end

---��ȡָ����ͼ�������
---*  actor: ��Ҷ���
---*  MapId: ��ͼID
---*  isAllgain: �Ƿ�ȫ����ȡ 0=ȫ����ȡ 1=�ų���������
---@param actor userdata
---@param MapId userdata
---@param isAllgain userdata
function getplaycountinmap(actor,MapId,isAllgain) end

---��ȡ��ұ���
---*  actor: ��Ҷ���
---*  varName: ������
---@param actor userdata
---@param varName string
function getplaydef(actor,varName) end

---�������ΨһID��ȡ��Ҷ���
---*  userdata: ���ΨһID
---@param makeindex string
function getplayerbyid(makeindex)  end

---�����������ȡ��Ҷ���
---*  name: �������
---@param name string
function getplayerbyname(name) end

---��ȡ������������б�
---@return table
function getplayerlst() end

---��ȡ�л��Ա���л��е�ְλ
---*  actor: ��Ҷ���
---@param actor userdata
function getplayguildlevel(actor) end

---��ȡ�Զ������
---*  actor: ��Ҷ���
---*  varName: ������
---@param actor userdata
---@param varName string
---@return any
function getplayvar(actor,varName) end

---��ȡ�ֿ�ʣ�������
---*  actor: ��Ҷ���
---@param actor userdata
function getsblank(actor) end

---��ȡ���ܳ�ʼ��ȴʱ��
---*  skillname: ��Ҷ���
---@param skillname string
function getskillcscd(skillname) end

---��ȡ��ǰ������ȴʱ��
---*  actor: ��Ҷ���
---*  skillname: ��������
---@param actor userdata
---@param skillname string
function getskilldqcd(actor,skillname) end

---���ݼ���id��ȡ��������
---*  skillname: ��������
---@param skillname string
function getskillindex(skillname) end

---��ȡ������Ϣ
---*  actor: ��Ҷ���
---*  skillid: ����ID
---*  type: ��ȡ����:1:�ȼ�;2:ǿ���ȼ�;3:������;4:����������;
---@param actor userdata
---@param skillid number
---@param type number
function getskillinfo(actor,skillid,type) end

---��ȡ���ܵȼ�
---*  actor: ��Ҷ���
---*  skillid: ����ID
---@param actor userdata
---@param skillid number
function getskilllevel(actor,skillid)  end

---��ȡ����ǿ���ȼ�
---*  actor: ��Ҷ���
---*  skillid: ����ID
---@param actor userdata
---@param skillid number
function getskilllevelup(actor,skillid)  end

---���ݼ���id��ȡ��������
---*  actor: ��Ҷ���
---*  skillname: ��������
---@param actor userdata
---@param skillname string
function getskillname(actor,skillname) end

---��ȡ����������
---*  actor: ��Ҷ���
---@param actor userdata
---@param skillid number
function getskilltrain(actor,skillid) end

---���ݱ���������ȡ��ɫ��������
---*  actor: ��Ҷ���
---@param actor userdata
---@param nIndex number
function getslavebyindex(actor,nIndex) end


---��ȡװ����ʯ��Ƕ���
---*  actor: ��Ҷ���
---*  item: װ������
---@param actor userdata
---@param item userdata
function getsocketableitem(actor,item) end

---��ȡ��Ҳֿ���������
---*  actor: ��Ҷ���
---@param actor userdata
function getssize(actor) end

---��ȡbuffģ����Ϣ
---*  buffinfo: buffID/buff����
---*  id: 0:idx1:����;2.���;3.����ʱ��;4.��������;
---@param buffinfo number|string
---@param id number
function getstdbuffinfo(buffinfo,id) end

---��ȡ��Ʒ��������
---*  itemid: ��ƷID
---@param itemid number
---@param id number
function getstditematt(itemid,id) end

---��ȡ��Ʒ������Ϣ
---*  item: ��ƷID/��Ʒ����
---*  id:��˵����
---@param item number|string
---@param id number
---@return any
function getstditeminfo(item,id) end

---��ȡ�ֿ�������Ʒ�б�
---*  actor: ��Ҷ���
---@param actor userdata
function getstorageitems(actor) end

---��ȡ�����˺�����
---*  actor: ��Ҷ���
---@param actor userdata
function getsuckdamage(actor) end

---��ȡȫ�ֱ���
---*  varName: ������
---@param varName string
function getsysvar(varName) end

---��ȡȫ���Զ������
---*  varName: ������
---@param varName string
function getsysvarex(varName) end

---��ȡ��������64λʱ���
function gettcount64() end

---��ȡ��Ʒ��Դ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---@param actor userdata
---@param item userdata
function getthrowitemly(actor,item) end

---��ȡ��ɫ���гƺ�
---*  actor: ��Ҷ���
---@param actor userdata
function gettitlelist(actor) end

---��ȡ������������
---*  actor: ��Ҷ���
---*  nIndex: 	����
---@param actor userdata
---@param nIndex userdata
function getusebonuspoint(actor,nIndex) end

---����Ʒ
---*  actor: ��Ҷ���
---*  itemname: ��Ʒ����
---*  num: 	����
---*  bind: ��Ʒ����
---@param actor userdata
---@param itemname string
---@param num number
---@param bind? number
function giveitem(actor,itemname,num,bind) end

---����json�ַ�������Ʒ
---*  actor: ��Ҷ���
---*  json: json�ַ���
---@param actor userdata
---@param json userdata
function giveitembyjson(actor,json) end

---����Ʒ,��ֱ�Ӵ���
---*  actor: ��Ҷ���
---*  where: װ��λ��
---*  itemname: ��Ʒ����
---*  num: ����
---*  bind: ��Ʒ����
---@param actor userdata
---@param where number
---@param itemname string
---@param num number
---@param bind number
function giveonitem(actor,where,itemname,num,bind) end

---��ȡȫ����Ϣ
---*  id: ��˵����
---@param id number
function globalinfo(id) end

---ִ��GM����
---*  actor: ��Ҷ���
---*  GM: GM����
---*  ...: �������
---@param actor userdata
---@param GM string
---@param ... any
function gmexecute(actor,GM,...) end

---�ص���������ĳ��а�ȫ��
---*  actor: ��Ҷ���
---@param actor userdata
function gohome(actor) end

---���ô���
---*  actor: ��Ҷ���
---*  type: ����ģʽ
---*  label: ��ת��Ľӿ�
---*  range: ����ģʽ=3ʱָ���ķ�Χ��С
---@param actor userdata
---@param type number
---@param label string
---@param range number
function gotolabel(actor,type,label,range) end

---������ҵ�ָ��λ��
---*  actor: ��Ҷ���
---*  x: X����
---*  y: Y����
---@param actor userdata
---@param x number
---@param y number
function gotonow(actor,x,y) end

---����ͼ�߼���
---*  mapid: ��ͼId
---*  x: X����
---*  y: Y����
---@param mapid userdata
---@param x number
---@param y number
---@param type number
---@param result boolean
function gridattr(mapid,x,y,type,result) end

---��ȡȫ����Ϣ
---*  id: ��˵����
---@param id number
---@return any
function grobalinfo(id) end

---�����ͼ����
---*  actor: ��Ҷ���
---*  mapid: ��ͼId
---*  x: X����
---*  y: Y����
---*  level: ���Դ�����͵ȼ�(����Ϊ�� Ϊ��ʱ������Ա�ĵȼ�ֱ�Ӵ���)
---*  value: ���ͷ�Χ��(�Զӳ�Ϊ���Ĵ��Ͷ��� 0Ϊ����Ҫ��Χ)
---*  obj: �����ֶ�(����Ϊ��)
---@param actor userdata
---@param mapid userdata
---@param x number
---@param y number
---@param level number
---@param value number
---@param obj userdata
function groupmapmove(actor,mapid,x,y,level,value,obj) end

---�����Զ�����ɫ��������Ϣ
---*  actor: ��Ҷ���
---*  FColor: ��ͼId
---*  BColor: X����
---*  Msg: Y����
---*  flag: ���Դ�����͵ȼ�(����Ϊ�� Ϊ��ʱ������Ա�ĵȼ�ֱ�Ӵ���)
---@param actor userdata
---@param FColor userdata
---@param BColor number
---@param Msg number
---@param flag number
function guildnoticemsg(actor,FColor,BColor,Msg,flag) end

---�Ƿ���buff
---*  actor: ��Ҷ���
---*  buffid: ��Ҷ���
---@param actor userdata
---@param buffid userdata
function hasbuff(actor,buffid) end

---�Ƿ���Ӣ��
---*  actor: ��Ҷ���
---@param actor userdata
function hashero(actor) end

---ˢ��Ѫ��/����
---*  object: ���/�������
---@param object userdata
function healthspellchanged(object) end

---������Ϣ�ϱ�
---*  actor: ��Ҷ���
---@param actor userdata
function httppost(actor) end

---�޸����ﵱǰѪ��
---*  actor: ��Ҷ���
---*  operate: �������� [+����][-����][=����]
---*  nvalue: HP����
---*  effid: �ز�ID
---@param actor userdata
---@param operate string
---@param nvalue number
---@param effid? number
function humanhp(actor,operate,nvalue,effid) end

---�޸����ﵱǰMP
---*  actor: ��Ҷ���
---*  operate: �������� [+����][-����][=����]
---*  nvalue: MP����
---@param actor userdata
---@param operate string
---@param nvalue number
function humanmp(actor,operate,nvalue) end

---ȡ�Զ������ֱ�����λ��
---*  actor: ��Ҷ���
---*  varName: ���������
---*  playflag: 0-������� 1-�������
---*  sortflag: 0-���� 1-����
---@param actor userdata
---@param varName string
---@param playflag number
---@param sortflag number
function humvarrank(actor,varName,playflag,sortflag) end

---�����ļ�
---*  path: ·������(��ʼĿ¼Envir)
---@param path string
function include(path) end

---��ʼ���л��Զ������
---*  guil: �л����
---*  varType: ��������
---*  varName: ������
---@param guil userdata
---@param varType string
---@param varName string
function iniguildvar(guil,varType,varName) end

---��ʼ�������Զ������
---*  actor: ��Ҷ���
---*  varType: ��������(number/string)
---*  varRage: ������Χ(HUMAN/GUILD) HUMANָ���˱��� GUILDָ�л����
---*  varName: ������
---@param actor userdata
---@param varType string
---@param varRage string
---@param varName string
function iniplayvar(actor,varType,varRage,varName) end

---��ʼ��ȫ���Զ������
---*  type: ��������(number/string)
---*  varName: ������
---@param type string
---@param varName string
function inisysvar(type,varName) end

---�жϵ�ͼ�����Ƿ�Ϊ��
---*  mapname: ��ͼ����
---*  nX: ��ͼx����
---*  nY: ��ͼy����
---@param mapname userdata
---@param nX userdata
---@param nY userdata
function isemptyinmap(mapname,nX,nY) end



---�ж�Ӣ���Ƿ�Ϊ����״̬
---*  actor: ��Ҷ���
---@param actor userdata
function isherorecall(actor) end



---������ս��״̬
---*  actor: ��Ҷ���
---@param actor userdata
function isnationswar(actor) end

---�����Ƿ����
---*  actor: ��Ҷ���
---@param actor userdata
function isnotnull(actor) end


---�ж϶����Ƿ�ɱ�����
---*  Hiter: ��������(���/Ӣ��/����)
---*  Target: ����������(���/Ӣ��/����)
---@param Hiter userdata
---@param Target userdata
function ispropertarget(Hiter,Target) end

---����/�˳�����
---*  actor: ��Ҷ���
---*  nIdx: ����ID (1~100),��0�˳�����
---*  jobIdx: ְλ��� 0-9 ���� Ĭ��Ϊ0 
---@param actor userdata
---@param nIdx number
---@param jobIdx number
function joinnational(actor,nIdx,jobIdx) end

---�ַ���ת���ɱ��
---*  str: ��Ҷ���
---@param str string
function json2tbl(str) end

---���֪ͨ��������QF
---*  id: ��Ϣid 1-99
---*  userid: ���userid
---*  parama: ���ݵ��ַ���1(�ַ���)
---*  paramb: ���ݵ��ַ���2(�ַ���)
---@param id number
---@param userid string
---@param parama string
---@param paramb string
function kfbackcall(id,userid,parama,paramb) end

---����ǿ�Ƶ���
---*  actor: ��Ҷ���
---@param actor userdata
function kick(actor) end

---����ɱ����ɫ
---*  play: ��ɫ�Ķ���
---*  actor: ���ֵĶ���
---@param play userdata
---@param strKiller userdata
function kill(actor,strKiller) end

---�ű����÷���ɱ����
---*  actor: ��Ҷ���
---@param actor userdata
function killedprotect(actor) end

---��ָ��λ�����ȴ�ָ�����
---*  actor: ��Ҷ���
---*  map: ��ͼ
---*  X: 	X����
---*  Y: 	Y����
---*  MonName: ���ȹ����Ĺ�������֧�ֶ����������,���������м��� | �ָ�
---@param actor userdata
---@param map string
---@param X number
---@param Y number
---@param MonName? string
function killmobappoint(actor,map,X,Y,MonName) end

---ɱ��2
---*  actor: ��Ҷ���
---*  mon: �������
---*  drop: �Ƿ������Ʒ true����|false������
---*  trigger: �Ƿ񴥷�killmon
---*  showdie: �Ƿ���ʾ��������
---@param actor userdata
---@param mon userdata
---@param drop boolean
---@param trigger boolean
---@param showdie boolean
function killmonbyobj(actor,mon,drop,trigger,showdie) end

---ɱ��1
---*  mapid: ��ͼid
---*  monname: ����ȫ�� �� nil|* ɱ��ȫ��
---*  count: ���� ��0ɱ������
---*  drop: �Ƿ������Ʒ
---@param mapid string
---@param monname string
---@param count number
---@param drop boolean
function killmonsters(actor,mapid,monname,count,drop) end

---���п����һر��� ����ִ���������д���
function kuafuusergohome() end

---����װ����Ʒ
---*  actor: ��Ҷ���
---*  where: װ��λ��
---@param actor userdata
---@param where number
function linkbodyitem(actor,where) end

---�������ڲ�������Ʒ ��ȡ ���� ,����!!!!!!!!!!
function linkpickupitem() end


---�ı� ��/���� ״̬
---*  object: ���/���� ����
---*  type: ����(0=�̶� 1=�춾 5=��� 12=���� 13= ���� ������Ч)
---*  time: ʱ��(��)
---*  actor: ���� ֻ����̶�����
---@param object userdata
---@param type number
---@param time number
---@param value number
function makeposion(object,type,time,value) end

---��ת��ͼ(�������)
---*  actor: ��Ҷ���
---*  mapname: ��ͼ��
---@param actor userdata
---@param mapname string
function map(actor,mapname) end

---��ӵ�ͼ��Ч
---*  Id: 	��Ч����ID �������ֶ����ͼ��Ч
---*  MapId: ��ͼID
---*  X: ����X
---*  Y: ����Y
---*  effId: ��ЧID
---*  time: ����ʱ��(��)
---*  mode: ģʽ:(0~4 0�����˿ɼ� 1�Լ��ɼ� 2��ӿɼ� 3�л��Ա�ɼ� 4�жԿɼ�)
---@param Id number
---@param MapId string
---@param X number
---@param Y number
---@param effId number
---@param time number
---@param mode number
function mapeffect(Id,MapId,X,Y,effId,time,mode) end

---���õ�ͼɱ�־��鱶��
---*  actor: ��Ҷ���
---*  MapId: ��ͼid( * �ű�ʾ���е�ͼ)
---*  much: ���� Ϊɱ�־��鱶�� ��������100Ϊ�����ı���(200 Ϊ 2 ������ 150 Ϊ1.5��,0��ʾ�رյ�ͼ��ɱ�־��鱶��)
---@param actor userdata
---@param MapId string
---@param much number
function mapkillmonexprate(actor,MapId,much) end

---�ɵ�ͼ(ָ������)
---*  actor: ��Ҷ���
---*  mapname: ��ͼ��
---*  nX: X����
---*  nY: Y����
---*  nRange: 	��Χ
---@param actor userdata
---@param mapname number|string
---@param nX number
---@param nY number
---@param nRange? number
function mapmove(actor,mapname,nX,nY,nRange) end

---MD5����
---*  str: ��Ҫ���ܵ��ı�
---@param str string
function md5str(str) end

---����������Ϣ
---*  actor: ��Ҷ���
---*  info: ��������
---*  flag1: ȷ������ת�Ľӿ�
---*  flag2: ȡ������ת�Ľӿ�
---@param actor userdata
---@param info string
---@param flag1 string
---@param flag2 string
function messagebox(actor,info,flag1,flag2) end

---�ͻ��˸���
---*  actor: ��Ҷ���
---*  str: �ı�����
---@param actor userdata
---@param str string
function mircopy(actor,str) end

---��ȡ/���� �����ͼʣ��ʱ��
---*  actor: ��Ҷ���
---@param actor userdata
function mirrormaptime(actor) end

---���Ź⻷Ч��
---*  actor: ��Ҷ���
---*  mapid: ��ͼid
---*  x: ����x
---*  y: ����y
---*  type: �⻷����
---*  time: ʱ��(��)
---*  behind: ����ģʽ-0-ǰ��-1-����
---*  selfshow: ���Լ��ɼ�0-�� ��Ұ�ھ��ɼ� 1-��
---@param actor userdata
---@param mapid number|string
---@param x number
---@param y number
---@param type number
---@param time number
---@param behind? number
---@param selfshow? number
function mobfireburn(actor,mapid,x,y,type,time,behind,selfshow) end

---ɱ����Ʒ�ٱ�
---*  actor: ��Ҷ���
---*  count: ������Ʒ�������Ӵ���
---@param actor userdata
---@param count number
function monitems(actor,count) end

---��ĳ����ͼ�е����ȫ���ƶ�������һ����ͼ
---*  actor: ��Ҷ���
---*  aMapId: �ƶ�ǰ��ͼId
---*  bMapId: �ƶ����ͼId
---*  x: x����
---*  y: y����
---@param actor userdata
---@param aMapId userdata
---@param bMapId userdata
---@param x userdata
---@param y userdata
function movemapplay(actor,aMapId,bMapId,x,y) end

---������ս
---*  actor: ��Ҷ���
---@param actor userdata
function nationswar(actor) end

---���ֽ�����������
---*  actor: ��Ҷ���
---*  NPCIdx: ����ID
---*  BtnIdx: ��ť����
---*  sMsg: ��ʾ������
---@param actor userdata
---@param NPCIdx number
---@param BtnIdx number
---@param sMsg string
function navigation(actor,NPCIdx,BtnIdx,sMsg) end

---ˢ�½���������״̬
---*  actor: ��Ҷ���
---*  nId: ����ID
---*  ...:����1~����10
---@param actor userdata
---@param nId number
---@param ... any
function newchangetask(actor,nId,...) end

---�������
---*  actor: ��Ҷ���
---*  nId: ����
---@param actor userdata
---@param nId number
function newcompletetask(actor,nId) end

---ɾ������
---*  actor: ��Ҷ���
---*  nId: ����
---@param actor userdata
---@param nId number
function newdeletetask(actor,nId) end

---��ȡ������ĵڼ��еڼ�������(0��0�п�ʼ)
---*  filename: ��Ҷ���
---*  row: ��Ҷ���
---*  col: ��Ҷ���
---@param filename userdata
---@param row userdata
---@param col userdata
function newdqcsv(filename,row,col) end


---�½�����
---*  actor: ��Ҷ���
---*  nId: 	����ID
---*  ...: ����1~����10 �����滻�����������%s
---@param actor userdata
---@param nId number
---@param ... string
function newpicktask(actor,nId,...) end

---����csv�������
---*  filename: �ļ���
---@param filename string
function newreadcsv(filename) end

---�Ƿ�����ָ���������� CanBuyShopItem������ʹ�� 
---*  actor: ��Ҷ���
---*  canbuy: 1-�������� 0-������
---@param actor userdata
---@param canbuy number
function notallowbuy(actor,canbuy) end

---�Ƿ�����ָ��������ʾ CanShowShopItem������ʹ�� 
---*  actor: ��Ҷ���
---*  canbuy: 1-����ʾ 0-��ʾ
---@param actor userdata
---@param canshow number
function notallowshow(actor,canshow) end

---�ر�ָ��װ���Ա���ʾ
---*  actor: ��Ҷ���
---*  order: 1=��ƷΨһID 2=��ƷIDX 3=��Ʒ����
---*  str: 	��Ӧ����2������ֵ
---@param actor userdata
---@param order number
---@param str string
function nothintitem(actor,order,str) end

---���߹һ�
---*  actor: ��Ҷ���
---*  time: ����ʱ��(��)
---@param actor userdata
---@param time number
function offlineplay(actor,time) end

---������Ϸ���
---*  actor: ��Ҷ���
---*  nId: 	���ID
---*  nState: 0=�� 1=������ظ��㰴ť����ر�,����������رհ�ť(һ��������������������õ�) 2=�رյ�ǰ���ID
---@param actor userdata
---@param nId number
---@param nState number
function openhyperlink(actor,nId,nState) end

---��NPC�󴰿�
---*  path: ��Ҷ���
---*  pos: ��Ҷ���
---*  x: ��Ҷ���
---*  y: ��Ҷ���
---*  height: ��Ҷ���
---*  width: ��Ҷ���
---*  bool: ��Ҷ���
---*  closeX: ��Ҷ���
---*  closeY: ��Ҷ���
---*  isMove: ��Ҷ���
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

---��ָ��NPC���
---*  actor: ��Ҷ���
---*  NPCIndex: NPC���� NPC���ñ��е�ID
---*  nRange: ��Χֵ �ڴ˷�Χ�������
---@param actor userdata
---@param NPCIndex number
---@param nRange number
function opennpcshow(actor,NPCIndex,nRange) end

---�ƶ���ָ��NPC����
---*  actor: ��Ҷ���
---*  NPCIndex: NPC���� NPC���ñ��е�ID 
---*  nRange: ��Χֵ ���ڴ˷�Χ�����ƶ���NPC����
---*  actor: ��Χֵ2 �ƶ���NPC�����ķ�Χ��
---@param actor userdata
---@param NPCIndex number
---@param nRange number
---@param nRange2 number
function opennpcshowex(actor,NPCIndex,nRange,nRange2) end

---�򿪲ֿ����
---*  actor: ��Ҷ���
---@param actor userdata
function openstorage(actor) end

---��OK��
---*  actor: ��Ҷ���
---*  title: OK�����
---@param actor userdata
---@param title string
function openupgradedlg(actor,title) end

---��Ϸ�д���վ
---*  actor: ��Ҷ���
---*  url: ��վ
---@param actor userdata
---@param url string
function openwebsite(actor,url) end

---�鿴�Լ����
---*  actor: ��Ҷ���
---*  winID: 101=װ�� 102=״̬ 103=���� 104=���� 105=��Ф 106=�ƺ� 1011=ʱװ
---@param actor userdata
---@param winID number
function openwindows(actor,winID) end

---�����ı�
---*  text: 	�ı�����
---*  actor: ��Ҷ���
---@param text string
---@param actor userdata
function parsetext(text,actor) end

---�û��������� *ֻ�û���������:���󡢹�������� ԭ������������ȫ������ �������
---*  actor: ��Ҷ���
---*  idx: 	�������
---*  monidx: 	����IDX
---@param actor userdata
---@param idx number
---@param monidx number
function petmon(actor,idx,monidx) end

---��ȡ����״̬
---*  actor: ��Ҷ���
---*  idx: �������
---@param actor userdata
---@param idx number
function petstate(actor,idx) end

---������װ�� �˽ӿڲ��ۼ���Ʒ ���ۼ��������϶�Ӧװ�����ԡ�
---*  actor: ��Ҷ���
---*  idx: �������
---*  item: װ������ ���װ����#�ָ� -1��ʾ����ȫ��װ��
---@param actor userdata
---@param idx number
---@param item string
function pettakeoff(actor,idx,item) end

---���ﴩװ�� �˽ӿڲ���������Ʒ ������Ʒ��������ӵ��������� �����浽���ݿ⡣
---*  actor: ��Ҷ���
---*  idx: �������
---*  item: װ������ ���װ����#�ָ�
---@param actor userdata
---@param idx number
---@param item string
function pettakeon(actor,idx,item) end

---ʰȡģʽ
---*  actor: ��Ҷ���
---*  mode: ģʽ 0=������Ϊ���ļ�ȡ 1=��С����Ϊ���ļ�ȡ
---*  Range: ��Χ
---*  interval: ��� ��С500ms
---@param actor userdata
---@param mode number
---@param Range number
---@param interval number
function pickupitems(actor,mode,Range,interval) end

---���������ϲ�����Ч
---*  actor: ��Ҷ���
---*  actor: ��ЧID
---*  actor: ���������ƫ�Ƶ�X����
---*  actor: ���������ƫ�Ƶ�Y����
---*  actor: ���Ŵ��� ��0��һֱ����
---*  actor: ����ģʽ0-ǰ��1-����
---*  actor: ���Լ��ɼ� 0-��(��Ұ�ھ��ɼ�) 1-��
---@param actor userdata
---@param effectid number
---@param offsetX number
---@param offsetY number
---@param times number
---@param behind number
---@param selfshow number
function playeffect(actor,effectid,offsetX,offsetY,times,behind,selfshow) end

---������������
---*  actor: ��Ҷ���
---*  index: �����ļ������� ��Ӧ�������ñ�id(cfg_sound.xls)
---*  times: ѭ�����Ŵ���
---*  flag: ����ģʽ:0.���Ÿ��Լ� 1.���Ÿ�ȫ�� 2.���Ÿ�ͬһ��ͼ 4.���Ÿ�ͬ������
---@param actor userdata
---@param index userdata
---@param times userdata
---@param flag userdata
function playsound(actor,index,times,flag) end

---�������﹥������
---*  actor: ��Ҷ���
---*  rate: ������������ 100=100%
---*  time: ��Чʱ�� ����ʱ��ָ�����
---@param actor userdata
---@param rate number
---@param time number
function powerrate(actor,rate,time) end

---��ȡ�ͻ��˳�ֵ�ӿ�
---*  actor: ��Ҷ���
---*  money: ���
---*  type: ��ֵ��ʽ 1-֧���� 2-���� 3-΢��
---*  flagid: ��Ҷ���
---@param actor userdata
---@param money number
---@param type number
---@param flagid number
function pullpay(actor,money,type,flagid) end

---��ѯ���������Ƿ����
---*  actor: ��Ҷ���
---*  name: Ҫ��ѯ������
---@param actor userdata
---@param name string
function queryhumnameexist(actor,name) end

---��ѯ�������
---*  actor: ��Ҷ���
---*  id: ����ID 1-100 
---@param actor userdata
---@param id number
function querymoney(actor,id) end

---���ɱ����ͼ�еĹ���
---*  mapid: ��Ҷ���
---*  name: ��������
---*  num: ����(1-255)
---*  drop: �Ƿ���� 0=���� 1=������
---@param mapid string
---@param name number
---@param num number
---@param drop number
function randomkillmon(mapid,name,num,drop) end

---���Ӹ����˺�Ч��
---*  actor: ��Ҷ���
---*  targetX: X����
---*  targetY: Y����
---*  range: Ӱ�췶Χ
---*  power: ������
---*  addtype: ��������,��˵����
---*  addvalue: ��������ֵ,��˵����
---*  checkstate: �Ƿ��������/���/ʯ��/����/����/�춾/�̶�����0=ֱ������״̬;1=��������״̬)
---*  targettype: Ŀ������(0���=����Ŀ��;1=������;2=������)
---*  effectid: Ŀ�����ϲ��ŵ���ЧID
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

---��ȡIni�ļ��е��ֶ�ֵ
---*  actor: ��Ҷ���
---*  section: ��������
---*  item: ������
---@param actor userdata
---@param section string
---@param item string
function readini(actor,section,item) end

---��ȡIni�ļ��е��ֶ�ֵ ��Cache
---*  actor: ��Ҷ���
---*  section: ��������
---*  item: ������
---@param actor userdata
---@param section string
---@param item string
function readinibycache(actor,section,item) end

---����
---*  actor: ��Ҷ���
---@param actor userdata
function realive(actor) end

---���ظ���ĳ������
---*  actor: ��Ҷ���
---*  idx: �������
---*  nHp: ������HP��
---*  type: 0-����ֵ 1-�ٷֱ�
---@param actor userdata
---@param idx number
---@param nHp number
---@param type number
function realivepet(actor,idx,nHp,type) end

---ˢ����������
---*  actor: ��Ҷ���
---@param actor userdata
function recalcabilitys(actor) end

---�ٻ�Ӣ��
---*  actor: ��Ҷ���
---@param actor userdata
function recallhero(actor) end

---�ٻ�����
---*  actor: ��Ҷ���
---*  monName: ��������
---*  level: �����ȼ�(���Ϊ7)
---*  time: �ѱ�ʱ��(����)
---*  param1: Ԥ��(��0)
---*  param2: Ԥ��(��0)
---*  param3: ���ô���0 ���ʱ������ñ�������(��M2���Ƶ��ٻ�����)
---@param actor userdata
---@param monName string
---@param level number
---@param time number
---@param param1 number
---@param param2 number
---@param param3 number
function recallmob(actor,monName,level,time,param1,param2,param3) end

---�����ٻ��ĳ������
---*  actor: ��Ҷ���
---*  idx: ��Ҷ���
---@param actor userdata
---@param idx number
function recallpet(actor,idx) end

---����OK����Ʒ������
---*  actor: ��Ҷ���
---@param actor userdata
function reclaimitem(actor) end

---�����������Ʒ
---*  actor: ��Ҷ���
---@param actor userdata
function refreshbag(actor) end

---ˢ����Ʒ��Ϣ��ǰ��
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---@param actor userdata
---@param item userdata
function refreshitem(actor,item) end

---��NPCע��Lua��Ϣ
---*  msgId: ��ϢID
---*  NPCIndex: NPC���� NPC���ñ��е�ID
---@param msgId number
---@param NPCIndex number
function regnpcmsg(msgId,NPCIndex) end

---�ýű������ͷż���
---*  actor: ��Ҷ���
---*  skillid: 	����ID
---*  type: ���� 1-��ͨ����2-ǿ������
---*  level: ���ܵȼ�
---*  target: ���ܶ���: 1-����Ŀ�� 2-����
---*  flag: �Ƿ���ʾʩ������ 0-����ʾ 1-��ʾ
---@param actor userdata
---@param skillid number
---@param type number
---@param level number
---@param target number
---@param flag number
function releasemagic(actor,skillid,type,level,target,flag) end

---����
---*  actor: ��Ҷ���
---@param actor userdata
function releasesprite(actor) end

---��ӡ��Ϣ������̨ ���濪��ģʽ �����������̨�� ����ģʽ ���¼��ScriptXX�ļ��� ���������Ų����
---@param ... any
function release_print(...) end

---����ת������
---*  actor: ��Ҷ���
---*  rlevel: ת������һ��ת���ټ�(��ֵ��ΧΪ1-255)
---*  level: ת����ȼ�����ת��������ĵȼ� 0Ϊ���ı����ﵱǰ�ȼ�
---*  num: �������ת������Եõ��ĵ��� �˵������ܰ����������������Ե�(��ֵ��Χ 1 - 20000)
---@param actor userdata
---@param rlevel userdata
---@param level userdata
---@param num userdata
function renewlevel(actor,rlevel,level,num) end

---�޸�����װ��
---*  actor: ��Ҷ���
---@param actor userdata
function repairall(actor) end

---�����ļ�
---*  path: ·������
---@param path string
function require(path) end

---�ջس���
---*  actor: ��Ҷ���
---@param actor userdata
function retractpettoitem(actor) end

---����
---*  actor: ��Ҷ���
---*  HorseAppr: ��Ҷ���
---*  HorseEff: ��Ҷ���
---*  HorseFature: ��Ҷ���
---*  Type: ��Ҷ���
---@param actor userdata
---@param HorseAppr number
---@param HorseEff number
---@param HorseFature number
---@param Type number
function ridehorse(actor,HorseAppr,HorseEff,HorseFature,Type) end

---NPC�����ı�����
---*  actor: ��Ҷ���
---*  msg: �����ı�����
---@param actor userdata
---@param msg string
function say(actor,msg) end

---��Ļ��
---*  actor: ��Ҷ���
---*  type: ģʽ(0~4)0.���Լ�;1.����������;2��Ļ��Χ������;3.��ǰ��ͼ��������;4.ָ����ͼ��������;
---*  level: ��(1~3)
---*  num: 	����
---*  mapid: ��ͼID(ģʽ����4ʱ ��Ҫ�ò���)
---@param actor userdata
---@param type number
---@param level number
---@param num number
---@param mapid number
function scenevibration(actor,type,level,num,mapid) end

---������Ļ��Ч
---*  actor: ��Ҷ���
---*  id: ģʽ(0~4)0.���Լ�;1.����������;2��Ļ��Χ������;3.��ǰ��ͼ��������;4.ָ����ͼ��������;
---*  effectid: ��(1~3)
---*  X: ����
---*  Y: ��ͼID(ģʽ����4ʱ ��Ҫ�ò���)
---*  speed: ����
---*  times: ��ͼID(ģʽ����4ʱ ��Ҫ�ò���)
---*  type: ��ͼID(ģʽ����4ʱ ��Ҫ�ò���)
---@param actor userdata
---@param id number
---@param effectid number
---@param X number
---@param Y number
---@param speed number
---@param times number
---@param type number
function screffects(actor,id,effectid,X,Y,speed,times,type) end


---����������ѡ��Ʒ
---*  actor: ��Ҷ���
---*  makeindex: ѡ�е���ƷΨһID�����Ʒ��","�ָ�
---@param actor userdata
---@param makeindex userdata
function selectbagitems(actor,makeindex) end

---����ƮѪƮ����Ч
---*  target: ƮѪƮ�ֵ����� һ��Ϊ�ܹ�����
---*  type: ��ʾ���� 1- �˺� 2- �����˺� 3- ����Ч�� 4- ��HP 5- �� 8- �ۼ�HP��MP 9- �˺� 10-�ۼ�MP 11- ����һ��
---*  damage: ��ʾ�ĵ���
---*  hitter: �ɿ���ƮѪƮ�ֵ����� һ��Ϊ������
---@param target userdata
---@param type number
---@param damage number
---@param hitter? userdata
function sendattackeff(target,type,damage,hitter) end

---������Ļ�м��������Ϣ
---*  actor: ��Ҷ���
---*  FColor: ǰ��ɫ
---*  BColor: 	����ɫ
---*  Msg: ���Ͷ���
---*  flag: ��Ҷ���
---*  time: ��ʾʱ��
---*  func: ����ʱ�����󴥷��ص�
---@param actor userdata
---@param FColor number
---@param BColor number
---@param Msg string
---@param flag string
---@param time number
---@param func string
function sendcentermsg(actor,FColor,BColor,Msg,flag,time,func) end

---��Ļ�������귢�͹�����Ϣ
---*  actor: ��Ҷ���
---*  type: ��Ϣ����0-ȫ�� 1-�Լ� 2-��� 3-�л� 4-��ǰ��ͼ
---*  msg: ��Ϣ����
---*  FColor: ǰ��ɫ
---*  BColor: ����ɫ
---*  X: X����
---*  Y: Y����
---@param actor userdata
---@param type number
---@param msg string
---@param FColor number
---@param BColor number
---@param X number
---@param Y number
function sendcustommsg(actor,type,msg,FColor,BColor,X,Y) end

---��ʾ����ʱ��Ϣ��ʾ
---*  actor: ��Ҷ���
---*  msg: ��Ϣ����
---*  time: ʱ�� ��
---*  FColor: ���徰ɫ
---*  mapdelete: ����ͼ�Ƿ�ɾ�� 0-��ɾ�� 1-ɾ��
---*  func: ��ת�ĺ���
---*  Y: Y����
---@param actor userdata
---@param msg string
---@param time number
---@param FColor number
---@param mapdelete number
---@param func string
---@param Y number
function senddelaymsg(actor,msg,time,FColor,mapdelete,func,Y) end

---������Ϣ
---*  actor:    ��Ҷ���
---*  msgid:    ��ϢID
---*  param1: 	����1
---*  param2: 	����2
---*  param3: 	����3
---*  sMsg: 	��Ϣ��
---@param actor userdata
---@param msgid number
---@param param1? number
---@param param2? number
---@param param3? number
---@param sMsg? string
function sendluamsg(actor,msgid,param1,param2,param3,sMsg) end

---�����ʼ�
---*  userid: ��UserId ���������� ��Ҫ��ǰ���#(��:#����)
---*  id: �Զ����ʼ�ID
---*  title: �ʼ�����
---*  memo: �ʼ�����
---*  rewards: ��������: ��Ʒ1#����#�󶨱��&��Ʒ2#����#�󶨱�� &���� #�ָ�
---@param userid string
---@param id number
---@param title string
---@param memo string
---@param rewards string
function sendmail(userid,id,title,memo,rewards) end

---������Ļ������Ϣ
---*  actor: ��Ҷ���
---*  type: ģʽ ���Ͷ��� 0-�Լ� 1-������ 2-�л� 3-��ǰ��ͼ 4-���
---*  FColor: ���徰ɫ
---*  BColor: ����ɫ
---*  Y: Y����
---*  scroll: ��������
---*  msg: 	��Ϣ����
---@param actor userdata
---@param type number
---@param FColor number
---@param BColor number
---@param Y number
---@param scroll number
---@param msg number
function sendmovemsg(actor,type,FColor,BColor,Y,scroll,msg) end

---�����������Ϣ
---*  actor: ��Ҷ���
---*  type: ��Ҷ���
---*  msg: ��Ҷ���
---@param actor userdata|nil
---@param type number
---@param msg string
function sendmsg(actor,type,msg) end

---����Ļ��������
---*  actor: ��Ҷ���
---*  FColor: ǰ��ɫ
---*  BColor: ����ɫ
---*  msg: ��������
---*  type: ģʽ ���Ͷ��� 0-�Լ� 1-������ 2-�л� 3-��ǰ��ͼ 4-���
---*  time: ��ʾʱ��
---@param actor userdata
---@param FColor number
---@param BColor number
---@param msg string
---@param type number
---@param time number
function sendmsgnew(actor,FColor,BColor,msg,type,time) end

---������Ұ�ڹ㲥��Ϣ
---*  actor:    ��Ҷ���
---*  msgid:    ��ϢID
---*  param1: 	����1
---*  param2: 	����2
---*  param3: 	����3
---*  sMsg: 	��Ϣ��
---@param actor userdata
---@param msgid number
---@param param1? number
---@param param2? number
---@param param3? number
---@param sMsg? string
function sendrefluamsg(actor,msgid,param1,param2,param3,sMsg) end

---���������̶���Ϣ
---*  actor: ��Ҷ���
---*  type: ģʽ ���Ͷ��� 0-�Լ� 1-������ 2-�л� 3-��ǰ��ͼ 4-���
---*  FColor: ǰ��ɫ
---*  BColor: ����ɫ
---*  time: ��ʾʱ��
---*  msg: ��������
---*  showflag: �Ƿ���ʾ�������� 0-�� 1-��
---@param actor userdata
---@param type number
---@param FColor number
---@param BColor number
---@param time number
---@param msg string
---@param showflag number
function sendtopchatboardmsg(actor,type,FColor,BColor,time,msg,showflag) end

---�趨���﹥��ƮѪƮ������
---*  actor: ��Ҷ���
---*  actor: ��ʾ���� ��˵����
---@param actor userdata
---@param type number
function setattackefftype(actor,type) end

---ǿ���޸Ĺ���ģʽ
---*  actor: ��Ҷ���
---*  mode: ����ģʽ
---*  time: ǿ���л�ʱ��ʱ��
---@param actor userdata
---@param mode number
---@param time number
function setattackmode(actor,mode,time) end

---�����ݵ㾭��
---*  actor: ��Ҷ���
---*  evetime: ʱ��
---*  experience: 	����
---*  isSafe: �Ƿ�ȫ��(��0Ϊ�κεط�)
---*  mapid: ��ͼ��(�κε�ͼʹ��*��)
---*  opt: �������Ƿ��ܻ�ȡ����(0=������ 1= ����)
---*  alltime: ʱ��:��(�ݵ��þ����ʱ��)
---*  level: �ȼ�(���ټ����»�þ���)
---@param actor userdata
---@param evetime number
---@param experience number
---@param isSafe number
---@param mapid number
---@param opt number
---@param alltime number
---@param level number
function setautogetexp(actor,evetime,experience,isSafe,mapid,opt,alltime,level) end

---�������ﱳ��������
---*  actor: ��Ҷ���
---*  count: ���Ӵ�С *��С��46 ������126
---@param actor userdata
---@param count number
function setbagcount(actor,count) end

---��������/���������Ϣ
---*  actor: ��Ҷ���
---*  nID: ����(���˵��)
---*  value: ����ֵ
---@param actor userdata
---@param nID number
---@param value number
function setbaseinfo(actor,nID,value) end

---�����ɫ
---*  actor: ��Ҷ���
---*  color: ��ɫ(0~255); 255ʱ�����ɫ; -1��Ϊת�����õ���ɫ�����������Ͻ��б�ɫ
---*  time: �ı�ʱ��(��)
---@param actor userdata
---@param color number
---@param time number
function setbodycolor(actor,color,time) end

---��������ǰ׺
---*  actor: ��Ҷ���
---*  Prefix: ǰ׺��Ϣ �����������ǰ׺
---*  color: ����ɫ
---@param actor userdata
---@param Prefix string
---@param color number
function setchatprefix(actor,Prefix,color) end

---���ñ��ֵ
---*  object: ����������
---*  index: �±�ID 0-9
---*  value: ���ֵ
---@param object userdata
---@param index number
---@param value number
function setcurrent(object,index,value) end

---�����Զ������������
---*  actor: ��Ҷ���
---*  item: װ������
---*  index: װ������������ 0~2
---*  json: ���������� json�ַ���
---@param actor userdata
---@param item userdata
---@param index number
---@param json string
function setcustomitemprogressbar(actor,item,index,json) end

---�޸���Ʒ�־ö�
---*  actor: ��Ҷ���
---*  itemmakeid: ��Ҷ���
---*  char: ��Ҷ���
---*  dura: ��Ҷ���
---@param actor userdata
---@param itemmakeid number
---@param char string
---@param dura number
function setdura(actor,itemmakeid,char,dura) end

---�رյ�ͼ��ʱ��
---*  MapId: ��ͼID
---*  Idx: ��ʱ��ID
---@param MapId number|string
---@param Idx number
function setenvirofftimer(MapId,Idx) end

---�趨��ͼ��ʱ��
---*  MapId: ��ͼID
---*  Idx: ��ʱ��ID
---*  second: ʱ��(��)
---*  func: ������ת�ĺ���
---@param MapId number|string
---@param Idx number
---@param second number
---@param func string
function setenvirontimer(MapId,Idx,second,func) end

---����������/��ʶֵ
---*  actor: ��Ҷ���
---*  nIndex: ���� 0-800
---*  nvalue: ��Ӧ����ֵ
---@param actor userdata
---@param nIndex number
---@param nvalue number
function setflagstatus(actor,nIndex,nvalue) end

---�������GMȨ��ֵ
---*  actor: ��Ҷ���
---*  gmlevel: GMȨ��ֵ
---@param actor userdata
---@param gmlevel number
function setgmlevel(actor,gmlevel) end

---�����л���Ϣ
---*  actor: ��Ҷ���
---*  index: ����   0-�лṫ��
---*  value: ����ֵ
---@param actor userdata
---@param index userdata
---@param value userdata
function setguildinfo(actor,index,value) end

---���л��Զ��������ֵ
---*  guild: ��Ҷ���
---*  varName: ������
---*  value: ����ֵ
---*  isSave: �Ƿ񱣴浽���ݿ�(0/1)
---@param guild userdata
---@param varName string
---@param value number|string
---@param isSave? number
function setguildvar(guild,varName,value,isSave) end

---��������
---*  actor: ��Ҷ���
---*  where: λ�� 0-9
---*  effType: ����Ч��(0ͼƬ���� 1��ЧID)
---*  resName: X���� (Ϊ��ʱĬ��X=0)
---*  x: Y���� (Ϊ��ʱĬ��Y=0)
---*  y: Y���� (Ϊ��ʱĬ��Y=0)
---*  autoDrop: �Զ���ȫ�հ�λ��0,1(0=�� 1=����)
---*  selfSee: �Ƿ�ֻ���Լ�����0=�����˶��ɼ�;1=�����Լ��ɼ�;
---*  posM: ����λ��(����Ĭ��Ϊ0)0=�ڽ�ɫ֮��;1=�ڽ�ɫ֮��;
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

---������Ʒ��¼��Ϣ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  type: [1,2]
---*  position: ��type=1,ȡֵ��Χ[0..49]type=2,ȡֵ��Χ[0..19]
---*  value: ������Ʒ��Ӧλ��ֵ
---@param actor userdata
---@param item userdata
---@param type number
---@param position number
---@param value number
function setitemaddvalue(actor,item,type,position,value) end


---�����Զ�������
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  value: Json�ַ��� �Զ�����������
---@param actor userdata
---@param item userdata
---@param value string
function setitemcustomabil(actor,item,value) end

---������Ʒ��Ч
---*  actor: ��Ҷ���
---*  index: װ��λ�� -1~OK���е���Ʒ
---*  bageffectid: ������Ч���
---*  ineffectid: �ڹ���Ч���
---@param actor userdata
---@param index number
---@param bageffectid number
---@param ineffectid number
function setitemeffect(actor,index,bageffectid,ineffectid) end

---�޸�װ���ڹ�Looksֵ
---*  actor: ��Ҷ���
---*  pos: װ��λ�� (-1ʱ��OK���е�װ��0~16 17~46 55)
---*  char: ������(+ - =)
---*  actor: �ڹ�ͼƬ
---@param actor userdata
---@param pos number
---@param char string
---@param pictrue number
function setitemlooks(actor,pos,char,pictrue) end

---������Ʒ��״̬
---*  item: ��Ʒ����
---*  bind: ������(0-8)
---*  state: ��״̬(0Ϊ����,1Ϊ��)
---@param item userdata
---@param bind userdata
---@param state userdata
function setitemstate(item,bind,state) end

---���Ӽ��ܷ�����
---*  actor: ��Ҷ���
---*  skillname: ��Ҷ���
---*  value: ��Ҷ���
---*  type: ��Ҷ���
---@param actor userdata
---@param skillname userdata
---@param value userdata
---@param type userdata
function setmagicdefpower(actor,skillname,value,type) end

---���Ӽ�������
---*  actor: ��Ҷ���
---*  skillname: ��������
---*  actor: ����ֵ
---*  type: ���㷽ʽ(0����������,1���ٷֱȼ���)
---@param actor userdata
---@param skillname userdata
---@param value userdata
---@param type userdata
function setmagicpower(actor,skillname,value,type) end

---�ѹ������óɱ���
---*  mon: �������
---*  actor: ��Ҷ���
---@param mon userdata
---@param actor userdata
function setmonmaster(mon,actor) end

---���õ�ǰ�����ڹ��ҵ�ְλ��ʽ
---*  actor: ��Ҷ���
---*  jobIdx: ְλ���
---@param actor userdata
---@param jobIdx userdata
function setnationking(actor,jobIdx) end

---�޸Ĺ���ְλ����
---*  actor: ��Ҷ���
---*  nIdx: ����ID (1~100)
---*  jobIdx: ְλ���
---*  jobName: ְλ����
---@param actor userdata
---@param nIdx userdata
---@param jobIdx userdata
---@param jobName userdata
function setnationrank(actor,nIdx,jobIdx,jobName) end

---����װ����Ԫ������
---*  actor: ��Ҷ���
---*  where: װ��λ��-1-OK���е�װ�� 0~55-���ϵ�װ��
---*  iAttr: ��Ҷ���
---*  sFlag: ��Ҷ���
---*  iValue: ��Ҷ���
---@param actor userdata
---@param where userdata
---@param iAttr userdata
---@param sFlag userdata
---@param iValue userdata
function setnewitemvalue(actor,where,iAttr,sFlag,iValue) end

---����NPC��Ч
---*  actor: ��Ҷ���
---*  NPCIndex: NPC���� NPC���ñ��е�ID
---*  Effect: ��ЧID 5055-��̾�� 5056-�ʺ�
---*  X: X����
---*  Y: Y����
---@param actor userdata
---@param NPCIndex userdata
---@param Effect userdata
---@param X userdata
---@param Y userdata
function setnpceffect(actor,NPCIndex,Effect,X,Y) end

---�Ƴ�ȫ�ֶ�ʱ��
---*  id: ��ʱ��ID
---@param id number
function setofftimerex(id) end

---�Ƴ����˶�ʱ��
---*  actor: ��Ҷ���
---*  id: ��ʱ��ID
---@param actor userdata
---@param id number
function setofftimer(actor,id,RunTick,RunTime,kf) end

---��Ӹ��˶�ʱ��
---*  actor: ��Ҷ���
---*  id: ��ʱ��ID
---*  RunTick: ִ�м�� ��
---*  RunTime: ִ�д��� >0ִ����ɺ� �Զ��Ƴ�
---*  kf: ����Ƿ����ִ�� 1:����
---@param actor userdata
---@param id number
---@param RunTick number
---@param RunTime? number
---@param kf? number
function setontimer(actor,id,RunTick,RunTime,kf) end

------���ȫ�ֶ�ʱ��
---*  id: ��ʱ��ID
---*  tick: ִ�м�� ��
---*  count: ִ�д��� Ϊ0ʱ���޴���
---@param id number
---@param tick number
---@param count? number
function setontimerex(id,tick,count) end

---��ȡ���ﵰ�ȼ�
---*  actor: ��Ҷ���
---*  itemmakeid: ��ƷMakeIndex
---*  level: �ȼ�: -1��ʾ���޸�ֵ
---*  zlevel: ת���ȼ�: -1��ʾ���޸�ֵ
---*  exp: ����ֵ: -1��ʾ���޸�ֵ
---@param actor userdata
---@param itemmakeid number
---@param level number
---@param zlevel number
---@param exp number
function setpetegglevel(actor,itemmakeid,level,zlevel,exp) end

---���ó���ģʽ
---*  actor: ��Ҷ���
---*  mode: ����ģʽ:1-����;2-����;3-����(������ʱ���趨Ŀ��);4-��Ϣ
---@param actor userdata
---@param mode number
function setpetmode(actor,mode) end

---������ұ���
---*  actor: ��Ҷ���
---*  varName: ������
---*  varValue: ����ֵ
---@param actor userdata
---@param varName string
---@param varValue string|number
function setplaydef(actor,varName,varValue) end

---�����л��Ա���л��е�ְλ;
---*  actor: ��Ҷ���
---*  pos: ���л��е�ְλ 0:�᳤;1:���᳤;2:�л��Ա1;3:�л��Ա2;4:�л��Ա3;
---@param actor userdata
---@param pos number
function setplayguildlevel(actor,pos) end

---������Զ��������ֵ
---*  actor: ��Ҷ���
---*  varType: ������Χ(HUMAN/GUILD)
---*  varName: ������
---*  varValue: ����ֵ
---*  isSave: �Ƿ񱣴浽���ݿ�(0/1)
---@param actor userdata
---@param varType string
---@param varName string
---@param varValue string|number
---@param isSave? number
function setplayvar(actor,varType,varName,varValue,isSave) end

---��ʾ����ĳƺ�
---*  actor: ��Ҷ���
---*  levelname: �ƺ��ı�: ������һ����ʾ
---@param actor userdata
---@param levelname string
function setranklevelname(actor,levelname) end

---���ټ���CD��ȴʱ��
---*  actor: ��Ҷ���
---*  skillname: ��������
---*  char: ������(+/-/=)=0���ǻ�ԭ����CD
---*  time: ʱ�� ��
---@param actor userdata
---@param skillname string
---@param char string
---@param time number
function setskilldeccd(actor,skillname,char,time) end

---���ü��ܵȼ�
---*  actor: ��Ҷ���
---*  skillid: ����ID
---*  flag: ����: 1-���ܵȼ� 2-ǿ���ȼ� 3-������
---*  point: ����ֵ
---@param actor userdata
---@param skillid number
---@param flag number
---@param point number
function setskillinfo(actor,skillid,flag,point) end

---��/�����κ�
---*  actor: ��Ҷ���
---*  bState: 0:�ر�: 1:����
---@param actor userdata
---@param bState number
function setsndaitembox(actor,bState) end

---���������˺�����
---*  actor: ��Ҷ���
---*  operate: �������� "+"���� "-"���� "="����
---*  sum: ��������
---*  rate: ���ձ���ǧ�ֱ� 1=0.1%100=10%
---*  success: ���ճɹ���
---@param actor userdata
---@param operate string
---@param sum number
---@param rate number
---@param success number
function setsuckdamage(actor,operate,sum,rate,success) end

---����ȫ�ֱ���
---*  varName: ������
---*  varValue: ����ֵ
---@param varName string
---@param varValue string|number
function setsysvar(varName,varValue) end

---��ȫ���Զ��������ֵ
---*  varName: ������
---*  varValue: ����ֵ
---*  isSave: �Ƿ񱣴�(0/1)
---@param varName string
---@param varValue string|number
---@param isSave number
function setsysvarex(varName,varValue,isSave) end

---���õ�ǰ����Ŀ��
---*  Hiter: ������(���/Ӣ��/����)
---*  Target: ��������(���/Ӣ��/����)
---@param Hiter userdata
---@param Target userdata
function settargetcert(Hiter,Target) end

---������Ʒ��Դ
---*  jsonStr: ��Ҷ���
---@param jsonStr string
function setthrowitemly(jsonStr) end

---������Ʒ��Դ(ʹ����Ʒ����)
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  jsonStr: json�ַ���
---@param actor userdata
---@param item userdata
---@param jsonStr string
function setthrowitemly2(actor,item,jsonStr) end

---����������������
---*  actor: ��Ҷ���
---*  nIndex: ���� ��˵����
---*  nvalue: ��Ӧ����ֵ
---@param actor userdata
---@param nIndex number
---@param nvalue number
function setusebonuspoint(actor,nIndex,nvalue) end

---�ɼ��ڿ�Ƚ���������
---*  actor: ��Ҷ���
---*  time: ������ʱ�� ��
---*  succ: �ɹ�����ת�ĺ���
---*  msg: ��ʾ��Ϣ
---*  canstop: �ܷ��ж� 0-�����ж� 1-�����ж�
---*  fail: �жϴ����ĺ���
---@param actor userdata
---@param time userdata
---@param succ userdata
---@param msg userdata
---@param canstop userdata
---@param fail userdata
function showprogressbardlg(actor,time,succ,msg,canstop,fail) end

---װ����Ƕ��ʯ
---*  actor: ��Ҷ���
---*  item: װ������
---*  hole: װ��������� 0~9
---*  index: ��Ƕ��ʯ��index װ�����ܵ�Index
---@param actor userdata
---@param item userdata
---@param hole number
---@param index number
function socketableitem(actor,item,hole,index) end

---�Զ����������
---*  varName: ��Ҷ���
---*  playflag: 0-������� 1-������� 2-�л�
---*  sortflag: 0-���� 1-����
---*  count: ��ȡ�������� Ϊ�ջ�0ȡ���� ȡǰ����
---@param varName userdata
---@param playflag userdata
---@param sortflag userdata
---@param count userdata
function sorthumvar(varName,playflag,sortflag,count) end

---�����Զ��һ�
---*  actor: ��Ҷ���
---@param actor userdata
function startautoattack(actor) end

---ִֹͣ��
---*  actor: ��Ҷ���
---@param actor userdata
function stop(actor) end

---ֹͣ�Զ��һ�
---*  actor: ��Ҷ���
---@param actor userdata
function stopautoattack(actor) end

---ֹͣʰȡ
---*  actor: ��Ҷ���
---@param actor userdata
function stoppickupitems(actor) end

---�����������
---*  itype: �������� 1=ȫ��G���� 2=ȫ��A���� 3=ȫ���Զ������ 4=�л����
---*  astr: ���ȫ�ֱ���
---*  bstr: ���뱾��ȫ�ֱ���
---*  id: ��Ϣid
---@param itype number
---@param astr string
---@param bstr string
---@param id number
function synzvar(itype,astr,bstr,id) end

---����OK����Ʒ
---*  actor: ��Ҷ���
---*  count: ���� (��Ե�����Ʒ��Ч)
---@param actor userdata
---@param count number
function takedlgitem(actor,count) end

---����Ʒ
---*  actor: ��Ҷ���
---*  itemname: ��Ʒ����
---*  qty: ����
---*  IgnoreJP: ���Լ�Ʒ0 ���ж��۳�1 ��Ʒ���۳�
---@param actor userdata
---@param itemname string
---@param qty number
---@param IgnoreJP number
function takeitem(actor,itemname,qty,IgnoreJP) return boolean end

---����װ��
---*  actor: ��Ҷ���
---*  where: λ��
---*  makeindex: ��ƷΨһID
---@param actor userdata
---@param where number
---@param makeindex number
function takeoffitem(actor,where,makeindex) end

---����װ��
---*  actor: ��Ҷ���
---*  where: λ��
---*  makeindex: ��ƷΨһID
---@param actor userdata
---@param where number
---@param makeindex number
function takeonitem(actor,where,makeindex) end

---�����ö���ʾ
---*  actor: ��Ҷ���
---*  nId: ����ID
---@param actor userdata
---@param nId number
function tasktopshow(actor,nId) end

---���ת�����ַ���
---*  tbl: ��Ҷ���
---@param tbl table
function tbl2json(tbl) end

---�޳����߹һ���ɫ
---*  mapID: ��ͼ�� ��*����ʾȫ����ͼ
---*  level: �޳��ȼ� ���ڴ˵ȼ����޳���*����ʾ����
---*  count: ����޳������ ��*����ʾ����
---@param mapID string|number
---@param level string|number
---@param count string|number
function tdummy(mapID,level,count) end

---������Ҵ��˴���
---*  actor: ��Ҷ���
---*  type: ģʽ 0-�ָ�Ĭ�� 1-���� 2-���� 3-���˴���
---*  time: ʱ��(��)
---*  objtype: ����  0-��� 1-����
---@param actor userdata
---@param type userdata
---@param time userdata
---@param objtype userdata
function throughhum(actor,type,time,objtype) end

---�ڵ�ͼ�Ϸ�����Ʒ
---*  actor: ��Ҷ���
---*  MapId: 	��ͼID
---*  X: ����X
---*  Y: ����Y
---*  range: ��Χ
---*  itemName: ��Ʒ��
---*  count: ����
---*  time: ʱ��(��)
---*  hint: true-������ʾ
---*  take: true-����ʰȡ
---*  onlyself: true-���Լ�ʰȡ
---*  xyinorder: true-��λ��˳�� false-���λ��
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

---�ջ�Ӣ��
---*  actor: ��Ҷ���
---@param actor userdata
function unrecallhero(actor) end

---�����ջصĳ������
---*  actor: ��Ҷ���
---*  idx: �������
---@param actor userdata
---@param idx userdata
function unrecallpet(actor,idx) end

---������װ��������Ч
---*  actor: ��Ҷ���
---*  effectid: ��ЧID  0-ɾ����Ч
---*  position: ��ʾλ�� 0-ǰ�� 1-����
---@param actor userdata
---@param effectid number
---@param position number
function updateequipeffect(actor,effectid,position) end

---�鿴���������Ϣ
---*  actor: ��Ҷ���
---*  userid: ������ҵ�UserID
---*  winID: ���ID 101-װ�� 106-�ƺ� 1011-ʱװ
---@param actor userdata
---@param userid userdata
---@param winID userdata
function viewplayer(actor,userid,winID) end

---д��Ini�ļ��е��ֶ�ֵ
---*  filename: �ļ���
---*  section: ��������
---*  item: ������
---*  value: ������ֵ
---@param filename userdata
---@param section userdata
---@param item userdata
---@param value userdata
function writeini(filename,section,item,value) end

---д��Ini�ļ��е��ֶ�ֵ ��Cache
---*  filename: �ļ���
---*  section: ��������
---*  item: ������
---*  value: ������ֵ
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

---��ȡ��̬��ͼ����
---*  actor: ��Ҷ���
---*  mapID: ��ͼID
---@param actor userdata
---@param mapID string|number
function getmapgate(actor,mapID) end

---�������ƻ�ȡ��ͼ������Ϣ
---*  mapname: ��ͼ����
---*  nIndex: 0:��ͼ�� 1:��ͼ��
---@param mapname userdata
---@param nIndex number
function getmapinfo(mapname,nIndex) end

---��ȡ��ͼָ����Χ�ڵĹ�������б�
---*  mapID: ��ͼID
---*  monName: ��ͼ����
---*  nIndex: ������ Ϊ�� or * Ϊ������й�
---*  nx: ����X
---*  ny: ����Y
---*  nRange: ��Χ
---@param mapID string|number
---@param monName userdata
---@param nx number
---@param ny number
---@param nRange number
function getmapmon(mapID,monName,nx,ny,nRange) end

---���ݵ�ͼid���ص�ͼ��
---*  mapID: ��ͼID
---@param mapID string|number
function getmapname(mapID) end

---���ع��������Ϣ
---*  monidx: ����idx
---*  id: idȡֵ:1-��������;2-����������ɫ;3-ɱ�������õľ���ֵ;
---@param monidx userdata
---@param id userdata
function getmonbaseinfo(monidx,id) end

---����UserId���ع������
---*  mapID: ��ͼID
---*  monUserId: ����userid
---@param mapID string|number
---@param monUserId string
function getmonbyuserid(mapID,monUserId) end

---��ȡָ����ͼ��������
---*  mapID: ��ͼID
---*  MonId: ����idx
---*  isAllMon: �Ƿ���Ա���
---@param mapID string|number
---@param MonId number
---@param isAllMon boolean
function getmoncount(mapID,MonId,isAllMon) end

---��ȡ����λ�ü�����ʱ�䣨��֧��С��ͼ����ʾ�Ĺ��
---*  mapID: ��ͼID
---@param mapID string|number
function getmonrefresh(mapID) end

---��ȡ������ڵ��л����
---*  actor: ��Ҷ���
---@param actor userdata
function getmyguild(actor) end

---��ȡ��Ʒ�ĸ�������
---*  item: ��Ҷ���
---*  value: Ԫ������ ��˵����
---@param item userdata
---@param value number
function getnewitemaddvalue(item,value) end

---����ID��ȡNPC����
---*  npcIdx: NPC���ڵ�idx
---@param npcIdx number
function getnpcbyindex(npcIdx) end

---��ȡNPC�����Idx
---*  npc: npc����
---@param npc userdata
function getnpcindex(npc) end

---��ȡ��ͼ��ָ����Χ�ڵĶ���
---*  mapID: ��ͼID
---*  X: ����X
---*  Y: ����Y
---*  range: ��Χ
---*  flag: ���ֵ ������λ��ʾ 1-��� 2-����4-NPC 8-��Ʒ16-��ͼ�¼�
---@param mapID string|number
---@param X number
---@param Y number
---@param range number
---@param flag number
function getobjectinmap(mapID,X,Y,range,flag) end

---��ȡ�������������
---*  actor: ��Ҷ���
---@param actor userdata
function getoppositeobj(actor) end

---��ȡ����
---*  actor: ��Ҷ���
---*  idx: ������Ż�""X"��ʾ��ǰ����
---@param actor userdata
---@param idx number
function getpet(actor,idx) end

---��ȡ��������װ���б�
---*  idx: �������
---@param actor userdata
---@param idx number
function getpetbodyitem(actor,idx) end

---��ȡ���ﵰ��Ϣ
---*  actor: ��Ҷ���
---*  itemmakeid: ��ƷMakeIndex
---*  type: ��Ҫ���ص���ֵ1-ת���ȼ�;2-�ȼ�;3-����;0-ͬʱ��������ֵ
---@param actor userdata
---@param itemmakeid number
---@param type number
function getpetegglevel(actor,itemmakeid,type) end

---��ȡ���pk�ȼ�
---*  actor: ��Ҷ���
---@param actor userdata
function getpklevel(actor) end

---��ȡ��ǰNPC����
---*  actor: ��Ҷ���
---@param actor userdata
function getcurrnpc(actor) end

---��ȡ�Զ������������
---*  actor: ��Ҷ���
---*  item: װ������
---*  actor: װ������������ 0~2
---@param actor userdata
---@param item userdata
---@param index number
function getcustomitemprogressbar(actor,item,index) end

---��ȡװ����������
---*  actor: ��Ҷ���
---*  item: װ������
---@param actor userdata
---@param item userdata
function getdrillhole(actor) end


---��ȡEnvir�ļ������ļ��б�
function getenvirfilelist() end

---��ȡ������/��ʶֵ
---*  actor: �������
---*  index:  ���� 0-800
---@param actor userdata
---@param index number
function getflagstatus(actor,index) end

---��ȡ��Һ����б�
---*  actor: ��Ҷ���
---@param actor userdata
function getfriendnamelist(actor) end

---ȡ�ַ�����csv����е��к�
function getgjcsv() end

---��ȡ���GMȨ��ֵ
---*  actor: ��Ҷ���
---@param actor userdata
function getgmlevel(actor) end

---��ȡ��Ա�б�
---*  actor: ��Ҷ���
---@param actor userdata
function getgroupmember(actor) end

---��ȡ�л���Ϣ
---*  actor: ��Ҷ���
---@param actor userdata
function getguildinfo(actor) end

---��ȡ���������л��Ա����
---*  actor: ��Ҷ���
---@param actor userdata
function getguildmembercount(actor) end

---��ȡ�л��Զ������
---*  guild: �л����
---*  index: ���� 0-�л�ID1-�л�����2-�лṫ��3-�л��Ա����������table��4-�л�����������
---@param guild userdata
---@param index userdata
function getguildvar(guild,index) end

---��ȡӢ�۶���
---*  actor: ��Ҷ���
---@param actor userdata
function gethero(actor) end

---��ȡ��ǰ�������������ͻ�ȡ����������
---*  filename: �ļ���
---*  type: ��ȡĿ�꣺0-���� 1-����
---@param filename string
---@param type number
function gethlcsv(filename,type) end

---��ȡ��������
---*  actor: ��Ҷ���
---*  actor: ����ID��1-20��
---@param actor userdata
---@param id number
function gethumability(actor,id) end

---��ȡ������ʱ����
---*  actor: ��Ҷ���
---*  nWhere: λ�� ��Ӧcfg_att_score ����ID
---@param actor userdata
---@param nWhere userdata
function gethumnewvalue(actor,nWhere) end

---��ȡ��Ʒ��¼��Ϣ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  type: [1,2,3]
---*  position: ��type=1,ȡֵ��Χ[0..49] type=2,ȡֵ��Χ[0..19]
---@param actor userdata
---@param item userdata
---@param type number
---@param position number
function getitemaddvalue(actor,item,type,position) end

---������ƷΨһID�����Ʒ����
---*  actor: ��Ҷ���
---*  makeindex: ��ƷΨһID
---@param actor userdata
---@param makeindex number
function getitembymakeindex(actor,makeindex) end

---��ȡ�Զ�������
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---@param actor userdata
---@param item userdata
function getitemcustomabil(actor,item) end

---��ȡ��Ʒ��Ϣ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  id: 1:ΨһID2:��ƷID3:ʣ��־�4:���־�5:��������6:��״̬
---@param actor userdata
---@param item userdata
---@param id number
---@return any
function getiteminfo(actor,item,id) end

---�����������ر�����Ʒ��Ϣ
---*  actor: ��Ҷ���
---*  index: ������,0��ʼ
---@param actor userdata
---@param index number
function getiteminfobyindex(actor,index) end

---�������
---*  actor: ��Ҷ���
---*  distance: �������������
---*  grade: �ܳ���Ӱ��Ĺ���ȼ�����
---@param actor userdata
---@param distance number
---@param grade number
function dotaunt(actor,distance,grade) end

---װ������
---*  actor: ��Ҷ���
---*  item: װ������
---*  holejson: ������� json�ַ��� ֧��0~9��10����
---@param actor userdata
---@param item userdata
---@param holejson string
function drillhole(actor,item,holejson) end

---ʹ����Ʒ����ҩ��ʹ��������Ʒ�ȣ�
---*  actor: ��Ҷ���
---*  itemname: ��Ʒ����
---*  count: ��Ҷ���
---@param actor userdata
---@param itemname string
---@param count number
function eatitem(actor,itemname,count) end

---���дʻ���
---*  str: Ҫ�����ı�
---@param str string
function exisitssensitiveword(str) end

---����ȫ����ʾ��Ϣ
---*  actor: ��Ҷ���
---*  flag: �Ƿ����0-������1-����
---@param actor userdata
---@param flag userdata
function filterglobalmsg(actor,flag) end

---�����л�
---*  index: �����ؼ��� 0-�л�ID 1-�л�����
---*  key: 	�����ؼ���
---@param index number
---@param key string
function findguild(index,key) end

---�����������
---*  actor: ��Ҷ���
---*  idx: 	�������
---*  attrName: ��ն�Ӧ�����������;nil�������������
---@param actor userdata
---@param idx number
---@param attrName? number
function delpetattlist(actor,idx,attrName) end

---ɾ�����﹥������
---*  actor: ��Ҷ���
---*  idx: ������Ż�"X"��ʾ��ǰ����
---*  skillid: ���ӵĹ�������ID Ϊcfg_monattack���е�ID
---@param actor userdata
---@param idx number
---@param skillid number
function delpetskill(actor,idx,skillid) end

---�ڳ��Զ�Ѱ·��ָ������
---*  actor: ��Ҷ���
---*  aimX: Ŀ��X����
---*  aimY: Ŀ��Y����
---*  range: �������ڳ��������Զ�Ѱ·ȡֵ��Χ 0-120-�����
---@param actor userdata
---@param aimX number
---@param aimY number
---@param range number
function dartmap(actor,aimX,aimY,range) end

---�������� �ڳ��������
---*  actor: ��Ҷ���
---*  time: �ڳ����ʱ�� ��
---*  isdie: �����Ƿ���ʧ0-��ʧ 1-ʱ�䵽����ʧ
---@param actor userdata
---@param time number
---@param isdie number
function darttime(actor,time,isdie) end


---��ʱ��ת
---*  actor: ��Ҷ���
---*  time: ʱ��(����)
---*  func: ��������
---*  del: ����ͼ�Ƿ�ɾ������ʱ 0��Ϊ��ʱ=��ɾ�� 1=ɾ��
---@param actor userdata
---@param time number
---@param func string
---@param del? number
function delaygoto(actor,time,func,del) end

---��ʱ��Ϣ��ת
---*  actor: ��Ҷ���
---*  time: ʱ��(����)
---*  func: ��������
---@param actor userdata
---@param time number
---@param func string
function delaymsggoto(actor,time,func) end

---ɾ��buff
---*  actor: ��Ҷ���
---*  buffid: buffID
---@param actor userdata
---@param buffid number
function delbuff(actor,buffid) end

---ɾ������
---*  actor: ��Ҷ���
---*  id: ��Ҷ���
---@param actor userdata
---@param id number
function delbutshow(actor,id) end

---ɾ���Զ��尴ť
---*  actor: ��Ҷ���
---*  windowid: ������ID
---*  buttonid: ��ťID
---@param actor userdata
---@param windowid number
---@param buttonid number
function delbutton(actor,windowid,buttonid) end

---�ر���Ļ��Ч
---*  actor: ��Ҷ���
---*  id: ��������Ч���
---*  type: ����ģʽ 0-�Լ� 1-������
---@param actor userdata
---@param id number
---@param type number
function deleffects(actor,id,type) end

---ɾ����Ա
---*  actor: ��Ҷ���
---*  memberId: ��ԱUserId
---@param actor userdata
---@param memberId string
function delgroupmember(actor,memberId) end

---��ӳƺ�
---*  actor: ��Ҷ���
---*  name: �ƺ���Ʒ����
---*  use: �������� 1����
---@param actor userdata
---@param name string
---@param use number
function confertitle(actor,name,use) end

---�۳�����ͨ�û�������(��������μ���)
---*  actor: ��Ҷ���
---*  moneyname: ��������
---*  actor: ��Ӧ����ֵ
---@param actor userdata
---@param moneyname string
---@param count number
function consumebindmoney(actor,moneyname,count) end

---��������
---*  actor: ��Ҷ���
---@param actor userdata
function creategroup(actor) end

---����Ӣ��
---*  actor: ��Ҷ���
---*  name: Ӣ������
---*  job: 	ְҵ
---*  sex: �Ա�
---@param actor userdata
---@param name string
---@param job number
---@param sex number
function createhero(actor,name,job,sex) end

---��������
---*  actor: ��Ҷ���
---*  nIdx: ����ID (1~100)
---*  maxNum: ��������
---@param actor userdata
---@param nIdx number
---@param maxNum number
function createnation(actor,nIdx,maxNum) end

---������ʱNPC
---*  actor: ��Ҷ���
---*  X: X����
---*  Y: Y����
---*  npcJosn: NPC��Ϣ json�ַ���
---@param actor userdata
---@param X number
---@param Y number
---@param npcJosn string
function createnpc(actor,X,Y,npcJosn) end

---�ٻ�����(������ﵰ)
---*  actor: ��Ҷ���
---*  monname: �Զ����������
---*  level: ����ȼ�
---@param actor userdata
---@param monname userdata
---@param level userdata
function createpet(actor,monname,level) end

---�޸�������ʱ���ԣ�����Ч�ڣ�
---*  actor: ��Ҷ���
---*  nWhere: λ�� ��Ӧcfg_att_score ����ID
---*  nValue: ��Ӧ����ֵ
---*  nTime: ��Чʱ�� ��
---@param actor userdata
---@param nWhere userdata
---@param nValue userdata
---@param nTime userdata
function changehumnewvalue(actor,nWhere,nValue,nTime) end

---����ƷΨһIDת���ɵ��߱����Ӧ��IDX��Ʒ
---*  actor: ��Ҷ���
---*  itemmakeid: ΨһID
---*  itemidx: 	����ID
---@param actor userdata
---@param itemmakeid number
---@param itemidx number
function changeitemidx(actor,itemmakeid,itemidx) end

---��������������Ʒװ��������ɫ
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  color: ��ɫ(0-255)��ɫ=0ʱ�ָ�Ĭ����ɫ
---@param actor userdata
---@param item userdata
---@param color userdata
function changeitemnamecolor(actor,item,color) end

---�޸��������·����
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  looks: ���ֵ
---@param actor userdata
---@param item userdata
---@param looks number
function changeitemshape(actor,item,looks) end

---��������ȼ�
---*  actor: ��Ҷ���
---*  opt: ������ + - =
---*  count: ����
---@param actor userdata
---@param opt string
---@param count number
function changelevel(actor,opt,count) end

---�޸ı�������ֵ
---*  actor: ��Ҷ���
---*  mob: 	��������
---*  attr: ����λ��
---*  method: ������(+ - =)
---*  value: ����ֵ
---*  time: ��Чʱ��
---@param actor userdata
---@param mob userdata
---@param attr number
---@param method string
---@param value number
---@param time number
function changemobability(actor,mob,attr,method,value,time) end

---�ı�����ģʽ
---*  actor: ��Ҷ���
---*  mode: ģʽ1~24
---*  time: ʱ��(��)
---*  param1: ����1,12-13 18 20 21������ �����������ֵ
---*  param2: ����2 ��������ֵ
---@param actor userdata
---@param mode number
---@param time number
---@param param1 number
---@param param2 number
function changemode(actor,mode,time,param1,param2) end

---�����������
---*  actor: ��Ҷ���
---*  id: ����ID 1-100
---*  opt: 	������ + - =
---*  count: ����
---*  msg: ��ע����
---*  send: �Ƿ����͵��ͻ���
---@param actor userdata
---@param id number
---@param opt string
---@param count number
---@param msg string
---@param send boolean
function changemoney(actor,id,opt,count,msg,send) end

---�޸ı�������
---*  mon: ��������
---*  name: ��������
---@param mon userdata
---@param name string
function changemonname(mon,name) end

---�޸�����������ɫ
---*  actor: ��Ҷ���
---*  color: ��ɫ����
---@param actor userdata
---@param color number
function changenamecolor(actor,color) end

---�޸ı����ȼ�
---*  actor: ��Ҷ���
---*  mon: ��������
---*  opt: ������ + - =
---*  nLevel:�ȼ�
---@param actor userdata
---@param mon userdata
---@param opt string
---@param nLevel number
function changeslavelevel(actor,mon,opt,nLevel) end

---�ı�����ٶ�
---*  actor: ��Ҷ���
---*  type: �ٶ����� 1-�ƶ��ٶ�2-�����ٶ�3-ʩ���ٶ�
---*  level: �ٶȵȼ� -10~100-ԭʼ�ٶȣ�-1ʱ��������10%+1ʱ��������10%
---@param actor userdata
---@param type number
---@param level number
function changespeed(actor,type,level) end

---�½����ֿ����
---*  actor: ��Ҷ���
---*  nCount: �½����ĸ�����
---@param actor userdata
---@param nCount number
function changestorage(actor,nCount) end

---�������Ƿ񴴽�
---*  nIdx: ����ID
---@param nIdx number
function checkation(nIdx) end

---����Ӣ������
---*  actor: ��Ҷ���
---*  name: 	Ӣ������
---@param actor userdata
---@param name userdata
function checkheroname(actor,name) end

---��� ��/���� ״̬
---*  objcfg: ���/���� ����
---*  type: ���� ��˵����
---@param objcfg userdata
---@param type number
function checkhumanstate(objcfg,type) end

---��⵱ǰ�����Ƿ��ڿ���ĵ�ͼ
---*  actor: ��Ҷ���
---@param actor userdata
function checkkuafu(actor) end

---����������Ƿ���������
function checkkuafuconnect() end

---��⵱ǰ�������Ƿ�Ϊ���������
function checkkuafuserver() end

---��⾵���ͼ�Ƿ����
---*  MapId: ��ͼID
---@param MapId string|number
function checkmirrormap(MapId) end

---���������
---*  actor: ��Ҷ���
---*  nIdx: ���ұ�� 0~100 0����û�м������
---@param actor userdata
---@param nIdx number
function checknational(actor,nIdx) end

---��������������
---*  actor: ��Ҷ���
---*  sFlag: �ȽϷ� =<>
---*  iValue: 	����
---@param actor userdata
---@param sFlag string
---@param iValue number
function checknationhumcount(actor,sFlag,iValue) end

---���װ����Ԫ������
---*  actor: ��Ҷ���
---*  where: װ��λ�ã�-1-OK���е�װ�� 0~55-���ϵ�װ��
---*  iAttr: ����
---*  sFlag: �ȽϷ�=<>
---*  iValue: ��ֵ(1-100)���ٷֱ�
---@param actor userdata
---@param where number
---@param iAttr number
---@param sFlag string
---@param iValue number
function checknewitemvalue(actor,where,iAttr,sFlag,iValue) end

---�Ƿ�������
---*  actor: ��Ҷ���
---@param actor userdata
function checkonhorse(actor) end

---��ⷶΧ�ڹ�������
---*  actor: ��Ҷ���
---*  monName: ��������Ϊ�� or * Ϊ������й�
---*  nx: ����X
---*  ny: ����Y
---*  nRange: ��Χ
---@param actor userdata
---@param monName string
---@param nx number
---@param ny number
---@param nRange number
function checkrangemoncount(actor,monName,nx,ny,nRange) end

---���ʰȡС����
---*  actor: ��Ҷ���
---*  monName: ��������,Ϊ�� ����ȫ��
---@param actor userdata
---@param monName string
function checkspritelevel(actor,monName) end

---�������ƺ�
---*  actor: ��Ҷ���
---*  title: �ƺ�
---@param actor userdata
---@param title string
function checktitle(actor,title) end

---ɾ���ӳ�
---*  actor: ��Ҷ���
---@param actor userdata
function cleardelaygoto(actor) end

---�����Զ���ȫ�ֱ���
---*  varName: ������, * -���б���
---@param varName string
function clearglobalcustvar(varName) end

---�����Զ����л����
---*  guild: �л�����,* -�����л�
---*  varName: ������,* -���б���
---@param actor string
---@param varName string
function clearguildcustvar(actor,varName) end

---��������Զ������
---*  actor: Ҫ������������ ���� * ��ʾ�����������
---*  varName: ������,* -���б���
---@param actor userdata|string
---@param varName string
function clearhumcustvar(actor,varName) end

---������Ʒ�Զ�������
---*  actor: ��Ҷ���
---*  item: ��Ʒ����
---*  group: ���-1 ������ 0~5��Ӧ���
---@param actor userdata
---@param item userdata
---@param group number
function clearitemcustomabil(actor,item,group) end

---�����ͼ��ָ�����ֵ���Ʒ
---*  MapId: ��Ҷ���
---*  X: X����
---*  Y: Y����
---*  range: ��Χ
---*  itemName: ��Ʒ��
---@param MapId string|number
---@param X number
---@param Y number
---@param range number
---@param itemName string
function clearitemmap(MapId,X,Y,range,itemName) end

---ˢ��
---*  mapid: ��Ҷ���
---*  X: X����
---*  Y: Y����
---*  monname: ��������
---*  range: ��Χ
---*  count: ����
---*  color: ��ɫ(0~255)
---@param mapid userdata
---@param X number
---@param Y number
---@param monname string
---@param range number
---@param count number
---@param color number
function genmon(mapid,X,Y,monname,range,count,color) end