-- script_author: "kizn"

acceptId, time = -1, -1

function onTextDrawShow(textDrawId, positionX, positionY, textDrawString)
    if positionX == 233 and positionY == 337 then
        acceptId = textDrawId; time = os.clock()
    end
end

function onDialogShow(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
    if dialogText:find("дополнительную информацию") then
        hideDialog(); return true
    elseif dialogText:find("¬ведите свой пароль") then
        sendDialog(dialogId, 1, 65535, getPassword()); return true
    end
end

function onScriptUpdate()
    if acceptId ~= -1 then
        if os.clock() > time + 1 then
            clickTextDraw(acceptId); acceptId = -1; time = -1
        end
    end
end