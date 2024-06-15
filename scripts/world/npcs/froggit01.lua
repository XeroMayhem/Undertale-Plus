local npc = require 'scripts.npc'

function npc:onInteract()
    Textbox:create({"* Ribbit Ribbit."})
end

return npc