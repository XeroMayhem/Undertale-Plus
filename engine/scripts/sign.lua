local SignEvent = {}

function SignEvent:onInteract()
    local text = gameMap:getObjectProperties("Objects", "sign").text
    if string.sub(text, 1, 1) == "[" then
        Textbox:create()
        for i, page in pairs(json.decode(text)) do
            Textbox:pageParams(page)
        end
    else
        Textbox:create()
        Textbox:pageParams(text)
    end
end

return SignEvent