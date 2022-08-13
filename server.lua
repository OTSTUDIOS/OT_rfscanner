lib.callback.register("rfscanner:Scan", function(source)
    local src = source
    local frequencies = {}
    if Config.itemCheck then
        local scanner = exports.ox_inventory:Search(src, 'count', Config.item)
        if scanner == false or scanner < 1 then return frequencies end
    end
    local pCoords = GetEntityCoords(GetPlayerPed(src))
	for _, player in pairs(GetPlayers()) do
		if player ~= src then
            local dist = #(pCoords - GetEntityCoords(GetPlayerPed(player)))
            if dist <= Config.ScanRadius then             
                local frequency = Player(player).state.radioChannel
                if frequency ~= 0 then
                    frequencies[frequency] = {min = (frequency - math.random(10, Config.ScanRangeAccuracyMin * 10) / 10), max = (frequency + math.random(10, Config.ScanRangeAccuracyMax * 10) / 10)}
                end
            end
		end
	end
    return frequencies
end)