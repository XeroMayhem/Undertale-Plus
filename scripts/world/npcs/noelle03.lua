local npc = {}

function npc:onInteract()
    bgMusic:stop()
    Textbox:create({"* W- Where am I.", "* I don't think I'm supossed to be here.", "* I don't think you are either."})
end

return npc