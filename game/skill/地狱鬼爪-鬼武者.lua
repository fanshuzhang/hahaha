---@class dygzqhSkill ������צǿ��
local gwzSkill = {}
--ÿ10��ִ��--������
function ontimer104(player)
    if lualib:GetVar(player, EventCfg["��ɫְҵ"]) ~= 2 then --�Ƿ������ְҵ
        setofftimer(player, 104)
        return
    end
    if Magic.ClawCount(player) < 1 then
        setofftimer(player, 104)
        return
    end
    local time = 2
    if Magic.ClawCount(player) >= 2 then
        time = 6
    end
    lualib:ChangeMode(player, 2, time)
    Message:SendClawmsg(player, "������צ:�����������")
end

function gwzSkill.onChangeClawLevel(player, Job, Level, qhLevel)

end

--��װ��
function gwzSkill.onTakeOnEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 and Magic.ClawCount(player) >= 1 then
            setofftimer(player, 104)
            setontimer(player, 104, 10)
            return
        end
    end
end

--��װ��
function gwzSkill.onTakeOffEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 2 then
            setofftimer(player, 104)
            return
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onTakeOnEx, gwzSkill.onTakeOnEx, gwzSkill)  --��װ��
GameEvent.add(EventCfg.onTakeOnEx, gwzSkill.onTakeOffEx, gwzSkill) --��װ��
GameEvent.add(EventCfg.onChangeClawLevel, gwzSkill.onChangeClawLevel, gwzSkill)
return gwzSkill
