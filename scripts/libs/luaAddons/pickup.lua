if proxy == nil then
	_G.proxy = require('luaAddons.proxy')
end
local inspect = require("inspect")
local pickups = {}

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function proxy.Pickup(id,bs,size)
	if id == 95 then
		local bs = bitStreamInit(bs, size)
		local data = {}
		local pId = bitStreamReadDWord(bs)
		data.model = bitStreamReadDWord(bs)
		data.pickupType = bitStreamReadDWord(bs)
		local px = bitStreamReadFloat(bs)
		local py = bitStreamReadFloat(bs)
		local pz = bitStreamReadFloat(bs)
		data.position = {x=px,y=py,z=pz}
		pickups[pId] = data
		bitStreamDelete(bs)
		if type(onPickupCreate) == 'function' then
			onPickupCreate(pId, data)
		end
	elseif id == 63 then
		local bs = bitStreamInit(bs, size)
		local pId = bitStreamReadDWord(bs)
		local data = shallowcopy(pickups[pId])
		pickups[pId] = nil
		bitStreamDelete(bs)
		if type(onPickupDestroy) == 'function' then
			onPickupDestroy(pId, data)
		end
	end
end

local function check(id,e)
	id = tonumber(id)
	if pickups[id] == nil then
		return nil
	end
	if e then
		return pickups[id][e]
	end
	return pickups[id]
end

function getAllPickups()
	return pickups
end

function getPickupType(pId)
	return check(pId, 'pickupType')
end

function getPickupModel(pId)
	return check(pId, 'model')
end

function getPickupCoordinates(pId)
	return check(pId, 'position') 
end

function doesPickupExist(pId)
	return check(pId) and true or false
end