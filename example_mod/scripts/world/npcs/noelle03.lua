local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("* Hey there!^* Take this BIG SHOT off my hands!", 'snd_txt_noe.wav')
    inventory:addItem("big_shot")
end

return npc