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

-- Debug
print("PlaceId:", game.PlaceId)
print("GameId:", game.GameId)

if game.PlaceId == 13822889 then
    -- Lumber Tycoon 2
    loadstring(fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/LunarHubLT2.lua"))()

elseif game.PlaceId == 97598239454123 then
    -- Grow a Garden 2
    loadstring(fetch("https://raw.githubusercontent.com/ItsLunarHub/LunarHubGAG2/main/LunarHubGAG2.lua"))()

else
    LP:Kick(
        "LunarHub: This game is not supported. PlaceId: "
        .. tostring(game.PlaceId)
    )
end

getgenv().ItsLunarHubBase = nil
