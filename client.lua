local QBCore = exports["qb-core"]:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.PrivateStashes) do
            if #(coords - v.coords) <= 3.0 then
                sleep = 1
                DrawText3D(v.coords.x,v.coords.y,v.coords.z, "[~p~E~w~] "..v.stashText)
                if IsControlJustPressed(0, 38) then
                    QBCore.Functions.TriggerCallback('blessed_privatestash:checkisOwner', function(result)
                        if result then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.PrivateStashes[result].label..k, {
                                maxweight = Config.PrivateStashes[result].maxWeight * 1000,
                                slots = Config.PrivateStashes[result].slots,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", Config.PrivateStashes[result].label..k)
                        else
                            TriggerEvent("QBCore:Notify", "You can't use this stash.")
                        end
                    end, k)
                end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(true)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end