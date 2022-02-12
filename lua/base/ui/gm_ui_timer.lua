gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}
gm.client.data = gm.client.data or {}
gm.client.data.timer = gm.client.data.timer or {}
function gm.client.menus.timer(time, method)

    local function ScaleW(size)
        return ScrW() * size/1920
    end
    local function ScaleH(size)
        return ScrH() * size/1080        
    end

    surface.CreateFont("gm_timer_font", {
        font = "Roboto",
        size = ScaleH(50),
        weight = 500,
        antialias = true,
        shadow = false,
        stroke = true,
        outline = true
    })
    

    if method == "start" then
        for k,v in pairs(gm.client.data.timer) do
            k = nil
            v:Remove()
        end

        if timer.Exists("gm_timer") then
            timer.Remove("gm_timer")
        end

        timer.Create("gm_timer", time, 1, function()
            for k,v in pairs(gm.client.data.timer) do
                k = nil
                v:Remove()
            end
        end)

        local back = vgui.Create("DPanel")
        back:SetSize(ScrW(), ScrH())
        back:SetPos(0, 0)
        back.Paint = function(self, w, h)
            draw.RoundedBox( 6, 0, ScaleH(40), ScrW(), ScaleH(50), Color(41,41,41, 150))
        end
        table.insert(gm.client.data.timer, #gm.client.data.timer, back)

        local label = vgui.Create("DLabel")
        label:SetFont("gm_timer_font")
        label:SetTextColor(Color(255,255,255))
        label:SetSize(ScrW(200), ScaleH(50))
        -- Lets make the label so its at the top of the screen
        label:SetPos(ScrW()/2 - ScaleW(900), ScrH()/2 - ScaleH(500))
        label.Think = function()
            timeString = os.date( "%M Minute(s) %S Seconds" , timer.TimeLeft("gm_timer") ) .. " remaining"
            label:SetText(timeString)
        end
        table.insert(gm.client.data.timer, #gm.client.data.timer, label)

    elseif method == "stop" then
        if timer.Exists("gm_timer") then
            timer.Remove("gm_timer")
        end
        for k,v in pairs(gm.client.data.timer) do
            k = nil
            v:Remove()
        end
    end
end

net.Receive("GM2:Tools:ScreenTimerStart", function(len, ply)
    local time = net.ReadInt(32)
    gm.client.menus.timer(time, "start")
end)
net.Receive("GM2:Tools:ScreenTimerStop", function(len, ply)
    gm.client.menus.timer(0, "stop")
end)
net.Receive("GM2:Tools:ScreenTimerSync", function(len, ply)
    -- Aww lets get you synced up little buddy :)
    local time = net.ReadInt(32)
    gm.client.menus.timer(time, "start")
end)
