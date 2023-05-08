if proxy == nil then
	proxy = dofile(getRakBotPath()..'\\scripts\\libs\\luaAddons\\proxy.lua')
end

local currRaceCheckPoint = {x = nil, y = nil, z = nil}

function proxy.Checkpoint(id,bs,size)
	if id == 107 then
		local bs = bitStreamInit(bs, size)
		local px = bitStreamReadFloat(bs)
		local py = bitStreamReadFloat(bs)
		local pz = bitStreamReadFloat(bs)
		local position = {x=px,y=py,z=pz}
		local radius = bitStreamReadFloat(bs)
		bitStreamDelete(bs)
		if type(onSetCheckpoint) == 'function' then
			onSetCheckpoint(position, radius)
		end
	end
	if id == 38 then
		local bs = bitStreamInit(bs, size)
		local typeC = bitStreamReadByte(bs)
		local px = bitStreamReadFloat(bs)
		local py = bitStreamReadFloat(bs)
		local pz = bitStreamReadFloat(bs)
		local position = {x=px,y=py,z=pz}
		currRaceCheckPoint = {x=px,y=py,z=pz}
		local npx = bitStreamReadFloat(bs)
		local npy = bitStreamReadFloat(bs)
		local npz = bitStreamReadFloat(bs)
		local nextPosition = {x=npx,y=npy,z=npz}
		local size = bitStreamReadFloat(bs)
		bitStreamDelete(bs)
		if type(onSetRaceCheckpoint) == 'function' then
			onSetRaceCheckpoint(typeC, position, nextPosition, size)
		end
	end
end

function getCurrentRaceCheckpoint()
	return {x = currRaceCheckPoint.x, y = currRaceCheckPoint.y, z = currRaceCheckPoint.z}
end