TOOL.Category		=	"Gamemaster 2"
TOOL.Name			=	"Temp Weapon"
TOOL.Command		=	nil
TOOL.ConfigName		=	""

TOOL.ClientConVar["weapon"] = ""

if CLIENT then
	language.Add("Tool.gm2_tempweapon.name", "Temp Weapon")
	language.Add("Tool.gm2_tempweapon.desc", "Gives a player a temporary weapon.")
	language.Add("Tool.gm2_tempweapon.0", "Left Click: Give, Right Click: Remove, Reload:Self")
	language.Add("tool.gm2_tempweapon.weapon", "Weapon String:")

	surface.CreateFont("TempWeaponToolScreenFont", { font = "Arial", size = 40, weight = 1000, antialias = true, additive = false })
	surface.CreateFont("TempWeaponToolScreenSubFont", { font = "Arial", size = 30, weight = 1000, antialias = true, additive = false })
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end

	gm = gm or {}
	gm.server = gm.server or {}
	gm.server.data = gm.server.data or {}
	gm.server.data.tempweapon = gm.server.data.tempweapon or {}	

	if IsValid(trace.Entity) and trace.Entity:IsPlayer() then

		local wep = self:GetClientInfo("weapon")
		local ply = trace.Entity
		gm.server.data.tempweapon[ply:SteamID()] = gm.server.data.tempweapon[ply:SteamID()] or {}
	
		local yuh = gm.server.data.tempweapon[ply:SteamID()]
		if yuh[wep] then
			ply:StripWeapon(wep)
			yuh[wep] = nil
			ply:JLIBChatNotify("Temp Weapon", " removed your temporary weapon.")
		else
			ply:Give(wep)
			yuh[wep] = true
			ply:JLIBChatNotify("Temp Weapon", "You have been given a temporary weapon.")
		end
		
		self:GetOwner():JLIBChatNotify("Temp Weapon", "You have given "..ply:Nick().." a temporary weapon.")

	end

	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
	
	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end

	gm = gm or {}
	gm.server = gm.server or {}
	gm.server.data = gm.server.data or {}
	gm.server.data.tempweapon = gm.server.data.tempweapon or {}	

	local wep = self:GetClientInfo("weapon")
	local ply = self:GetOwner()
	gm.server.data.tempweapon[ply:SteamID()] = gm.server.data.tempweapon[ply:SteamID()] or {}

	local yuh = gm.server.data.tempweapon[ply:SteamID()]
	if yuh[wep] then
		ply:StripWeapon(wep)
		yuh[wep] = nil
		ply:JLIBChatNotify("Temp Weapon","You have removed your temporary weapon.")
	else
		ply:Give(wep)
		yuh[wep] = true
		ply:JLIBChatNotify("Temp Weapon", "You have been given a temporary weapon.")
	end

	return true
end

function TOOL.BuildCPanel(panel)

	panel:AddControl("Header",{Text = "Temp Weapon", Description = "Temp Weapon\n Gives a player a temporary weapon until the server restarts, map changes, or is removed.\n"})
	panel:AddControl("TextBox",{Label = "#tool.gm2_tempweapon.weapon", Command = "gm2_tempweapon_weapon"})

end

function TOOL:DrawToolScreen(width, height)

	if SERVER then return end

	surface.SetDrawColor(17, 148, 240, 255)
	surface.DrawRect(0, 0, 256, 256)

	surface.SetFont("TempWeaponToolScreenFont")
	local w, h = surface.GetTextSize(" ")
	surface.SetFont("TempWeaponToolScreenSubFont")
	local w2, h2 = surface.GetTextSize(" ")

	draw.SimpleText("Temp Weapon", "TempWeaponToolScreenFont", 128, 100, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	draw.SimpleText("By Justice", "TempWeaponToolScreenSubFont", 128, 128 + (h + h2) / 2 - 4, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)

end
