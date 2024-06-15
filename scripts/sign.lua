local SignEvent, super = setmetatable(Event, {__index = "sign"})

function SignEvent:onInteract()
    local text = gameMap:getObjectProperties("Objects", "sign").text
    if type(text) == "string" then
        Textbox:create({text})
    else
        Textbox:create(json.decode(text))
    end
end

return SignEvent