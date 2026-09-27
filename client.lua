local ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function OpenCheatMenu()
    local elements = {}

    for i=1, #Config.CheatOptions, 1 do
        table.insert(elements, {
            label = Config.CheatOptions[i].label,
            value = Config.CheatOptions[i].value
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cheat_menu', {
        title    = Config.CheatMenuTitle,
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('cheatMenuSystem:activateCheat', data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.CheatMenuKey) then
            OpenCheatMenu()
        end
    end
end)

RegisterNetEvent('cheatMenuSystem:activateCheat')
AddEventHandler('cheatMenuSystem:activateCheat', function(cheatName)
    if cheatName == 'godmode' then
        SetEntityInvincible(PlayerPedId(), true)
    elseif cheatName == 'infiniteammo' then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey('WEAPON_PISTOL'))
    elseif cheatName == 'superjump' then
        SetSuperJumpThisFrame(PlayerId())
    elseif cheatName == 'superrun' then
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    elseif cheatName == 'superswim' then
        SetSwimMultiplierForPlayer(PlayerId(), 1.49)
    elseif cheatName == 'supersprint' then
        SetSprintMultiplierForPlayer(PlayerId(), 1.49)
    elseif cheatName == 'superstrength' then
        SetPlayerMeleeWeaponDamageModifier(PlayerId(), 1.49)
    elseif cheatName == 'supervision' then
        SetSeethrough(true)
    elseif cheatName == 'superhearing' then
        SetAudioFlag('LoadMPData', true)
    elseif cheatName == 'superspeed' then
        SetGameSpeed(1.49)
    end
end)