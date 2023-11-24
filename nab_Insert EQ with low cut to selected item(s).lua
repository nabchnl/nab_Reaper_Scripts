-- Get the currently selected media item
selectedItem = reaper.GetSelectedMediaItem(0, 0)

if selectedItem then
    -- Loop through all selected items
    for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
        selectedItem = reaper.GetSelectedMediaItem(0, i)
        
        if selectedItem then
            -- Get the active take of the selected media item
            activeTake = reaper.GetActiveTake(selectedItem)
            
            if activeTake then
                -- Add a ReaEQ to the active take as takeFX
                eq = reaper.TakeFX_AddByName(activeTake, "ReaEQ", -1)
                
                -- Load the "stock - Basic 230 HPF" preset into the ReaEQ
                reaper.TakeFX_SetPreset(activeTake, eq, "stock - Basic 230 HPF")
                
                -- Show the takeFX window
                reaper.TakeFX_Show(activeTake, eq, 3) -- 3 = Show the plugin window
            end
        end
    end
else
    reaper.MB("Aucun élément média sélectionné.", "Erreur", 0)
end

