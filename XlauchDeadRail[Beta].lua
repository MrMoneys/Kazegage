local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathfindingService = game:GetService("PathfindingService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local StarterGui = game:GetService("StarterGui")
local humanoid = character:WaitForChild("Humanoid")
local player = Players.LocalPlayer
player.CameraMode = Enum.CameraMode.Classic
local aimbotEnabled = false
local aimbotRange = 500 -- Distância máxima em studs
local smoothness = 0.2 -- Suaviza��o do movimentodo Ainbot (0-1, onde 1 � mais suave)

local player = Players.LocalPlayer
local ESPEnabled = false
local autoTeleport = false
local autoTeleportInterval = 5
local uiVisible = true
local espObjects = {}
local espConnection = nil
local espMobsEnabled = false
local espMobsObjects = {}
local noclipEnabled = false
local nomeDatool = "Sack" 
local nomeDaBag = "Sack" -- Nome exato da bag no Backpack
local pastaDeItens = Workspace:FindFirstChild("RuntimeItems") -- Pasta dos itens
local intervaloDeBusca = 0.3 -- Tempo entre coletas

-- Criação da UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 5
MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Active = true
MainFrame.Draggable = true



-- Criando Abas
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 0.1, 0) 
TabsFrame.Position = UDim2.new(0, 0, 0, 0) 
TabsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabsFrame.Parent = MainFrame

-- Criando bot�es de Abas
local Tab1Button = Instance.new("TextButton")
Tab1Button.Size = UDim2.new(0.3, 0, 1, 0)
Tab1Button.Position = UDim2.new(0, 0, 0, 0)
Tab1Button.Text = "MAIN"
Tab1Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Tab1Button.Parent = TabsFrame
Tab1Button.Font = Enum.Font.SourceSansBold
Tab1Button.TextSize = 16

local Tab2Button = Instance.new("TextButton")
Tab2Button.Size = UDim2.new(0.4, 0, 1, 0)
Tab2Button.Position = UDim2.new(0.30, 0, 0, 0)
Tab2Button.Text = "TELEPORTE"
Tab2Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Tab2Button.Parent = TabsFrame
Tab2Button.Font = Enum.Font.SourceSansBold
Tab2Button.TextSize = 16

local Tab3Button = Instance.new("TextButton")
Tab3Button.Size = UDim2.new(0.3, 0, 1, 0)
Tab3Button.Position = UDim2.new(0.7, 0, 0, 0)
Tab3Button.Text = "ESP"
Tab3Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Tab3Button.Parent = TabsFrame
Tab3Button.Font = Enum.Font.SourceSansBold
Tab3Button.TextSize = 16

-- Criando Frames das Abas
local Tab1Frame = Instance.new("Frame")
Tab1Frame.Size = UDim2.new(1, 0, 0.9, 0)
Tab1Frame.Position = UDim2.new(0, 0, 0.1, 0)
Tab1Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab1Frame.Parent = MainFrame

local Tab2Frame = Instance.new("Frame")
Tab2Frame.Size = UDim2.new(1, 0, 0.9, 0)
Tab2Frame.Position = UDim2.new(0, 0, 0.1, 0)
Tab2Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab2Frame.Parent = MainFrame
Tab2Frame.Visible = false

local Tab3Frame = Instance.new("Frame")
Tab3Frame.Size = UDim2.new(1, 0, 0.9, 0)
Tab3Frame.Position = UDim2.new(0, 0, 0.1, 0)
Tab3Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab3Frame.Parent = MainFrame
Tab3Frame.Visible = false

-- Fun��o para alternar abas
local function switchTab(selectedFrame)
    Tab1Frame.Visible = false
    Tab2Frame.Visible = false
    Tab3Frame.Visible = false

    selectedFrame.Visible = true
end

Tab1Button.MouseButton1Click:Connect(function() switchTab(Tab1Frame) end)
Tab2Button.MouseButton1Click:Connect(function() switchTab(Tab2Frame) end)
Tab3Button.MouseButton1Click:Connect(function() switchTab(Tab3Frame) end)

