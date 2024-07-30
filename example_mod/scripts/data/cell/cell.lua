local cell = {}

function cell:init()
    cell.calls = {}
    cell.calls[1] = {name = "Call Home", call = function()
        Textbox:create()
        Textbox:pageParams("* Dialing...")
        Textbox:pageParams("* No one picked up...")
    end}
end

function cell:getCellList()
    local cellList = {}
    
    table.insert(cellList, cell.calls[1])

    return cellList
end

return cell