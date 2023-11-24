-- Fonction qui renomme les items sélectionnés
function renameSelectedItems()
  -- Récupération de la catégorie sélectionnée
  local category = reaper.GetExtState("UCS_renamer", "category")
  
  -- Si aucune catégorie n'a été sélectionnée, on affiche un message d'erreur
  if category == "" then
    reaper.ShowMessageBox("Veuillez sélectionner une catégorie.", "Erreur", 0)
    return
  end
  
  -- Récupération des éléments sélectionnés
  local numSelectedItems = reaper.CountSelectedMediaItems()
  
  -- Si aucun élément n'est sélectionné, on affiche un message d'erreur
  if numSelectedItems == 0 then
    reaper.ShowMessageBox("Veuillez sélectionner au moins un élément.", "Erreur", 0)
    return
  end
  
  -- Création du nouveau nom de fichier
  local newName = category
  
  -- Renommage des éléments sélectionnés avec le nouveau nom de fichier
  for i = 0, numSelectedItems - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", newName, true)
  end
end

-- Fonction qui affiche l'interface utilisateur
function showUI() end
  -- Création de la fenêtre
  local dialogTitle = "UCS Renamer"
  local dialogWidth = 400
  local dialogHeight = 150
  local dialog = reaper.JS_Window_Find(dialogTitle, true)
  
  if dialog ~= nil then
    reaper.JS_Window_Show(dialog, true)
    return
  end
  
  dialog = reaper.JS_Window_Create(dialogTitle, 0, 0, dialogWidth, dialogHeight)
  local font = reaper.JS_LICE_CreateFont("Arial", 16, 0)
  
  -- Liste déroulante pour la catégorie
  local categoryLabel = "Catégorie :"
  local categoryValues = {"", "AMBI", "FOLI", "FOLE", "HUMA", "MACH", "MUSI", "NATU", "SCIE", "TECH", "VEHI", "WATE"}
  local categoryX = 10
  local categoryY = 20
  local categoryWidth = 150
  local categoryHeight = 30
  
  -- Création de la liste déroulante pour la catégorie
  local categoryIndex = 1
  local categoryXYPad = {x=categoryX, y=categoryY, w=categoryWidth, h=categoryHeight}
  
  -- Bouton "Renommer"
  local renameButtonLabel = "Renommer"
  local renameButtonX = 10
  local renameButtonY = dialogHeight - 50
  local renameButtonWidth = 80
  local renameButtonHeight = 30
  
  -- Création du bouton
  local renameButton = gfx.getimgdim(gfx.loadimg(0, reaper.GetResourcePath() .. "/scripts/reaper_ucs_renamer/rename_button.png"), 0)
 

