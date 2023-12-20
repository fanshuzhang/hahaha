---@class kbxySkill ¿ñ±©ÑªÒº

function magselffunc1000(player)
    local level = Magic.BBcountEX(player, SkillIDCfg["¿ñ±©ÑªÒº"])
    lualib:SetValue(player, 28, ((5 + level) + lualib:GetValue(player, 28)), 10) --ÆÆ·À
    lualib:SetValue(player, 21, ((5 + level) + lualib:GetValue(player, 21)), 10) --±©»÷
    lualib:SetValue(player, 25, ((5 + level) + lualib:GetValue(player, 25)), 10) --ÉËº¦¼Ó³É
    Message:SendSkillmsg(player, "¿ñ±©ÑªÒº", "»ñµÃÆÆ·À£¬±©»÷£¬ÉËº¦ÌáÉý")
end