--TOGGLE HUB
local ToggleButton = Instance.new("ImageButton")
   ToggleButton.Parent = ScreenGui
   ToggleButton.Size = UDim2.new(0, 40, 0, 40)
   ToggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
   ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
   ToggleButton.Image = "rbxassetid://109158608681076" --Logo do Script
   ToggleButton.ScaleType = Enum.ScaleType.Fit
   ToggleButton.Draggable = true

   -- Adicionando bordas arredondadas
   local UICorner = Instance.new("UICorner")
   UICorner.Parent = ToggleButton
   UICorner.CornerRadius = UDim.new(0.3, 0) -- Quanto maior, mais arredondado (0.5 = c�rculo perfeito)

   -- Fun��o de toggle (opcional, caso queira ajustar)
   ToggleButton.MouseButton1Click:Connect(function()
       uiVisible = not uiVisible
       MainFrame.Visible = uiVisible
       
   end)

 
 local MobsESPButton = Instance.new("TextButton")
MobsESPButton.Parent = Tab3Frame
MobsESPButton.Size = UDim2.new(0.8, 0, 0.15, 0)
MobsESPButton.Position = UDim2.new(0.1, 0, 0.2, 0)
MobsESPButton.Text = "ESP MOBS: OFF"
MobsESPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MobsESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MobsESPButton.Font = Enum.Font.Fantasy
MobsESPButton.TextSize = 16

-- Bordas arredondadas
local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = MobsESPButton
mobsCorner.CornerRadius = UDim.new(0.2, 0)



local LockNpcButton = Instance.new("TextButton")
LockNpcButton.Size = UDim2.new(0.8, 0, 0.15, 0)
LockNpcButton.Position = UDim2.new(0.1, 0, 0.4, 0)
LockNpcButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LockNpcButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockNpcButton.Text = "NPC LOCK: OFF"
LockNpcButton.Font = Enum.Font.Fantasy
LockNpcButton.TextSize = 16
LockNpcButton.Parent = Tab1Frame

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = LockNpcButton
mobsCorner.CornerRadius = UDim.new(0.2, 0)


local AimbotButton = Instance.new("TextButton")
AimbotButton.Parent = Tab1Frame
AimbotButton.Size = UDim2.new(0.8, 0, 0.15, 0)
AimbotButton.Position = UDim2.new(0.1, 0, 0.6, 0) -- Ajuste a posi��o conforme necess�rio
AimbotButton.Text = "AIMBOT NPC: OFF"
AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotButton.Font = Enum.Font.Fantasy
AimbotButton.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = AimbotButton
mobsCorner.CornerRadius = UDim.new(0.2, 0)


local TpTrainButton = Instance.new("TextButton")
TpTrainButton.Parent = Tab2Frame
TpTrainButton.Size = UDim2.new(0.8, 0, 0.15, 0)
TpTrainButton.Position = UDim2.new(0.1, 0, 0.4, 0)
TpTrainButton.Text = "TP PARA O TREM(beta)"
TpTrainButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TpTrainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TpTrainButton.Font = Enum.Font.Fantasy
TpTrainButton.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = TpTrainButton
mobsCorner.CornerRadius = UDim.new(0.2, 0)



local noClipButton = Instance.new("TextButton")
noClipButton.Parent = Tab1Frame
noClipButton.Size = UDim2.new(0.8, 0, 0.15, 0)
noClipButton.Position = UDim2.new(0.1, 0, 0.2, 0)
noClipButton.Text = "NO CLIP:OFF"
noClipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipButton.Font = Enum.Font.Fantasy
noClipButton.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = noClipButton
mobsCorner.CornerRadius = UDim.new(0.2, 0)


local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Position =UDim2.new(0, 0, 0.1, 0)
Title.Text = "Xlauch Hub |Dead Rails"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20



local ESPToggle = Instance.new("TextButton")
ESPToggle.Parent = Tab3Frame
ESPToggle.Size = UDim2.new(0.8, 0, 0.15, 0)
ESPToggle.Position = UDim2.new(0.1, 0, 0.4, 0)
ESPToggle.Text = "ESP ITENS: OFF"
ESPToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Font = Enum.Font.Fantasy
ESPToggle.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = ESPToggle
mobsCorner.CornerRadius = UDim.new(0.2, 0)



