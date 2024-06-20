local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("gOODBYE fRISK", 'snd_txt_noe.wav')
    Textbox:pageParams("hUH YOU RECOGNISE ME!", 'snd_txt_noe.wav')
    Textbox:pageParams("iT'S ME.^yESELLE.", 'snd_txt_noe.wav')
    Textbox:pageParams("!!!", 'snd_txt_noe.wav')
end

return npc