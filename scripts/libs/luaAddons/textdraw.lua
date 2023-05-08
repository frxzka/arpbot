if proxy == nil then
	_G.proxy = require('luaAddons.proxy')
end
local tds = {}

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

function proxy.Textdraw(id, data, size)
	if id == 134 then
		local bs = bitStreamInit(data, size)
		local data = {}
		local textdrawId = bitStreamReadWord(bs)
		data.flags = bitStreamReadByte(bs)
		data.letterWidth = bitStreamReadFloat(bs)
		data.letterHeight = bitStreamReadFloat(bs)
		data.letterColor = bitStreamReadDWord(bs)
		data.lineWidth = bitStreamReadFloat(bs)
		data.lineHeight = bitStreamReadFloat(bs)
		data.boxColor = bitStreamReadDWord(bs)
		data.shadow = bitStreamReadByte(bs)
		data.outline = bitStreamReadByte(bs)
		data.backgroundColor = bitStreamReadDWord(bs)
		data.style = bitStreamReadByte(bs)
		data.selectable = bitStreamReadByte(bs)
		local vx = bitStreamReadFloat(bs)
		local vy = bitStreamReadFloat(bs)
		data.position = {x=vx,y=vy}
		data.modelId = bitStreamReadWord(bs)
		local vx = bitStreamReadFloat(bs)
		local vy = bitStreamReadFloat(bs)
		local vz = bitStreamReadFloat(bs)
		data.rotation = {x=vx,y=vy,z=vz}
		data.zoom = bitStreamReadFloat(bs)
		data.color = bitStreamReadDWord(bs)
		local l = bitStreamReadWord(bs)
		if l <= 0 then
			data.text = ''
		else
			data.text = bitStreamReadString(bs, l)
		end
		tds[textdrawId] = data
		bitStreamDelete(bs)
		if type(onShowTextDraw) == 'function' then
			onShowTextDraw(textdrawId,data)
		end
	end
	if id == 105 then
		local bs = bitStreamInit(data, size)
		local data = {}
		local textdrawId = bitStreamReadWord(bs)
		local l = bitStreamReadWord(bs)
		if l <= 0 then
			data.text = ''
		else
			data.text = bitStreamReadString(bs, l)
		end
		bitStreamDelete(bs)
		if tds[textdrawId] ~= nil then
			tds[textdrawId].text = data.text
		end
	end
	if id == 135 then
		local bs = bitStreamInit(data, size)
		local textdrawId = bitStreamReadWord(bs)
		local data = shallowcopy(tds[textdrawId])
		tds[textdrawId] = nil
		bitStreamDelete(bs)
		if type(onHideTextDraw) == "function" then
			onHideTextDraw(textdrawId, data)
		end
	end
end

local function check(id,e)
	id = tonumber(id)
	if tds[id] == nil then
		return nil
	end
	if e then
		return tds[id][e]
	end
	return tds[id]
end

function sampTextdrawGetString(id)
	return check(id,'text')
end

function sampTextdrawGetData(id)
	return check(id)
end

function sampTextdrawGetStyle(id)
	return check(id,'style')
end

function sampTextdrawGetPos(id)
	return check(id,'position') 
end

function sampTextdrawGetShadowColor(id)
	data = sampTextdrawGetData(id)
	if data ~= nil then
		return {data.shadow, data.color}
	end
	return nil
end

function sampTextdrawGetLetterSizeAndColor(id)
	data = sampTextdrawGetData(id)
	if data ~= nil then
		return {data.letterWidth, data.letterHeight, data.letterColor}
	end
	return nil
end

function sampTextdrawGetModelRotationZoomVehColor(id)
	data = sampTextdrawGetData(id)
	if data ~= nil then
		return {data.modelId, data.rotation.x, data.rotation.y, data.rotation.z, data.zoom, data.color, data.backgroundColor}
	end
	return nil
end

function sampTextdrawIsExists(id)
	if sampTextdrawGetData(id) then
		return true
	end
	return false
end
