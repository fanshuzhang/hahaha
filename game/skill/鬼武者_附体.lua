---@class gwzftSkill 鬼武者附体
-- local gwzftSkill = {}
--修罗附体
function magselffunc1001(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["修罗附体"])
    local gsNum = 1 --可召唤鬼神数量
    if Magic.BBcountEX(player, SkillIDCfg["神力共存"]) then
        gsNum = gsNum + 1
    end
    --地狱鬼爪
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "鬼神附体") >= gsNum then
        Message:Msg9(player, "当前拥有的鬼神已附体在其身上")
        return
    end
    lualib:SetValue(player, 28, ((10 + level * 2) + lualib:GetValue(player, 28)), 10) --破防
    lualib:SetInt(player, "鬼神附体", lualib:GetInt(player, "鬼神附体") + 1)
    Message:SendSkillmsg(player, "修罗附体", "破防能力增加！")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--罗刹附体
function magselffunc1002(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["罗刹附体"])
    local gsNum = 1 --可召唤鬼神数量
    if Magic.BBcountEX(player, SkillIDCfg["神力共存"]) then
        gsNum = gsNum + 1
    end
    --地狱鬼爪
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "鬼神附体") >= gsNum then
        Message:Msg9(player, "当前拥有的鬼神已附体在其身上")
        return
    end
    lualib:SetValue(player, 21, ((10 + level * 2) + lualib:GetValue(player, 21)), 10) --暴击
    lualib:SetInt(player, "鬼神附体", lualib:GetInt(player, "鬼神附体") + 1)
    -- setontimer(player, 102, 10, 1)
    Message:SendSkillmsg(player, "罗刹附体", "暴击能力增加！")
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--阎罗附体
function magselffunc1003(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["阎罗附体"])
    local gsNum = 1 --可召唤鬼神数量
    if Magic.BBcountEX(player, SkillIDCfg["神力共存"]) then
        gsNum = gsNum + 1
    end
    --地狱鬼爪
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "鬼神附体") >= gsNum then
        Message:Msg9(player, "当前拥有的鬼神已附体在其身上")
        return
    end
    lualib:SetValue(player, 25, ((10 + level * 2) + lualib:GetValue(player, 25)), 10) --伤害
    lualib:SetInt(player, "鬼神附体", lualib:GetInt(player, "鬼神附体") + 1)
    Message:SendSkillmsg(player, "阎罗附体", "伤害能力增加！")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--死神附体
function magselffunc1004(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["死神附体"])
    local gsNum = 1 --可召唤鬼神数量
    if Magic.BBcountEX(player, SkillIDCfg["神力共存"]) then
        gsNum = gsNum + 1
    end
    --地狱鬼爪
    if Magic.ClawCount(player) >= 3 and lualib:GetVar(player, VarCfg["角色职业"]) == 2 then
        gsNum = gsNum + 1
    end
    if lualib:GetInt(player, "鬼神附体") >= gsNum then
        Message:Msg9(player, "当前拥有的鬼神已附体在其身上")
        return
    end
    lualib:SetValue(player, 30, ((20 + level * 2) + lualib:GetValue(player, 30)), 10) --生命
    lualib:SetInt(player, "鬼神附体", lualib:GetInt(player, "鬼神附体") + 1)
    Message:SendSkillmsg(player, "死神附体", "生命能力增加！")
    -- setontimer(player, 102, 10, 1)
    delaygoto(player, 10000, "gwzftskill_ontimer", 0)
end

--定时器
function gwzftskill_ontimer(player)
    if lualib:GetInt(player, "鬼神附体") > 0 then
        lualib:SetInt(player, "鬼神附体", lualib:GetInt(player, "鬼神附体") - 1)
    end
end

--游戏事件
-- return gwzftSkill
