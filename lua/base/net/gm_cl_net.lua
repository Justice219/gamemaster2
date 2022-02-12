gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}

gm.client.data = gm.client.data or {}

net.Receive("GM2:Menus:Main", function(len, ply)
    gm.client.data.tools = net.ReadTable()
    gm.client.data.main = net.ReadTable()

    gm.client.menus.main()
end)

net.Receive("GM2:Net:StringConCommand", function(len, ply)
    local cmd = net.ReadString()
    print(cmd)
    RunConsoleCommand(cmd)
end)

net.Receive("GM2:Tools:EnableLights", function(len, ply)
    render.RedownloadAllLightmaps(true, true)
end)

net.Receive("GM2:Net:ClientConvar", function()
    local bool = net.ReadBool()
    local name = net.ReadString()
    print(name)
    print(bool)

    if bool then
        if GetConVar(name) then
            GetConVar(name):SetBool(true)
        else
            CreateClientConVar(name, 1, true, false)
        end
    else
        if GetConVar(name) then
            GetConVar(name):SetBool(false)
        else
            CreateClientConVar(name, 0, true, false)
        end
    end
    
end)

local function wallhack()
    if GetConVar("gm2_esp") then
        if GetConVar("gm2_esp"):GetBool() then
            for k, v in pairs (player.GetAll()) do
                local plypos = (v:GetPos() + Vector(0,0,80)):ToScreen()
                if v:IsAdmin() or v:IsSuperAdmin() then
                    draw.DrawText("" ..v:Name().. "[Admin]", "TabLarge", plypos.x, plypos.y, Color(220,60,90,255), 1)
                else
                    draw.DrawText(v:Name(), "Trebuchet18", plypos.x, plypos.y, Color(255,255,255), 1)
                end
            end
        end
    end
end

hook.Add("HUDPaint", "ESP", wallhack)