local et = {}
function onRecvRpc(id, data, size)
	for k,v in pairs(et) do
		v(id,data,size)
	end
	if type(onRRpc) == 'function' then
		return onRRpc(id,data,size)
	end
end
return et