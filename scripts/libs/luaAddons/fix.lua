function table.pack(...)
    return { n = select("#", ...); ... }
end

_G["print"] = function(...)
    local str = ""
    local args = table.pack(...)
    for i = 1, args.n do
        str = str .. tostring(args[i]) .. "    "
    end
    printLog(str:gsub("%%","#"))
end