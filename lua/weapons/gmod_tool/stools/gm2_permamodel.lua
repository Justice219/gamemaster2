TOOL.Category		=	"Gamemaster 2"
TOOL.Name			=	"Perma Model"
TOOL.Command		=	nil
TOOL.ConfigName		=	""

TOOL.ClientConVar["model"] = ""

if CLIENT then
	language.Add("Tool.gm2_permamodel.name", "PermaModel")
	language.Add("Tool.gm2_permamodel.desc", "Permanently changes a players model")
	language.Add("Tool.gm2_permamodel.0", "Left Click: Model Player, Reload: Self Model, Empty Model Path: Remove Model")
	language.Add("tool.gm2_permamodel.model", "Model String:")

	surface.CreateFont("PermaModelToolScreenFont", { font = "Arial", size = 40, weight = 1000, antialias = true, additive = false })
	surface.CreateFont("PermaModelToolScreenSubFont", { font = "Arial", size = 30, weight = 1000, antialias = true, additive = false })
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end

	gm = gm or {}
	gm.server = gm.server or {}
	gm.server.db = gm.server.db or {}
	gm.server.errors = gm.server.errors or {}

	local ent = trace.Entity
	local ply = self:GetOwner()

	if IsValid(ent) and ent:IsPlayer() then
		if self:GetClientInfo("model") == "" then
			local val = gm.server.db.loadAll("gm2_permamodel", "model_tbl")
			if val then
				local tbl = util.JSONToTable(val)
				tbl[ent:SteamID()] = nil
				ply:JLIBChatNotify("PermaModel","This player's model has been removed.")
				ent:JLIBChatNotify("PermaModel","Your model has been removed.")
				gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))
			end
		else
			local val = gm.server.db.loadAll("gm2_permamodel", "model_tbl")
			if val then
				local tbl = util.JSONToTable(val)
				tbl[ent:SteamID()] = self:GetClientInfo("model")
				gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))
				
				ply:JLIBChatNotify("PermaModel", "model has been set")
				ent:JLIBChatNotify("PermaModel", "model has been set")
				ent:SetModel(self:GetClientInfo("model"))
			else
				local tbl = {}
				tbl[ent:SteamID()] = self:GetClientInfo("model")
				gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))

				ent:SetModel(self:GetClientInfo("model"))
				ply:JLIBChatNotify("PermaModel", "model has been set")
				ent:JLIBChatNotify("PermaModel", "model has been set")
			end
		end
	else
		ply:JLIBChatNotify("PermaModel", "You must target a player.")
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
	gm.server.db = gm.server.db or {}
	gm.server.errors = gm.server.errors or {}


	local ply = self:GetOwner()
	if self:GetClientInfo("model") == "" then
		local val = gm.server.db.loadAll("gm2_permamodel", "model_tbl")
		if val then
			local tbl = util.JSONToTable(val)
			tbl[ply:SteamID()] = nil
			ply:JLIBChatNotify("PermaModel","Your model has been removed if you had one.")
			gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))
		end
	else
		local val = gm.server.db.loadAll("gm2_permamodel", "model_tbl")
		if val then
			local tbl = util.JSONToTable(val)
			tbl[ply:SteamID()] = self:GetClientInfo("model")
			gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))
			
			ply:JLIBChatNotify("PermaModel", "model has been set")
			ply:SetModel(self:GetClientInfo("model"))
		else
			local tbl = {}
			tbl[ply:SteamID()] = self:GetClientInfo("model")
			gm.server.db.updateAll("gm2_permamodel", "model_tbl", util.TableToJSON(tbl))

			ply:SetModel(self:GetClientInfo("model"))
			ply:JLIBChatNotify("PermaModel", "model has been set")
		end
	end

	return true
end

function TOOL.BuildCPanel(panel)

	panel:AddControl("Header",{Text = "PermaModel", Description = "Perma Model\n Permanently changes a players model!\n"})
	panel:AddControl("TextBox",{Label = "#tool.gm2_permamodel.model", Command = "gm2_permamodel_model"})

end

function TOOL:DrawToolScreen(width, height)

	if SERVER then return end

	surface.SetDrawColor(17, 148, 240, 255)
	surface.DrawRect(0, 0, 256, 256)

	surface.SetFont("PermaModelToolScreenFont")
	local w, h = surface.GetTextSize(" ")
	surface.SetFont("PermaModelToolScreenSubFont")
	local w2, h2 = surface.GetTextSize(" ")

	draw.SimpleText("Perma Model", "PermaModelToolScreenFont", 128, 100, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	draw.SimpleText("By Justice", "PermaModelToolScreenSubFont", 128, 128 + (h + h2) / 2 - 4, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)

end
