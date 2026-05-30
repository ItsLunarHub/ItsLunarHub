local KEY = getgenv().ItsLunarHubBase
local LP = game:GetService("Players").LocalPlayer

local function fetch(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)

    return ok and res or nil
end

if not KEY or KEY == "" then
    LP:Kick("LunarHub: Please provide a key in the script!")
    return
end

local keyData = fetch("https://raw.githubusercontent.com/ItsLunarHub/ItsLunarHub/main/keys.txt")

if not keyData then
    LP:Kick("LunarHub: Could not reach key server!")
    return
end

local keyValid = false

for line in keyData:gmatch("[^\r\n]+") do
    if line:match("^%s*(.-)%s*$") == KEY then
        keyValid = true
        break
    end
end

if not keyValid then
    LP:Kick("LunarHub: Invalid or Expired Key")
    return
end

if game.PlaceId == 13822889 then
    loadstring(fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/LunarHubLT2.lua"))()

elseif game.PlaceId == 537413528 then
    -- Build A Boat For Treasure
    loadstring(fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubBuildABoat/main/ItsLunarHub.lua"))()

elseif game.PlaceId == 606849621 then
    -- Jailbreak
    loadstring(fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubJailbreak/main/ItsLunarHub.lua"))()

else
    LP:Kick("LunarHub: This game is not supported.")
end

getgenv().ItsLunarHubBase = nil
