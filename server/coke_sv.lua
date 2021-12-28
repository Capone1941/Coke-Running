ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local process = vector3(1980.26, -2613.06, 3.55)
local startrun = vector3(734.34, -1295.0, 27.04)

RegisterNetEvent('coke:UPDT')
AddEventHandler('coke:UPDT', function(boolean)
    TriggerClientEvent('coke:synchroT', -1, boolean)
end)

ESX.RegisterUsableItem('cokebaggy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cokebaggy', 1)
	TriggerClientEvent('coke:onUse', source)
end)

ESX.RegisterServerCallback('coke:processingcoords', function(source, cb)
    cb(process)
end)

ESX.RegisterServerCallback('coke:startcoords', function(source, cb)
    cb(startrun)
end)

ESX.RegisterServerCallback('coke:payment', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = 25000
	local check = xPlayer.getMoney()
	if check >= price then
		xPlayer.removeMoney(price)
    	cb(true)
    else
		exports['mythic_notify']:DoCustomHudText('error', 'You do not have enough cash to pay George', 3000)
    	cb(false)
    end
end)

ESX.RegisterServerCallback('coke:process', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cockcheck = xPlayer.getInventoryItem('cokebrick').count
	if cockcheck >= 1 then
    	cb(true)
    else
		exports['mythic_notify']:DoCustomHudText('error', 'You dont have a brick to break down Tard', 3000)
    	cb(false)
    end
end)

RegisterServerEvent("coke:processed")
AddEventHandler("coke:processed", function(x,y,z)
  	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('cokebaggy', math.random(7, 15))
	xPlayer.addInventoryItem('oxy', math.random(1,4)) -- added it cus why not SUCK OUT LMAO
end)

RegisterServerEvent("coke:proc")
AddEventHandler("coke:proc", function(x,y,z)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cokebrick', 1)
end)

RegisterServerEvent("coke:GiveItem")
AddEventHandler("coke:GiveItem", function()
  	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('cokebrick', math.random(1, 3))
end)