local AutoTeleportToggle = Instance.new("TextButton")
AutoTeleportToggle.Parent = Tab2Frame
AutoTeleportToggle.Size = UDim2.new(0.8, 0, 0.15, 0)
AutoTeleportToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
AutoTeleportToggle.Text = "TP PARA ITEMS: OFF"
AutoTeleportToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoTeleportToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoTeleportToggle.Font = Enum.Font.Fantasy
AutoTeleportToggle.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = AutoTeleportToggle
mobsCorner.CornerRadius = UDim.new(0.2, 0)

local AutocoletarToggle = Instance.new("TextButton")
AutocoletarToggle.Parent = Tab2Frame
AutocoletarToggle.Size = UDim2.new(0.8, 0, 0.15, 0)
AutocoletarToggle.Position = UDim2.new(0.1, 0, 0.6, 0)
AutocoletarToggle.Text = "COLETAR ITEMS: OFF"
AutocoletarToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutocoletarToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutocoletarToggle.Font = Enum.Font.Fantasy
AutocoletarToggle.TextSize = 16

local mobsCorner = Instance.new("UICorner")
mobsCorner.Parent = AutocoletarToggle
mobsCorner.CornerRadius = UDim.new(0.2, 0)



local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Parent = MainFrame
CreditsLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
CreditsLabel.Position = UDim2.new(0.1, 0, 0.9, 0)
CreditsLabel.Text = "SCRIPT BY MRMONEYS"
CreditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Font = Enum.Font.Fantasy
CreditsLabel.TextSize = 18

-- Auto Coleta de Items 
local coletaAtiva = false
local itensColetados = {}

-- Função para equipar a bag automaticamente
local function equiparBag()
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then 
        print("Backpack não encontrado!")
        return false 
    end

    local bag = backpack:FindFirstChild(nomeDatool)
    if bag then
        bag.Parent = character -- Equipa a bag
        print("[+] Bag equipada:", nomeDaBag)
        return true
    else
        print("[-] Bag não encontrada no Backpack.")
        return false
    end
end

-- Função de Auto Armazenar Itens 
local function armazenarItem(item)
    -- Verifica se o item é válido
    if not item or not (item:IsA("Model") or item:IsA("BasePart")) then
        print("Item inválido para armazenamento!")
        return false
    end

    -- Obtém o serviço ReplicatedStorage
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Verifica se a pasta Remotes existe
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then
        print("Pasta 'Remotes' não encontrada em ReplicatedStorage!")
        return false
    end

    -- Verifica se o RemoteEvent StoreItem existe
    local remote = remotes:FindFirstChild("StoreItem")
    if not remote then
        print("Remote 'StoreItem' não encontrado!")
        return false
    end

    -- Executa o armazenamento
    remote:FireServer(item)
    
    return true
end

-- Função para encontrar o item mais próximo
local function findClosestItem()
    local runtimeItems = workspace:FindFirstChild("RuntimeItems")
    if not runtimeItems then return nil end

    local character = player.Character
    if not character then return nil end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end

    local playerPosition = humanoidRootPart.Position
    local closestItem = nil
    local shortestDistance = math.huge

    for _, item in ipairs(runtimeItems:GetChildren()) do
        if item:IsA("BasePart") or item:IsA("Model") then
            local itemPosition = item:GetPivot().Position
            local distance = (playerPosition - itemPosition).Magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                closestItem = item
            end
        end
    end

    return closestItem
end
-- Teleporte para os itens Andando.

-- Função para encontrar o item mais próximo
local function findClosestItem()
    local runtimeItems = workspace:FindFirstChild("RuntimeItems")
    if not runtimeItems then return nil end

    local character = player.Character
    if not character then return nil end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end

    local playerPosition = humanoidRootPart.Position
    local closestItem = nil
    local shortestDistance = math.huge

    for _, item in ipairs(runtimeItems:GetChildren()) do
        if item:IsA("BasePart") or item:IsA("Model") then
            local itemPosition = item:GetPivot().Position
            local distance = (playerPosition - itemPosition).Magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                closestItem = item
            end
        end
    end

    return closestItem
end

