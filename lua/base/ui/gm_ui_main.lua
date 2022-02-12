gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}
gm.client.data = gm.client.data or {}
gm.client.data.main = gm.client.data.main or {}

function gm.client.menus.main()
    local tabs = {}
    local data = {}
    local funcs = {}

    local function ScaleW(size)
        return ScrW() * size/1920
    end
    local function ScaleH(size)
        return ScrH() * size/1080        
    end

    surface.CreateFont("menu_title", {
        font = "Roboto",
        size = 20,
        weight = 500,
        antialias = true,
        shadow = false
    })
    surface.CreateFont("menu_button", {
        font = "Roboto",
        size = 22.5,
        weight = 500,
        antialias = true,
        shadow = false
    })

    local panel = vgui.Create("DFrame")
    panel:TDLib()
    panel:SetTitle("GM2 by Justice#4956")
    panel:ShowCloseButton(false)
    panel:SetSize(ScaleW(960), ScaleH(540))
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 6)
        :Text("Gamemaster 2", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(410), ScaleH(-240))
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(5),ScaleH(250))
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(ScaleW(0), ScaleH(60))
    panel2:SetSize(ScaleW(1920), ScaleH(5))
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(ScaleW(275), ScaleH(60))
    panel3:SetSize(ScaleW(5), ScaleH(1000))
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(ScaleW(925),ScaleH(10))
    close:SetSize(ScaleW(20),ScaleH(20))
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(ScaleW(17.5), ScaleH(75))
    scroll:SetSize(ScaleW(240), ScaleW(425))
    scroll:TDLib()
    scroll:ClearPaint()
        --:Background(Color(0, 26, 255), 6)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local function ChangeTab(name)
        print("Changing Tab")
        for k,v in pairs(data) do
            table.RemoveByValue(data, v)
            v:Remove()
            print("Removed")
        end

        local tbl = tabs[name]
        tbl.change()

    end
    
    local function CreateTab(name, tbl)
        local scroll = scroll:Add( "DButton" )
        scroll:SetText( name)
        scroll:Dock( TOP )
        scroll:SetTall( 50 )
        scroll:DockMargin( 0, 5, 0, 5 )
        scroll:SetTextColor(Color(255,255,255))
        scroll:TDLib()
        scroll:SetFont("menu_button")
        scroll:SetIcon(tbl.icon)
        scroll:ClearPaint()
            :Background(Color(59, 59, 59), 5)
            :BarHover(Color(255, 255, 255), 3)
            :CircleClick()
        scroll.DoClick = function()
            ChangeTab(name)
        end

        if tabs[name] then return end
        tabs[name] = tbl
    end
    CreateTab("Main", {
        icon = "icon16/application_view_tile.png",
        change = function()
            local d = {}
            local p = nil

            main = panel:Add("DPanel")
            main:SetPos(ScaleW(290), ScaleH(75))
            main:SetSize(ScaleW(660), ScaleH(455))
            main:TDLib()
            main:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Main Tools", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))
            table.insert(d, #d, main)


            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Player", {
        icon = "icon16/user.png",
        change = function()
            local d = {}
            local p = nil
            local sel = nil
            local a = {}

            server = panel:Add("DPanel")
            server:SetPos(ScaleW(290), ScaleH(75))
            server:SetSize(ScaleW(660), ScaleH(455))
            server:TDLib()
            server:ClearPaint()
                :Background(Color(59,59,59), 6)
                :Text("Server Tools", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(250),ScaleH(-202.5))
            table.insert(d, #d, server)

            scroll = panel:Add("DScrollPanel")
            scroll:SetPos(ScaleW(300), ScaleH(125))
            scroll:SetSize(ScaleW(240), ScaleH(400))
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)
            
            infop = panel:Add("DPanel")
            infop:SetPos(ScaleW(550), ScaleH(125))
            infop:SetSize(ScaleW(390), ScaleH(400))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            name = infop:Add("DLabel")
            name:SetPos(ScaleW(15), ScaleH(15))
            name:SetSize(ScaleW(200), ScaleH(25))
            name:SetFont("menu_title")
            name:SetText("Name: ")
            name:TDLib()
            name:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            desc = infop:Add("RichText")
            desc:SetPos(ScaleW(15), ScaleH(50))
            desc:SetSize(ScaleW(375), ScaleH(125))
            desc:SetText("Description: ")

            args = infop:Add("DScrollPanel")
            args:SetPos(ScaleW(15), ScaleH(200))
            args:SetSize(ScaleW(360), ScaleH(125))
            args:TDLib()
            args:ClearPaint()
                :Background(Color(127,173,127), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            run = infop:Add("DButton")
            run:SetPos(ScaleW(15), ScaleH(360))
            run:SetSize(ScaleW(360), ScaleH(25))
            run:SetText("Run")
            run:SetTextColor(Color(255, 255, 255))
            run:TDLib()
            run:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            run.DoClick = function()
                if !sel then return end

                net.Start("GM2:Tools:Run")
                net.WriteString(sel.name)
                net.WriteTable(sel.args)
                net.SendToServer()
            end

            for k,v in pairs(gm.client.data.tools) do
                if v.category != "Player" then continue end
                local button = scroll:Add( "DButton" )
                button:SetText( v.name )
                button:Dock( TOP )
                button:SetTall( 50 )
                button:DockMargin( 5, 5, 5, 5 )
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:SetFont("menu_button")
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    sel = v
                    name:SetText("Name: "..v.name)
                    desc:SetText("Description: "..v.desc)

                    args:Clear()

                    for k,v in pairs(v.args) do
                        local label = args:Add( "DLabel" )
                        label:SetText( v.name )
                        label:SetTextColor(Color(255,255,255))
                        label:SetFont("menu_button")
                        label:Dock( TOP )
                        label:DockMargin( 5, 5, 5, 5 )
                        label:TDLib()
                        label:ClearPaint()
                            :Background(Color(59, 59, 59), 5)
                            :BarHover(Color(255, 255, 255), 3)
                            :CircleClick()
                        table.insert(a, #a, label)

                        if v.type == "number" then
                            local number = args:Add("DTextEntry")
                            number:Dock(TOP)
                            number:SetTall(25)
                            number:DockMargin(5, 5, 5, 5)
                            number:SetText(v.def)
                            number:SetFont("menu_button")
                            number:SetUpdateOnType(true)
                            number.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            number.OnValueChange = function(self)
                                if !sel then return end
                                local num = tonumber(self:GetValue())
                                if !num then return end
                                sel.args[v.name].def = num
                            end
                            table.insert(a, #a, number)
                        elseif v.type == "string" then
                            local str = args:Add("DTextEntry")
                            str:Dock(TOP)
                            str:SetTall(25)
                            str:DockMargin(5, 5, 5, 5)
                            str:SetText(v.def)
                            str:SetFont("menu_button")
                            str:SetUpdateOnType(true)
                            str.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            str.OnValueChange = function(self)
                                if !sel then return end
                                PrintTable(sel.args)
                                print(v.name)
                                sel.args[v.name].def = str:GetValue()
                            end
                        end
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("World", {
        icon = "icon16/world.png",
        change = function()
            local d = {}
            local p = nil
            local sel = nil
            local a = {}

            server = panel:Add("DPanel")
            server:SetPos(ScaleW(290), ScaleH(75))
            server:SetSize(ScaleW(660), ScaleH(455))
            server:TDLib()
            server:ClearPaint()
                :Background(Color(59,59,59), 6)
                :Text("World Tools", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(250),ScaleH(-202.5))
            table.insert(d, #d, server)

            scroll = panel:Add("DScrollPanel")
            scroll:SetPos(ScaleW(300), ScaleH(125))
            scroll:SetSize(ScaleW(240), ScaleH(400))
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)
            
            infop = panel:Add("DPanel")
            infop:SetPos(ScaleW(550), ScaleH(125))
            infop:SetSize(ScaleW(390), ScaleH(400))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            name = infop:Add("DLabel")
            name:SetPos(ScaleW(15), ScaleH(15))
            name:SetSize(ScaleW(200), ScaleH(25))
            name:SetFont("menu_title")
            name:SetText("Name: ")
            name:TDLib()
            name:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            desc = infop:Add("RichText")
            desc:SetPos(ScaleW(15), ScaleH(50))
            desc:SetSize(ScaleW(375), ScaleH(125))
            desc:SetText("Description: ")

            args = infop:Add("DScrollPanel")
            args:SetPos(ScaleW(15), ScaleH(200))
            args:SetSize(ScaleW(360), ScaleH(125))
            args:TDLib()
            args:ClearPaint()
                :Background(Color(127,173,127), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            run = infop:Add("DButton")
            run:SetPos(ScaleW(15), ScaleH(360))
            run:SetSize(ScaleW(360), ScaleH(25))
            run:SetText("Run")
            run:SetTextColor(Color(255, 255, 255))
            run:TDLib()
            run:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            run.DoClick = function()
                if !sel then return end

                net.Start("GM2:Tools:Run")
                net.WriteString(sel.name)
                net.WriteTable(sel.args)
                net.SendToServer()
            end

            for k,v in pairs(gm.client.data.tools) do
                if v.category != "World" then continue end
                local button = scroll:Add( "DButton" )
                button:SetText( v.name )
                button:Dock( TOP )
                button:SetTall( 50 )
                button:DockMargin( 5, 5, 5, 5 )
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:SetFont("menu_button")
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    sel = v
                    name:SetText("Name: "..v.name)
                    desc:SetText("Description: "..v.desc)

                    args:Clear()

                    for k,v in pairs(v.args) do
                        local label = args:Add( "DLabel" )
                        label:SetText( v.name )
                        label:SetTextColor(Color(255,255,255))
                        label:SetFont("menu_button")
                        label:Dock( TOP )
                        label:DockMargin( 5, 5, 5, 5 )
                        label:TDLib()
                        label:ClearPaint()
                            :Background(Color(59, 59, 59), 5)
                            :BarHover(Color(255, 255, 255), 3)
                            :CircleClick()
                        table.insert(a, #a, label)

                        if v.type == "number" then
                            local number = args:Add("DTextEntry")
                            number:Dock(TOP)
                            number:SetTall(25)
                            number:DockMargin(5, 5, 5, 5)
                            number:SetText(v.def)
                            number:SetFont("menu_button")
                            number:SetUpdateOnType(true)
                            number.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            number.OnValueChange = function(self)
                                if !sel then return end
                                local num = tonumber(self:GetValue())
                                if !num then return end
                                sel.args[v.name].def = num
                            end
                            table.insert(a, #a, number)
                        elseif v.type == "string" then
                            local str = args:Add("DTextEntry")
                            str:Dock(TOP)
                            str:SetTall(25)
                            str:DockMargin(5, 5, 5, 5)
                            str:SetText(v.def)
                            str:SetFont("menu_button")
                            str:SetUpdateOnType(true)
                            str.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            str.OnValueChange = function(self)
                                if !sel then return end
                                sel.args[v.name].def = str:GetValue()
                            end
                        end
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Server", {
        icon = "icon16/server.png",
        change = function()
            local d = {}
            local p = nil
            local sel = nil
            local a = {}

            server = panel:Add("DPanel")
            server:SetPos(ScaleW(290), ScaleH(75))
            server:SetSize(ScaleW(660), ScaleH(455))
            server:TDLib()
            server:ClearPaint()
                :Background(Color(59,59,59), 6)
                :Text("Server Tools", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(250),ScaleH(-202.5))
            table.insert(d, #d, server)

            scroll = panel:Add("DScrollPanel")
            scroll:SetPos(ScaleW(300), ScaleH(125))
            scroll:SetSize(ScaleW(240), ScaleH(400))
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)
            
            infop = panel:Add("DPanel")
            infop:SetPos(ScaleW(550), ScaleH(125))
            infop:SetSize(ScaleW(390), ScaleH(400))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            name = infop:Add("DLabel")
            name:SetPos(ScaleW(15), ScaleH(15))
            name:SetSize(ScaleW(200), ScaleH(25))
            name:SetFont("menu_title")
            name:SetText("Name: ")
            name:TDLib()
            name:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            desc = infop:Add("RichText")
            desc:SetPos(ScaleW(15), ScaleH(50))
            desc:SetSize(ScaleW(375), ScaleH(125))
            desc:SetText("Description: ")

            args = infop:Add("DScrollPanel")
            args:SetPos(ScaleW(15), ScaleH(200))
            args:SetSize(ScaleW(360), ScaleH(125))
            args:TDLib()
            args:ClearPaint()
                :Background(Color(127,173,127), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            run = infop:Add("DButton")
            run:SetPos(ScaleW(15), ScaleH(360))
            run:SetSize(ScaleW(360), ScaleH(25))
            run:SetText("Run")
            run:SetTextColor(Color(255, 255, 255))
            run:TDLib()
            run:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            run.DoClick = function()
                if !sel then return end

                net.Start("GM2:Tools:Run")
                net.WriteString(sel.name)
                net.WriteTable(sel.args)
                net.SendToServer()
            end

            for k,v in pairs(gm.client.data.tools) do
                if v.category != "Server" then continue end
                local button = scroll:Add( "DButton" )
                button:SetText( v.name )
                button:Dock( TOP )
                button:SetTall( 50 )
                button:DockMargin( 5, 5, 5, 5 )
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:SetFont("menu_button")
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    sel = v
                    name:SetText("Name: "..v.name)
                    desc:SetText("Description: "..v.desc)

                    args:Clear()

                    for k,v in pairs(v.args) do
                        local label = args:Add( "DLabel" )
                        label:SetText( v.name )
                        label:SetTextColor(Color(255,255,255))
                        label:SetFont("menu_button")
                        label:Dock( TOP )
                        label:DockMargin( 5, 5, 5, 5 )
                        label:TDLib()
                        label:ClearPaint()
                            :Background(Color(59, 59, 59), 5)
                            :BarHover(Color(255, 255, 255), 3)
                            :CircleClick()
                        table.insert(a, #a, label)

                        if v.type == "number" then
                            local number = args:Add("DTextEntry")
                            number:Dock(TOP)
                            number:SetTall(25)
                            number:DockMargin(5, 5, 5, 5)
                            number:SetText(v.def)
                            number:SetFont("menu_button")
                            number:SetUpdateOnType(true)
                            number.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            number.OnValueChange = function(self)
                                if !sel then return end
                                local num = tonumber(self:GetValue())
                                if !num then return end
                                sel.args[v.name].def = num
                            end
                            table.insert(a, #a, number)
                        elseif v.type == "string" then
                            local str = args:Add("DTextEntry")
                            str:Dock(TOP)
                            str:SetTall(25)
                            str:DockMargin(5, 5, 5, 5)
                            str:SetText(v.def)
                            str:SetFont("menu_button")
                            str:SetUpdateOnType(true)
                            str.Paint = function(self, w, h)
                                draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                                self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                            end
                            str.OnValueChange = function(self)
                                if !sel then return end
                                sel.args[v.name].def = str:GetValue()
                            end
                        end
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Config", {
        icon = "icon16/cog.png",
        change = function()
            local d = {}
            local p = nil

            config = panel:Add("DPanel")
            config:SetPos(ScaleW(290), ScaleH(75))
            config:SetSize(ScaleW(660), ScaleH(455))
            config:TDLib()
            config:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Addon Configuration", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))
            table.insert(d, #d, config)

            infop = config:Add("DPanel")
            infop:SetPos(ScaleW(15), ScaleH(50))
            infop:SetSize(ScaleW(630), ScaleH(385))
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 5)
                :Text("Information", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, ScaleW(210),ScaleH(-202.5))

            r = infop:Add("DButton")
            r:SetText("Panel Rank Access")
            r:SetSize(ScaleW(600), ScaleH(50))
            r:SetPos(ScaleW(15), ScaleH(30))
            r:SetFont("menu_button")
            r:SetTextColor(Color(255,255,255))
            r:TDLib()
            r:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            r.DoClick = function()
                local j = {}
                panel:Remove()

                pop = vgui.Create("DFrame")
                pop:SetSize(ScaleW(600), ScaleH(200))
                pop:Center()
                pop:ShowCloseButton(false)
                pop:MakePopup()
                pop:SetTitle("Job Access")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local close = pop:Add("DImageButton")
                close:SetPos(ScaleW(575), ScaleH(15))
                close:SetSize(ScaleW(20), ScaleH(20))
                close:SetImage("icon16/cross.png")
                close:TDLib()
                close.DoClick = function()

                    pop:Remove()
                end

                local scroll = pop:Add("DScrollPanel")
                scroll:SetPos(ScaleW(15), ScaleH(65))
                scroll:SetSize(ScaleW(570), ScaleH(100))
                scroll:TDLib()
                scroll:ClearPaint()
                    :Background(Color(40,41,40), 5)
                    :CircleClick()

                local entry = pop:Add("DTextEntry")
                entry:SetPos(ScaleW(15), ScaleH(30))
                entry:SetSize(ScaleW(500), ScaleH(30))
                entry:SetFont("menu_button")
                entry:SetText("Test")
                entry:SetTextColor(Color(255,255,255))
                entry.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59, 59, 59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local button = pop:Add("DButton")
                button:SetPos(ScaleW(510), ScaleH(30))
                button:SetSize(ScaleW(80), ScaleH(30))
                button:SetText("Add")
                button:SetFont("menu_button")
                button:SetTextColor(Color(255,255,255))
                button:TDLib()
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    if entry:GetValue() == "" then return end

                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(entry:GetValue())
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[entry:GetValue()] = true
                        else
                            j[entry:GetValue()] = false
                        end
                    end
                end

                finish = pop:Add("DButton")
                finish:SetPos(ScaleW(15), ScaleH(175))
                finish:SetSize(ScaleW(570), ScaleH(20))
                finish:SetText("Finish")
                finish:SetFont("menu_title")
                finish:SetTextColor(Color(255,255,255))
                finish:TDLib()
                finish:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                finish.DoClick = function()
                    net.Start("GM2:Net:PanelAccess")
                    net.WriteTable(j)
                    net.SendToServer()

                    pop:Remove()
                end

                for k,v in pairs(gm.client.data.main.ranks) do
                    t = scroll:Add("DCheckBoxLabel")
                    t:Dock(TOP)
                    t:DockMargin(5,5,5,5)
                    t:SetTall(25)
                    t:SetText(k)
                    t:SetFont("menu_button")
                    t:SetTextColor(Color(255,255,255))
                    t:TDLib()
                    t:ClearPaint()
                        :Background(Color(59, 59, 59), 5)
                        :BarHover(Color(255, 255, 255), 3)
                        :CircleClick()
                    function t:OnChange(val)
                        if val then
                            j[k] = true
                        else
                            j[k] = false
                        end
                    end

                    if gm.client.data.main.ranks[k] then
                        t:SetChecked(true)
                    end
                end
            end

            

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })

    ChangeTab("Server")
end