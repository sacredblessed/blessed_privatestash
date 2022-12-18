local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateCallback("blessed_privatestash:checkisOwner", function(source,cb, identifier)
    local src = source
    if Config.HexSystem then
        if GetPlayerIdentifier(src, 0) == identifier then
            cb(identifier)
        else
            cb(nil)
        end
    else
        local hex = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
        if hex == identifier then
            cb(identifier)
        else
            cb(nil)
        end
    end
end)