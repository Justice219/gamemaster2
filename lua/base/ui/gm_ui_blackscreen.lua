gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}
gm.client.data = gm.client.data or {}
gm.client.data.black = gm.client.data.black or {}

function gm.client.menus.blackscreen(time, fade)
    if !gm.client.data.active then
        local alpha = 0
        local lerp = false
    
        local black = vgui.Create("DFrame")
        black:SetSize(ScrW(), ScrH())
        black:Center()
        black:SetTitle("")
        black:ShowCloseButton(false)
        black:SetDraggable(false)
        black:SetAlpha(0)
        black.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
        end
        table.insert(gm.client.data.black, #gm.client.data.black, black)
        black.Think = function()
            if alpha < 255 then
                alpha = math.Clamp(alpha + (fade * FrameTime()), 0, 255)
                black:SetAlpha(alpha)
                lerp = true
            end
            timer.Simple(time, function()
                if lerp == true then
                    alpha = math.Clamp(alpha - (fade * FrameTime()), 0, 255)
                    black:SetAlpha(alpha)
                end
                if alpha <= 0 then
                    lerp = false
                    black:Remove()
                end
            end)
        end
        gm.client.data.active = true
    else
        for k,v in pairs(gm.client.data.black) do
            k = nil
            v:Remove()
        end
        gm.client.data.active = false
    end
end

net.Receive("GM2:Tools:BlackScreen", function(len, ply)
    local ranks = net.ReadTable()
    local time = net.ReadInt(32)
    local fade = net.ReadInt(32)

    if !ranks[LocalPlayer():GetUserGroup()] then
        gm.client.menus.blackscreen(time, fade)
    end
end)