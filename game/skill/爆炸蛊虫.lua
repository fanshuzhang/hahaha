---@class bzgcSkill ±¬Õ¨¹Æ³æ
local bzgcSkill = {}
--¼¼ÄÜ
function magselffunc513(player)
    if lualib:GetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"]) == 0 then
        setontimer(player, 101, 2)
        lualib:SetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"], 1)
        Message:Msg9(player, "¿ªÆô±¬Õ¨¹Æ³æ")
    elseif lualib:GetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"]) == 1 then
        setofftimer(player, 101)
        lualib:SetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"], 0)
        Message:Msg9(player, "¹Ø±Õ±¬Õ¨¹Æ³æ")
    end
end

--¶¨Ê±Æ÷ÕÙ»½³æ×Ó--±¬Õ¨¹Æ³æ
function ontimer101(player)
    local count = lualib:GetVar(player, VarCfg["±¬Õ¨¹Æ³æÊıÁ¿"])
    if count >= 6 then
        return
    end
    for i = 1, 2 do
        local BBItem = recallmob(player, "±¬Õ¨¹Æ³æ", 7, 1440, 1)
        if BBItem then
            changemobability(player, BBItem, 1, '=', getbaseinfo(player, 15), 86400)
            changemobability(player, BBItem, 2, '=', getbaseinfo(player, 16), 86400)
            changemobability(player, BBItem, 3, '=', getbaseinfo(player, 17), 86400)
            changemobability(player, BBItem, 4, '=', getbaseinfo(player, 18), 86400)
            changemobability(player, BBItem, 11, '=', getbaseinfo(player, 10) / 10, 86400)
            --¹¥»÷
            local num = (80 + 4 * getskillinfo(player, SkillIDCfg["±¬Õ¨¹Æ³æ"], 2)) / 100
            local attUp, attLow = Magic.GetPlayerAtt(player)
            changemobability(player, BBItem, 5, '=', attLow * num, 86400)
            changemobability(player, BBItem, 6, '=', attUp * num, 86400)
            -- changemobability(player, BBItem, 7, '=', getbaseinfo(player, 21) * num, 86400)
            -- changemobability(player, BBItem, 8, '=', getbaseinfo(player, 22) * num, 86400)
            -- changemobability(player, BBItem, 9, '=', getbaseinfo(player, 23) * num, 86400)
            -- changemobability(player, BBItem, 10, '=', getbaseinfo(player, 24) * num, 86400)
            --ÉèÖÃÂú×´Ì¬
            setbaseinfo(BBItem, 9, getbaseinfo(BBItem, 10))
            --µØÓü¹í×¦Ç¿»¯
            if lualib:GetVar(player, VarCfg["½ÇÉ«Ö°Òµ"]) == 7 then
                local ClawCount = Magic.ClawCount(player)
                if ClawCount >= 1 then
                    local qhatt = 0.2
                    if ClawCount >= 2 then qhatt = 0.4 end
                    if ClawCount >= 3 then qhatt = 1 end
                    --Ìí¼ÓÔªËØÊôĞÔ
                    if addbuff(BBItem, 50004, 65535, 1, player, {
                            [21] = getbaseinfo(player, 51, 21) * qhatt,
                            [25] = getbaseinfo(player, 51, 25) * qhatt,
                            [28] = getbaseinfo(player, 51, 28) * qhatt,
                        }) then
                        Message:SendClawmsg(player, "µØÓü¹í×¦£º±¬Õ¨¹Æ³æ»ñµÃÔªËØÊôĞÔÌáÉı")
                    end
                end
            end
            --ÍöÁé´ó¾üÊıÁ¿
            lualib:SetVar(player, VarCfg["±¬Õ¨¹Æ³æÊıÁ¿"], lualib:GetVar(player, VarCfg["±¬Õ¨¹Æ³æÊıÁ¿"]) + 1)
        end
    end
end

--±¦±¦ËÀÍö
function bzgcSkill.onSelfKillSlave(player, bbobj)
    if getbaseinfo(bbobj, 1, 1) == "±¬Õ¨¹Æ³æ" then
        lualib:SetVar(player, VarCfg["±¬Õ¨¹Æ³æÊıÁ¿"], lualib:GetVar(player, VarCfg["±¬Õ¨¹Æ³æÊıÁ¿"]) - 1)
        --ËÀÍö±¬Õ¨-·¶Î§ÉËº¦
        rangeharm(player, getbaseinfo(bbobj, 4), getbaseinfo(bbobj, 5), 2, getbaseinfo(bbobj, 24), 0)
        if math.random(100) <= 100 then
            lualib:SetVar(player, VarCfg["Ï×¼À¹Æ³æÊıÁ¿"], lualib:GetVar(player, VarCfg["Ï×¼À¹Æ³æÊıÁ¿"]) + 1)
        end
    end
end

--É¾³ı¼¼ÄÜ
function bzgcSkill.onDelSkill(player, skillID)
    if skillID == SkillIDCfg["±¬Õ¨¹Æ³æ"] then
        if lualib:GetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"]) == 1 then
            setofftimer(player, 101)
            lualib:SetFlagStatus(player, PlayerVarCfg["±¬Õ¨¹Æ³æ¿ª¹Ø"], 0)
            Message:Msg9(player, "¹Ø±Õ±¬Õ¨¹Æ³æ")
        end
    end
end

--ÓÎÏ·ÊÂ¼ş
GameEvent.add(EventCfg.onDelSkill, bzgcSkill.onDelSkill, bzgcSkill)
GameEvent.add(EventCfg.onSelfKillSlave, bzgcSkill.onSelfKillSlave, bzgcSkill)
return bzgcSkill
