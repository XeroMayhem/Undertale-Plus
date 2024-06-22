local npc = {}

function npc:onInteract()
    local px = player.x/gameScale
    Textbox:create()
    if px < 210 then
        Textbox:pageParams("* ...")
        Textbox:pageParams("* Meow.")
    elseif px < 420 then
        Textbox:pageParams("* Ribbit, ribbit.^* (Greetings human.)")
        Textbox:pageParams("* (It seems I am blocking your path.)^* (But there is another.)")
        Textbox:pageParams("* (In the room next to this one you will find the entrance to it.)")
        Textbox:pageParams("* (What?)^* (It's covered in vines?)")
        Textbox:pageParams("* (You do know every human soul has a unique and hidden power.)")
        Textbox:pageParams("* (Maybe yours is to cut things.)")
        Textbox:pageParams("* (I hear another human had that ability.)^* (So give it a try)")
        flag[1] = 1
    else
        Textbox:pageParams("* Ribbit Ribbit.")
    end
end

return npc