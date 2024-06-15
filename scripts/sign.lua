local SignEvent, super = setmetatable(Event, {__index = "sign"})

function SignEvent:onInteract()
    local text = gameMap:getObjectProperties("Objects", "sign").text
    if string.sub(text, 1, 1) == "[" then
        Textbox:create(json.decode(text))
    else
        Textbox:create({text})
    end
end

return SignEvent