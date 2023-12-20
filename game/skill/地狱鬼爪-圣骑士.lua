---@class sqsSkill ������צ-ʥ��ʿ
local sqsSkill = {}
--ʥ��ʿ�ȼ��ı�
function sqsSkill.onChangeClawLevel(player, Job, Level, qhLevel)

end

function ontimer105(player)
    if lualib:GetVar(player, VarCfg["��ɫְҵ"]) ~= 3 then --�Ƿ�ʥ��ʿְҵ
        setofftimer(player, 105)
        return
    end
    if Magic.ClawCount(player) < 1 then
        setofftimer(player, 105)
        return
    end
    local range, effectID = 1, 53411
    if Magic.ClawCount(player) >= 3 then
        range = 3
        effectID = 53403
    end
    lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), range, lualib:GetBaseInfo(player, 20), 0, 0, 0, 0)
    playeffect(player, effectID, 0, 0, 1, 0, 0)
    -- Message:SendClawmsg(player,"������צ:�˺������ĵ���")
end

--��װ��
function sqsSkill.onTakeOnEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 3 then
            local level = Magic.ClawCount(player)
            if level >= 1 then
                setofftimer(player, 105)
                setontimer(player, 105, 2)
            end
        end
    end
end

--��װ��
function sqsSkill.onTakeOffEx(player, item, itemName, where)
    if where == 16 and NpcHellishGhostClawCfg.equipIndex[itemName] then
        if lualib:GetVar(player, VarCfg["��ɫְҵ"]) == 3 then
            setofftimer(player, 105)
            return
        end
    end
end

--��Ϸ�¼�
GameEvent.add(EventCfg.onTakeOnEx, sqsSkill.onTakeOnEx, sqsSkill)  --��װ��
GameEvent.add(EventCfg.onTakeOnEx, sqsSkill.onTakeOffEx, sqsSkill) --��װ��
GameEvent.add(EventCfg.onChangeClawLevel, sqsSkill.onChangeClawLevel, sqsSkill)
return sqsSkill
