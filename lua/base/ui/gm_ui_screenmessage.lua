gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}

function gm.client.menus.screenmessage(message, color, duration, fade)
    surface.CreateFont("gm_screenmessage", {
        font = "Arial",
        size = ScreenScale(10),
        weight = 1000,
        antialias = true,
        shadow = true
    })
    print(message, color, duration, fade)

    local function ScaleW(size)
        return ScrW() * size/1920
    end
    local function ScaleH(size)
        return ScrH() * size/1080        
    end

    local alpha = 0
    local fade = fade or 75
    local lerp = false

    local back = vgui.Create("DPanel")
    back:SetSize(ScrW(), ScrH())
    back:SetPos(0, 0)
    back:SetBackgroundColor(color_black)
    back:SetAlpha(0)
    back.Paint = function(self, w, h)
        draw.RoundedBox( 6, 0, ScaleH(50), ScrW(), ScaleH(50), Color(41,41,41))
    end


    local label = vgui.Create("DLabel")
    label:SetFont("gm_screenmessage")
    label:SetText(message)
    label:SetTextColor(color)
    label:SetSize(ScrW(), ScaleH(50))
    label:SetAlpha(0)
    -- Lets make the label so its at the top of the screen
    label:SetPos(ScrW()/2 - ScaleW(900), ScrH()/2 - ScaleH(490))
    label.Think = function()
        if alpha < 255 then
            alpha = math.Clamp(alpha + (fade * FrameTime()), 0, 255)
            label:SetAlpha(alpha)
            back:SetAlpha(alpha)
            lerp = true 
        end
        timer.Simple(duration, function()
            if lerp == true then
                alpha = math.Clamp(alpha - (fade * FrameTime()), 0, 255)
                label:SetAlpha(alpha)
                back:SetAlpha(alpha)
            end
            if alpha <= 0 then
                lerp = false
                back:Remove()
                label:Remove()
            end
        end)
    end
end

net.Receive("GM2:Tools:ScreenMessage", function(len, ply)
    local msg = net.ReadString()
    local color = net.ReadColor()
    local time = net.ReadInt(32)
    local fade = net.ReadInt(32)

    gm.client.menus.screenmessage(msg, color, time, fade)
end)