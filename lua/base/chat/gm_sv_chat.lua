gm = gm or {}
gm.server = gm.server or {}
gm.server.chat = gm.server.chat or {}

gm.server.data = gm.server.data or {}
gm.server.data.main = gm.server.data.main or {}
gm.server.data.tools = gm.server.data.tools or {}

hook.Add("PlayerSay", "GM2:ChatCommands", function(ply, text)
    if text == "!gm2" then
        local r = gm.server.data.main.ranks
        local pr = ply:GetUserGroup()
    
        if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
            net.Start("GM2:Menus:Main")
            local tbl = {}
            for k,v in pairs(gm.server.data.tools) do
                tbl[k] = {
                    name = v.name,
                    desc = v.desc,
                    args = v.args,
                    category = v.category,
                }
            end
            net.WriteTable(tbl)
            net.WriteTable(gm.server.data.main)
            net.Send(ply)
        end

        return ""
    end
end)