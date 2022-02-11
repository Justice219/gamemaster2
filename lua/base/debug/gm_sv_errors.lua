gm = gm or {}
gm.server = gm.server or {}
gm.server.errors = gm.server.errors or {}

function gm.server.errors.severe(message)
    MsgC(Color(233, 135, 44), "[GM SEVERE] ", Color(255, 255, 255), message, "\n")
end
function gm.server.errors.normal(message)
    MsgC(Color(233, 135, 44), "[GM SYSTEM] ", Color(255, 255, 255), message, "\n")
end
function gm.server.errors.debug(message)
    MsgC(Color(233, 135, 44), "[GM DEBUG] ", Color(255, 255, 255), message, "\n")
end
function gm.server.errors.change(message)
    MsgC(Color(233, 135, 44), "[GM CHANGE] ", Color(255, 255, 255), message, "\n")
end