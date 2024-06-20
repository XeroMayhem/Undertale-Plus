local dt = {}

function dt:load()
    local open = io.open
    local file = open("data.json", "rb")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()
    
    local save_data = json.decode(jsonString)
    --Inventory
    inventory:create()
    for i, item in pairs(save_data.inventory) do
        inventory:addItem(item)
    end

end

return dt