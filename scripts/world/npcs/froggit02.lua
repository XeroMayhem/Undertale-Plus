local npc = require 'scripts.npc'

function npc:onInteract()
    Textbox:create({"* Rib Ribbit."})
end

return npc