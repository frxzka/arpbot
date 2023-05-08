if proxy == nil then
    _G["proxy"] = require("luaAddons.proxy")
end

local interiorId = -1

function proxy.Other(id,bs,size)
    if id == 156 then
        local bs = bitStreamInit(bs,size)
        interiorId = bitStreamReadByte(bs)
        bitStreamDelete(bs)
        if type(onSetInterior) == 'function' then
            onSetInterior(interiorId)
        end
    end
end

function getInteriorId()
    return interiorId
end