-- Função para caminhar até um objeto usando Pathfinding
local function walkToObject(targetObject)
    if not player.Character or not targetObject then return end

    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local targetPosition = targetObject:GetPivot().Position
    local distance = (humanoidRootPart.Position - targetPosition).Magnitude

    --  Se o jogador j� estiver perto do item, n�o faz nada
    if distance < 3 then
        print("Já está perto do item!")
        return
    end

    --  Criando um novo caminho com desvio de obst�culos
    local path = PathfindingService:CreatePath({
        AgentRadius = 2, 
        AgentHeight = 5, 
        AgentCanJump = true, 
        AgentWalkableFloorAngle = 60,
        Costs = {
            ["Obstacle"] = math.huge -- Faz o jogador evitar objetos marcados como "Obstacle"
        }
    })

    path:ComputeAsync(humanoidRootPart.Position, targetPosition)

    --  Verifica se o caminho � v�lido
    if path.Status ~= Enum.PathStatus.Success then
        print("Caminho inv�lido! Tentando novamente em 1 segundo...")
        wait(1)
        return
    end

    local waypoints = path:GetWaypoints()

    --  Seguir os waypoints corretamente
    for _, waypoint in ipairs(waypoints) do
        if not player.Character or not humanoid then return end
        
        if waypoint.Action == Enum.PathWaypointAction.Jump then
            humanoid.Jump = true
        end

        humanoid:MoveTo(waypoint.Position)

        --  Esperar at� o personagem alcan�ar o waypoint
        local moveComplete = humanoid.MoveToFinished:Wait(2)
        if not moveComplete then
            print("Travou em um ponto... recalculando caminho!")
            walkToObject(targetObject) --  Tenta novamente com um novo caminho
            return
        end
    end
end


-- Função principal de teleporte
local function teleportToClosestItem()
    local closestItem = findClosestItem()
    if closestItem then
        walkToObject(closestItem)
    else
        print("Nenhum item próximo encontrado!")
    end
end

-- Auto Teleporte
spawn(function()
    while true do
        if autoTeleport then
            teleportToClosestItem()
        end
        wait(autoTeleportInterval)
    end
end)


-- Funções do ESP
local function createBoxESP(item)
    if not espObjects[item] then
        local highlight = Instance.new("Highlight")
        highlight.Parent = item
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        espObjects[item] = highlight

        local billboardGui = Instance.new("BillboardGui", item)
        billboardGui.Name = "ItemESP"
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.Adornee = item
        billboardGui.AlwaysOnTop = true
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)

        local textLabel = Instance.new("TextLabel", billboardGui)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0
        textLabel.Text = item.Name
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 14

        espObjects[item .. "_label"] = billboardGui
    end
end

local function removeESP(item)
    if espObjects[item] then
        espObjects[item]:Destroy()
        espObjects[item] = nil
    end
    if espObjects[item .. "_label"] then
        espObjects[item .. "_label"]:Destroy()
        espObjects[item .. "_label"] = nil
    end
end

local function clearAllESP()
    for item, _ in pairs(espObjects) do
        removeESP(item)
    end
    espObjects = {}
end

local function updateESP()
    if espConnection then
        espConnection:Disconnect()
    end
    
    if not ESPEnabled then
        clearAllESP()
        return
    end
    
    espConnection = RunService.RenderStepped:Connect(function()
        local runtimeItems = workspace:FindFirstChild("RuntimeItems")
        if runtimeItems then
            -- Limpar ESP de itens que não existem mais
            for item, _ in pairs(espObjects) do
                if not item:IsDescendantOf(runtimeItems) then
                    removeESP(item)
                end
            end
            
            -- Adicionar ESP para novos itens
            for _, item in ipairs(runtimeItems:GetChildren()) do
                if (item:IsA("BasePart") or item:IsA("Model")) and not espObjects[item] then
                    createBoxESP(item)
                end
            end
        else
            clearAllESP()
        end
    end)
end
--    ESPITEMS TOGGLE 
local function toggleESP()
    ESPEnabled = not ESPEnabled
    ESPToggle.Text = "ESP ITEMS: " .. (ESPEnabled and "ON" or "OFF")

    if ESPEnabled then
    ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 250, 0)
        -- Atualiza ESP normalmente
        updateESP()
    else
        --  Corrigir problema removendo ESP corretamente
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
            ESPToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end

        --  Remover os ESPs visuais corretamente (Highlight + NameTag)
        for item, esp in pairs(espObjects) do
            if esp and esp.Parent then
                esp:Destroy()
            end

            --  Remover NameTag (BillboardGui)
            local nameTag = item:FindFirstChild("ItemESP")
            if nameTag then
                nameTag:Destroy()
            end
        end

        espObjects = {} -- Limpar a tabela de ESPs
    end
