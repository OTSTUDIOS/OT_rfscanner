local function ScanRF()
    local frequencies = lib.callback.await('rfscanner:Scan', false)
    if table.type(frequencies) == 'empty' then lib.notify({type = 'inform', description = 'No channels found in area'}) return end
    local options = {}
    for k, v in pairs(frequencies) do
        options[#options + 1] = {id = 'scanned_frequency_' .. k, icon = "fa-solid fa-rss", title = v.min ..' MHz ~ '..v.max .." MHz"}
    end
    lib.registerContext({id = 'rf_menu', title = 'Frequencies', options = options})
    lib.showContext('rf_menu')
end

RegisterNetEvent("rfscanner:frequencyScan", function()
    if lib.progressBar({
        duration = Config.useTime,
        label = 'Scanning frequencies',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            scenario = 'WORLD_HUMAN_STAND_MOBILE'
        },
    }) then ScanRF() end
end)