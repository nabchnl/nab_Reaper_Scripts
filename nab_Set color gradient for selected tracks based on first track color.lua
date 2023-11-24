local r = reaper
local verifysws = r.APIExists( 'CF_GetSWSVersion' )------- my easy way to check if SWS extensions are installed

-----------------------------------------------------------------------------------------------------------
if  verifysws then  

local colchildren = r.NamedCommandLookup("_SWS_COLCHILDREN")
local itemtotrkcolor = r.NamedCommandLookup("_SWS_ITEMTRKCOL")

---Gradient Step ---- positive numbers will gradient to white // negative numbers will gradient to black
local gradientstep = -15 ---- 0 = no gradient 
local coloritem = true -----if true = force to color items/takes with track color
local trktbl = {}

function getseltracktable()
  local trackCount = r.CountSelectedTracks(0)
  if trackCount ~= 0 then 
    for i = 1, trackCount, 1 do
    trktbl[i] = r.GetSelectedTrack(0, i-1)
    end
  end
end

function seltracktable()
    for i = 1, #trktbl, 1 do
    r.SetTrackSelected( trktbl[i], true )
    end
end

function main()
local trackCount = #trktbl
local gradientstep =  math.ceil((gradientstep*10)/(trackCount+1)) ----dependent on track count
 for i = 1, trackCount - 1, 1 do
    local track = trktbl[i]
    local nexttrack = trktbl[i+1]
    local prevColorNative = r.GetTrackColor(track)
    local prevColorR, prevColorG, prevColorB = r.ColorFromNative(prevColorNative)
    if prevColorR + gradientstep < 0 then prevColorR = 0 else prevColorR = prevColorR + gradientstep end
    if prevColorG + gradientstep < 0 then prevColorG = 0 else prevColorG = prevColorG + gradientstep end
    if prevColorB + gradientstep < 0 then prevColorB = 0 else prevColorB = prevColorB + gradientstep end
    local newColorR = math.min(prevColorR, 255)
    local newColorG = math.min(prevColorG, 255)
    local newColorB = math.min(prevColorB, 255)
    local newColorNative = r.ColorToNative(newColorR, newColorG, newColorB)
    r.SetTrackColor(nexttrack, newColorNative)
       
  end
end

r.Undo_BeginBlock()
r.PreventUIRefresh(1)

getseltracktable()

if #trktbl ~=0 then
r.Main_OnCommandEx(colchildren, 0, 0)
main()
r.Main_OnCommandEx(40769, 0, 0)
seltracktable()
end

r.PreventUIRefresh(-1)
r.Undo_EndBlock( "folder Color Gradient", 0)

else

reaper.ShowMessageBox( "This script requires the SWS/S&M extension.\n\nThe SWS/S&M extension can be downloaded from www.sws-extension.org.", "ERROR", 0)
end