end



--Esp Mobs
--  Criando ESP de Mobs (Highlight + NameTag)
local function CreateMobESP(mob)
    if not espMobsObjects[mob] then
        -- Criar Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Box"
        highlight.Parent = mob
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0
        espMobsObjects[mob] = highlight

        -- Criar BillboardGui (NameTag)
        local billboard = Instance.new("BillboardGui", mob)
        billboard.Name = "ESP_Tag"
        billboard.Size = UDim2.new(0, 50, 0, 20)
        billboard.Adornee = mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)

        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Text = mob.Name
        textLabel.Parent = billboard
    end
end

-- Fun��o para atualizar o ESP dinamicamente
local function UpdateESPMobs()
    if not espMobsEnabled then
        -- Limpa ESPs existentes
        for mob, _ in pairs(espMobsObjects) do
            if mob:FindFirstChild("ESP_Box") then mob.ESP_Box:Destroy() end
            if mob:FindFirstChild("ESP_Tag") then mob.ESP_Tag:Destroy() end
        end
        espMobsObjects = {}
        return
    end
    
    -- Atualiza ESP apenas para NPCs (n�o-Players)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local isPlayer = false
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character == obj then
                    isPlayer = true
                    break
                end
            end
            
            if not isPlayer and not espMobsObjects[obj] then
                CreateMobESP(obj)
            end
        end
    end
end

-- Fun��o para ativar/desativar ESP
local function ToggleESP(state)
    espEnabled = state
    DebugPrint("ESP Estado: " .. tostring(espEnabled))

    if espEnabled then
        UpdateESP()
    else
        -- Remover ESPs existentes
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local espTag = obj:FindFirstChild("ESP_Tag")
                local espBox = obj:FindFirstChild("ESP_Box")
                if espTag then espTag:Destroy() end
                if espBox then espBox:Destroy() end
            end
        end
        DebugPrint("Todos os ESPs foram removidos")
    end
end

-- Eventos
MobsESPButton.MouseButton1Click:Connect(function()
    espMobsEnabled = not espMobsEnabled
    MobsESPButton.Text = espMobsEnabled and "ESP Mobs: ON" or "ESP Mobs: OFF"

    if espMobsEnabled then
        spawn(function()
        MobsESPButton.BackgroundColor3 = Color3.fromRGB(0, 250, 0)
            while espMobsEnabled do
                UpdateESPMobs()
                wait(1)
            end
        end)
    else
        UpdateESPMobs() -- Remove os ESPs
        MobsESPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

--Movimento do Tp
local function setPrimaryPart(model)
    if model and model:IsA("Model") and not model.PrimaryPart then
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                model.PrimaryPart = part
                break
            end
        end
    end
    return model.PrimaryPart
end

--Tp para o Train
local function findLadder()
    local train = game.Workspace:FindFirstChild("Train")
    if train then
        local platform = train:FindFirstChild("TrainControls")
        if platform then
            for _, obj in ipairs(platform:GetChildren()) do
                if obj:IsA("Model") and obj.Name == "ConductorSeat" then
                    setPrimaryPart(obj)
                    return obj
                end
            end
        end
    end
    return nil
end

local function faceLadder(ladder)
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if ladder and ladder.PrimaryPart and humanoidRootPart then
        local ladderPos = ladder.PrimaryPart.Position
        local lookVector = (ladderPos - humanoidRootPart.Position).unit
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + lookVector)
    end
end

