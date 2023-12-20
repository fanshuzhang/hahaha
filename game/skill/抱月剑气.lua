---@class byjqSkill ±§ÔÂ½£Æø   Ë«ÁúÕ¶
function magselffunc40(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["Ë«ÁúÕ¶"])
    local att, job = 0, lualib:Job(player)
    if job == 0 then
        att = lualib:GetBaseInfo(player, 20)
    elseif job == 1 then
        att = lualib:GetBaseInfo(player, 22)
    elseif job == 2 then
        att = lualib:GetBaseInfo(player, 24)
    end
    lualib:RangeHarm(player, lualib:X(player), lualib:Y(player), 1, (att + att * level / 10), 0, 0, 0, 0)
end
