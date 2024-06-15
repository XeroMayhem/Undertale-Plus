local npc = require 'scripts.npc'

function npc:onInteract()
    Textbox:create({"* ...", "* Meow."})
end

return npc