local function walkToDestination(destination, finalAdjustment)
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not humanoidRootPart or not destination or not destination.PrimaryPart then
        warn("Erro: Componentes n�o encontrados!")
        return
    end

    local destinationPos = destination.PrimaryPart.Position
    local stopDistance = 12  -- Se a dist�ncia for menor ou igual a 12, teleporta diretamente

    local distance = (humanoidRootPart.Position - destinationPos).Magnitude

    -- **Se j� estiver perto o suficiente, teleporta direto**
    if distance <= stopDistance then
        humanoidRootPart.CFrame = destination.PrimaryPart.CFrame * CFrame.new(0, 0, -1.5)
        humanoid.Sit = true
        return
    end

    -- **Caso contr�rio, move at� o destino**
    local timeLimit = 60 -- Tempo de caminhada
    local startTime = tick()

    humanoid:MoveTo(destinationPos)
    local reached = false

    local connection
    connection = humanoid.MoveToFinished:Connect(function(success)
        if success then
            reached = true
        end
    end)

    -- **Espera at� que o jogador chegue ou o tempo limite acabe**
    while not reached and tick() - startTime < timeLimit do
        task.wait(0.1)

        -- **Verifica a dist�ncia durante a caminhada**
        if (humanoidRootPart.Position - destinationPos).Magnitude <= stopDistance then
            humanoidRootPart.CFrame = destination.PrimaryPart.CFrame * CFrame.new(0, 0, -1.5)
            humanoid.Sit = true
            reached = true
            break
        end
    end

    connection:Disconnect()
    humanoid:Move(Vector3.new(0, 0, 0), true)

    if finalAdjustment then
        faceLadder(destination)
    end
end

-- NoClip (atravessar paredes)

local function toggleNoClip()
    noclipEnabled = not noclipEnabled
    noClipButton.Text = "NO CLIP: OFF"
    noClipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    while noclipEnabled do
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
                noClipButton.Text ="NO CLIP: ON"
                noClipButton.BackgroundColor3 = Color3.fromRGB(0, 250, 0)
            end
        end
        task.wait()
    end
end
--Lock Npc Stage
local npcLock = false
local lastTarget = nil
local toggleLoop

local function addPlayerHighlight()
    if player.Character then
        local highlight = player.Character:FindFirstChild("PlayerHighlightESP")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "PlayerHighlightESP"
            highlight.FillColor = Color3.new(1, 1, 1)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
        end
    end
end

local function removePlayerHighlight()
    if player.Character and player.Character:FindFirstChild("PlayerHighlightESP") then
        player.Character.PlayerHighlightESP:Destroy()
    end
end
--???
local function isPlayerModel(model)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character == model then
            return true
        end
    end
    return false
end
--Lock Npcs/e Aimbot 
local function getClosestNPC(maxRange)
    local closestNPC = nil
    local closestPart = nil
    local closestDistance = maxRange or math.huge
    
    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("Model") then
            local humanoid = object:FindFirstChild("Humanoid") or object:FindFirstChildWhichIsA("Humanoid")
            local hrp = object:FindFirstChild("HumanoidRootPart")
            local head = object:FindFirstChild("Head")
            
            -- Lista de NPCs para ignorar
            local ignoredNPCs = {"Horse", "Unicorn"}
            local shouldIgnore = false
            for _, name in ipairs(ignoredNPCs) do
                if object.Name == name then
                    shouldIgnore = true
                    break
                end
            end
            
            -- Verifica se � um NPC v�lido
            if humanoid and humanoid.Health > 0 and not shouldIgnore and not isPlayerModel(object) then
                local targetPart = head or hrp  -- Prioriza a cabe�a
                if targetPart then
                    local distance = (targetPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestNPC = object
                        closestPart = targetPart
                    end
                end
            end
        end
    end
    
    return closestNPC, closestPart
end


-- Fun��o para suavizar o movimento da mira
local function smoothLookAt(currentCF, targetCF, alpha)
    return currentCF:Lerp(targetCF, alpha)
end

-- Loop principal do aimbot
local aimbotConnection
local function startAimbot()
    if aimbotConnection then return end
    
    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not aimbotEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local npc, targetPart = getClosestNPC(aimbotRange)  -- Agora recebe ambos valores
        if npc and targetPart then
            local targetPosition = targetPart.Position
            local currentLook = camera.CFrame
            local newLook = CFrame.lookAt(camera.CFrame.Position, targetPosition)
            camera.CFrame = smoothLookAt(currentLook, newLook, 1 - smoothness)
        end
    end)
