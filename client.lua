ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

function MenuPeds()
    local MenuPeds = RageUI.CreateMenu("Menu Peds", "~b~Menu des différents Peds.")


        RageUI.Visible(MenuPeds, not RageUI.Visible(MenuPeds))
        while MenuPeds do
            Citizen.Wait(0)


                    RageUI.IsVisible(MenuPeds, true, true, true, function()

                    RageUI.Separator("↓ Reprendre sa forme Normal ↓")

                            RageUI.ButtonWithStyle("Normal", "Pour se remettre en normal", {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    Normalemode()
                                end
                            end)

                            RageUI.Separator('')
                            RageUI.Separator('↓ Peds Définit ↓')
                            RageUI.Separator('')

                            RageUI.ButtonWithStyle("A choisir", "Pour choisir un ped", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local j1 = PlayerId()
                                    local PedPerso = KeyboardInput('Ecrit Ton Ped Ici', '', 45)
                                    local p1 = GetHashKey(PedPerso)
                                    RequestModel(p1)
                                    while not HasModelLoaded(p1) do
                                      Wait(100)
                                     end
                                     SetPlayerModel(j1, p1)
                                     SetModelAsNoLongerNeeded(p1)
                                end      
                            end)

                        for _, v in pairs (Config.Peds) do
                            RageUI.ButtonWithStyle(v.namepeds, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local j1 = PlayerId()
                                    local p1 = GetHashKey(v.modelpeds)
                                    local namepeds = v.namepeds
                                    RequestModel(p1)
                                    while not HasModelLoaded(p1) do
                                      Wait(100)
                                     end
                                     SetPlayerModel(j1, p1)
                                     SetModelAsNoLongerNeeded(p1)
                                end
                            end)
                        end

                end, function() 
                end)

                if not RageUI.Visible(MenuPeds) and not RageUI.Visible(MenuPeds) then
                    MenuPeds = RMenu:DeleteType("", true)
        end
    end
end


Keys.Register('F6', 'Peds', 'Ouvrir le menu Peds', function()
    ESX.TriggerServerCallback("Menu-Peds:getUsergroup",function(group)
    if (group) == 'superadmin' or (group) == 'admin' or (group) == 'mod' then
    	MenuPeds()
    end
    end)
end)