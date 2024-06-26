local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("* Hey there!^* Wanna take this off my hands?^        Yes         No/C", 'snd_txt_noe.wav')
    Textbox:setChoice(1, function() 
        Textbox:create()
        inventory:addItem("snow_cone")
        Textbox:pageParams("* Thanks!", 'snd_txt_noe.wav')
        Textbox:pageParams("* Theres plenty more!", 'snd_txt_noe.wav')
    end)
    Textbox:setChoice(2, function() 
        Textbox:create()
        Textbox:pageParams("* Oh, ok then.", 'snd_txt_noe.wav')
    end)
    --Textbox:pageParams("* Hey there!", 'snd_txt_noe.wav')
    --Textbox:pageParams("* Wanna take this Snow Cone off my hands?^        Yes         No", 'snd_txt_noe.wav')
end

return npc