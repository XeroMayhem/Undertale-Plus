local npc = {}

function npc:onInteract()
    local px = player.x/gameScale
    Textbox:create()
    if px < 210 then
        Textbox:pageParams("* ...")
        Textbox:pageParams("* Meow.")
    elseif px < 420 then
        Textbox:pageParams("* Rib Ribbit.")
    else
        Textbox:pageParams("* Ribbit Ribbit.")
    end
end

return npc