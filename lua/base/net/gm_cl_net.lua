gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}

gm.client.data = gm.client.data or {}

net.Receive("GM2:Menus:Main", function(len, ply)
    gm.client.data.tools = net.ReadTable()
    gm.client.data.main = net.ReadTable()

    gm.client.menus.main()
end)