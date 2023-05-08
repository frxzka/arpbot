if proxy == nil then
	proxy = dofile(getRakBotPath()..'\\scripts\\libs\\luaAddons\\proxy.lua')
end
local objs = {}
local MATERIAL_TYPE = {
	NONE = 0,
	TEXTURE = 1,
	TEXT = 2,
}
function proxy.Object(id, data, size)
	if id == 44 then
		local bs = bitStreamInit(data, size)
		local data = {materials = {}}
		local objectId = bitStreamReadWord(bs) -- 2
		data.modelId = bitStreamReadDWord(bs) -- 4
		local px = bitStreamReadFloat(bs) -- 4
		local py = bitStreamReadFloat(bs) -- 4
		local pz = bitStreamReadFloat(bs) -- 4
		data.position = {x=px,y=py,z=pz}
		local rx = bitStreamReadFloat(bs) -- 4
		local ry = bitStreamReadFloat(bs) -- 4
		local rz = bitStreamReadFloat(bs) -- 4
		data.rotation = {x=rx,y=ry,z=rz}
		data.drawDistance = bitStreamReadFloat(bs) -- 4
		data.noCameraCol = bitStreamReadByte(bs) ~= 0 -- 1
		data.attachToVehicleId = bitStreamReadWord(bs) -- 2
		data.attachToObjectId = bitStreamReadWord(bs) -- 2
		if data.attachToVehicleId ~= 65535 or data.attachToObjectId ~= 65535 then
			local aox = bitStreamReadFloat(bs)
			local aoy = bitStreamReadFloat(bs)
			local aoz = bitStreamReadFloat(bs)
			data.attachOffsets = {x=aox,y=aoy,z=aoz}
			local arx = bitStreamReadFloat(bs)
			local ary = bitStreamReadFloat(bs)
			local arz = bitStreamReadFloat(bs)
			data.attachRotation = {x=arx,y=ary,z=arz}
			data.syncRotation = bitStreamReadByte(bs) ~= 0
		end
		data.texturesCount = bitStreamReadByte(bs) -- 1
		if bitStreamSize(bs) >= 1 then
			local materialType = bitStreamReadByte(bs)
			if materialType == MATERIAL_TYPE.TEXTURE then
				local mdata = {}
				mdata.materialId = bitStreamReadByte(bs)
				mdata.modelId = bitStreamReadWord(bs)
				local l = bitStreamReadByte(bs)
				if l <= 0 then mdata.libraryName = '' else mdata.libraryName = bitStreamReadString(bs, l) end
				l = bitStreamReadByte(bs)
				if l <= 0 then mdata.textureName = '' else mdata.textureName = bitStreamReadString(bs, l) end
				mdata.color = bitStreamReadDWord(bs)
				mdata.type = MATERIAL_TYPE.TEXTURE
				data.materials = mdata
			elseif materialType == MATERIAL_TYPE.TEXT then
				data.materials.type = MATERIAL_TYPE.TEXT
			end
		end
		bitStreamDelete(bs)
		objs[objectId] = data
		if type(onObjectCreate) == 'function' then
			onObjectCreate(objectId,data)
		end
	end
	if id == 45 then
		local bs = bitStreamInit(data, size)
		local data = {}
		local objectId = bitStreamReadWord(bs)
		local px = bitStreamReadFloat(bs)
		local py = bitStreamReadFloat(bs)
		local pz = bitStreamReadFloat(bs)
		data.position = {x=px,y=py,z=pz}
		if objs[objectId] ~= nil then
			objs[objectId].position = data.position
		end
		bitStreamDelete(bs)
		if type(onSetObjectPosition) == 'function' then
			onSetObjectPosition(objectId, data.position)
		end
	end
	if id == 46 then
		local bs = bitStreamInit(data, size)
		local data = {}
		local objectId = bitStreamReadWord(bs)
		local rx = bitStreamReadFloat(bs)
		local ry = bitStreamReadFloat(bs)
		local rz = bitStreamReadFloat(bs)
		data.rotation = {x=rx,y=ry,z=rz}
		if objs[objectId] ~= nil then
			objs[objectId].rotation = data.rotation
		end
		bitStreamDelete(bs)
		if type(onSetObjectRotation) == 'function' then
			onSetObjectRotation(objectId, data.rotation)
		end
	end
	if id == 47 then
		local bs = bitStreamInit(data, size)
		local data = {}
		local objectId = bitStreamReadWord(bs)
		objs[objectId] = nil
		bitStreamDelete(bs)
	end
end

local function check(id,e)
	id = tonumber(id)
	if objs[id] == nil then
		return nil
	end
	if e then
		return objs[id][e]
	end
	return objs[id]
end

function getAllObjects()
	return objs
end

function getObjectData(id)
	return check(id)
end

function getObjectCoordinates(id)
	data = check(id, 'position')
	if data ~= nil then
		return {true, data.x, data.y, data.z}
	end
	return {false, 0,0,0}
end

function doesObjectExist(id)
	data = check(id)
	if data ~= nil then
		return true
	end
	return false
end