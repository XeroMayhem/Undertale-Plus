local npc = {}

function npc:onInteract()
    local px = player.x/gameScale
    local text = {"* Ribbit Ribbit."}
    if px < 210 then
        text = {"* ...", "* Meow."}
    elseif px < 420 then
        text = {"* Rib Ribbit."}
    else
        text = {"* Ribbit Ribbit."}
    end
    Textbox:create(text)
end

return npc