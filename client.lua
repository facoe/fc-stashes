QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for k, v in pairs(Config.StashCoords) do
        if Config.UseQBTarget then
            exports['qb-target']:AddBoxZone("stash_" .. k, v.coords, 1.0, 1.0, {
                name = "stash_" .. k,
                heading = 0,
                debugPoly = false,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "client:setStash",
                        icon = "fas fa-box-open",
                        label = "Almacén",
                        name = k,
                        stashSize = v.stashSize,
                        stashSlots = v.stashSlots,
                        canInteract = function()
                            return CanAccessStorage(v)
                        end
                    }
                },
                distance = 2.0
            })
        else
            CreateThread(function()
                while true do
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local dist = #(playerCoords - v.coords)

                    if dist < 2.0 then
                        if CanAccessStorage(v) then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[E] Almacén")
                            if IsControlJustReleased(0, 38) then -- 38 = tecla E
                                TriggerEvent("client:setStash", {name = k, stashSize = v.stashSize, stashSlots = v.stashSlots})
                            end
                        end
                    end

                    Wait(1)
                end
            end)
        end
    end

    for k, v in pairs(Config.WardrobeCoords) do
        if Config.UseQBTarget then
            exports['qb-target']:AddBoxZone("wardrobe_" .. k, v.coords, 1.0, 1.0, {
                name = "wardrobe_" .. k,
                heading = 0,
                debugPoly = false,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-clothing:client:openOutfitMenu",
                        icon = "fas fa-tshirt",
                        label = "Guardarropa",
                        canInteract = function()
                            return CanAccessStorage(v)
                        end
                    }
                },
                distance = 2.0
            })
        else
            CreateThread(function()
                while true do
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local dist = #(playerCoords - v.coords)

                    if dist < 2.0 then
                        if CanAccessStorage(v) then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[E] Guardarropa")
                            if IsControlJustReleased(0, 38) then -- 38 = tecla E
                                TriggerEvent("qb-clothing:client:openOutfitMenu")
                            end
                        end
                    end

                    Wait(1)
                end
            end)
        end
    end
end)

RegisterNetEvent("client:setStash")
AddEventHandler("client:setStash", function(data)
    TriggerEvent("inventory:client:SetCurrentStash", data.name)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.name, {
        maxweight = data.stashSize or 4000000, -- Usa el tamaño configurado o un valor por defecto
        slots = data.stashSlots or 500, -- Usa los slots configurados o un valor por defecto
    })
end)

function CanAccessStorage(storage)
    local PlayerData = QBCore.Functions.GetPlayerData()

    if storage.access == "everyone" then
        return true
    elseif storage.access == "job" and PlayerData.job then
        for _, job in pairs(storage.allowedJobs) do
            if job == PlayerData.job.name then
                return true
            end
        end
    elseif storage.access == "gang" and PlayerData.gang then
        for _, gang in pairs(storage.allowedGangs) do
            if gang == PlayerData.gang.name then
                return true
            end
        end
    end

    return false
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

