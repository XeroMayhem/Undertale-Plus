local npc = {}

function npc:onInteract()
    Textbox:create({"* Hi Frisk!", "* Huh you don't recognise me?", "* It's me.\n* N- Noelle.", "* ..."})
end

return npc