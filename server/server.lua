local VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

-- Buy Portal Passage
RegisterServerEvent('bcc-portals:BuyPassage')
AddEventHandler('bcc-portals:BuyPassage', function(data)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local location = data.location
    local currencyType = data.currencyType
    local buyPrice = data.buyPrice

    if currencyType == "cash" then
        local money = Character.money
        if money >= buyPrice then
            Character.removeCurrency(0, buyPrice)
            TriggerClientEvent('bcc-portals:SendPlayer', _source, location)
        else
            VORPcore.NotifyRightTip(_source, _U("shortCash"), 4000)
        end

    elseif currencyType == "gold" then
        local gold = Character.gold
        if gold >= buyPrice then
            Character.removeCurrency(1, buyPrice)
            TriggerClientEvent('bcc-portals:SendPlayer', _source, location)
        else
            VORPcore.NotifyRightTip(_source, _U("shortGold"), 4000)
        end
    end
end)

-- Check Player Job and Job Grade
RegisterServerEvent('bcc-portals:getPlayerJob')
AddEventHandler('bcc-portals:getPlayerJob', function()
    local _source = source
    if _source then
        local Character = VORPcore.getUser(_source).getUsedCharacter
        local CharacterJob = Character.job
        local CharacterGrade = Character.jobGrade

        TriggerClientEvent('bcc-portals:sendPlayerJob', _source, CharacterJob, CharacterGrade)
    end
end)
