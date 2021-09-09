local success = {}
RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    success = data.data
    await = false
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
    SetNuiFocusKeepInput(false)
    TriggerEvent('vt_core:NUI:controls', false)
    success = nil
    await = false
end)


function KeyboardInput(data)
    if not data then return end
    success = {}
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
    await = true
    while await do Wait(0) end
    if success ~= nil and next(success) ~= nil then
        if #success == 1 then
            return success[1].input
        else
            return success
        end
    else
        return nil
    end
end

exports("KeyboardInput", KeyboardInput)