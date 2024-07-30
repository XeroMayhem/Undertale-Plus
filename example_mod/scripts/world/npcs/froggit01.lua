local npc = {}

function npc:onInteract()
    local px = player.x/gameScale
    Textbox:create()
    if px < 210 then
        Textbox:pageParams("* ...")
        Textbox:pageParams("* Meow.")
    elseif px < 420 then
        if flag[1] == 0 then
            Textbox:pageParams("* Ribbit, ribbit.^* (Greetings human.)")
            Textbox:pageParams("* (I see that you're new here.)")
            Textbox:pageParams("* (One word of advice.)")
            Textbox:pageParams("* (Stay clear of Asgore.)")
            flag[1] = 1
            elseif flag[1] == 1 then
                Textbox:pageParams("* Ribbit, ribbit.^* (I wish you well on your journey.)")
            end
    else
        Textbox:pageParams("* Ribbit Ribbit.")
    end
end

return npc