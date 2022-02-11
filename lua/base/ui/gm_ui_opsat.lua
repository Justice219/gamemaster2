gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}
gm.client.data = gm.client.data or {}
gm.client.data.opsat = gm.client.data.opsat or {}

function gm.client.menus.opsat(args, method)
    local function ScaleW(size)
        return ScrW() * size/1920
    end
    local function ScaleH(size)
        return ScrH() * size/1080        
    end

    surface.CreateFont("gm_opsat_font", {
        font = "Roboto",
        size = ScreenScale(10),
        weight = 500,
        antialias = true,
        shadow = false
    })

    if method == "set" then
        for k,v in pairs(gm.client.data.opsat) do
            k = nil
            v:Remove()
        end

        local back = vgui.Create("DPanel")
        back:SetSize(ScrW(), ScrH())
        back:SetPos(ScaleW(1550), ScaleH(0))
        back:SetBackgroundColor(color_black)
        back.Paint = function(self, w, h)
            draw.RoundedBox( 6, 0, ScaleH(115), ScaleW(325), ScaleH(400), Color(41,41,41, 200) )
        end
        table.insert(gm.client.data.opsat, #gm.client.data.opsat, back)

        label = back:Add("DLabel")
        label:SetParent(back)
        label:SetPos(ScaleW(20), ScaleH(130))
        label:SetSize(ScaleW(300), ScaleH(50))
        label:SetText(args["Title 1"].def)
        label:SetFont("gm_opsat_font")

        text1 = back:Add("DLabel")
        text1:SetParent(back)
        text1:SetPos(ScaleW(20), ScaleH(170))
        text1:SetSize(ScaleW(300), ScaleH(50))
        text1:SetText(args["Line 1"].def)

        text2 = back:Add("DLabel")
        text2:SetParent(back)
        text2:SetPos(ScaleW(20), ScaleH(190))
        text2:SetSize(ScaleW(300), ScaleH(50))
        text2:SetText(args["Line 2"].def)

        title2 = back:Add("DLabel")
        title2:SetParent(back)
        title2:SetPos(ScaleW(20), ScaleH(230))
        title2:SetSize(ScaleW(300), ScaleH(50))
        title2:SetText(args["Title 2"].def)
        title2:SetFont("gm_opsat_font")

        text3 = back:Add("DLabel")
        text3:SetParent(back)
        text3:SetPos(ScaleW(20), ScaleH(260))
        text3:SetSize(ScaleW(300), ScaleH(50))
        text3:SetText(args["Line 3"].def)

        text4 = back:Add("DLabel")
        text4:SetParent(back)
        text4:SetPos(ScaleW(20), ScaleH(280))
        text4:SetSize(ScaleW(300), ScaleH(50))
        text4:SetText(args["Line 4"].def)
    elseif method == "remove" then
        for k,v in pairs(gm.client.data.opsat) do
            k = nil
            v:Remove()
        end
    end

end

net.Receive("GM2:Tools:OpsatSet", function()
    local data = net.ReadTable()
    
    gm.client.menus.opsat(data, "set")
end)
net.Receive("GM2:Tools:OpsatRemove", function()
    gm.client.menus.opsat(data, "remove")
end)