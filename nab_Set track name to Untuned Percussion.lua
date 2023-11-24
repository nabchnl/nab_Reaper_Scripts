-- Fonction pour renommer les pistes sélectionnées
function rename_selected_tracks()

    -- Récupération du nombre de pistes sélectionnées
    local num_tracks = reaper.CountSelectedTracks(0)
    
    -- Si aucune piste ou plus d'une piste est sélectionnée
    if num_tracks == 0 then
        return -- On ne fait rien
    end
    
    -- Si une seule piste est sélectionnée
    local track = reaper.GetSelectedTrack(0, 0)
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "Untuned Percussion", true)
    
    -- Si plusieurs pistes sont sélectionnées
    if num_tracks > 1 then
        for i = 1, num_tracks do
            local track = reaper.GetSelectedTrack(0, i - 1)
            reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", true)
            local _, name = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", false)
            if name:match("^Untuned Percussion") then
                local new_name = name:gsub("^Untuned Percussion", "Untuned Percussion ")
                local number = tonumber(new_name:match("%d+$")) or 0
                reaper.GetSetMediaTrackInfo_String(track, "P_NAME", new_name .. " " .. number+1, true)
            else
                reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "Untuned Percussion " .. i, true)
            end
        end
    end
    
end

-- Appel de la fonction pour renommer les pistes sélectionnées
rename_selected_tracks()

