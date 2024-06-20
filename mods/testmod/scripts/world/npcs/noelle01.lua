local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("* Hi ~RFrisk~W!", 'snd_txt_noe.wav')
    Textbox:pageParams("* Huh you don't recognise me?", 'snd_txt_noe.wav')
    Textbox:pageParams("* It's me.^* N- ~YNoelle~W.", 'snd_txt_noe.wav')
    Textbox:pageParams("* ...", 'snd_nosound.wav')
end

return npc