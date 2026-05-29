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
    -- Lumber Tycoon 2

    local scripts = {
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar1.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar2.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar3.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar4.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar5.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar6.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar7.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar8.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar9.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar10.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar11.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar12.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar13.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar14.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar15.lua",
        "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/Lunar16.lua",
    }

    for _, url in ipairs(scripts) do
        local content = fetch(url)

        if content then
            local func = loadstring(content)

            if func then
                task.spawn(func)
            end
        end

        task.wait(0.2)
    end
else
    LP:Kick("LunarHub: This game is not supported.")
end

getgenv().ItsLunarHubBase = nil