end
--Aimbot Toogle Function
-- Fun��o para ativar/desativar o aimbot
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    
    if aimbotEnabled then
        startAimbot()
        print("Aimbot: ON")
        AimbotButton.BackgroundColor3 = Color3.fromRGB(0, 250, 0)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        print("Aimbot: OFF")
        AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end


--Fun��es Toggle/Bot�es 
AimbotButton.MouseButton1Click:Connect(function()
    toggleAimbot()
    AimbotButton.Text = "AIMBOT NPC: " .. (aimbotEnabled and "ON" or "OFF")
end)

noClipButton.MouseButton1Click:Connect(toggleNoClip)

ESPToggle.MouseButton1Click:Connect(toggleESP)

TpTrainButton.MouseButton1Click:Connect(function()
task.spawn(function()
            local seat = findLadder()
            if seat then
                walkToDestination(seat, true)
                
            else
                print("Falhou!")
            end

            task.wait(1.5)
            print("Retomado")
        end)
    end)


AutoTeleportToggle.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    AutoTeleportToggle.Text = "TP PARA ITENS: " .. (autoTeleport and "ON" or "OFF")
    AutoTeleportToggle.BackgroundColor3 = autoTeleport and Color3.fromRGB(0, 250, 0) or Color3.fromRGB(50, 50, 50) -- Atualizado para mudar cor baseada no estado

    if autoTeleport then
        spawn(function()
            while autoTeleport do
                teleportToClosestItem()
                wait(autoTeleportInterval)
            end
        end)
    end
end)


local function removePlayerHighlight()
    if player.Character and player.Character:FindFirstChild("PlayerHighlightESP") then
        player.Character.PlayerHighlightESP:Destroy()
    end
end
--Lock Npcs Button 
-- Substitua a fun��o LockNpcButton.MouseButton1Click por esta vers�o corrigida:
LockNpcButton.MouseButton1Click:Connect(function()
    npcLock = not npcLock
    LockNpcButton.Text = "NPC LOCK: " .. (npcLock and "ON" or "OFF")
    LockNpcButton.BackgroundColor3 = npcLock and Color3.fromRGB(0, 250, 0) or Color3.fromRGB(50, 50, 50) -- Adicionado esta linha
    
    if npcLock then
        if toggleLoop then
            toggleLoop:Disconnect()
            
        end
        toggleLoop = RunService.RenderStepped:Connect(function()
            local npc = getClosestNPC()
            if npc and npc:FindFirstChild("Humanoid") then
                local npcHumanoid = npc:FindFirstChild("Humanoid")
                if npcHumanoid.Health > 0 then
                    camera.CameraSubject = npcHumanoid
                    lastTarget = npc
                    addPlayerHighlight()
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "Killed NPC",
                        Text = npc.Name,
                        Duration = 0.4
                    })
                    lastTarget = nil
                    removePlayerHighlight()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        camera.CameraSubject = player.Character:FindFirstChild("Humanoid")
                    end
                end
            else
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    camera.CameraSubject = player.Character:FindFirstChild("Humanoid")
                end
                lastTarget = nil
                removePlayerHighlight()
                
            end
        end)
    else
        if toggleLoop then
            toggleLoop:Disconnect()
            toggleLoop = nil
        end
        removePlayerHighlight()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = player.Character:FindFirstChild("Humanoid")
        end
    end
end)

AutocoletarToggle.MouseButton1Click:Connect(function()
    coletaAtiva = not coletaAtiva
    AutocoletarToggle.Text = "COLETAR ITEMS: " .. (coletaAtiva and "ON" or "OFF")
    AutocoletarToggle.BackgroundColor3 = coletaAtiva and Color3.fromRGB(0, 250, 0) or Color3.fromRGB(50, 50, 50)
    
    if coletaAtiva then
        equiparBag() -- Tenta equipar a bag ao ativar
        
        -- Loop principal
        spawn(function()
            while true do
                if coletaAtiva and character and pastaDeItens then
                    for _, item in ipairs(pastaDeItens:GetChildren()) do
                        if not coletaAtiva then break end
                        armazenarItem(item)
                        wait(intervaloDeBusca)
                    end
                end
                wait(1)
            end
        end)
    end
end)


-- Inicialização
updateESP()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMoneys/LoadingTelan/refs/heads/main/LoadingTelan.lua"))()
 
