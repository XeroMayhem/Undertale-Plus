local npc = {}

function npc:onInteract()
    Textbox:create()
    Textbox:pageParams("* W- Where am I.", 'snd_txt_noe.wav')
    Textbox:pageParams("* I don't think I'm supossed to be here.", 'snd_txt_noe.wav')
    Textbox:pageParams("* I don't think you are either.", 'snd_txt_noe.wav')
end

return npc