local function fetch(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(res) == "string" and #res > 0 then
        return res
    end
    return nil
end

local BASE = "https://raw.githubusercontent.com/ItsLunarHub/LunarHubLT2/main/"

-- Load Lunar1 first and wait for _G.LH to be ready
local scaffold = fetch(BASE .. "Lunar1.lua")
if not scaffold then
    warn("[LunarHub] Failed to fetch Lunar1 (scaffold). Aborting.")
    return
end

local scaffoldFunc = loadstring(scaffold)
if not scaffoldFunc then
    warn("[LunarHub] Failed to compile Lunar1. Aborting.")
    return
end

scaffoldFunc() -- run synchronously

-- Wait up to 5 seconds for _G.LH to be populated
local timeout = 5
local elapsed = 0
while not _G.LH and elapsed < timeout do
    task.wait(0.1)
    elapsed += 0.1
end

if not _G.LH then
    warn("[LunarHub] Lunar1 ran but _G.LH was never set. Check Lunar1 for errors.")
    return
end

-- Now load the rest sequentially (not spawned), so each one has _G.LH available
local tabs = {
    "Lunar2.lua",  "Lunar3.lua",  "Lunar4.lua",  "Lunar5.lua",
    "Lunar6.lua",  "Lunar7.lua",  "Lunar8.lua",  "Lunar9.lua",
    "Lunar10.lua", "Lunar11.lua", "Lunar12.lua", "Lunar13.lua",
    "Lunar14.lua", "Lunar15.lua", "Lunar16.lua",
}

for _, name in ipairs(tabs) do
    local content = fetch(BASE .. name)
    if content then
        local func = loadstring(content)
        if func then
            local ok, err = pcall(func)
            if not ok then
                warn("[LunarHub] Error in " .. name .. ": " .. tostring(err))
            end
        else
            warn("[LunarHub] Failed to compile: " .. name)
        end
    else
        warn("[LunarHub] Failed to fetch: " .. name)
    end
    task.wait(0.1)
end
