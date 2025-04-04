QBCore = exports['qb-core']:GetCoreObject()

-- Registrar puntos de stash en qb-target
CreateThread(function()
    if Config.UseQBTarget then
        for stashName, stashData in pairs(Config.StashCoords) do
            exports['qb-target']:AddBoxZone("stash_" .. stashName, stashData.coords, 1.0, 1.0, {
                name = "stash_" .. stashName,
                heading = 0,
                debugPoly = false,
                minZ = stashData.coords.z - 1.0,
                maxZ = stashData.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "client:openStash",
                        icon = "fas fa-box",
                        label = "Abrir Stash",
                        canInteract = function()
                            return isAuthorized(stashData)
                        end,
                        stashName = stashName
                    }
                },
                distance = 1.5
            })
        end
    else
        -- Si qb-target está desactivado, se puede usar el sistema de proximidad original
        QBCore.Functions.Notify("qb-target está desactivado en la configuración.", "error")
    end
end)

-- Registrar puntos de guardarropa en qb-target
CreateThread(function()
    if Config.UseQBTarget then
        for wardrobeName, wardrobeData in pairs(Config.WardrobeCoords) do
            exports['qb-target']:AddBoxZone("wardrobe_" .. wardrobeName, wardrobeData.coords, 1.0, 1.0, {
                name = "wardrobe_" .. wardrobeName,
                heading = 0,
                debugPoly = false,
                minZ = wardrobeData.coords.z - 1.0,
                maxZ = wardrobeData.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-clothing:client:openOutfitMenu",
                        icon = "fas fa-tshirt",
                        label = "Abrir Guardarropa",
                        canInteract = function()
                            return isAuthorized(wardrobeData)
                        end
                    }
                },
                distance = 1.5
            })
        end
    end
end)

-- Evento para abrir el stash
RegisterNetEvent("client:openStash")
AddEventHandler("client:openStash", function(data)
    local stashName = data.stashName
    local stashData = Config.StashCoords[stashName]

    if stashData then
        TriggerEvent("inventory:client:SetCurrentStash", stashName)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
            maxweight = stashData.stashSize or 100000,
            slots = stashData.stashSlots or 50,
        })
    else
        QBCore.Functions.Notify("Stash no encontrado", "error")
    end
end)

-- Función para verificar autorización
function isAuthorized(data)
    local playerData = QBCore.Functions.GetPlayerData()
    local job = playerData.job.name
    local gang = playerData.gang.name

    if data.access == "everyone" then
        return true
    elseif data.access == "job" and data.allowedJobs then
        for _, allowedJob in ipairs(data.allowedJobs) do
            if job == allowedJob then
                return true
            end
        end
    elseif data.access == "gang" and data.allowedGangs then
        for _, allowedGang in ipairs(data.allowedGangs) do
            if gang == allowedGang then
                return true
            end
        end
    end

    return false
end

-- Función para dibujar texto en 3D
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
