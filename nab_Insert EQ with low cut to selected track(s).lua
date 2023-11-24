-- Get the currently selected track
selectedTrack = reaper.GetSelectedTrack(0,0)

-- Add a ReaEQ to the selected track
eq = reaper.TrackFX_AddByName(selectedTrack, "ReaEQ", false, -1)

-- Load the "stock - Basic 150 HPF" preset into the ReaEQ
reaper.TrackFX_SetPreset(selectedTrack, eq, "stock - Basic 230 HPF")

-- Hide the EQ window
reaper.TrackFX_Show(selectedTrack, eq, 2) -- 2 = Hide the plugin window

