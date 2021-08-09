Citizen.CreateThread(function()

        Citizen.Wait(3000)
        print(uniqueid)

end)

RegisterNetEvent("printcriminals")

AddEventHandler("printcriminals", function(crmnlist)
    for k, v in pairs(crmnlist) do
    TriggerEvent("chat:addMessage", { 
        color = { 255, 0, 0},
        multiline = true,
        args = {v}
    })
end

end)

RegisterCommand("printcriminals", function()

    TriggerServerEvent("wantedlist")

end)