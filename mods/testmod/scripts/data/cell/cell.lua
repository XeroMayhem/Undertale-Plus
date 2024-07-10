local cell = {}

function cell:init()
    cell.calls = {}
    cell.calls[1] = {name = "Call Noelle", call = function()
        Textbox:create()
        Textbox:pageParams("* Dialing..")
        Textbox:pageParams("* Hey Frisk!", 'snd_txt_noe.wav')
        Textbox:pageParams("* I gotta go now.", 'snd_txt_noe.wav')
        Textbox:pageParams("* See ya later!", 'snd_txt_noe.wav')
    end}
    cell.calls[2] = {name = "Flirt with Noelle", call = function()
        Textbox:create()
        Textbox:pageParams("* Dialing..")
        Textbox:pageParams("* Uh.", 'snd_txt_noe.wav')
        Textbox:pageParams("* Thanks.", 'snd_txt_noe.wav')
    end}
    cell.calls[3] = {name = "Call Froggit", call = function()
        Textbox:create()
        Textbox:pageParams("* Ring..")
        Textbox:pageParams("* Ribbit Ribbit")
    end}
    cell.calls[4] = {name = "Thank Froggit", call = function()
        Textbox:create()
        Textbox:pageParams("* Ring...")
        Textbox:pageParams("* Ribbit Ribbit^* (You're welcome.)")
    end}
    cell.calls[5] = {name = "Call Suzy", call = function()
        Textbox:create()
        Textbox:pageParams("* Dialing...")
        Textbox:pageParams("* (It went straight to voicemail.)")
    end}
end

function cell:getCellList()
    local cellList = {}
    
    table.insert(cellList, cell.calls[1])
    table.insert(cellList, cell.calls[2])
    if flag[1] == 1 then
        table.insert(cellList, cell.calls[3])
    elseif flag[1] == 2 then
        table.insert(cellList, cell.calls[4])
    end

    return cellList
end

return cell