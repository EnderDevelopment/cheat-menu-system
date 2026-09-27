local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cheatMenuSystem:getCheatStatus', function(source, cb, cheatName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT cheat_value FROM cheat_menu WHERE player_id = @player_id AND cheat_name = @cheat_name', {
        ['@player_id'] = playerId,
        ['@cheat_name'] = cheatName
    }, function(result)
        if result then
            cb(result)
        else
            cb('false')
        end
    end)
end)

RegisterServerEvent('cheatMenuSystem:activateCheat')
AddEventHandler('cheatMenuSystem:activateCheat', function(cheatName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.execute('UPDATE cheat_menu SET cheat_value = @cheat_value WHERE player_id = @player_id AND cheat_name = @cheat_name', {
        ['@cheat_value'] = 'true',
        ['@player_id'] = playerId,
        ['@cheat_name'] = cheatName
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('cheatMenuSystem:activateCheat', source, cheatName)
        end
    end)
end)