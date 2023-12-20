---@class NpcEasyApp 简单功能
local NpcEasyApp = {}

function NpcEasyApp.recover(player)
    local myHp, myMaxHp = lualib:Hp(player), lualib:Hp(player, 1)
    local myMp, myMaxMp = lualib:Mp(player), lualib:Mp(player, 1)
    if myHp == myMaxHp and myMp == myMaxMp then
        Message:Msg9(player, "你这不是病，是心病，我可医不了！")
        return
    end
    if myHp ~= myMaxHp then
        lualib:SetHpEx(player, "=", 100)
    end
    if myMp ~= myMaxMp then
        lualib:SetMpEx(player, "=", 100)
    end
    Message:Msg9(player, "以全新的姿态投入战斗吧，披荆斩棘，无所畏惧！！")
end

-- npc点击触发
function NpcEasyApp.onClickNpc(player, npcId, npcName)
    if npcId == 20 then
        NpcEasyApp.recover(player)
        return
    elseif npcName == "简单功能2" then
    end
end

-- 登录触发
--function NpcEasyApp.onLogin(player)
--end

--GameEvent.add(EventCfg.onLogin, NpcEasyApp.onLogin, NpcEasyApp)
GameEvent.add(EventCfg.onClickNpc, NpcEasyApp.onClickNpc, NpcEasyApp)

return NpcEasyApp
