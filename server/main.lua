AddEventHandler("onResourceStart", function()

    print("resource yüklendi!")

end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function returncriminalslist(args)
    local table_new = {}
    for k, v in pairs(args) do
        print(v["comment"])
        local string = "Criminal's Database ID: " .. tostring(v["id"]) .. " Criminal Game ID: " .. tostring(v["playerid"]) .. " Crime: " .. tostring(v["comment"])
        table.insert(table_new, k, string)
        print(json.encode(table_new))
       
    end
    return table_new
end

uniqueid = 0
new_table = {}


Citizen.CreateThread(function()

   while true do
        MySQL.Async.fetchAll("SELECT * FROM criminal_database ORDER BY id DESC LIMIT 1",{},function(result)
        uniqueid = result[1]["id"]
        end)
        Citizen.Wait(10)
    end
    end)



RegisterCommand("addrecord", function(source, args)

    local crimeComment = table.concat(args, " ", 2)

MySQL.Async.fetchAll("INSERT INTO criminal_database (id, playerid, comment) VALUES (@id, @playerid, @comment)",

    {["@id"] = uniqueid + 1, ["@playerid"] = args[1], ["@comment"] = crimeComment}
)
print(uniqueid)
end)

RegisterNetEvent("wantedlist")

AddEventHandler("wantedlist", function()
    MySQL.Async.fetchAll("SELECT * FROM criminal_database ORDER BY id",{}, function(result)

        

        table.sort(result, function(a,b)
            return a.id < b.id
        end)

        
        --[[for i, v in pairs(result) do
            for id, p in pairs(v) do
                new_table[id] = p
            end
        end--]]
        new_table = returncriminalslist(result)
        TriggerClientEvent("printcriminals", -1, new_table)


    end)
end)


