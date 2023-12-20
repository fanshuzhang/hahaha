local titleChanged_list = {
    [10417] = { 0, 1, 11200, 0, 0, 0, 0 },
    [10418] = { 0, 1, 11201, 0, 0, 0, 0 },
    [10419] = { 0, 1, 11202, 0, 0, 0, 0 },
    [10420] = { 0, 1, 11203, 0, 0, 0, 0 },
    [10421] = { 0, 1, 11204, 0, 0, 0, 0 },
    [10422] = { 0, 1, 11205, 0, 0, 0, 0 },
    [10423] = { 0, 1, 11206, 0, 0, 0, 0 },
    [10424] = { 0, 1, 11207, 0, 0, 0, 0 },
    [10425] = { 0, 1, 11208, 0, 0, 0, 0 },
    [10426] = { 0, 1, 11209, 0, 0, 0, 0 },
    [10427] = { 0, 1, 11210, 0, 0, 0, 0 },
    [10428] = { 0, 1, 11211, 0, 0, 0, 0 },
    [10408] = { 0, 1, 9000, 0, 0, 0, 0 },
    [10409] = { 0, 1, 9001, 0, 0, 0, 0 },
    [10410] = { 0, 1, 9002, 0, 0, 0, 0 },
    [10411] = { 0, 1, 9003, 0, 0, 0, 0 },
    [10412] = { 0, 1, 9004, 0, 0, 0, 0 },
}

-- 下称号
for i, v in pairs(titleChanged_list) do
    _G["untitled_" .. i] = function(player)
        lualib:SetIcon(player, v[1], -1)
    end
end

-- 上称号
for i, v in pairs(titleChanged_list) do
    _G["titlechanged_" .. i] = function(player)
        lualib:SetIcon(player, v[1], v[2], v[3], v[4], v[5], v[6], v[7])
    end
end
--永久称号外显示
local TitleShow = {}
TitleShow.DataCfg = {
    ["VIP1"] = { 1, 1, 50719, 0, 0, 0, 0 },
    ["VIP2"] = { 1, 1, 50720, 0, 0, 0, 0 },
    ["VIP3"] = { 1, 1, 50721, 0, 0, 0, 0 },
    ["VIP4"] = { 1, 1, 50722, 0, 0, 0, 0 },
    ["VIP5"] = { 1, 1, 50723, 0, 0, 0, 0 },
    ["VIP6"] = { 1, 1, 50724, 0, 0, 0, 0 },
    ["VIP7"] = { 1, 1, 50725, 0, 0, 0, 0 },
    ["VIP8"] = { 1, 1, 50726, 0, 0, 0, 0 },
    ["VIP9"] = { 1, 1, 50727, 0, 0, 0, 0 },
    ["VIP10"] = { 1, 1, 50728, 0, 0, 0, 0 },
    ["VIP11"] = { 1, 1, 50729, 0, 0, 0, 0 },
    ["VIP12"] = { 1, 1, 50730, 0, 0, 0, 0 },
    ["VIP13"] = { 1, 1, 50731, 0, 0, 0, 0 },
    ["VIP14"] = { 1, 1, 50732, 0, 0, 0, 0 },
    ["VIP15"] = { 1, 1, 50733, 0, 0, 0, 0 },
    ["狂暴之力"] = { 2, 1, 11511, 0, 0, 0, 0 },
}
function TitleShow.RefreshTitleShow(player)
    lualib:SetIcon(player, 1, -1)
    lualib:SetIcon(player, 2, -1)
    for k, v in pairs(TitleShow.DataCfg) do
        if lualib:HasTitle(player, k) then
            lualib:SetIcon(player, v[1], v[2], v[3], v[4], v[5], v[6], v[7])
        end
    end
end

--游戏事件
GameEvent.add(EventCfg.onLogin, TitleShow.RefreshTitleShow, TitleShow)
return TitleShow
