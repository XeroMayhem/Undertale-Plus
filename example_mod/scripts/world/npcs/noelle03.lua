local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("* Hey there!^* Take this Snow Cone off my hands!", 'snd_txt_noe.wav')
    inventory:addItem("snow_cone")
end

return npc