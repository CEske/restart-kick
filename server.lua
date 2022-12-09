local genstarttider = {'23:55:00', '05:55:00', '11:55:00', '17:55:00'}
local kick = false
local nojoin = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i=1, #genstarttider, 1 do
            if genstarttider[i] == os.date("%X") then 
                for _, spillerId in ipairs(GetPlayers()) do
                    DropPlayer(spillerId, '[AUTO-KICK] Du er blevet smidt ud af serveren grundet genstart.')
                    nojoin = true
                end
            end
        end
    end
end)

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    deferrals.defer()
    Wait(0)
    if nojoin == true then
        deferrals.done("Du kan ikke joine lige før genstart. Vent venligst til efter genstart.")
    else
        deferrals.done()
    end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)