local npc = {}

function npc:onInteract()
    if flag[1] < 2 then

        Textbox:create()
        if flag[1] == 0 then
            Textbox:pageParams("* Vines block the path.")
            Textbox:pageParams("* If only you could cut them.")
        elseif flag[1] == 1 then
            Textbox:pageParams("* Your SOUL shined it's power and cut the vines.")
            flag[1] = 2
        end
    end
end

return npc