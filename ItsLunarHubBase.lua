-- LunarHub Loader
getgenv().ItsLunarHubBase = "testkey"

local KEY = getgenv().ItsLunarHubBase
local LP = game:GetService("Players").LocalPlayer

local function fetch(url)
    local ok, res = pcall(game.HttpGet, game, url)
    if ok and type(res) == "string" and #res > 0 then
        return res
    end
    return nil
end

if not KEY or KEY:match("^%s*$") then
    LP:Kick("[LunarHub] No key provided.")
    return
end

local keyData = fetch("https://raw.githubusercontent.com/ItsLunarHub/ItsLunarHub/main/keys.txt")
if not keyData then
    LP:Kick("[LunarHub] Could not reach key server. Check your internet or try again.")
    return
end

local keyValid = false
for line in keyData:gmatch("[^\r\n]+") do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed == KEY then
        keyValid = true
        break
    end
end

if not keyValid then
    LP:Kick("[LunarHub] Invalid or expired key: " .. tostring(KEY))
    return
end

if game.PlaceId ~= 13822889 then
    LP:Kick("[LunarHub] Wrong game. Join Lumber Tycoon 2.")
    return
end

local mainScript = fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/ItsLunarHub.lua")
if not mainScript then
    LP:Kick("[LunarHub] Failed to fetch main script. Repo may be private or deleted.")
    return
end

loadstring(mainScript)()
getgenv().ItsLunarHubBase = nil
