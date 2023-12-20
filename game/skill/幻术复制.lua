---@class hsfzSkill 幻术复制
local hsfzSkill = {}
hsfzSkill.numCfg = {
    [0] = 1,
    [1] = 2,
    [2] = 2,
    [3] = 3,
    [4] = 3,
    [5] = 3,
    [6] = 4,
    [7] = 4,
    [8] = 4,
    [9] = 5,
}

function hsfzSkill.onBeginmagic(player, maigicID, maigicName, targetObject, x, y, mapID)
    if maigicName == "幻术复制" then
        local level = Magic.BBcountEX(player, SkillIDCfg["幻术复制"])
        if not level then
            return
        end
        local monAttNum = getbaseinfo(targetObject, 20)
        local selfAttNum = getbaseinfo(player, 24)
        if monAttNum - (selfAttNum + 50 * level) > 50 then
            Message:Msg9(player, "此怪物太过强大，无法复制！")
            return
        end
        local num = Magic.BBcountEX(player, SkillIDCfg["无限复制"])
        if num then
            num = hsfzSkill.numCfg[num]
        else
            num = 1
        end
        if lualib:GetInt(player, "幻术复制") >= num then
            Message:Msg9(player, "可复制的怪物数量已达上限！")
            return
        end
        local BBItem = recallmob(player, getbaseinfo(targetObject, 1, 1), 7, 1440, 1)
        --地狱鬼爪强化
        if lualib:GetVar(player, VarCfg["角色职业"]) == 9 then
            local ClawCount = Magic.ClawCount(player)
            if ClawCount >= 1 then
                local qhatt = 0.25
                if ClawCount >= 2 then qhatt = 0.45 end
                if ClawCount >= 3 then qhatt = 1 end
                --添加元素属性
                if addbuff(BBItem, 50004, 65535, 1, player, {
                        [21] = getbaseinfo(player, 51, 21) * qhatt,
                        [25] = getbaseinfo(player, 51, 25) * qhatt,
                        [28] = getbaseinfo(player, 51, 28) * qhatt,
                    }) then
                    Message:SendClawmsg(player, "地狱鬼爪：宝宝获得元素属性提升")
                end
            end
        end
        setcurrent(BBItem, 0, "幻术复制")
        lualib:SetInt(player, "幻术复制", lualib:GetInt(player, "幻术复制") + 1)
    end
end

--宝宝死亡
function hsfzSkill.onSelfKillSlave(player, bbobj)
    if getcurrent(bbobj, 0) == "幻术复制" then
        lualib:SetInt(player, "幻术复制", lualib:GetInt(player, "幻术复制") - 1)
    end
end

--游戏事件
GameEvent.add(EventCfg.onBeginmagic, hsfzSkill.onBeginmagic, hsfzSkill)
GameEvent.add(EventCfg.onSelfKillSlave, hsfzSkill.onSelfKillSlave, hsfzSkill)
return hsfzSkill
