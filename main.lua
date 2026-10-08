-- =========================================================
-- ONE W + ALFZXZZZ MEGA HUB
-- Section 1 : Config + Loading + State
-- =========================================================

Players = game:GetService("Players")
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
VirtualInputManager = game:GetService("VirtualInputManager")
Stats = game:GetService("Stats")
GuiService = game:GetService("GuiService")
SoundService = game:GetService("SoundService")
StarterGui = game:GetService("StarterGui")
TeleportService = game:GetService("TeleportService")
CollectionService = game:GetService("CollectionService")

LP = Players.LocalPlayer
PG = LP:WaitForChild("PlayerGui")

IMAGE_ID = "rbxassetid://138040631725974"
STUN_SOUND_ID = "rbxassetid://131869004949152"
STUN_ANIM_ID = "123047897844134"
STUN_DURATION = 2.5

function getRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

C = {
    BG = Color3.fromRGB(10, 20, 45),
    BG2 = Color3.fromRGB(15, 30, 65),
    PANEL = Color3.fromRGB(20, 45, 95),
    PANEL2 = Color3.fromRGB(30, 60, 130),
    GOLD = Color3.fromRGB(255, 210, 80),
    GOLD_LIGHT = Color3.fromRGB(255, 230, 120),
    GOLD_DARK = Color3.fromRGB(200, 160, 50),
    ORANGE = Color3.fromRGB(255, 180, 60),
    TXT = Color3.fromRGB(230, 245, 255),
    DIM = Color3.fromRGB(150, 190, 230),
    GRN = Color3.fromRGB(80, 255, 150),
    RED = Color3.fromRGB(255, 70, 100),
    CYAN = Color3.fromRGB(120, 220, 255),
}

DIAMOND_BLUE = Color3.fromRGB(120, 200, 255)
DIAMOND_LIGHT = Color3.fromRGB(180, 230, 255)
DIAMOND_DARK = Color3.fromRGB(40, 100, 180)
DIAMOND_MID = Color3.fromRGB(80, 160, 240)

function rnd(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = o
    return c
end

function strk(o, col, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or C.GOLD
    s.Thickness = t or 1.5
    s.Transparency = tr or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local ToggleSoundId = "rbxassetid://6073491164"
local _toggleSoundInstance = nil
function playToggleSound()
    task.spawn(function()
        pcall(function()
            if not _toggleSoundInstance or not _toggleSoundInstance.Parent then
                _toggleSoundInstance = Instance.new("Sound")
                _toggleSoundInstance.SoundId = ToggleSoundId
                _toggleSoundInstance.Volume = 0.5
                _toggleSoundInstance.Parent = SoundService
            end
            _toggleSoundInstance:Play()
        end)
    end)
end

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "OneWLoading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999999
loadingGui.Parent = PG

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 12, 30)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(10, 25, 60)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(30, 70, 140)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 160, 240)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(30, 70, 140)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(10, 25, 60)),
})
bgGradient.Rotation = 45
bgGradient.Parent = bg

task.spawn(function()
    local t = 0
    while bgGradient.Parent do
        t = t + 0.8
        bgGradient.Rotation = (t) % 360
        task.wait(0.05)
    end
end)

local logoLoading = Instance.new("ImageLabel")
logoLoading.Size = UDim2.new(0, 140, 0, 140)
logoLoading.Position = UDim2.new(0.5, -70, 0.32, -70)
logoLoading.BackgroundTransparency = 1
logoLoading.Image = IMAGE_ID
logoLoading.ImageTransparency = 1
logoLoading.ZIndex = 3
logoLoading.Parent = bg

task.delay(0.3, function()
    TweenService:Create(logoLoading, TweenInfo.new(0.8, Enum.EasingStyle.Back), {ImageTransparency = 0}):Play()
end)

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Size = UDim2.new(1, 0, 0, 60)
welcomeTitle.Position = UDim2.new(0, 0, 0.52, 0)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "ONE W + ALF"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 0
welcomeTitle.Font = Enum.Font.GothamBlack
welcomeTitle.TextStrokeTransparency = 0.4
welcomeTitle.TextStrokeColor3 = Color3.fromRGB(120, 200, 255)
welcomeTitle.ZIndex = 3
welcomeTitle.Parent = bg

TweenService:Create(welcomeTitle, TweenInfo.new(1.2, Enum.EasingStyle.Back), {TextSize = 52}):Play()

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 320, 0, 4)
barBg.Position = UDim2.new(0.5, -160, 0.68, 0)
barBg.BackgroundColor3 = Color3.fromRGB(20, 40, 80)
barBg.BorderSizePixel = 0
barBg.BackgroundTransparency = 0.3
barBg.ZIndex = 3
barBg.Parent = bg
rnd(barBg, 999)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(120, 200, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
rnd(barFill, 999)

TweenService:Create(barFill, TweenInfo.new(1.4, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)}):Play()

task.delay(1.6, function()
    if loadingGui then loadingGui:Destroy() end
end)

-- =========================================================
-- STATE ONE W
-- =========================================================
_G.RoooorS = _G.RoooorS or {
    FireOn = false, FireType = "CosmicFire", FireSize = 5,
    WalkSpeed = false, WalkSpeedVal = 16,
    SpeedHack = false, SpeedHackVal = 40,
    NoClip = false, NoClipCamera = false,
    Korblox = true, KorbloxYOffset = 0.80, KorbloxScale = 1,
    Headless = true,
    EightBitOn = false, EightBitSize = 1.24, EightBitHeight = 0.88,
    Trail = false, TrailColor = Color3.fromRGB(255, 210, 80),
    Aura = false, AuraColor = Color3.fromRGB(255, 210, 80),
    KillEffect = false,
    Crosshair = false, CrosshairColor = Color3.fromRGB(255, 210, 80),
    CrosshairSize = 8, CrosshairThickness = 2,
    CrosshairStyle = "Plus", CrosshairGap = 4,
    CrosshairShowOutline = true,
    CrosshairOutlineColor = Color3.fromRGB(0, 0, 0),
    CrosshairOffsetX = 0, CrosshairOffsetY = 0,
    ZoomOut = false, ZoomOutValue = 500,
    FOV = 90, FOVEnabled = false,
    Fullbright = false, FullbrightVal = 200,
    ClockTime = 14, CustomBrightness = 200,
    NoFog = false, UltraHD = false,
    Contrast = false, ContrastVal = 0.3, SaturationVal = 0.2,
    SkyId = "Default",
    NoScreenEffects = false, LowGraphics = false, CleanSky = false,
    HDSky = false, KillFog = true,
    AntiAFK = false, ShowFPS = true, ShowPing = true,
    Killer_AutoAtk = false, Killer_AtkDelay = 0.35,
    Killer_KillAll = false, MaskedPower = "Cobra",
    InstantInteract = false,
    AutoCarry = false, AutoHook = false, CarryRange = 60,
    HDTexture = false, HDReflection = false, HDBloom = false,
    HDShadow = false, HDWater = false, HDSunRays = false,
    HDDepthField = false, HDAntiAliasing = false,
    ESPNameMode = "Galaxy", ESPNameSize = 8,
    ESPGenMode = "Bar",
    ESPGenBarSize = 64, ESPGenBarHeight = 8, ESPGenBarTextSize = 6,
    KillFeed = false, StunNotify = false,
    AutoEscapeGate = false, AutoEscapeRange = 50,
    AutoEscapeUseKillerCheck = true, AutoEscapeUseGenCheck = true,
}
S = _G.RoooorS

_G.ToggleStates = _G.ToggleStates or {}
_G.SliderStates = _G.SliderStates or {}
_G.DropdownStates = _G.DropdownStates or {}

ESP = _G.Roooor_ESP or {
    Survivor = true, Killer = true, Generator = true,
    Pallet = false, Window = false, SCP = false, Distance = 1000,
}
_G.Roooor_ESP = ESP

ESPStatus = _G.Roooor_ESPStatus or {
    Enabled = false, ShowName = true, ShowDistance = true,
    ShowHealth = true, Radius = 1000,
}
_G.Roooor_ESPStatus = ESPStatus

TeamColors = _G.Roooor_TeamColors or {
    Killer = Color3.fromRGB(255, 60, 60),
    Survivor = Color3.fromRGB(0, 120, 255),
}
_G.Roooor_TeamColors = TeamColors

-- =========================================================
-- STATE ALFZXZZZ (Auto Parry + Fitur Tambahan)
-- =========================================================
ALF = _G.Roooor_ALF or {
    -- Auto Parry ALF v1
    PARRY_Enabled = false,
    PARRY_Aggressive = false,
    PARRY_Distance = 10,
    PARRY_ShowCircle = false,
    PARRY_SilentParry = false,
    -- Wisnu Auto Parry v2
    Wisnu_AutoParry = false,
    Wisnu_ParryAggressive = false,
    Wisnu_ParrySafety = false,
    Wisnu_ParryDistance = 6,
    Wisnu_ParryFace = 0.7,
    Wisnu_ParryCircle = true,
    Wisnu_IgnoredSkills = {},
    -- Auto Crouch
    AutoCrouch = false,
    -- Auto Attack (Killer)
    KILLER_AutoAttack = false,
    KILLER_AutoAttackRange = 12,
    KILLER_AutoAttackCooldown = 0.15,
    -- Auto Flee
    SURV_AutoFlee = false,
    SURV_AutoFleeDist = 40,
    SURV_AutoFleeCooldown = 1.5,
    -- Self Heal
    InstantHealSelf = false,
    AutoHealAll = false,
    -- Fake Perks
    FakePerks_Flowstate = false,
    FakePerks_QuickRecovery = false,
    FakePerks_PerfectLanding = false,
    FakePerks_AdrenalineRush = false,
    -- Fake Parry V2
    SURV_FakeParry = false,
    SURV_FakeParryAnim = "Enten",
    SURV_FakeParryCooldown = 0.4,
    SURV_FakeParryKey = "V",
    SURV_FakeParryShowBtn = false,
    SURV_FakeParryLocked = false,
    -- Killer Bypass
    KILLER_BypassLeap = false,
    KILLER_InfGrab = false,
    KILLER_InfLakeMist = false,
    KILLER_InfPursuit = false,
    KILLER_BypassCooldown = false,
    KILLER_InfFrenzy = false,
    KILLER_AntiBlind = false,
    KILLER_DestroyPallets = false,
    KILLER_InfLunge = false,
    KILLER_AutoHook = false,
    -- Killer Abilities
    KA_AutoStalk = false,
    KA_AutoStalkRange = 150,
    KA_AutoKillAll = false,
    KA_DropAllPallet = false,
    KA_BlockAllVault = false,
    -- Silent Aim / Aimbot
    TOF_SilentAim = false,
    TOF_TargetMode = "Killer",
    TOF_Key = "Q",
    TOF_Laser = true,
    TOF_WallCheck = true,
    TOF_BlockKnocked = true,
    -- Aim Lock
    AimLock_Hidden = false,
    AimLock_Attack = false,
    AimLock_Gun = false,
    -- Veil
    VeilEnabled = false,
    VeilShowFOV = true,
    VeilShowTracker = false,
    VeilAutoPredict = true,
    VeilFOV = 150,
    VeilMaxDist = 280,
    VeilSpearSpeed = 165,
    VeilGravity = 103,
    VeilLeadMultiplier = 1.4,
    -- Silent Flask
    FLASK_SilentAim = false,
    -- Silent Flashlight
    FLASH_SilentAim = false,
    -- Misc
    NoFallDamage = false,
    NextMapPredict = false,
    ManualGen = false,
    AutoGen = false,
    KillerEscapeDist = 30,
    KillerPerksDisplay = false,
    SpeedBoostEnabled = false,
    SpeedBoostValue = 30,
    CursorEnabled = false,
    Invis_Enabled = false,
    Invis_Hotkey = "G",
    -- Stun Sound
    StunSoundEnabled = false,
    StunSoundSelected = "Default",
    StunSoundVolume = 1.5,
    StunSoundRange = 500,
    -- Status ESP Advanced
    StatusESP_Advanced = false,
    StatusESP_ShowAvatar = true,
    StatusESP_ShowAction = true,
    StatusESP_AutoScale = true,
    -- God Mode
    GodMode = false,
}
_G.Roooor_ALF = ALF

-- =========================================================
-- STUN SOUND LIST (12 Suara dari ALF)
-- =========================================================
StunSounds = _G.Roooor_StunSounds or {
    ["Default"] = "18843924331",
    ["Clash Royale"] = "114072050006157",
    ["Blash"] = "89068385567682",
    ["Coin"] = "75510526696824",
    ["Kururin Kuru"] = "119896940405402",
    ["Spongebob"] = "6835794541",
    ["Fahhhh"] = "123562480982353",
    ["Cave"] = "3173566193",
    ["Aughhh"] = "9095205664",
    ["Samsung"] = "6879335951",
    ["iPhone"] = "4203251375",
    ["Siren"] = "130677853589923",
}
_G.Roooor_StunSounds = StunSounds

-- =========================================================
-- MOONWALK
-- =========================================================
Moonwalk = _G.Roooor_Moonwalk or {
    Enabled = false, Locked = false, SpamSpeed = 30,
    Intensity = 35, SlowSpeed = 13, UseSlow = true, ShowButton = true,
}
_G.Roooor_Moonwalk = Moonwalk

-- =========================================================
-- FAST VAULT
-- =========================================================
FastVault = _G.Roooor_FastVault or {
    Enabled = false, Speed = 1.2,
    ReplaceMap = {
        ["rbxassetid://83873880822918"] = "rbxassetid://136962284480779",
    },
}
_G.Roooor_FastVault = FastVault

-- =========================================================
-- AUTO FLEE
-- =========================================================
AutoFlee = _G.Roooor_AutoFlee or {
    Enabled = false, DetectDistance = 50, Cooldown = 0.1, LastFlee = 0,
}
_G.Roooor_AutoFlee = AutoFlee

-- =========================================================
-- GOD MODE
-- =========================================================
GodMode = _G.Roooor_GodMode or { Enabled = false }
_G.Roooor_GodMode = GodMode

-- =========================================================
-- STUN INDICATOR
-- =========================================================
StunIndicator = _G.Roooor_StunIndicator or {
    Enabled = true,
    ActiveStuns = {},
}
_G.Roooor_StunIndicator = StunIndicator

-- =========================================================
-- BOMBAX MUSIC
-- =========================================================
Bombax = _G.Roooor_Bombax or {
    DaftarLagu = {
        {id = "101985596918228", judul = "One"},
        {id = "78520199502339",  judul = "Two"},
        {id = "78253224480952",  judul = "Three"},
        {id = "136949217768985", judul = "Four"},
        {id = "92143860315842",  judul = "Five"},
        {id = "96568301359656",  judul = "Six"},
        {id = "96053601899287",  judul = "Seven"},
        {id = "116537762304510", judul = "Eight"},
        {id = "111775377151665", judul = "Nine"},
        {id = "131317416582166", judul = "Ten"},
        {id = "107569604895628", judul = "Eleven"},
        {id = "80210594606101",  judul = "Danza Kuduro"},
        {id = "135887188304832", judul = "Ada Yang Tumbang Jos Jis"},
        {id = "105372329671874", judul = "Million Stars Asoy"},
        {id = "79296696808534",  judul = "My Lope Lope (Speed Up)"},
        {id = "70578919220987",  judul = "My Lope Lope (Andri Poter)"},
        {id = "89338419772018",  judul = "Habibi Ishqi"},
        {id = "93652038633690",  judul = "Santai Dulu"},
        {id = "124582101215124", judul = "DJ Akimilaku Im Back"},
        {id = "121304834713825", judul = "Dangdut Week Sebelas"},
        {id = "102944382854479", judul = "Lagu Misterius"},
        {id = "126810420971446", judul = "Anak Kota"},
        {id = "94299109467073",  judul = "Cinderella Jedag Jedug"},
        {id = "83463789936127",  judul = "Lagu Jawa (Kowe Siji)"},
        {id = "771523191444498", judul = "Cintaku Ini Istimewa - AIS x Celawze"},
        {id = "86422417888834",  judul = "Kini Tinggal Kenangan - Celawze"},
        {id = "70868757792328",  judul = "Mashup Dora Dora (Funky RMX)"},
        {id = "128071048140468", judul = "Always Loving You - Natraa"},
        {id = "136239433509180", judul = "Mysterious Girl (Funky RMX)"},
        {id = "101280279977761", judul = "Kini Kita Pe Kisah - DJ Pelik Pungki"},
        {id = "117080961502380", judul = "DJ Music Dubstep x Bangun Tidur Selfie"},
        {id = "110337096446518", judul = "DJ Onia"},
    },
    Volume = 0.5, Pitch = 1,
}
_G.Roooor_Bombax = Bombax

-- =========================================================
-- KILL FOG AUTO
-- =========================================================
Lighting.FogEnd = 1000000
Lighting.FogStart = 1000000
Lighting.FogColor = Color3.fromRGB(255, 255, 255)
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Atmosphere") then
        v.Density = 0
        v.Haze = 0
        v.Glare = 0
        v.Offset = 0
    end
end

task.spawn(function()
    while task.wait(0.5) do
        if S.KillFog then
            if Lighting.FogEnd < 100000 then
                Lighting.FogEnd = 1000000
                Lighting.FogStart = 1000000
            end
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") and v.Density > 0 then
                    v.Density = 0
                    v.Haze = 0
                    v.Glare = 0
                end
            end
        end
    end
end)

print("[1/20] Config + Loading + State + ALF + Stun Sound + Kill Fog OK")-- =========================================================
-- Section 2 : Fire + Sky + KillerAnims + SkipAnims + Grafik
-- =========================================================

FireList = {
    "Classic","HellFire","IceFire","ToxicFire","VoidFire",
    "GoldenKing","SakuraFire","EmeraldFire","BloodFire","ShadowFire",
    "HolyFire","OceanFire","Firework","Lava","GhostFire",
    "CosmicFire","DragonFire","MysteryFire","RainbowFire","LightningFire",
    "GalaxyFire","NebulaFire","AuroraFire","PhoenixFire","DemonFire",
    "AngelFire","CrystalFire","NeonFire","PlasmaFire","QuantumFire",
    "LegendaryFire","MythicFire","DivineFire","CursedFire","AncientFire",
    "EternalFire","InfernoFire","BifrostFire","ChaosFire","OmegaFire",
    "SolarFire","LunarFire","EclipseFire","SolarFlare","VoidStorm",
    "StarFire","SupernovaFire","BlackHoleFire","MeteorFire","CometFire",
    "FrostFire","BlizzardFire","ThunderFire","StormFire","TornadoFire",
    "SoulFire","SpiritFire","PhantomFire","WraithFire","ReaperFire"
}

FireConfig = {
    Classic = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(0, 230, 255) },
    HellFire = { c1 = Color3.fromRGB(180, 0, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    IceFire = { c1 = Color3.fromRGB(120, 200, 255), c2 = Color3.fromRGB(220, 240, 255), spark = true },
    ToxicFire = { c1 = Color3.fromRGB(0, 255, 50), c2 = Color3.fromRGB(180, 255, 0), smoke = true },
    VoidFire = { c1 = Color3.fromRGB(100, 0, 180), c2 = Color3.fromRGB(220, 50, 255), spark = true },
    GoldenKing = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    SakuraFire = { c1 = Color3.fromRGB(255, 150, 200), c2 = Color3.fromRGB(255, 220, 240), spark = true },
    EmeraldFire = { c1 = Color3.fromRGB(0, 220, 100), c2 = Color3.fromRGB(120, 255, 170) },
    BloodFire = { c1 = Color3.fromRGB(220, 0, 0), c2 = Color3.fromRGB(120, 0, 0), smoke = true },
    ShadowFire = { c1 = Color3.fromRGB(30, 30, 40), c2 = Color3.fromRGB(100, 0, 130), smoke = true },
    HolyFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    OceanFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(120, 220, 255) },
    Firework = { c1 = Color3.fromRGB(255, 0, 120), c2 = Color3.fromRGB(255, 220, 50), rainbow = true, spark = true },
    Lava = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(120, 30, 0), smoke = true },
    GhostFire = { c1 = Color3.fromRGB(200, 200, 255), c2 = Color3.fromRGB(255, 255, 255) },
    CosmicFire = { c1 = Color3.fromRGB(80, 0, 150), c2 = Color3.fromRGB(255, 120, 220), rainbow = true },
    DragonFire = { c1 = Color3.fromRGB(255, 80, 0), c2 = Color3.fromRGB(255, 220, 50), smoke = true },
    MysteryFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true },
    RainbowFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true, spark = true },
    LightningFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(255, 255, 255), spark = true },
    GalaxyFire = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(255, 200, 255), rainbow = true, spark = true },
    NebulaFire = { c1 = Color3.fromRGB(220, 80, 255), c2 = Color3.fromRGB(80, 220, 255), rainbow = true, spark = true },
    AuroraFire = { c1 = Color3.fromRGB(0, 255, 200), c2 = Color3.fromRGB(120, 255, 120), rainbow = true, spark = true },
    PhoenixFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    DemonFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 0), smoke = true },
    AngelFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 240, 255), spark = true },
    CrystalFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(220, 220, 255), spark = true },
    NeonFire = { c1 = Color3.fromRGB(0, 255, 120), c2 = Color3.fromRGB(255, 0, 220), rainbow = true },
    PlasmaFire = { c1 = Color3.fromRGB(180, 0, 255), c2 = Color3.fromRGB(0, 220, 255), spark = true },
    QuantumFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(255, 0, 120), rainbow = true },
    LegendaryFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 120, 0), spark = true },
    MythicFire = { c1 = Color3.fromRGB(220, 0, 255), c2 = Color3.fromRGB(255, 220, 0), rainbow = true },
    DivineFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    CursedFire = { c1 = Color3.fromRGB(100, 0, 0), c2 = Color3.fromRGB(220, 0, 220), smoke = true },
    AncientFire = { c1 = Color3.fromRGB(220, 180, 0), c2 = Color3.fromRGB(120, 60, 0), smoke = true },
    EternalFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 220, 255), rainbow = true },
    InfernoFire = { c1 = Color3.fromRGB(255, 40, 0), c2 = Color3.fromRGB(255, 220, 0), smoke = true },
    BifrostFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 255, 220), rainbow = true },
    ChaosFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 255), rainbow = true },
    OmegaFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 0, 255), rainbow = true },
    SolarFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    LunarFire = { c1 = Color3.fromRGB(220, 220, 255), c2 = Color3.fromRGB(120, 170, 255), spark = true },
    EclipseFire = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(255, 180, 0), spark = true },
    SolarFlare = { c1 = Color3.fromRGB(255, 120, 0), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    VoidStorm = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(220, 0, 255), rainbow = true, spark = true },
    StarFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    SupernovaFire = { c1 = Color3.fromRGB(255, 220, 0), c2 = Color3.fromRGB(255, 0, 220), rainbow = true, spark = true },
    BlackHoleFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(120, 0, 180), smoke = true },
    MeteorFire = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(220, 40, 0), smoke = true },
    CometFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(220, 255, 255), spark = true },
    FrostFire = { c1 = Color3.fromRGB(220, 240, 255), c2 = Color3.fromRGB(120, 200, 255), spark = true },
    BlizzardFire = { c1 = Color3.fromRGB(240, 250, 255), c2 = Color3.fromRGB(170, 220, 255), spark = true, smoke = true },
    ThunderFire = { c1 = Color3.fromRGB(255, 255, 120), c2 = Color3.fromRGB(120, 120, 255), spark = true },
    StormFire = { c1 = Color3.fromRGB(100, 100, 180), c2 = Color3.fromRGB(220, 220, 255), spark = true, smoke = true },
    TornadoFire = { c1 = Color3.fromRGB(180, 180, 220), c2 = Color3.fromRGB(100, 100, 150), spark = true, smoke = true },
    SoulFire = { c1 = Color3.fromRGB(0, 255, 220), c2 = Color3.fromRGB(180, 255, 255), spark = true },
    SpiritFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(180, 220, 255), spark = true },
    PhantomFire = { c1 = Color3.fromRGB(120, 0, 180), c2 = Color3.fromRGB(80, 0, 120), smoke = true },
    WraithFire = { c1 = Color3.fromRGB(50, 0, 80), c2 = Color3.fromRGB(180, 0, 220), smoke = true },
    ReaperFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(255, 0, 0), smoke = true },
}

for _, name in ipairs(FireList) do
    if not FireConfig[name] then
        FireConfig[name] = FireConfig.Classic
    end
end

SkyList = {
    "Default", "Sunset", "Night", "Space",
    "Alien", "Purple", "Galaxy", "Void",
    "GalaxyPurple", "GalaxyBlue", "GalaxyPink", "GalaxyMulticolor",
    "Nebula", "CosmicStorm", "Aurora",
    "SunsetHD", "NightHD", "DeepSpace",
}

SkyIds = {
    Sunset = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    Night = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    Space = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Alien = { Bk = "rbxassetid://10253172001", Dn = "rbxassetid://10253172001", Ft = "rbxassetid://10253172001", Lf = "rbxassetid://10253172001", Rt = "rbxassetid://10253172001", Up = "rbxassetid://10253172001" },
    Purple = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    Galaxy = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Void = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    GalaxyPurple = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    GalaxyBlue = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    GalaxyPink = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    GalaxyMulticolor = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Nebula = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    CosmicStorm = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Aurora = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    SunsetHD = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    NightHD = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    DeepSpace = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
}

KillerAnims = {}
for _, id in ipairs({
    "105374834496520","113255068724446","118907603246885","129784271201071",
    "117042998468241","122812055447896","78935059863801","74968262036854",
    "78432063483146","132817836308238","133963973694098","111920872708571",
    "80411309607666","98163597193511","82666958311998","110355011987939",
    "139369275981139","135002183282873","121216847022485","130593238885843",
    "117070354890871","106871536134254","138720291317243"
}) do
    KillerAnims["rbxassetid://"..id] = true
end

SkipAnims = {
    ["112166042383605"] = "Break Pallet",
    ["123047897844134"] = "Stun",
    ["126965695851149"] = "WalkCrouch",
    ["135084204086504"] = "WalkCrouch Injured",
    ["127096285501517"] = "Parry Anim",
}

GraphicPresets = {
    ["Soft"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.075, Ambient = Color3.fromRGB(42,45,52), OutdoorAmbient = Color3.fromRGB(130,138,155) },
    ["Cinematic"] = { Brightness = 2.10, Exposure = 0.05, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(32,35,42), OutdoorAmbient = Color3.fromRGB(125,132,150) },
    ["Ultra Cinematic"] = { Brightness = 2.15, Exposure = 0.07, ShadowSoftness = 0.045, Ambient = Color3.fromRGB(30,32,40), OutdoorAmbient = Color3.fromRGB(135,142,160) },
    ["Golden Hour"] = { Brightness = 2.20, Exposure = 0.08, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(58,48,38), OutdoorAmbient = Color3.fromRGB(155,135,105) },
    ["Night Cinema"] = { Brightness = 1.65, Exposure = -0.02, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(20,25,38), OutdoorAmbient = Color3.fromRGB(65,78,110) },
}

GraphicPresetOrder = {"Soft","Cinematic","Ultra Cinematic","Golden Hour","Night Cinema"}

GraphicState = _G.Roooor_GraphicState or {
    SoftCinematic = false, LowGraphics = false, FullBright = false,
    NoFog = false, ClockTime = 18, SelectedPreset = "Soft",
}
_G.Roooor_GraphicState = GraphicState

SharpState = _G.Roooor_SharpState or { ActivePreset = nil }
_G.Roooor_SharpState = SharpState

SharpBackup = {
    Particle = {}, Part = {},
    Lighting = {
        Brightness = Lighting.Brightness,
        ExposureCompensation = Lighting.ExposureCompensation,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        GlobalShadows = Lighting.GlobalShadows,
        ShadowSoftness = Lighting.ShadowSoftness,
        ClockTime = Lighting.ClockTime,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
    },
    CreatedEffects = {},
}

-- =========================================================
-- AUTO PARRY ALF v1 - STATE (dari ALF)
-- =========================================================
APALF_State = {
    LastParry = 0,
    ActiveAttackers = {},
    CircleFolder = nil,
    CircleDashes = {},
    CircleRotCFs = {},
    CircleOffsets = {},
    CircleRadius = 0,
    CircleBuiltForDagger = false,
    CircleLastX = math.huge,
    CircleLastY = math.huge,
    CircleLastZ = math.huge,
    CircleSpawnTime = 0,
    CircleSpawnDuration = 0.55,
}

APALF_Cooldown = {
    OnCooldown = false,
    CooldownEnd = 0,
    WaitingForResult = false,
    WaitingStart = 0,
    WaitTimeout = 2.0,
    FallbackCooldown = 60,
    MaxCooldown = 90,
    LastFiredAt = 0,
    IsSilenced = false,
    JustFired = false,
    ManualDetect = false,
    ManualIgnoreWindow = 0.35,
}

-- =========================================================
-- WISNU AUTO PARRY v2 - STATE (dari ALF)
-- =========================================================
Wisnu_State = {
    Cooldown = false,
    CooldownThread = nil,
    lastParry = 0,
    Adornment = nil,
}

Wisnu_Attached = {}

Wisnu_ValidParryIDs = {
    ["122812055447896"] = "Veil lunge",
    ["133963973694098"] = "Mayers Basic",
    ["117042998468241"] = "Mayers lunge",
    ["135002183282873"] = "cure lunge",
    ["121216847022485"] = "cure Basic",
    ["132817836308238"] = "Jeff Basic",
    ["129784271201071"] = "Jeff lunge",
    ["82666958311998"]  = "Jeff Frenzy",
    ["78432063483146"]  = "Abyssal Basic",
    ["118907603246885"] = "Abyssal lunge",
    ["139369275981139"] = "Jason Basic",
    ["110355011987939"] = "Jason lunge",
    ["111920872708571"] = "Masked Basic",
    ["105374834496520"] = "Masked lunge",
    ["138720291317243"] = "Masked Tony",
    ["106871536134254"] = "Masked Alex",
    ["130593238885843"] = "Masked Cobra",
    ["115244153053858"] = "Masked Cobra lunge",
    ["74968262036854"]  = "Hidden Basic",
    ["113255068724446"] = "Hidden lunge",
    ["98163597193511"]  = "Hidden S1",
    ["80411309607666"]  = "Abyssal S1"
}

-- =========================================================
-- KILLER ATTACK ANIMS (untuk APALF v1)
-- =========================================================
APALF_KillerAttackAnims = {
    ["78432063483146"] = "attack",
    ["121216847022485"] = "attack",
    ["74968262036854"] = "attack",
    ["132817836308238"] = "attack",
    ["82666958311998"] = "attack",
    ["111920872708571"] = "attack",
    ["106871536134254"] = "attack",
    ["109402730355822"] = "attack",
    ["130593238885843"] = "attack",
    ["138720291317243"] = "attack",
    ["139369275981139"] = "attack",
    ["133963973694098"] = "attack",
    ["78935059863801"] = "attack",
    ["118907603246885"] = "lungehold",
    ["135002183282873"] = "lungehold",
    ["113255068724446"] = "lungehold",
    ["129784271201071"] = "lungehold",
    ["105374834496520"] = "lungehold",
    ["117070354890871"] = "lungehold",
    ["115244153053858"] = "lungehold",
    ["110355011987939"] = "lungehold",
    ["117042998468241"] = "lungehold",
    ["122812055447896"] = "lungehold",
}

print("[2/20] Fire + Sky + KillerAnims + SkipAnims + Grafik + APALF State OK")-- =========================================================
-- Section 3 : Bombax Music Player
-- =========================================================

local GN = {
    DIAMOND_BLUE = Color3.fromRGB(120, 200, 255),
    DIAMOND_LIGHT = Color3.fromRGB(180, 230, 255),
    DIAMOND_DARK = Color3.fromRGB(40, 100, 180),
    DIAMOND_MID = Color3.fromRGB(80, 160, 240),
}

local bombaxMusic = Instance.new("Sound")
bombaxMusic.Name = "BombaxMusic"
bombaxMusic.Volume = Bombax.Volume or 0.5
bombaxMusic.Pitch = Bombax.Pitch or 1
bombaxMusic.Looped = false
bombaxMusic.Parent = SoundService
Bombax.Music = bombaxMusic

local bombaxSedangDiputar = false
local bombaxLaguSekarang = nil
local bombaxGuiTerbuka = true
local shimmerPos = 0

local bombaxGui = Instance.new("ScreenGui")
bombaxGui.Name = "BombaxGUI"
bombaxGui.ResetOnSpawn = false
bombaxGui.IgnoreGuiInset = true
bombaxGui.DisplayOrder = 99998
bombaxGui.Parent = PG
_G.Roooor_BombaxGui = bombaxGui

local bFrame = Instance.new("Frame")
bFrame.Name = "MainFrame"
bFrame.Size = UDim2.new(0, 200, 0, 110)
bFrame.Position = UDim2.new(0, 20, 0, 100)
bFrame.BackgroundColor3 = GN.DIAMOND_MID
bFrame.BackgroundTransparency = 0.15
bFrame.BorderSizePixel = 0
bFrame.Active = true
bFrame.Draggable = true
bFrame.Parent = bombaxGui

local bCorner = Instance.new("UICorner")
bCorner.CornerRadius = UDim.new(0, 14)
bCorner.Parent = bFrame

local bStroke = Instance.new("UIStroke")
bStroke.Color = GN.DIAMOND_BLUE
bStroke.Thickness = 2
bStroke.Transparency = 0
bStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
bStroke.Parent = bFrame

local bGlow = Instance.new("UIStroke")
bGlow.Color = GN.DIAMOND_LIGHT
bGlow.Thickness = 8
bGlow.Transparency = 0.7
bGlow.Parent = bFrame

local bGradient = Instance.new("UIGradient")
bGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, GN.DIAMOND_DARK),
    ColorSequenceKeypoint.new(0.3, GN.DIAMOND_BLUE),
    ColorSequenceKeypoint.new(0.6, GN.DIAMOND_LIGHT),
    ColorSequenceKeypoint.new(1, GN.DIAMOND_BLUE)
}
bGradient.Rotation = 45
bGradient.Parent = bFrame

task.spawn(function()
    local t = 0
    while bGradient.Parent do
        t = t + 1
        bGradient.Rotation = (t * 1.5) % 360
        task.wait(0.05)
    end
end)

local bShimmer = Instance.new("ImageLabel")
bShimmer.Size = UDim2.new(0, 80, 1, 0)
bShimmer.Position = UDim2.new(0, -80, 0, 0)
bShimmer.BackgroundTransparency = 1
bShimmer.Image = "rbxassetid://5028857084"
bShimmer.ImageColor3 = GN.DIAMOND_LIGHT
bShimmer.ImageTransparency = 0.3
bShimmer.ZIndex = 2
bShimmer.Parent = bFrame

local bOverlay = Instance.new("Frame")
bOverlay.Size = UDim2.new(1, 0, 1, 0)
bOverlay.BackgroundColor3 = GN.DIAMOND_LIGHT
bOverlay.BackgroundTransparency = 0.9
bOverlay.BorderSizePixel = 0
bOverlay.ZIndex = 1
bOverlay.Parent = bFrame
rnd(bOverlay, 14)

local bNeonLine = Instance.new("Frame")
bNeonLine.Size = UDim2.new(1, -24, 0, 3)
bNeonLine.Position = UDim2.new(0, 12, 0, 0)
bNeonLine.BackgroundColor3 = GN.DIAMOND_LIGHT
bNeonLine.BorderSizePixel = 0
bNeonLine.ZIndex = 3
bNeonLine.Parent = bFrame
rnd(bNeonLine, 2)

local bEqIcon = Instance.new("Frame")
bEqIcon.Size = UDim2.new(0, 18, 0, 18)
bEqIcon.Position = UDim2.new(0, 8, 0, 7)
bEqIcon.BackgroundTransparency = 1
bEqIcon.ZIndex = 4
bEqIcon.Parent = bFrame

local function makeBar(xPos, hScale, yPos)
    local b = Instance.new("Frame")
    b.Size = UDim2.new(0, 3, hScale, 0)
    b.Position = UDim2.new(0, xPos, yPos, 0)
    b.BackgroundColor3 = GN.DIAMOND_LIGHT
    b.BorderSizePixel = 0
    b.ZIndex = 4
    b.Parent = bEqIcon
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = b
    return b
end

makeBar(0, 0.4, 0.6)
makeBar(5, 0.7, 0.3)
makeBar(10, 0.5, 0.5)

local bTitleApp = Instance.new("TextLabel")
bTitleApp.Size = UDim2.new(1, -60, 0, 14)
bTitleApp.Position = UDim2.new(0, 32, 0, 9)
bTitleApp.BackgroundTransparency = 1
bTitleApp.Text = "BOMBAX"
bTitleApp.TextColor3 = Color3.fromRGB(255, 255, 255)
bTitleApp.Font = Enum.Font.GothamBold
bTitleApp.TextScaled = true
bTitleApp.TextXAlignment = Enum.TextXAlignment.Left
bTitleApp.TextStrokeTransparency = 0.5
bTitleApp.TextStrokeColor3 = GN.DIAMOND_DARK
bTitleApp.ZIndex = 4
bTitleApp.Parent = bFrame

local bToggle = Instance.new("TextButton")
bToggle.Size = UDim2.new(0, 18, 0, 18)
bToggle.Position = UDim2.new(1, -24, 0, 9)
bToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
bToggle.Text = "−"
bToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
bToggle.Font = Enum.Font.GothamBold
bToggle.TextScaled = true
bToggle.ZIndex = 4
bToggle.Parent = bFrame
rnd(bToggle, 5)

local bContainer = Instance.new("Frame")
bContainer.Size = UDim2.new(1, 0, 1, -32)
bContainer.Position = UDim2.new(0, 0, 0, 32)
bContainer.BackgroundTransparency = 1
bContainer.ZIndex = 3
bContainer.Parent = bFrame

local bTitleLabel = Instance.new("TextLabel")
bTitleLabel.Size = UDim2.new(1, -16, 0, 14)
bTitleLabel.Position = UDim2.new(0, 8, 0, 0)
bTitleLabel.BackgroundTransparency = 1
bTitleLabel.Text = "Memuat..."
bTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
bTitleLabel.Font = Enum.Font.GothamBold
bTitleLabel.TextScaled = true
bTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
bTitleLabel.TextStrokeTransparency = 0.5
bTitleLabel.TextStrokeColor3 = GN.DIAMOND_DARK
bTitleLabel.ZIndex = 4
bTitleLabel.Parent = bContainer

local bStatusLabel = Instance.new("TextLabel")
bStatusLabel.Size = UDim2.new(1, -16, 0, 10)
bStatusLabel.Position = UDim2.new(0, 8, 0, 14)
bStatusLabel.BackgroundTransparency = 1
bStatusLabel.Text = "● Berhenti"
bStatusLabel.TextColor3 = GN.DIAMOND_LIGHT
bStatusLabel.Font = Enum.Font.Gotham
bStatusLabel.TextScaled = true
bStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
bStatusLabel.ZIndex = 4
bStatusLabel.Parent = bContainer

local bTimeLabel = Instance.new("TextLabel")
bTimeLabel.Size = UDim2.new(1, -16, 0, 8)
bTimeLabel.Position = UDim2.new(0, 8, 0, 24)
bTimeLabel.BackgroundTransparency = 1
bTimeLabel.Text = "00:00 / 00:00"
bTimeLabel.TextColor3 = GN.DIAMOND_LIGHT
bTimeLabel.Font = Enum.Font.Gotham
bTimeLabel.TextScaled = true
bTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
bTimeLabel.ZIndex = 4
bTimeLabel.Parent = bContainer

local bProgressBg = Instance.new("Frame")
bProgressBg.Size = UDim2.new(1, -16, 0, 3)
bProgressBg.Position = UDim2.new(0, 8, 0, 34)
bProgressBg.BackgroundColor3 = Color3.fromRGB(20, 40, 80)
bProgressBg.BorderSizePixel = 0
bProgressBg.ZIndex = 4
bProgressBg.Parent = bContainer
rnd(bProgressBg, 2)

local bProgressFill = Instance.new("Frame")
bProgressFill.Size = UDim2.new(0, 0, 1, 0)
bProgressFill.BackgroundColor3 = GN.DIAMOND_LIGHT
bProgressFill.BorderSizePixel = 0
bProgressFill.ZIndex = 4
bProgressFill.Parent = bProgressBg
rnd(bProgressFill, 2)

local function bBuatTombol(teks, posisiX, warna, ukuran)
    local t = Instance.new("TextButton")
    t.Size = UDim2.new(0, ukuran, 0, 22)
    t.Position = UDim2.new(0, posisiX, 0, 42)
    t.BackgroundColor3 = warna
    t.Text = teks
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.Font = Enum.Font.GothamBold
    t.TextScaled = true
    t.ZIndex = 4
    t.Parent = bContainer
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = t
    local s = Instance.new("UIStroke")
    s.Color = GN.DIAMOND_LIGHT
    s.Thickness = 1
    s.Transparency = 0.3
    s.Parent = t
    return t
end

local bTombolPlay = bBuatTombol("▶", 8, GN.DIAMOND_DARK, 32)
local bTombolStop = bBuatTombol("⏹", 44, Color3.fromRGB(60, 120, 200), 32)
local bTombolNext = bBuatTombol("⏭", 80, GN.DIAMOND_DARK, 32)
local bTombolAcak = bBuatTombol("🔀", 116, GN.DIAMOND_MID, 32)
local bTombolUlang = bBuatTombol("🔁", 152, GN.DIAMOND_DARK, 32)

local function formatWaktu(detik)
    if not detik or detik ~= detik then detik = 0 end
    local m = math.floor(detik / 60)
    local s = math.floor(detik % 60)
    return string.format("%02d:%02d", m, s)
end

local function updateTeks()
    if bombaxLaguSekarang then
        bTitleLabel.Text = bombaxLaguSekarang.judul
    else
        bTitleLabel.Text = "Memuat..."
    end
    if bombaxSedangDiputar then
        bStatusLabel.Text = "● Diputar"
        bStatusLabel.TextColor3 = GN.DIAMOND_LIGHT
    else
        bStatusLabel.Text = "● Berhenti"
        bStatusLabel.TextColor3 = GN.DIAMOND_BLUE
    end
end

local function putarRandom()
    if #Bombax.DaftarLagu == 0 then return end
    local pilihan = Bombax.DaftarLagu[math.random(1, #Bombax.DaftarLagu)]
    bombaxLaguSekarang = pilihan
    bombaxMusic.SoundId = "rbxassetid://" .. pilihan.id
    bombaxMusic:Play()
    bombaxSedangDiputar = true
    updateTeks()
end

Bombax.PutarRandom = putarRandom
Bombax.Stop = function()
    bombaxMusic:Stop()
    bombaxSedangDiputar = false
    updateTeks()
end

bTombolPlay.MouseButton1Click:Connect(function()
    if not bombaxSedangDiputar then
        if bombaxMusic.IsPlaying then
            bombaxMusic:Resume()
        else
            putarRandom()
        end
        bombaxSedangDiputar = true
        updateTeks()
    end
end)

bTombolStop.MouseButton1Click:Connect(function()
    bombaxMusic:Stop()
    bombaxSedangDiputar = false
    updateTeks()
end)

bTombolNext.MouseButton1Click:Connect(function() putarRandom() end)
bTombolAcak.MouseButton1Click:Connect(function() putarRandom() end)

bTombolUlang.MouseButton1Click:Connect(function()
    if bombaxMusic.IsPlaying then
        bombaxMusic.TimePosition = 0
    end
end)

bToggle.MouseButton1Click:Connect(function()
    bombaxGuiTerbuka = not bombaxGuiTerbuka
    if bombaxGuiTerbuka then
        bToggle.Text = "−"
        bToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        bContainer.Visible = true
        TweenService:Create(bFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 200, 0, 110)
        }):Play()
    else
        bToggle.Text = "+"
        bToggle.BackgroundColor3 = Color3.fromRGB(0, 160, 80)
        TweenService:Create(bFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 200, 0, 32)
        }):Play()
        task.delay(0.3, function() bContainer.Visible = false end)
    end
end)

bombaxMusic.Ended:Connect(function() putarRandom() end)

RunService.RenderStepped:Connect(function(dt)
    if bombaxMusic.IsPlaying and bombaxMusic.TimeLength > 0 then
        local persen = bombaxMusic.TimePosition / bombaxMusic.TimeLength
        bProgressFill.Size = UDim2.new(persen, 0, 1, 0)
        bTimeLabel.Text = formatWaktu(bombaxMusic.TimePosition) .. " / " .. formatWaktu(bombaxMusic.TimeLength)
    else
        bProgressFill.Size = UDim2.new(0, 0, 1, 0)
    end
    shimmerPos = shimmerPos + dt * 1.2
    if shimmerPos > 1.4 then shimmerPos = -0.4 end
    bShimmer.Position = UDim2.new(shimmerPos, 0, 0, 0)
end)

updateTeks()

print("[3/20] BOMBAX Music Player OK - " .. #Bombax.DaftarLagu .. " lagu")-- =========================================================
-- Section 4 : Fungsi Utama + Crosshair 10 Style + Kill Fog
-- =========================================================

-- ============ FIRE ============
function clearFire()
    if not LP.Character then return end
    local head = LP.Character:FindFirstChild("Head")
    if not head then return end
    for _, obj in pairs(head:GetChildren()) do
        if obj.Name == "RoooorFire" or obj.Name == "RoooorSmoke" or obj.Name == "RoooorSparkles" then
            obj:Destroy()
        end
    end
end

function applyFire()
    clearFire()
    if not S.FireOn then return end
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local cfg = FireConfig[S.FireType] or FireConfig.Classic

    local fire = Instance.new("Fire")
    fire.Name = "RoooorFire"
    fire.Size = S.FireSize
    fire.Heat = 15
    fire.Color = cfg.c1
    fire.SecondaryColor = cfg.c2
    fire.Parent = head

    if cfg.smoke then
        local smoke = Instance.new("Smoke")
        smoke.Name = "RoooorSmoke"
        smoke.Size = S.FireSize + 2
        smoke.RiseVelocity = 3
        smoke.Opacity = 0.4
        smoke.Color = cfg.c2
        smoke.Parent = head
    end

    if cfg.spark then
        local spark = Instance.new("Sparkles")
        spark.Name = "RoooorSparkles"
        spark.SparkleColor = cfg.c2
        spark.SparkleSize = 1
        spark.Parent = head
    end
end

task.spawn(function()
    while task.wait(0.8) do
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            local fire = head and head:FindFirstChild("RoooorFire")
            if fire then
                local cfg = FireConfig[S.FireType] or FireConfig.Classic
                if cfg.rainbow then
                    local t = tick()
                    fire.Color = Color3.fromHSV((t * 0.5) % 1, 1, 1)
                    fire.SecondaryColor = Color3.fromHSV(((t * 0.5) + 0.5) % 1, 1, 1)
                end
            end
        end
    end
end)

-- ============ 8-BIT ============
eightBitPart = nil

function clear8Bit()
    if eightBitPart then eightBitPart:Destroy(); eightBitPart = nil end
end

function apply8Bit(enable, itemName, size, height)
    clear8Bit()
    if not enable then return end
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    size = size or S.EightBitSize or 1.24
    height = height or S.EightBitHeight or 0.88

    eightBitPart = Instance.new("Part")
    eightBitPart.Name = "Client8Bit"
    eightBitPart.Size = Vector3.new(2, 2, 2) * size
    eightBitPart.CanCollide = false
    eightBitPart.Massless = true
    eightBitPart.Transparency = 0
    eightBitPart.Parent = head

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://10138606900"
    mesh.TextureId = "rbxassetid://10138606949"
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5) * size
    mesh.Parent = eightBitPart

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = eightBitPart
    weld.C0 = CFrame.new(0, height * size, 0)
    weld.Parent = eightBitPart
end

-- ============ KORBLOX ============
korbloxParts = {}
korbloxOrigData = {}

function clearKorblox()
    for _, part in pairs(korbloxParts) do
        if part and part.Parent then part:Destroy() end
    end
    korbloxParts = {}
    local char = LP.Character
    if not char then return end
    for legName, data in pairs(korbloxOrigData) do
        local leg = char:FindFirstChild(legName)
        if leg then
            leg.Transparency = data.trans
            leg.CanCollide = data.collide
        end
    end
    korbloxOrigData = {}
end

function applyKorblox(enable, mode, yOffset, scale)
    clearKorblox()
    if not enable then return end
    yOffset = yOffset or 0.80
    scale = scale or S.KorbloxScale or 1
    local char = LP.Character
    if not char then return end
    local rightLeg = char:FindFirstChild("Right Leg")
    if not rightLeg then return end

    korbloxOrigData["Right Leg"] = {
        trans = rightLeg.Transparency,
        collide = rightLeg.CanCollide,
    }
    rightLeg.Transparency = 1
    rightLeg.CanCollide = false

    local korbloxPart = Instance.new("Part")
    korbloxPart.Name = "ClientKorblox"
    korbloxPart.Size = Vector3.new(1, 2, 1)
    korbloxPart.CanCollide = false
    korbloxPart.Massless = true
    korbloxPart.Transparency = 0
    korbloxPart.Parent = char

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://902942096"
    mesh.TextureId = "rbxassetid://902843398"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Offset = Vector3.new(0, yOffset, 0)
    mesh.Parent = korbloxPart

    local weld = Instance.new("Weld")
    weld.Part0 = rightLeg
    weld.Part1 = korbloxPart
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = korbloxPart

    table.insert(korbloxParts, korbloxPart)
end

-- ============ HEADLESS ============
function applyHeadless(s)
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if s then
        head.Transparency = 1
        head.CanCollide = false
        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
                v.CanCollide = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
        for _, obj in pairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    else
        head.Transparency = 0
        head.CanCollide = true
        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
                v.CanCollide = true
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            end
        end
    end
end

-- ============ HD SKY & VISUAL ============
hdExtras = {}
origLighting = {
    FogEnd = Lighting.FogEnd, FogStart = Lighting.FogStart,
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    ExposureCompensation = Lighting.ExposureCompensation,
    GlobalShadows = Lighting.GlobalShadows,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    ShadowSoftness = Lighting.ShadowSoftness,
}

origSky = nil
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") then
        origSky = v
        break
    end
end

function applyKillFog(s)
    if s then
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 1000000
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then
                v.Density = 0
                v.Haze = 0
                v.Glare = 0
                v.Offset = 0
            end
        end
    else
        Lighting.FogEnd = origLighting.FogEnd
        Lighting.FogStart = origLighting.FogStart
    end
end

function applyHDSky(s)
    if s then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then v:Destroy() end
        end
        pcall(function()
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.FogColor = Color3.fromRGB(200, 220, 255)
        end)
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
        local cleanSky = Instance.new("Sky")
        cleanSky.Name = "HDSky_Clean"
        cleanSky.SkyboxBk = "rbxassetid://159454299"
        cleanSky.SkyboxDn = "rbxassetid://159454296"
        cleanSky.SkyboxFt = "rbxassetid://159454293"
        cleanSky.SkyboxLf = "rbxassetid://159454286"
        cleanSky.SkyboxRt = "rbxassetid://159454300"
        cleanSky.SkyboxUp = "rbxassetid://159454288"
        cleanSky.Parent = Lighting

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(150, 160, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 190, 210)
    else
        local oldSky = Lighting:FindFirstChild("HDSky_Clean")
        if oldSky then oldSky:Destroy() end
        pcall(function()
            Lighting.FogEnd = origLighting.FogEnd or 100000
            Lighting.FogStart = origLighting.FogStart or 0
            Lighting.Brightness = origLighting.Brightness
            Lighting.ClockTime = origLighting.ClockTime
            Lighting.Ambient = origLighting.Ambient
            Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        end)
    end
end

function applySky(skyName)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    Lighting.FogEnd = 1000000
    Lighting.FogStart = 1000000
    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then
            v.Density = 0
            v.Haze = 0
            v.Glare = 0
            v.Offset = 0
        end
    end
    if not skyName or skyName == "Default" then
        if origSky then
            local c = origSky:Clone()
            c.Name = "OrigSky_Clone"
            c.Parent = Lighting
        end
        return
    end
    local ids = SkyIds[skyName]
    if not ids then ids = SkyIds.SunsetHD end
    local sky = Instance.new("Sky")
    sky.Name = "OneWSky_" .. skyName
    sky.SkyboxBk = ids.Bk
    sky.SkyboxDn = ids.Dn or ids.Bk
    sky.SkyboxFt = ids.Ft or ids.Bk
    sky.SkyboxLf = ids.Lf or ids.Bk
    sky.SkyboxRt = ids.Rt or ids.Bk
    sky.SkyboxUp = ids.Up or ids.Bk
    sky.Parent = Lighting
    
    local atmo = Lighting:FindFirstChild("OneWAtmosphere")
    if not atmo then
        atmo = Instance.new("Atmosphere")
        atmo.Name = "OneWAtmosphere"
        atmo.Parent = Lighting
    end
    atmo.Density = 0
    atmo.Haze = 0
    atmo.Glare = 0
    atmo.Offset = 0
    atmo.Color = Color3.fromRGB(220, 230, 255)
    atmo.Decay = Color3.fromRGB(180, 200, 240)
end

function applyHDTexture(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applyHDReflection(s)
    if s then
        if not hdExtras.Reflection then
            hdExtras.Reflection = Instance.new("ColorCorrectionEffect")
            hdExtras.Reflection.Name = "OneWReflection"
            hdExtras.Reflection.Brightness = 0.05
            hdExtras.Reflection.Contrast = 0.1
            hdExtras.Reflection.Parent = Lighting
        end
    else
        if hdExtras.Reflection then hdExtras.Reflection:Destroy(); hdExtras.Reflection = nil end
    end
end

function applyHDBloom(s)
    if s then
        if not hdExtras.Bloom then
            hdExtras.Bloom = Instance.new("BloomEffect")
            hdExtras.Bloom.Name = "OneWHDBloom"
            hdExtras.Bloom.Intensity = 0.7
            hdExtras.Bloom.Size = 24
            hdExtras.Bloom.Threshold = 0.9
            hdExtras.Bloom.Parent = Lighting
        end
    else
        if hdExtras.Bloom then hdExtras.Bloom:Destroy(); hdExtras.Bloom = nil end
    end
end

function applyHDShadow(s)
    if s then Lighting.GlobalShadows = true end
end

function applyHDWater(s)
    if s then
        if not hdExtras.Water then
            hdExtras.Water = Instance.new("ColorCorrectionEffect")
            hdExtras.Water.Name = "OneWWater"
            hdExtras.Water.TintColor = Color3.fromRGB(180, 220, 255)
            hdExtras.Water.Parent = Lighting
        end
    else
        if hdExtras.Water then hdExtras.Water:Destroy(); hdExtras.Water = nil end
    end
end

function applyHDSunRays(s)
    if s then
        if not hdExtras.SunRays then
            hdExtras.SunRays = Instance.new("SunRaysEffect")
            hdExtras.SunRays.Name = "OneWSunRays"
            hdExtras.SunRays.Intensity = 0.15
            hdExtras.SunRays.Spread = 1
            hdExtras.SunRays.Parent = Lighting
        end
    else
        if hdExtras.SunRays then hdExtras.SunRays:Destroy(); hdExtras.SunRays = nil end
    end
end

function applyHDDepthField(s)
    if s then
        if not hdExtras.DepthField then
            hdExtras.DepthField = Instance.new("DepthOfFieldEffect")
            hdExtras.DepthField.Name = "OneWDOF"
            hdExtras.DepthField.FarIntensity = 0.15
            hdExtras.DepthField.FocusDistance = 20
            hdExtras.DepthField.InFocusRadius = 15
            hdExtras.DepthField.NearIntensity = 0.1
            hdExtras.DepthField.Parent = Lighting
        end
    else
        if hdExtras.DepthField then hdExtras.DepthField:Destroy(); hdExtras.DepthField = nil end
    end
end

function applyHDAntiAliasing(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applyFullbright(s)
    if s then
        local val = (S.FullbrightVal or 200) / 100
        Lighting.Brightness = val
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        Lighting.ExposureCompensation = 0.5
    else
        Lighting.Brightness = origLighting.Brightness
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        Lighting.ExposureCompensation = origLighting.ExposureCompensation or 0
    end
end

function applyNoFog(s)
    if s then
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
    else
        Lighting.FogStart = origLighting.FogStart
        Lighting.FogEnd = origLighting.FogEnd
    end
end

function applyUltraHD()
    if S.UltraHD then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
            Lighting.GlobalShadows = true
        end)
    end
end

function applyContrast()
    if not hdExtras.Contrast then
        hdExtras.Contrast = Instance.new("ColorCorrectionEffect")
        hdExtras.Contrast.Name = "OneWContrast"
        hdExtras.Contrast.Parent = Lighting
    end
    if S.Contrast then
        hdExtras.Contrast.Contrast = S.ContrastVal or 0.3
        hdExtras.Contrast.Saturation = S.SaturationVal or 0.2
    else
        if hdExtras.Contrast then hdExtras.Contrast:Destroy(); hdExtras.Contrast = nil end
    end
end

function applyZoomOut(s, val)
    if s then
        LP.CameraMaxZoomDistance = val or 500
    else
        LP.CameraMaxZoomDistance = 128
    end
end

function applyFOV()
    local cam = workspace.CurrentCamera
    if cam and S.FOVEnabled then
        cam.FieldOfView = S.FOV
    end
end

-- ============ TRAIL / AURA ============
function applyTrail(s, color)
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local att0 = hrp:FindFirstChild("TrailAtt0")
    local att1 = hrp:FindFirstChild("TrailAtt1")
    local trail = hrp:FindFirstChild("OneWTrail")
    if s then
        if not att0 then
            att0 = Instance.new("Attachment"); att0.Name = "TrailAtt0"
            att0.Position = Vector3.new(0, 1, 0); att0.Parent = hrp
        end
        if not att1 then
            att1 = Instance.new("Attachment"); att1.Name = "TrailAtt1"
            att1.Position = Vector3.new(0, -1, 0); att1.Parent = hrp
        end
        if not trail then
            trail = Instance.new("Trail")
            trail.Name = "OneWTrail"
            trail.Attachment0 = att0
            trail.Attachment1 = att1
            trail.Lifetime = 1
            trail.Parent = hrp
        end
        trail.Color = ColorSequence.new(color or Color3.fromRGB(255, 210, 80))
    else
        if trail then trail:Destroy() end
        if att0 then att0:Destroy() end
        if att1 then att1:Destroy() end
    end
end

function applyAura(s, color)
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local aura = hrp:FindFirstChild("OneWAura")
    if s then
        if not aura then
            aura = Instance.new("ParticleEmitter")
            aura.Name = "OneWAura"
            aura.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            aura.Rate = 50
            aura.Lifetime = NumberRange.new(0.5, 1)
            aura.Size = NumberSequence.new(0.5)
            aura.Speed = NumberRange.new(1, 3)
            aura.SpreadAngle = Vector2.new(180, 180)
            aura.Parent = hrp
        end
        aura.Color = ColorSequence.new(color or Color3.fromRGB(255, 210, 80))
    else
        if aura then aura:Destroy() end
    end
end

-- ============ CROSSHAIR 10 STYLE ============
crosshairGui = nil

function applyCrosshair(s, color, size)
    if crosshairGui then
        crosshairGui:Destroy()
        crosshairGui = nil
    end
    if not s then return end

    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "OneWCrosshair"
    crosshairGui.ResetOnSpawn = false
    crosshairGui.IgnoreGuiInset = true
    crosshairGui.DisplayOrder = 999998
    crosshairGui.Parent = PG

    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 200, 0, 200)
    container.Position = UDim2.new(0.5, -100 + (S.CrosshairOffsetX or 0), 0.5, -100 + (S.CrosshairOffsetY or 0))
    container.BackgroundTransparency = 1
    container.Parent = crosshairGui

    local style = S.CrosshairStyle or "Plus"
    local thickness = S.CrosshairThickness or 2
    local color2 = color or S.CrosshairColor or Color3.fromRGB(255, 255, 255)
    local sz = size or S.CrosshairSize or 8
    local gap = S.CrosshairGap or 4
    local showOutline = S.CrosshairShowOutline ~= false
    local outlineCol = S.CrosshairOutlineColor or Color3.fromRGB(0, 0, 0)

    local function mkLine(w, h, x, y, rot)
        if showOutline then
            local o = Instance.new("Frame")
            o.Size = UDim2.new(0, w + 2, 0, h + 2)
            o.Position = UDim2.new(0, x - 1, 0, y - 1)
            o.BackgroundColor3 = outlineCol
            o.BorderSizePixel = 0
            o.Rotation = rot or 0
            o.ZIndex = 1
            o.Parent = container
        end
        local l = Instance.new("Frame")
        l.Size = UDim2.new(0, w, 0, h)
        l.Position = UDim2.new(0, x, 0, y)
        l.BackgroundColor3 = color2
        l.BorderSizePixel = 0
        l.Rotation = rot or 0
        l.ZIndex = 2
        l.Parent = container
    end

    local function mkLineCenter(w, h, rot)
        if showOutline then
            local o = Instance.new("Frame")
            o.Size = UDim2.new(0, w + 2, 0, h + 2)
            o.Position = UDim2.new(0.5, 0, 0.5, 0)
            o.AnchorPoint = Vector2.new(0.5, 0.5)
            o.BackgroundColor3 = outlineCol
            o.BorderSizePixel = 0
            o.Rotation = rot or 0
            o.ZIndex = 1
            o.Parent = container
        end
        local l = Instance.new("Frame")
        l.Size = UDim2.new(0, w, 0, h)
        l.Position = UDim2.new(0.5, 0, 0.5, 0)
        l.AnchorPoint = Vector2.new(0.5, 0.5)
        l.BackgroundColor3 = color2
        l.BorderSizePixel = 0
        l.Rotation = rot or 0
        l.ZIndex = 2
        l.Parent = container
    end

    local function mkDot(sizeDot)
        if showOutline then
            local o = Instance.new("Frame")
            o.Size = UDim2.new(0, sizeDot + 2, 0, sizeDot + 2)
            o.Position = UDim2.new(0.5, 0, 0.5, 0)
            o.AnchorPoint = Vector2.new(0.5, 0.5)
            o.BackgroundColor3 = outlineCol
            o.BorderSizePixel = 0
            o.ZIndex = 1
            o.Parent = container
            rnd(o, 999)
        end
        local d = Instance.new("Frame")
        d.Size = UDim2.new(0, sizeDot, 0, sizeDot)
        d.Position = UDim2.new(0.5, 0, 0.5, 0)
        d.AnchorPoint = Vector2.new(0.5, 0.5)
        d.BackgroundColor3 = color2
        d.BorderSizePixel = 0
        d.ZIndex = 2
        d.Parent = container
        rnd(d, 999)
    end

    if style == "Plus" then
        mkLine(thickness, sz, 100 - thickness/2, 100 - sz - gap)
        mkLine(thickness, sz, 100 - thickness/2, 100 + gap)
        mkLine(sz, thickness, 100 - sz - gap, 100 - thickness/2)
        mkLine(sz, thickness, 100 + gap, 100 - thickness/2)
    elseif style == "Dot" then
        mkDot(math.max(4, thickness + 2))
    elseif style == "Circle" then
        if showOutline then
            local oc = Instance.new("Frame")
            oc.Size = UDim2.new(0, sz * 2 + 4, 0, sz * 2 + 4)
            oc.Position = UDim2.new(0.5, 0, 0.5, 0)
            oc.AnchorPoint = Vector2.new(0.5, 0.5)
            oc.BackgroundTransparency = 1
            oc.ZIndex = 1
            oc.Parent = container
            rnd(oc, 999)
            local os = Instance.new("UIStroke")
            os.Color = outlineCol
            os.Thickness = thickness + 2
            os.Parent = oc
        end
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, sz * 2, 0, sz * 2)
        circle.Position = UDim2.new(0.5, 0, 0.5, 0)
        circle.AnchorPoint = Vector2.new(0.5, 0.5)
        circle.BackgroundTransparency = 1
        circle.ZIndex = 2
        circle.Parent = container
        rnd(circle, 999)
        local cs = Instance.new("UIStroke")
        cs.Color = color2
        cs.Thickness = thickness
        cs.Parent = circle
    elseif style == "Cross" then
        for i = 1, 2 do
            mkLineCenter(thickness, sz + gap, (i - 1) * 90 + 45)
        end
    elseif style == "X-Cross" then
        mkLine(thickness, sz, 100 - thickness/2, 100 - sz - gap)
        mkLine(thickness, sz, 100 - thickness/2, 100 + gap)
        mkLine(sz, thickness, 100 - sz - gap, 100 - thickness/2)
        mkLine(sz, thickness, 100 + gap, 100 - thickness/2)
        for i = 1, 2 do
            mkLineCenter(thickness, sz + gap, (i - 1) * 90 + 45)
        end
    elseif style == "T-Shape" then
        mkLine(sz * 2 + gap * 2, thickness, 100 - sz - gap, 100 - thickness - gap)
        mkLine(thickness, sz, 100 - thickness/2, 100)
    elseif style == "Chevron" then
        for i = 1, 2 do
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, thickness, 0, sz)
            line.Position = UDim2.new(0.5, (i == 1) and -sz/2 or sz/2, 0.5, -sz/4)
            line.AnchorPoint = Vector2.new(0.5, 0.5)
            line.BackgroundColor3 = color2
            line.BorderSizePixel = 0
            line.Rotation = (i == 1) and 45 or -45
            line.ZIndex = 2
            line.Parent = container
        end
    elseif style == "Arrow" then
        mkLine(sz * 2, thickness, 100 - sz, 100 - thickness/2)
        for i = 1, 2 do
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, thickness, 0, sz/1.5)
            line.Position = UDim2.new(0.5, sz/2, 0.5, (i == 1) and -sz/4 or sz/4)
            line.AnchorPoint = Vector2.new(0.5, 0.5)
            line.BackgroundColor3 = color2
            line.BorderSizePixel = 0
            line.Rotation = (i == 1) and 45 or -45
            line.ZIndex = 2
            line.Parent = container
        end
    elseif style == "Brackets" then
        mkLine(thickness, sz * 1.5, 100 - sz - gap - thickness, 100 - sz * 0.75)
        mkLine(thickness, sz * 1.5, 100 + sz + gap, 100 - sz * 0.75)
    elseif style == "Diamond" then
        mkLineCenter(thickness, sz, 45)
        mkLineCenter(thickness, sz, -45)
    end
end

-- ============ KILL EFFECT ============
function spawnKillEffect(pos)
    if not pos then return end
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanCollide = false
    p.Transparency = 0.5
    p.Material = Enum.Material.Neon
    p.Color = Color3.fromRGB(120, 200, 255)
    p.Size = Vector3.new(2, 2, 2)
    p.Position = pos
    p.Parent = workspace
    TweenService:Create(p, TweenInfo.new(0.8), {
        Size = Vector3.new(20, 20, 20),
        Transparency = 1
    }):Play()
    task.delay(1, function() p:Destroy() end)
end

function teleportToFinishLine()
    local root = getRoot()
    if not root then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = string.lower(obj.Name)
            if n == "fininshline" or n == "finishline"
               or n == "escape" or n == "escapegate"
               or string.find(n, "escape") then
                pcall(function()
                    root.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                end)
                return
            end
        end
    end
end

function applyAntiAFK(enable)
    S.AntiAFK = enable
end

function rejoinServer()
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LP)
    end)
end

-- ============ FPS + PING ============
fpsPingGui = nil
fpsCounter = 0
fpsLastTime = tick()
currentFPS = 0
currentPing = 0

function createFPSPingGui()
    if fpsPingGui then fpsPingGui:Destroy() end
    fpsPingGui = Instance.new("ScreenGui")
    fpsPingGui.Name = "OneWFPSPing"
    fpsPingGui.ResetOnSpawn = false
    fpsPingGui.IgnoreGuiInset = true
    fpsPingGui.DisplayOrder = 999
    fpsPingGui.Parent = PG

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 100, 0, 20)
    frame.Position = UDim2.new(1, -110, 0, 5)
    frame.BackgroundColor3 = Color3.fromRGB(10, 25, 60)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = fpsPingGui
    rnd(frame, 4)
    strk(frame, C.CYAN, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "StatsLabel"
    label.Size = UDim2.new(1, -6, 1, 0)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "FPS: 0 | Ping: 0"
    label.TextColor3 = C.CYAN
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = frame
end

RunService.RenderStepped:Connect(function()
    fpsCounter = fpsCounter + 1
    if tick() - fpsLastTime >= 1 then
        currentFPS = fpsCounter
        fpsCounter = 0
        fpsLastTime = tick()
        pcall(function()
            currentPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if not fpsPingGui or not fpsPingGui.Parent then
            pcall(createFPSPingGui)
        end
        if fpsPingGui then
            local frame = fpsPingGui:FindFirstChild("MainFrame")
            if frame then
                local label = frame:FindFirstChild("StatsLabel")
                if label then
                    local fpsText = S.ShowFPS and tostring(currentFPS) or "OFF"
                    local pingText = S.ShowPing and (tostring(currentPing) .. "ms") or "OFF"
                    label.Text = "FPS: " .. fpsText .. " | Ping: " .. pingText
                    if currentFPS >= 50 then
                        label.TextColor3 = C.GRN
                    elseif currentFPS >= 30 then
                        label.TextColor3 = C.CYAN
                    else
                        label.TextColor3 = C.RED
                    end
                end
            end
        end
    end
end)

-- ============ GRAFIK LOGIC ============
GraphicCreatedEffects = {}
GraphicPartBackup = {}

function GraphicRemoveEffects()
    for name, effect in pairs(GraphicCreatedEffects) do
        if effect and effect.Parent then effect:Destroy() end
        GraphicCreatedEffects[name] = nil
    end
end

function GraphicApplyCharacterShadow()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if GraphicPartBackup[obj] == nil then
                GraphicPartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
    end
end

function GraphicRestorePartShadows()
    for part, oldValue in pairs(GraphicPartBackup) do
        if part and part.Parent then part.CastShadow = oldValue end
    end
    table.clear(GraphicPartBackup)
end

function GraphicApplySoftCinematic()
    local cfg = GraphicPresets[GraphicState.SelectedPreset]
    if not cfg then return end
    Lighting.Brightness = cfg.Brightness
    Lighting.ExposureCompensation = cfg.Exposure
    Lighting.ShadowSoftness = cfg.ShadowSoftness
    Lighting.Ambient = cfg.Ambient
    Lighting.OutdoorAmbient = cfg.OutdoorAmbient
    Lighting.GlobalShadows = true
end

function GraphicEnableSoftCinematic()
    GraphicState.SoftCinematic = true
    GraphicApplySoftCinematic()
end

function GraphicDisableSoftCinematic()
    GraphicState.SoftCinematic = false
    GraphicRemoveEffects()
    GraphicRestorePartShadows()
    Lighting.Brightness = origLighting.Brightness
    Lighting.ExposureCompensation = origLighting.ExposureCompensation or 0
    Lighting.ShadowSoftness = origLighting.ShadowSoftness or 0.2
    Lighting.Ambient = origLighting.Ambient
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
end

function GraphicSelectPreset(name)
    if not GraphicPresets[name] then return end
    GraphicState.SelectedPreset = name
    if GraphicState.SoftCinematic then GraphicApplySoftCinematic() end
end

function GraphicReset()
    GraphicState.SoftCinematic = false
    GraphicRemoveEffects()
    GraphicRestorePartShadows()
    Lighting.Brightness = origLighting.Brightness
    Lighting.ExposureCompensation = origLighting.ExposureCompensation or 0
    Lighting.ShadowSoftness = origLighting.ShadowSoftness or 0.2
    Lighting.Ambient = origLighting.Ambient
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
    Lighting.FogStart = origLighting.FogStart
    Lighting.FogEnd = origLighting.FogEnd
    GraphicState.SelectedPreset = "Soft"
end

-- ============ SHARP GRAPH ============
function SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end)
    Lighting.GlobalShadows = SharpBackup.Lighting.GlobalShadows
    Lighting.Brightness = SharpBackup.Lighting.Brightness
    Lighting.Ambient = SharpBackup.Lighting.Ambient
    Lighting.OutdoorAmbient = SharpBackup.Lighting.OutdoorAmbient
    Lighting.ExposureCompensation = SharpBackup.Lighting.ExposureCompensation
    Lighting.ClockTime = SharpBackup.Lighting.ClockTime
    Lighting.FogStart = SharpBackup.Lighting.FogStart
    Lighting.FogEnd = SharpBackup.Lighting.FogEnd
end

function SharpApplyAntiLag10()
    SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
    Lighting.GlobalShadows = false
    Lighting.FogStart = 100000
    Lighting.FogEnd = 100000
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(120, 130, 145)
    Lighting.OutdoorAmbient = Color3.fromRGB(140, 150, 165)
    SharpState.ActivePreset = "ANTI LAG 10"
end

function SharpApplyTajamMax()
    SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level06
    end)
    Lighting.GlobalShadows = true
    Lighting.Brightness = 2.8
    Lighting.ExposureCompensation = 0.15
    Lighting.Ambient = Color3.fromRGB(145, 152, 170)
    Lighting.OutdoorAmbient = Color3.fromRGB(175, 182, 200)
    Lighting.ClockTime = 14
    SharpState.ActivePreset = "TAJAM MAX"
end

function SharpApplyBalance()
    SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level06
    end)
    Lighting.Brightness = 2.4
    Lighting.Ambient = Color3.fromRGB(135, 142, 160)
    Lighting.OutdoorAmbient = Color3.fromRGB(160, 168, 185)
    Lighting.ClockTime = 14
    SharpState.ActivePreset = "BALANCE"
end

function SharpApplyHDSharp()
    SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level08
    end)
    Lighting.Brightness = 2.5
    Lighting.Ambient = Color3.fromRGB(135, 145, 165)
    Lighting.OutdoorAmbient = Color3.fromRGB(165, 175, 195)
    Lighting.ClockTime = 14
    SharpState.ActivePreset = "HD SHARP"
end

function SharpApplyUltraHD10()
    SharpCleanupAll()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
    end)
    Lighting.Brightness = 2.5
    Lighting.Ambient = Color3.fromRGB(140, 148, 168)
    Lighting.OutdoorAmbient = Color3.fromRGB(170, 178, 198)
    Lighting.ClockTime = 14
    SharpState.ActivePreset = "ULTRA HD 10"
end

function SharpReset()
    SharpCleanupAll()
    SharpState.ActivePreset = nil
end

-- ============ FPS BOOST ============
local ScreenEffectTypes = {
    "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect",
    "SunRaysEffect", "BloomEffect"
}
DisabledEffects = {}

function applyNoScreenEffects()
    if S.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in pairs(ScreenEffectTypes) do
                if v:IsA(t) then
                    DisabledEffects[v] = v.Enabled
                    v.Enabled = false
                end
            end
        end
    else
        for obj, state in pairs(DisabledEffects) do
            if obj and obj.Parent then obj.Enabled = state end
        end
        DisabledEffects = {}
    end
end

function applyLowGraphics()
    pcall(function()
        if S.LowGraphics then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end

function applyCleanSky()
    if S.CleanSky then
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
    end
end

print("[4/20] Fungsi Utama + Crosshair 10 Style + Kill Fog + FPS/Ping + Grafik OK")-- =========================================================
-- Section 5 : ESP + Auto Parry ALF v1 (Original)
-- =========================================================

ESPObjects = {}
StatusESP = {}
CachedSCP = {}
Cached = { Generators = {}, Windows = {}, Pallets = {} }
GeneratorColor = Color3.fromRGB(255, 170, 0)
PalletColor = Color3.fromRGB(74, 255, 181)
WindowColor = Color3.fromRGB(74, 255, 181)
SCPColor = Color3.fromRGB(255, 0, 0)

function cacheObject(obj)
    if obj.Name == "Generator" then
        Cached.Generators[obj] = true
    elseif obj.Name == "Window" then
        Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        Cached.Pallets[obj] = true
    end
    local name = string.lower(obj.Name)
    if string.find(name, "scp") then
        CachedSCP[obj] = true
    end
end

function removeCache(obj)
    Cached.Generators[obj] = nil
    Cached.Windows[obj] = nil
    Cached.Pallets[obj] = nil
    CachedSCP[obj] = nil
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do cacheObject(obj) end
workspace.DescendantAdded:Connect(cacheObject)
workspace.DescendantRemoving:Connect(removeCache)

function createESP(obj, color)
    if not obj then return end
    if ESPObjects[obj] then
        if ESPObjects[obj].FillColor ~= color then
            ESPObjects[obj].FillColor = color
            ESPObjects[obj].OutlineColor = color
        end
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj
    ESPObjects[obj] = h
    obj.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if ESPObjects[obj] then
                ESPObjects[obj]:Destroy()
                ESPObjects[obj] = nil
            end
        end
    end)
end

function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

function removeStatusESP(char)
    if StatusESP[char] then
        StatusESP[char]:Destroy()
        StatusESP[char] = nil
    end
end

function createStatusESP(player, char, root)
    if not ESPStatus.Enabled then
        removeStatusESP(char)
        return
    end
    if not root then return end
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local isDown = hum.Health <= 0 or hum.Health < 2
    local dist = (head.Position - root.Position).Magnitude
    if dist > ESPStatus.Radius then
        removeStatusESP(char)
        return
    end

    local text = ""
    if isDown then text = text .. "🔻 DOWN\n" end
    if ESPStatus.ShowName then text = text .. player.Name .. "\n" end
    if ESPStatus.ShowDistance then text = text .. string.format("Dist: %.0f\n", dist) end
    if ESPStatus.ShowHealth then text = text .. string.format("HP: %.0f\n", hum.Health) end
    if text == "" then
        removeStatusESP(char)
        return
    end

    local billboard = StatusESP[char]
    local teamColor = Color3.new(1, 1, 1)
    if player.Team then
        if player.Team.Name == "Killer" then
            teamColor = TeamColors.Killer
        elseif player.Team.Name == "Survivors" then
            teamColor = TeamColors.Survivor
        end
    end
    if isDown then teamColor = Color3.fromRGB(255, 0, 0) end

    local size = S.ESPNameSize or 12

    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 120, 0, 50)
        billboard.AlwaysOnTop = true
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = teamColor
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = size
        label.Text = text
        label.Parent = billboard
        billboard.Adornee = head
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Parent = char
        StatusESP[char] = billboard
    else
        local label = billboard:FindFirstChildOfClass("TextLabel")
        if label then
            if label.Text ~= text then label.Text = text end
            if label.TextColor3 ~= teamColor then label.TextColor3 = teamColor end
            if label.TextSize ~= size then label.TextSize = size end
        end
    end
end

task.spawn(function()
    while task.wait(0.15) do
        if S.ESPNameMode == "Galaxy" then
            for char, billboard in pairs(StatusESP) do
                if not billboard or not billboard.Parent then
                    StatusESP[char] = nil
                    continue
                end
                local label = billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    local grad = label:FindFirstChildOfClass("UIGradient")
                    if not grad then
                        grad = Instance.new("UIGradient")
                        grad.Parent = label
                    end
                    local t = tick()
                    grad.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromHSV((t * 0.5 + 0.33) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.66, Color3.fromHSV((t * 0.5 + 0.66) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                    })
                    grad.Rotation = (t * 120) % 360
                end
            end
        end
    end
end)

-- ============ GENERATOR ESP ============
function GetGameValue(obj, name)
    if not obj then return nil end
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child and child:IsA("ValueBase") then
        local ok, val = pcall(function() return child.Value end)
        if ok then return val end
    end
    return nil
end

function GetGeneratorProgress(gen)
    if not gen then return 0 end
    local names = {"RepairProgress","Progress","Value","RepairValue","ProgressValue","GenProgress","Repaired","Repair","Percent","Percentage","RepairPercent"}
    for _, n in ipairs(names) do
        local v = GetGameValue(gen, n)
        if v ~= nil and type(v) == "number" then return v end
    end
    return 0
end

function ApplyGenHighlight(object, color)
    if not object then return end
    local h = object:FindFirstChild("GenHighlight") or Instance.new("Highlight")
    h.Name = "GenHighlight"
    h.Adornee = object
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = object
end

function UpdateGenerator(generator)
    if not generator or not generator.Parent then return end
    if not ESP.Generator then
        local a = generator:FindFirstChild("GenESP")
        if a then a:Destroy() end
        local b = generator:FindFirstChild("GenESPBar")
        if b then b:Destroy() end
        local h = generator:FindFirstChild("GenHighlight")
        if h then h:Destroy() end
        return
    end
    local percent = GetGeneratorProgress(generator)
    local cp = math.clamp(percent, 0, 100)

    if S.ESPGenMode == "Classic" then
        local oldBar = generator:FindFirstChild("GenESPBar")
        if oldBar then oldBar:Destroy() end
        if percent >= 100 then
            local old = generator:FindFirstChild("GenESP")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end
        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)
        local billboard = generator:FindFirstChild("GenESP")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESP"
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.AlwaysOnTop = true
            local label = Instance.new("TextLabel")
            label.Name = "GenLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = color
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.Parent = billboard
            billboard.Adornee = generator
            billboard.Parent = generator
        else
            local lbl2 = billboard:FindFirstChild("GenLabel")
            if lbl2 then
                lbl2.Text = text
                lbl2.TextColor3 = color
            end
        end
        ApplyGenHighlight(generator, color)

    elseif S.ESPGenMode == "Bar" then
        local oldClassic = generator:FindFirstChild("GenESP")
        if oldClassic then oldClassic:Destroy() end
        if percent >= 100 then
            local old = generator:FindFirstChild("GenESPBar")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end
        local barSize = S.ESPGenBarSize or 64
        local barHeight = S.ESPGenBarHeight or 8
        local textSize = S.ESPGenBarTextSize or 6
        local billboard = generator:FindFirstChild("GenESPBar")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESPBar"
            billboard.Size = UDim2.new(0, barSize, 0, barHeight)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.Adornee = generator
            billboard.Parent = generator

            local barBg = Instance.new("Frame")
            barBg.Name = "BarBg"
            barBg.Size = UDim2.new(1, 0, 1, 0)
            barBg.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
            barBg.BorderSizePixel = 0
            barBg.Parent = billboard
            rnd(barBg, 999)

            local barFill = Instance.new("Frame")
            barFill.Name = "BarFill"
            barFill.Size = UDim2.new(0, 0, 1, 0)
            barFill.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
            barFill.BorderSizePixel = 0
            barFill.Parent = barBg
            rnd(barFill, 999)

            local pctText = Instance.new("TextLabel")
            pctText.Name = "PctText"
            pctText.Size = UDim2.new(1, 0, 1, 0)
            pctText.BackgroundTransparency = 1
            pctText.Text = "0%"
            pctText.TextColor3 = Color3.fromRGB(255, 255, 255)
            pctText.TextSize = textSize
            pctText.Font = Enum.Font.GothamBold
            pctText.TextStrokeTransparency = 0.2
            pctText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            pctText.ZIndex = 10
            pctText.Parent = barBg
        end
        local barBg = billboard:FindFirstChild("BarBg")
        if barBg then
            local barFill = barBg:FindFirstChild("BarFill")
            local pctText = barBg:FindFirstChild("PctText")
            if barFill then barFill.Size = UDim2.new(cp / 100, 0, 1, 0) end
            if pctText then
                pctText.Text = string.format("%.0f%%", percent)
                pctText.TextSize = textSize
            end
        end
        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        ApplyGenHighlight(generator, color)
    end
end

function UpdateMapESP(obj, root)
    if not obj or not root then return end
    local pos
    if obj:IsA("Model") then pos = obj:GetPivot().Position
    elseif obj:IsA("BasePart") then pos = obj.Position end
    if not pos then return end
    local distance = (pos - root.Position).Magnitude
    if obj.Name == "Window" then
        if ESP.Window and distance <= ESP.Distance then createESP(obj, WindowColor)
        else removeESP(obj) end
    end
    if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        if ESP.Pallet and distance <= ESP.Distance then createESP(obj, PalletColor)
        else removeESP(obj) end
    end
end

function UpdateSCPEsp(root)
    if not ESP.SCP then
        for obj in pairs(CachedSCP) do removeESP(obj) end
        return
    end
    for obj in pairs(CachedSCP) do
        if obj and obj.Parent then
            local pos
            if obj:IsA("Model") then pos = obj:GetPivot().Position
            elseif obj:IsA("BasePart") then pos = obj.Position end
            if pos then
                local dist = (pos - root.Position).Magnitude
                if dist <= ESP.Distance then createESP(obj, SCPColor)
                else removeESP(obj) end
            end
        end
    end
end

-- =========================================================
-- AUTO PARRY ALF v1 (ORIGINAL) — menggantikan One W v1
-- =========================================================

-- =========================================================
-- NOTIFY HELPER
-- =========================================================
local function APALF_Notify(title, text, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Auto Parry",
            Text = text or "",
            Duration = dur or 2,
        })
    end)
end

-- =========================================================
-- COOLDOWN MANAGEMENT
-- =========================================================
local function APALF_StartCooldown(d)
    d = math.clamp(tonumber(d) or 0, 0, APALF_Cooldown.MaxCooldown)
    if d <= 0 then d = APALF_Cooldown.FallbackCooldown end
    APALF_Cooldown.OnCooldown = true
    APALF_Cooldown.CooldownEnd = os.clock() + d
    APALF_Cooldown.WaitingForResult = false
    APALF_Cooldown.JustFired = false
    APALF_Cooldown.ManualDetect = false
end

local function APALF_ClearCooldown()
    APALF_Cooldown.OnCooldown = false
    APALF_Cooldown.CooldownEnd = 0
    APALF_Cooldown.WaitingForResult = false
    APALF_Cooldown.JustFired = false
    APALF_Cooldown.ManualDetect = false
end

local function APALF_IsOnCooldown()
    if not APALF_Cooldown.OnCooldown then return false end
    if os.clock() >= APALF_Cooldown.CooldownEnd then
        APALF_ClearCooldown()
        return false
    end
    return true
end

-- REMOTE SETUP
APALF_parryResultRemote = nil
APALF_parryFireRemote = nil

pcall(function()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local items = remotes and remotes:FindFirstChild("Items")
    local dagger = items and items:FindFirstChild("Parrying Dagger")
    if dagger then
        APALF_parryResultRemote = dagger:FindFirstChild("parryResult")
        APALF_parryFireRemote = dagger:FindFirstChild("parry")
    end
end)

if APALF_parryResultRemote then
    APALF_parryResultRemote.OnClientEvent:Connect(function(success, cd)
        if not APALF_Cooldown.WaitingForResult and not APALF_Cooldown.JustFired then return end
        local c = tonumber(cd) or 0
        if success and c > 0 then
            APALF_StartCooldown(math.min(c, APALF_Cooldown.MaxCooldown))
        else
            APALF_StartCooldown(APALF_Cooldown.FallbackCooldown)
        end
    end)
end

-- SILENCED CHECK
local function APALF_HookSilenced(char)
    if not char then return end
    APALF_Cooldown.IsSilenced = CollectionService:HasTag(char, "Silenced")
end

CollectionService:GetInstanceAddedSignal("Silenced"):Connect(function(i)
    if i == LP.Character then APALF_Cooldown.IsSilenced = true end
end)

CollectionService:GetInstanceRemovedSignal("Silenced"):Connect(function(i)
    if i == LP.Character then APALF_Cooldown.IsSilenced = false end
end)

LP.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    APALF_HookSilenced(c)
end)

if LP.Character then APALF_HookSilenced(LP.Character) end

-- CHAR CACHE
local APALF_CharCache = {
    Char = nil, Root = nil, Hum = nil,
    UpperTorso = nil, CheckInt = nil,
}

local function APALF_GetCharCache()
    local char = LP.Character
    if char ~= APALF_CharCache.Char then
        APALF_CharCache.Char = char
        APALF_CharCache.Root = nil
        APALF_CharCache.Hum = nil
        APALF_CharCache.UpperTorso = nil
        APALF_CharCache.CheckInt = nil
    end
    if not char then return APALF_CharCache end
    if not APALF_CharCache.Root then
        APALF_CharCache.Root = char:FindFirstChild("HumanoidRootPart")
    end
    if not APALF_CharCache.Hum then
        APALF_CharCache.Hum = char:FindFirstChildOfClass("Humanoid")
    end
    if not APALF_CharCache.UpperTorso then
        APALF_CharCache.UpperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    end
    if not APALF_CharCache.CheckInt then
        APALF_CharCache.CheckInt = char:FindFirstChild("CheckInterractable")
    end
    return APALF_CharCache
end

-- DAGGER CHECK
local APALF_DaggerCache = { Value = false, LastCheck = 0, Interval = 0.15 }

local function APALF_IsDaggerModel(inst)
    if not inst then return false end
    return inst:IsA("Model") or inst:IsA("Tool") or inst:IsA("Accessory")
end

local function APALF_IsEquippedDagger()
    local now = os.clock()
    if now - APALF_DaggerCache.LastCheck < APALF_DaggerCache.Interval then
        return APALF_DaggerCache.Value
    end
    APALF_DaggerCache.LastCheck = now
    local hasDagger = false
    local char = LP.Character
    if char then
        local d = char:FindFirstChild("Parrying Dagger")
        if APALF_IsDaggerModel(d) then hasDagger = true end
    end
    if not hasDagger then
        local wsChar = workspace:FindFirstChild(LP.Name)
        if wsChar then
            local d = wsChar:FindFirstChild("Parrying Dagger")
            if APALF_IsDaggerModel(d) then hasDagger = true end
        end
    end
    APALF_DaggerCache.Value = hasDagger
    return hasDagger
end

LP.CharacterAdded:Connect(function()
    APALF_DaggerCache.Value = false
    APALF_DaggerCache.LastCheck = 0
end)

-- BUSY CHECK
local APALF_CheckAttrs = {
    "isVaulting", "isSliding", "isDroppingPallet",
    "isRepairing", "isHealing", "isUnhooking", "isExiting"
}

local function APALF_IsBusy()
    local cc = APALF_GetCharCache()
    if not cc.Char then return true end
    if LP:GetAttribute("IsDead") then return true end
    if cc.Char:GetAttribute("IsCarried") then return true end
    if cc.Char:GetAttribute("IsHooked") then return true end
    if cc.Root and CollectionService:HasTag(cc.Root, "doing action") then return true end
    if cc.CheckInt then
        for i = 1, #APALF_CheckAttrs do
            if cc.CheckInt:GetAttribute(APALF_CheckAttrs[i]) then return true end
        end
    end
    return false
end

local function APALF_IsLowHealth()
    local hum = APALF_GetCharCache().Hum
    if not hum then return false end
    return hum.Health < hum.MaxHealth * 0.5
end

local function APALF_CanFire()
    if not APALF_IsEquippedDagger() then return false end
    if APALF_Cooldown.IsSilenced then return false end
    if APALF_IsOnCooldown() then return false end
    if APALF_Cooldown.WaitingForResult then return false end
    if APALF_IsBusy() then return false end
    if APALF_IsLowHealth() then return false end
    return true
end

-- EXECUTE PARRY
local function APALF_ExecuteMobile()
    local didFire = false
    local pGui = LP:FindFirstChildOfClass("PlayerGui")
    if pGui and type(firesignal) == "function" then
        local mobRoot = pGui:FindFirstChild("Survivor-mob")
        local controls = mobRoot and mobRoot:FindFirstChild("Controls")
        if controls then
            for _, n in ipairs({"Gui-mob", "action", "Gui-mobile", "Gui_mob", "Parry", "parry"}) do
                local btn = controls:FindFirstChild(n)
                if btn and btn:IsA("GuiButton") then
                    pcall(function()
                        firesignal(btn.MouseButton1Down)
                        task.delay(0.05, function()
                            if btn and btn.Parent then
                                firesignal(btn.MouseButton1Up)
                                firesignal(btn.MouseButton1Click)
                            end
                        end)
                    end)
                    didFire = true
                    break
                end
            end
        end
    end
    if not didFire then
        local remote = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remote and remote:FindFirstChild("Items")
        local dagger = items and items:FindFirstChild("Parrying Dagger")
        local parry = dagger and dagger:FindFirstChild("parry")
        if parry then pcall(function() parry:FireServer() end) end
    end
end

local function APALF_ExecutePC()
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendMouseMoveEvent(0, 0, game)
        task.wait(0.005)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 2, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 2, false, game, 0)
    end)
end

local function APALF_ExecuteSilent()
    if APALF_parryFireRemote then
        return pcall(function() APALF_parryFireRemote:FireServer() end)
    end
    return false
end

local function APALF_ExecuteParry()
    if not APALF_CanFire() then return end
    APALF_State.LastParry = os.clock()
    APALF_Cooldown.LastFiredAt = os.clock()
    APALF_Cooldown.WaitingForResult = true
    APALF_Cooldown.WaitingStart = os.clock()
    APALF_Cooldown.JustFired = true
    APALF_Cooldown.ManualDetect = false

    if ALF.PARRY_SilentParry then
        APALF_ExecuteSilent()
        return
    end

    if UIS.TouchEnabled then
        APALF_ExecuteMobile()
    else
        APALF_ExecutePC()
    end
end

-- MANUAL DETECTION
local function APALF_MarkManual()
    if not APALF_IsEquippedDagger() then return end
    if APALF_Cooldown.IsSilenced then return end
    if os.clock() - APALF_Cooldown.LastFiredAt < APALF_Cooldown.ManualIgnoreWindow then return end
    if APALF_Cooldown.OnCooldown or APALF_Cooldown.WaitingForResult then return end
    APALF_Cooldown.WaitingForResult = true
    APALF_Cooldown.WaitingStart = os.clock()
    APALF_Cooldown.JustFired = true
    APALF_Cooldown.ManualDetect = true
    APALF_Cooldown.LastFiredAt = os.clock()
end

UIS.InputBegan:Connect(function(input, gp)
    if input.UserInputType ~= Enum.UserInputType.MouseButton2 then return end
    if gp then return end
    APALF_MarkManual()
end)

-- HOOK MOBILE BUTTONS
local APALF_HookedButtons = setmetatable({}, {__mode = "k"})

local function APALF_TryHookMobileButton(inst)
    if not inst or not inst:IsA("GuiButton") then return end
    if APALF_HookedButtons[inst] then return end
    local nm = inst.Name
    if nm ~= "Gui-mob" and nm ~= "action" and nm ~= "Gui-mobile"
        and nm ~= "Gui_mob" and nm ~= "Parry" and nm ~= "parry" then return end
    APALF_HookedButtons[inst] = true
    inst.MouseButton1Down:Connect(APALF_MarkManual)
end

local function APALF_ScanForMobileButtons(root)
    if not root then return end
    for _, d in ipairs(root:GetDescendants()) do
        APALF_TryHookMobileButton(d)
    end
end

local function APALF_AttachPlayerGui(pGui)
    if not pGui then return end
    APALF_ScanForMobileButtons(pGui)
    pGui.DescendantAdded:Connect(APALF_TryHookMobileButton)
end

local existingPGui = LP:FindFirstChildOfClass("PlayerGui")
if existingPGui then APALF_AttachPlayerGui(existingPGui) end

LP.ChildAdded:Connect(function(c)
    if c:IsA("PlayerGui") then APALF_AttachPlayerGui(c) end
end)

-- GET HITBOX PART
local function APALF_GetHitboxPart(char)
    if not char then return nil end
    return char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("HumanoidRootPart")
end

-- CHECK & PARRY
local function APALF_CheckAndParry(killerChar)
    if APALF_IsOnCooldown() or APALF_Cooldown.WaitingForResult
        or APALF_Cooldown.IsSilenced or not APALF_IsEquippedDagger() then return end
    
    local cc = APALF_GetCharCache()
    local myRoot = cc.UpperTorso or cc.Root
    local killerPart = APALF_GetHitboxPart(killerChar)
    if not myRoot or not killerPart then return end
    
    local dist = (myRoot.Position - killerPart.Position).Magnitude
    
    if ALF.PARRY_Aggressive then
        local ping = math.clamp(LP:GetNetworkPing(), 0, 0.3)
        local killerRoot = killerChar:FindFirstChild("HumanoidRootPart") or killerPart
        local killerVel = killerRoot.AssemblyLinearVelocity
        local flatVel = Vector3.new(killerVel.X, 0, killerVel.Z)
        local predictedPos = killerPart.Position + flatVel * ping
        local predDist = (myRoot.Position - predictedPos).Magnitude
        if predDist <= ((ALF.PARRY_Distance or 10) + 2.5) then
            if flatVel.Magnitude > 6 then
                local dir = myRoot.Position - killerPart.Position
                if dir.Magnitude > 0 and flatVel.Unit:Dot(dir.Unit) > 0.4 then
                    APALF_ExecuteParry()
                    return
                end
            end
        end
    end
    
    if dist <= (ALF.PARRY_Distance or 10) then
        APALF_ExecuteParry()
    end
end

-- CIRCLE VISUAL
local function APALF_DestroyCircle()
    if APALF_State.CircleFolder then
        pcall(function()
            if APALF_State.CircleFolder.Parent then
                APALF_State.CircleFolder:Destroy()
            end
        end)
    end
    APALF_State.CircleFolder = nil
    APALF_State.CircleDashes = {}
    APALF_State.CircleRotCFs = {}
    APALF_State.CircleOffsets = {}
    APALF_State.CircleRadius = 0
    APALF_State.CircleBuiltForDagger = false
    APALF_State.CircleLastX = math.huge
    APALF_State.CircleLastY = math.huge
    APALF_State.CircleLastZ = math.huge
    APALF_State.CircleSpawnTime = 0
end

_G.Roooor_APALF_DestroyCircle = APALF_DestroyCircle

local function APALF_BuildCircle(radius)
    APALF_DestroyCircle()
    local folder = Instance.new("Folder")
    folder.Name = "APALF_ParryCircleDashes"
    
    local dashCount = math.clamp(math.floor(radius * 6), 24, 120)
    local slotLength = (2 * math.pi * radius) / dashCount
    local dashLength = slotLength * 0.55
    local dashThickness = 0.03
    
    local dashes = table.create(dashCount)
    local rotCFs = table.create(dashCount)
    local offsets = table.create(dashCount)
    
    for i = 1, dashCount do
        local part = Instance.new("Part")
        part.Name = "Dash" .. i
        part.Anchored = true
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.CastShadow = false
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(255, 255, 255)
        part.Transparency = 1
        part.Size = Vector3.new(dashThickness, dashThickness, dashLength)
        part.Parent = folder
        
        local angle = ((i - 1) / dashCount) * math.pi * 2
        local cosA, sinA = math.cos(angle), math.sin(angle)
        rotCFs[i] = CFrame.lookAt(Vector3.zero, Vector3.new(-sinA, 0, cosA))
        offsets[i] = Vector3.new(cosA * radius, 0, sinA * radius)
        dashes[i] = part
    end
    
    folder.Parent = workspace
    APALF_State.CircleFolder = folder
    APALF_State.CircleDashes = dashes
    APALF_State.CircleRotCFs = rotCFs
    APALF_State.CircleOffsets = offsets
    APALF_State.CircleRadius = radius
    APALF_State.CircleBuiltForDagger = true
    APALF_State.CircleSpawnTime = tick()
end

local function APALF_UpdateCircle(myRoot)
    if not APALF_State.CircleFolder or not APALF_State.CircleFolder.Parent then return end
    local dashes = APALF_State.CircleDashes
    local dashCount = #dashes
    if dashCount == 0 then return end
    
    local center = myRoot.Position - Vector3.new(0, (myRoot.Size.Y * 0.5) + 1.0, 0)
    local elapsed = tick() - (APALF_State.CircleSpawnTime or 0)
    local spawnT = math.clamp(elapsed / (APALF_State.CircleSpawnDuration or 0.55), 0, 1)
    local eased = 1 - (1 - spawnT)^3
    local scaleMult = eased
    
    if spawnT < 0.7 and spawnT > 0 then
        local bt = spawnT / 0.7
        scaleMult = eased + math.sin(bt * math.pi) * 0.1
    end
    
    local spinRot = (1 - eased) * math.pi * 2
    local spawnAlpha = 1 - eased
    
    local busy = APALF_IsBusy()
    local onCD = APALF_Cooldown.OnCooldown
    local tc
    if busy then
        tc = Color3.fromRGB(255, 20, 20)
    elseif onCD then
        tc = Color3.fromRGB(255, 140, 0)
    else
        tc = Color3.fromRGB(255, 255, 255)
    end
    
    local targetT = 0
    if onCD then
        local period = 0.55
        local phase = (os.clock() % period) / period
        local pulse = (math.cos(phase * math.pi * 2) + 1) * 0.5
        targetT = (1 - pulse) * 0.85
    end
    local finalT = math.max(targetT, spawnAlpha)
    
    local dx = math.abs(center.X - APALF_State.CircleLastX)
    local dy = math.abs(center.Y - APALF_State.CircleLastY)
    local dz = math.abs(center.Z - APALF_State.CircleLastZ)
    if dx < 0.01 and dy < 0.01 and dz < 0.01 and spawnT >= 1 then return end
    
    APALF_State.CircleLastX = center.X
    APALF_State.CircleLastY = center.Y
    APALF_State.CircleLastZ = center.Z
    
    local rotCFs = APALF_State.CircleRotCFs
    local offsets = APALF_State.CircleOffsets
    local rotCF = CFrame.Angles(0, spinRot, 0)
    
    for i = 1, dashCount do
        local dash = dashes[i]
        if dash and dash.Parent then
            local scaledOff = offsets[i] * scaleMult
            local rotatedOff = rotCF:VectorToWorldSpace(scaledOff)
            local worldPos = Vector3.new(center.X + rotatedOff.X, center.Y, center.Z + rotatedOff.Z)
            dash.CFrame = (rotCF * rotCFs[i]) + worldPos
            dash.Color = tc
            dash.Transparency = finalT
        end
    end
end

-- ANIM TYPE
local function APALF_GetAnimType(track)
    if not track or not track.Animation then return nil end
    local animId = track.Animation.AnimationId or ""
    local numId = animId:match("%d+") or ""
    local name = string.lower(track.Animation.Name or "")
    
    local v = APALF_KillerAttackAnims[animId]
    if v then return v end
    if numId ~= "" then
        v = APALF_KillerAttackAnims[numId]
        if v then return v end
    end
    
    if string.find(name, "lunge", 1, true) or string.find(name, "charge", 1, true) then
        return "lungehold"
    end
    if string.find(name, "attack", 1, true) or string.find(name, "slash", 1, true)
        or string.find(name, "swing", 1, true) or string.find(name, "stab", 1, true)
        or string.find(name, "melee", 1, true) then
        return "attack"
    end
    return nil
end

-- HOOK ANIMATOR
local function APALF_HookAnimatorOnChar(plr, char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
    if not anim then return end
    anim.AnimationPlayed:Connect(function(track)
        if not ALF.PARRY_Enabled then return end
        if not APALF_IsEquippedDagger() then return end
        local at = APALF_GetAnimType(track)
        if at then
            APALF_State.ActiveAttackers[plr] = {
                char = char, track = track, type = at, registeredAt = os.clock()
            }
        end
    end)
end

local function APALF_HookKillerPlayer(plr)
    if plr == LP then return end
    if plr.Character then APALF_HookAnimatorOnChar(plr, plr.Character) end
    plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        APALF_HookAnimatorOnChar(plr, char)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do APALF_HookKillerPlayer(p) end
Players.PlayerAdded:Connect(APALF_HookKillerPlayer)

-- POLL ATTACKS
local parryLastPoll = 0
local function APALF_PollAttacks()
    if not ALF.PARRY_Enabled or not APALF_IsEquippedDagger() then return end
    local now = os.clock()
    if now - parryLastPoll < 0.15 then return end
    parryLastPoll = now
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                        local at = APALF_GetAnimType(track)
                        if at then
                            local ex = APALF_State.ActiveAttackers[plr]
                            if not ex or ex.track ~= track then
                                APALF_State.ActiveAttackers[plr] = {
                                    char = char, track = track, type = at, registeredAt = now
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end

-- CLEANUP
local parryLastCleanup = 0
local function APALF_CleanupAttackers()
    local now = os.clock()
    if now - parryLastCleanup < 1.0 then return end
    parryLastCleanup = now
    for plr, data in pairs(APALF_State.ActiveAttackers) do
        if not plr or not plr.Parent or not data.track or not data.track.IsPlaying then
            APALF_State.ActiveAttackers[plr] = nil
        end
    end
end

-- MAIN LOGIC
local function APALF_UpdateLogic()
    if not ALF.PARRY_Enabled then return end
    if not APALF_IsEquippedDagger() then
        APALF_State.ActiveAttackers = {}
        return
    end
    if APALF_Cooldown.WaitingForResult then
        if os.clock() - APALF_Cooldown.WaitingStart > APALF_Cooldown.WaitTimeout then
            if APALF_Cooldown.ManualDetect then
                APALF_Cooldown.WaitingForResult = false
                APALF_Cooldown.JustFired = false
                APALF_Cooldown.ManualDetect = false
            else
                APALF_StartCooldown(APALF_Cooldown.FallbackCooldown)
            end
        end
    end
    if APALF_IsOnCooldown() or APALF_Cooldown.WaitingForResult then return end
    APALF_PollAttacks()
    APALF_CleanupAttackers()
    for plr, data in pairs(APALF_State.ActiveAttackers) do
        if plr and plr.Parent and data.track and data.track.IsPlaying then
            local shouldCheck = false
            if data.type == "attack" then
                if data.track.TimePosition < 0.35 then shouldCheck = true end
            elseif data.type == "lungehold" then
                shouldCheck = true
            end
            if shouldCheck then
                APALF_CheckAndParry(data.char)
                if APALF_Cooldown.WaitingForResult then break end
            end
        end
    end
end

-- CIRCLE LOGIC
local function APALF_UpdateCircleLogic()
    local char = LP.Character
    local myRoot = char and char:FindFirstChild("HumanoidRootPart")
    if ALF.PARRY_ShowCircle and ALF.PARRY_Enabled and APALF_IsEquippedDagger() and myRoot then
        if not APALF_State.CircleFolder
            or APALF_State.CircleRadius ~= (ALF.PARRY_Distance or 10)
            or not APALF_State.CircleFolder.Parent then
            APALF_BuildCircle(ALF.PARRY_Distance or 10)
        end
        APALF_UpdateCircle(myRoot)
    else
        if APALF_State.CircleFolder then APALF_DestroyCircle() end
    end
end

-- LOOP
RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - (APALF_LastLogicUpdate or 0) >= 0.05 then
        APALF_LastLogicUpdate = now
        pcall(APALF_UpdateLogic)
    end
    if now - (APALF_LastCircleUpdate or 0) >= 0.033 then
        APALF_LastCircleUpdate = now
        pcall(APALF_UpdateCircleLogic)
    end
end)

print("[5/20] ESP + Auto Parry ALF v1 (Original) OK")-- =========================================================
-- Section 6 : Aimbot + Fast Vault + Wisnu Auto Parry v2
-- =========================================================

-- =========================================================
-- AIMBOT SENTER (dari One W)
-- =========================================================
AimbotLaserGui = nil
AimbotLaserLines = {}

local function CreateLaserGui()
    if AimbotLaserGui then AimbotLaserGui:Destroy() end
    AimbotLaserGui = Instance.new("ScreenGui")
    AimbotLaserGui.Name = "OneWAimbotLaser"
    AimbotLaserGui.ResetOnSpawn = false
    AimbotLaserGui.IgnoreGuiInset = true
    AimbotLaserGui.Parent = PG
end
CreateLaserGui()

AimbotSenter = _G.Roooor_AimbotSenter or {
    Enabled = false, LockPart = "Head",
    ShowLaser = true, LaserColor = Color3.fromRGB(255, 210, 80),
    CurrentTarget = nil, HoldingSenter = false,
}
_G.Roooor_AimbotSenter = AimbotSenter

function AimbotSenter_IsKiller(p)
    if not p or not p.Character then return false end
    if p.Team and p.Team.Name == "Killer" then return true end
    local n = string.lower(p.Character.Name)
    local d = string.lower(p.DisplayName or "")
    for _, tag in ipairs({"killer","hidden","abyss","walker","masked","jacket","617","slasher","hunter"}) do
        if n:find(tag) or d:find(tag) then return true end
    end
    return false
end

function GetGunAimButton()
    local current = PG
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

AimbotSenter.CurrentGunButton = nil
AimbotSenter.GunConns = {}

task.spawn(function()
    while task.wait(1) do
        if not AimbotSenter.Enabled then
            AimbotSenter.CurrentGunButton = nil
            for _, conn in ipairs(AimbotSenter.GunConns) do
                pcall(function() conn:Disconnect() end)
            end
            AimbotSenter.GunConns = {}
            continue
        end
        local btn = GetGunAimButton()
        if not btn then continue end
        if btn ~= AimbotSenter.CurrentGunButton then
            AimbotSenter.CurrentGunButton = btn
            for _, conn in ipairs(AimbotSenter.GunConns) do
                pcall(function() conn:Disconnect() end)
            end
            AimbotSenter.GunConns = {}

            local c1 = btn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                or input.UserInputType == Enum.UserInputType.MouseButton2
                or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    AimbotSenter.HoldingSenter = true
                end
            end)
            local c2 = btn.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                or input.UserInputType == Enum.UserInputType.MouseButton2
                or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    AimbotSenter.HoldingSenter = false
                    AimbotSenter.CurrentTarget = nil
                end
            end)
            table.insert(AimbotSenter.GunConns, c1)
            table.insert(AimbotSenter.GunConns, c2)
        end
    end
end)

function GetClosestKillerTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local closest = nil
    local shortest = 999999
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and AimbotSenter_IsKiller(p) then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            
            if head and hum and hum.Health > 0 then
                local pos, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = head
                    end
                end
            end
        end
    end
    return closest
end

task.spawn(function()
    while task.wait() do
        if not AimbotSenter.Enabled then
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end
        if not AimbotSenter.HoldingSenter then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end
        local target = GetClosestKillerTarget()
        if not target then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end
        AimbotSenter.CurrentTarget = target
        
        local cam = workspace.CurrentCamera
        if cam then
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
        end
        
        if AimbotSenter.ShowLaser then
            local cam2 = workspace.CurrentCamera
            local screenPoint, onScreen = cam2:WorldToViewportPoint(target.Position)
            if onScreen then
                if AimbotLaserGui then
                    for _, line in pairs(AimbotLaserLines) do
                        if line then line:Remove() end
                    end
                    AimbotLaserLines = {}
                end
                local ok, line = pcall(function() return Drawing.new("Line") end)
                if ok and line then
                    line.Visible = true
                    line.From = Vector2.new(cam2.ViewportSize.X / 2, cam2.ViewportSize.Y / 2)
                    line.To = Vector2.new(screenPoint.X, screenPoint.Y)
                    line.Color = AimbotSenter.LaserColor or Color3.fromRGB(120, 200, 255)
                    line.Thickness = 2
                    line.Transparency = 0.5
                    table.insert(AimbotLaserLines, line)
                end
            end
        end
    end
end)

-- =========================================================
-- AIMBOT KILLER (AIMLOCK) (dari One W)
-- =========================================================
Aimlock = _G.Roooor_Aimlock or {
    Enabled = false, Radius = 80, TargetTeam = "Survivors",
    AimPart = "HumanoidRootPart", Holding = false, CurrentTarget = nil,
}
_G.Roooor_Aimlock = Aimlock

Aimlock_AttackButtons = Aimlock_AttackButtons or {}

local function isAttackButton(obj)
    if not obj:IsA("GuiObject") then return false end
    local n = string.lower(obj.Name)
    if n:find("attack") or n:find("slash") or n:find("swing") or n:find("hit") then
        return true
    end
    return false
end

function Aimlock_ScanAttackButtons()
    table.clear(Aimlock_AttackButtons)
    for _, obj in pairs(PG:GetDescendants()) do
        if isAttackButton(obj) and obj.Visible then
            table.insert(Aimlock_AttackButtons, obj)
        end
    end
end

function Aimlock_HookAttackButtons()
    Aimlock_ScanAttackButtons()
    for _, btnObj in ipairs(Aimlock_AttackButtons) do
        if not btnObj:GetAttribute("AimlockHooked") then
            btnObj:SetAttribute("AimlockHooked", true)
            btnObj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = true
                end
            end)
            btnObj.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = false
                end
            end)
        end
    end
end

task.spawn(function()
    while task.wait(5) do
        if Aimlock.Enabled then
            Aimlock_HookAttackButtons()
        end
    end
end)

function Aimlock_GetClosestSurvivor()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local closest = nil
    local shortest = Aimlock.Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local isTarget = false
            if p.Team and p.Team.Name == Aimlock.TargetTeam then
                isTarget = true
            end
            if isTarget then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(Aimlock.AimPart)
                local isDowned = false
                if hum then
                    isDowned = hum.Health <= 0
                        or hum.Health < 2
                        or p.Character:GetAttribute("Downed") == true
                        or p.Character:GetAttribute("IsDown") == true
                        or p.Character:GetAttribute("Knocked") == true
                end
                if not isDowned and hum and hum.Health > 0 and targetPart then
                    local dist = (targetPart.Position - myRoot.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = targetPart
                    end
                end
            end
        end
    end
    return closest
end

Aimlock_CameraConn = nil

function Aimlock_StartLoop()
    if Aimlock_CameraConn then return end
    Aimlock_CameraConn = RunService.RenderStepped:Connect(function()
        if not Aimlock.Enabled then return end
        if not Aimlock.Holding then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local target = Aimlock_GetClosestSurvivor()
        if not target then return end
        Aimlock.CurrentTarget = target
        local camPos = cam.CFrame.Position
        local targetPos = target.Position
        cam.CFrame = CFrame.new(camPos, targetPos)
    end)
end

function Aimlock_StopLoop()
    if Aimlock_CameraConn then
        Aimlock_CameraConn:Disconnect()
        Aimlock_CameraConn = nil
    end
    Aimlock.CurrentTarget = nil
end

-- =========================================================
-- FAST VAULT (dari One W)
-- =========================================================
FastVaultTracks = {}

local function normalizeId(id)
    local num = tostring(id):match("%d+")
    return num and ("rbxassetid://" .. num)
end

function hookVault(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        if not FastVault.Enabled then return end
        local anim = track.Animation
        if not anim or not anim.AnimationId then return end
        local id = normalizeId(anim.AnimationId)
        if not id then return end
        local replaceId = FastVault.ReplaceMap[id]
        if not replaceId then return end
        if FastVaultTracks[track] then return end
        FastVaultTracks[track] = true

        track:Stop()

        local newAnim = Instance.new("Animation")
        newAnim.AnimationId = replaceId
        local newTrack = animator:LoadAnimation(newAnim)
        newTrack.Priority = Enum.AnimationPriority.Action
        newTrack:Play()
        newTrack:AdjustSpeed(FastVault.Speed or 1.2)

        newTrack.Stopped:Connect(function()
            FastVaultTracks[track] = nil
        end)
    end)
end

LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if FastVault.Enabled then
        pcall(function() hookVault(char) end)
    end
end)

if LP.Character and FastVault.Enabled then
    pcall(function() hookVault(LP.Character) end)
end

-- =========================================================
-- WISNU AUTO PARRY v2 (dari ALF)
-- =========================================================

-- =========================================================
-- HELPER: IS KILLER
-- =========================================================
local function Wisnu_IsKiller(p)
    return p and p.Team and p.Team.Name == "Killer"
end

local function Wisnu_IsDowned(char)
    return char and (char:GetAttribute("Knocked") == true or char:GetAttribute("IsHooked") == true)
end

local function Wisnu_IsSafeToParry(char)
    if not ALF.Wisnu_ParrySafety then return true end
    if not char then return false end
    local interactObj = char:FindFirstChild("CheckInterractable")
    if interactObj then
        if interactObj:GetAttribute("isVaulting") == true then return false end
        if interactObj:GetAttribute("isRepairing") == true then return false end
        if interactObj:GetAttribute("isUnhooking") == true then return false end
        if interactObj:GetAttribute("isHealing") == true then return false end
        if interactObj:GetAttribute("isSliding") == true then return false end
    end
    return true
end

-- =========================================================
-- WISNU PRESS RIGHT CLICK / MOBILE
-- =========================================================
local function Wisnu_PressRightClick()
    if not VirtualInputManager then return end
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
        task.wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
    end)
end

local function Wisnu_TapMobileParryButton()
    local playerGui = LP:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local survivorMob = playerGui:FindFirstChild("Survivor-mob")
    local parryBtn = survivorMob and survivorMob:FindFirstChild("Controls") and survivorMob.Controls:FindFirstChild("Gui-mob")
    if parryBtn and parryBtn.Visible then
        if firesignal then
            pcall(function()
                firesignal(parryBtn.MouseButton1Down)
                task.wait(0.01)
                firesignal(parryBtn.MouseButton1Up)
            end)
        end
    else
        Wisnu_PressRightClick()
    end
end

-- =========================================================
-- WISNU EXECUTE PARRY
-- =========================================================
local function Wisnu_ExecuteParry()
    if Wisnu_State.Cooldown then return end
    Wisnu_State.lastParry = tick()
    pcall(function()
        local parryRemote = ReplicatedStorage:FindFirstChild("Remotes")
            :FindFirstChild("Items")
            :FindFirstChild("Parrying Dagger")
            :FindFirstChild("parry")
        if parryRemote then
            for i = 1, 10 do parryRemote:FireServer() end
        end
        task.spawn(Wisnu_TapMobileParryButton)
    end)
end

-- =========================================================
-- WISNU COOLDOWN HOOK
-- =========================================================
task.spawn(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    local dagger = remotes and remotes:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
    local parryResultRemote = dagger and dagger:WaitForChild("parryResult", 5)
    if parryResultRemote then
        parryResultRemote.OnClientEvent:Connect(function(arg1, arg2)
            local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
            Wisnu_State.Cooldown = true
            if Wisnu_State.CooldownThread then task.cancel(Wisnu_State.CooldownThread) end
            Wisnu_State.CooldownThread = task.delay(cdDur, function()
                Wisnu_State.Cooldown = false
            end)
        end)
    end
end)

-- =========================================================
-- WISNU ATTACH PARRY SENSOR
-- =========================================================
local function Wisnu_AttachParrySensor(kChar)
    if not kChar or Wisnu_Attached[kChar] then return end
    Wisnu_Attached[kChar] = true
    local humanoid = kChar:FindFirstChild("Humanoid")
    if not humanoid then
        humanoid = kChar:WaitForChild("Humanoid", 5)
        if not humanoid then return end
    end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = humanoid:WaitForChild("Animator", 5)
        if not animator then return end
    end

    humanoid.ChildAdded:Connect(function(child)
        if child:IsA("Animator") then
            Wisnu_Attached[kChar] = nil
            Wisnu_AttachParrySensor(kChar)
        end
    end)
    kChar.AncestryChanged:Connect(function(_, parent)
        if not parent then Wisnu_Attached[kChar] = nil end
    end)

    animator.AnimationPlayed:Connect(function(track)
        local animId = track.Animation and track.Animation.AnimationId or ""
        local id = animId:match("%d+")
        local attackName = Wisnu_ValidParryIDs[id]
        if not attackName then return end

        if id == "80411309607666" and ALF.AutoCrouch then
            local myChar = LP.Character
            if Wisnu_IsDowned(myChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                if (myHRP.Position - kHRP.Position).Magnitude <= 40 then
                    -- TriggerCrouch akan dipanggil dari Section 17 (Survivor+)
                    if _G.Roooor_ALF_TriggerCrouch then
                        pcall(_G.Roooor_ALF_TriggerCrouch)
                    end
                end
            end
            return
        end

        if not ALF.Wisnu_AutoParry then return end
        if Wisnu_State.Cooldown then return end
        if ALF.Wisnu_IgnoredSkills and ALF.Wisnu_IgnoredSkills[attackName] then return end

        local myChar = LP.Character
        if Wisnu_IsDowned(myChar) or not Wisnu_IsSafeToParry(myChar) then return end
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local kHRP = kChar:FindFirstChild("HumanoidRootPart")
        if not myHRP or not kHRP then return end

        local startDistance = (myHRP.Position - kHRP.Position).Magnitude

        if ALF.Wisnu_ParryAggressive then
            local aggressiveRadius = 12
            local detectionRadius = ALF.Wisnu_ParryDistance + 5
            if startDistance > detectionRadius then return end
            if startDistance <= aggressiveRadius then
                Wisnu_ExecuteParry()
            else
                local tracker
                local startTime = os.clock()
                tracker = RunService.Heartbeat:Connect(function()
                    if os.clock() - startTime >= 1.5 or Wisnu_State.Cooldown
                        or not myHRP or not kHRP or Wisnu_IsDowned(myChar) then
                        if tracker then tracker:Disconnect() end
                        return
                    end
                    if (myHRP.Position - kHRP.Position).Magnitude <= aggressiveRadius then
                        Wisnu_ExecuteParry()
                        if tracker then tracker:Disconnect() end
                    end
                end)
            end
        else
            if startDistance > ALF.Wisnu_ParryDistance then return end
            local myPosFlat = Vector3.new(myHRP.Position.X, 0, myHRP.Position.Z)
            local kPosFlat = Vector3.new(kHRP.Position.X, 0, kHRP.Position.Z)
            local flatDelta = myPosFlat - kPosFlat
            if flatDelta.Magnitude > 0 then
                local flatDirection = flatDelta.Unit
                local kLookFlat = Vector3.new(kHRP.CFrame.LookVector.X, 0, kHRP.CFrame.LookVector.Z).Unit
                if kLookFlat:Dot(flatDirection) < ALF.Wisnu_ParryFace then return end
            end
            Wisnu_ExecuteParry()
        end
    end)
end

-- =========================================================
-- WISNU TRY ATTACH
-- =========================================================
local function Wisnu_TryAttach(p)
    if p ~= LP and Wisnu_IsKiller(p) and p.Character then
        Wisnu_AttachParrySensor(p.Character)
    end
end

local function Wisnu_SetupPlayer(p)
    if p == LP then return end
    p.CharacterAdded:Connect(function() Wisnu_TryAttach(p) end)
    p:GetPropertyChangedSignal("Team"):Connect(function() Wisnu_TryAttach(p) end)
    if p.Character then Wisnu_TryAttach(p) end
end

for _, p in pairs(Players:GetPlayers()) do Wisnu_SetupPlayer(p) end
Players.PlayerAdded:Connect(Wisnu_SetupPlayer)

task.spawn(function()
    while true do
        task.wait(5)
        for _, p in pairs(Players:GetPlayers()) do Wisnu_TryAttach(p) end
    end
end)

-- =========================================================
-- WISNU CIRCLE VISUAL (CylinderHandleAdornment)
-- =========================================================
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if ALF.Wisnu_ParryCircle and ALF.Wisnu_AutoParry and hrp then
        if not Wisnu_State.Adornment or Wisnu_State.Adornment.Parent ~= hrp then
            if Wisnu_State.Adornment then Wisnu_State.Adornment:Destroy() end
            Wisnu_State.Adornment = Instance.new("CylinderHandleAdornment")
            Wisnu_State.Adornment.Name = "WisnuAutoParryCircleESP"
            Wisnu_State.Adornment.Height = 0.05
            Wisnu_State.Adornment.Transparency = 0.3
            Wisnu_State.Adornment.Adornee = hrp
            Wisnu_State.Adornment.Parent = hrp
            Wisnu_State.Adornment.ZIndex = 0
            Wisnu_State.Adornment.AlwaysOnTop = false
        end
        local cR = ALF.Wisnu_ParryDistance
        Wisnu_State.Adornment.Radius = cR
        Wisnu_State.Adornment.InnerRadius = math.max(0.1, cR - 0.15)
        Wisnu_State.Adornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)
        if Wisnu_State.Cooldown then
            Wisnu_State.Adornment.Color3 = Color3.fromRGB(128, 128, 128)
        else
            Wisnu_State.Adornment.Color3 = Color3.fromRGB(255, 255, 255)
        end
    elseif Wisnu_State.Adornment then
        Wisnu_State.Adornment:Destroy()
        Wisnu_State.Adornment = nil
    end
end)

print("[6/20] Aimbot + Fast Vault + Wisnu Auto Parry v2 OK")-- =========================================================
-- Section 7 : GUI Utama + Tombol W + Panel + Tab Bar
-- =========================================================

gui = Instance.new("ScreenGui")
gui.Name = "OneWHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 99999

local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not ok then gui.Parent = PG end

_G.Roooor_Gui = gui

btnContainer = Instance.new("ImageButton")
btnContainer.Size = UDim2.fromOffset(56, 56)
btnContainer.Position = UDim2.fromOffset(20, 120)
btnContainer.BackgroundColor3 = C.PANEL
btnContainer.Image = IMAGE_ID
btnContainer.ImageTransparency = 0.05
btnContainer.BorderSizePixel = 0
btnContainer.AutoButtonColor = false
btnContainer.Active = true
btnContainer.ZIndex = 10
btnContainer.Parent = gui
rnd(btnContainer, 999)

local ring1 = Instance.new("Frame")
ring1.Size = UDim2.new(1, 8, 1, 8)
ring1.Position = UDim2.new(0, -4, 0, -4)
ring1.BackgroundTransparency = 1
ring1.ZIndex = -1
ring1.Parent = btnContainer
rnd(ring1, 999)

local ring1Stroke = Instance.new("UIStroke")
ring1Stroke.Thickness = 2.5
ring1Stroke.Color = C.CYAN
ring1Stroke.Transparency = 0.1
ring1Stroke.Parent = ring1

local ring1Grad = Instance.new("UIGradient")
ring1Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.CYAN),
    ColorSequenceKeypoint.new(0.5, DIAMOND_LIGHT),
    ColorSequenceKeypoint.new(1, DIAMOND_DARK),
})
ring1Grad.Parent = ring1Stroke

local ring2 = Instance.new("Frame")
ring2.Size = UDim2.new(1, 4, 1, 4)
ring2.Position = UDim2.new(0, -2, 0, -2)
ring2.BackgroundTransparency = 1
ring2.ZIndex = -1
ring2.Parent = btnContainer
rnd(ring2, 999)

local ring2Stroke = Instance.new("UIStroke")
ring2Stroke.Thickness = 1.5
ring2Stroke.Color = DIAMOND_LIGHT
ring2Stroke.Transparency = 0.4
ring2Stroke.Parent = ring2

local tGlow = Instance.new("UIStroke")
tGlow.Color = C.CYAN
tGlow.Thickness = 8
tGlow.Transparency = 0.7
tGlow.Parent = btnContainer

local tStroke = Instance.new("UIStroke")
tStroke.Thickness = 2
tStroke.Color = DIAMOND_BLUE
tStroke.Parent = btnContainer

task.spawn(function()
    local t = 0
    while btnContainer.Parent do
        t = t + 0.03
        ring1.Rotation = t * 45
        ring2.Rotation = -t * 60
        ring1Grad.Rotation = t * 90
        tGlow.Transparency = 0.7 - math.abs(math.sin(t * 2)) * 0.4
        tStroke.Transparency = 0.1 + math.abs(math.sin(t * 2.5)) * 0.3
        task.wait(0.03)
    end
end)

btnContainer.MouseEnter:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(64, 64)
    }):Play()
end)

btnContainer.MouseLeave:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(56, 56)
    }):Play()
end)

panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(620, 420)
panel.Position = UDim2.new(0.5, -310, 0.5, -210)
panel.BackgroundColor3 = C.BG
panel.BackgroundTransparency = 0.02
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Visible = false
panel.Parent = gui
rnd(panel, 14)
strk(panel, DIAMOND_BLUE, 2, 0.25)

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(10, 25, 60)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(30, 70, 140)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 160, 240)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(30, 70, 140)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(10, 25, 60)),
})
bgGrad.Rotation = 135
bgGrad.Parent = panel

task.spawn(function()
    local t = 0
    while bgGrad.Parent do
        t = t + 0.8
        bgGrad.Rotation = (135 + t) % 360
        task.wait(0.05)
    end
end)

local panelShimmer = Instance.new("ImageLabel")
panelShimmer.Size = UDim2.new(0, 200, 1.5, 0)
panelShimmer.Position = UDim2.new(0, -200, 0, 0)
panelShimmer.BackgroundTransparency = 1
panelShimmer.Image = "rbxassetid://5028857084"
panelShimmer.ImageColor3 = Color3.fromRGB(150, 220, 255)
panelShimmer.ImageTransparency = 0.7
panelShimmer.ZIndex = 1
panelShimmer.Parent = panel

task.spawn(function()
    while panelShimmer.Parent do
        panelShimmer.Position = UDim2.new(0, -200, 0, 0)
        TweenService:Create(panelShimmer, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1, 50, 0, 0)
        }):Play()
        task.wait(3)
    end
end)

header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = C.PANEL
header.BackgroundTransparency = 0.05
header.BorderSizePixel = 0
header.Parent = panel
rnd(header, 14)

local headerGradNew = Instance.new("UIGradient")
headerGradNew.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 50, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 160, 240)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 50, 120)),
})
headerGradNew.Parent = header

local hIcon = Instance.new("ImageLabel")
hIcon.Size = UDim2.fromOffset(36, 36)
hIcon.Position = UDim2.new(0, 10, 0.5, -18)
hIcon.BackgroundTransparency = 1
hIcon.Image = IMAGE_ID
hIcon.Parent = header

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(0, 200, 0, 24)
hTitle.Position = UDim2.new(0, 54, 0.5, -12)
hTitle.BackgroundTransparency = 1
hTitle.Text = "ONE W + ALF"
hTitle.TextColor3 = Color3.fromRGB(230, 245, 255)
hTitle.TextSize = 18
hTitle.Font = Enum.Font.GothamBlack
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.TextStrokeTransparency = 0.5
hTitle.TextStrokeColor3 = Color3.fromRGB(20, 60, 120)
hTitle.Parent = header

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.fromOffset(26, 26)
minBtn.Position = UDim2.new(1, -62, 0.5, -13)
minBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(230, 245, 255)
minBtn.TextSize = 13
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.Parent = header
rnd(minBtn, 6)
strk(minBtn, DIAMOND_BLUE, 1, 0.4)

closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(26, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = C.RED
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = header
rnd(closeBtn, 6)
strk(closeBtn, C.RED, 1, 0.4)

tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 42)
tabBar.Position = UDim2.new(0, 10, 0, 60)
tabBar.BackgroundColor3 = C.PANEL
tabBar.BackgroundTransparency = 0.3
tabBar.BorderSizePixel = 0
tabBar.Parent = panel
rnd(tabBar, 8)
strk(tabBar, DIAMOND_BLUE, 1, 0.3)

tabScroll = Instance.new("ScrollingFrame")
tabScroll.Size = UDim2.new(1, -8, 1, -8)
tabScroll.Position = UDim2.new(0, 4, 0, 4)
tabScroll.BackgroundTransparency = 1
tabScroll.BorderSizePixel = 0
tabScroll.ScrollBarThickness = 0
tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tabScroll.ScrollingDirection = Enum.ScrollingDirection.X
tabScroll.Parent = tabBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 10)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Parent = tabScroll

local tabPadding = Instance.new("UIPadding")
tabPadding.PaddingLeft = UDim.new(0, 6)
tabPadding.PaddingRight = UDim.new(0, 6)
tabPadding.Parent = tabScroll

contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -115)
contentFrame.Position = UDim2.new(0, 10, 0, 107)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = panel

leftCol = Instance.new("Frame")
leftCol.Size = UDim2.new(0.5, -5, 1, 0)
leftCol.BackgroundColor3 = C.BG2
leftCol.BackgroundTransparency = 0.3
leftCol.BorderSizePixel = 0
leftCol.Parent = contentFrame
rnd(leftCol, 10)
strk(leftCol, DIAMOND_BLUE, 1, 0.3)

rightCol = Instance.new("Frame")
rightCol.Size = UDim2.new(0.5, -5, 1, 0)
rightCol.Position = UDim2.new(0.5, 5, 0, 0)
rightCol.BackgroundColor3 = C.BG2
rightCol.BackgroundTransparency = 0.3
rightCol.BorderSizePixel = 0
rightCol.Parent = contentFrame
rnd(rightCol, 10)
strk(rightCol, DIAMOND_BLUE, 1, 0.3)

leftScroll = Instance.new("ScrollingFrame")
leftScroll.Size = UDim2.new(1, -12, 1, -12)
leftScroll.Position = UDim2.new(0, 6, 0, 6)
leftScroll.BackgroundTransparency = 1
leftScroll.BorderSizePixel = 0
leftScroll.ScrollBarThickness = 2
leftScroll.ScrollBarImageColor3 = DIAMOND_BLUE
leftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
leftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
leftScroll.Parent = leftCol

local leftLayout = Instance.new("UIListLayout")
leftLayout.Padding = UDim.new(0, 5)
leftLayout.Parent = leftScroll

rightScroll = Instance.new("ScrollingFrame")
rightScroll.Size = UDim2.new(1, -12, 1, -12)
rightScroll.Position = UDim2.new(0, 6, 0, 6)
rightScroll.BackgroundTransparency = 1
rightScroll.BorderSizePixel = 0
rightScroll.ScrollBarThickness = 2
rightScroll.ScrollBarImageColor3 = DIAMOND_BLUE
rightScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rightScroll.Parent = rightCol

local rightLayout = Instance.new("UIListLayout")
rightLayout.Padding = UDim.new(0, 5)
rightLayout.Parent = rightScroll

cs = leftScroll
_G.Roooor_cs = cs

dragging = false
dragStart = nil
startPos = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

btnDragging = false
btnDragStart = nil
btnStartPos = nil
btnWasDragged = false

btnContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnWasDragged = false
        btnDragStart = input.Position
        btnStartPos = btnContainer.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            btnWasDragged = true
        end
        btnContainer.Position = UDim2.new(
            btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
            btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = false
    end
end)

isOpen = false

function openPanel()
    if isOpen then return end
    isOpen = true
    panel.Visible = true
    panel.Size = UDim2.fromOffset(80, 80)
    panel.Position = UDim2.new(0.5, -40, 0.5, -40)
    TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(620, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
    }):Play()
end

function closePanel()
    if not isOpen then return end
    isOpen = false
    TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(80, 80),
        Position = UDim2.new(0.5, -40, 0.5, -40),
    }):Play()
    task.wait(0.25)
    panel.Visible = false
end

_G.Roooor_openPanel = openPanel
_G.Roooor_closePanel = closePanel

btnContainer.MouseButton1Click:Connect(function()
    if btnWasDragged then
        btnWasDragged = false
        return
    end
    if isOpen then closePanel() else openPanel() end
    playToggleSound()
end)

closeBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

minBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if isOpen then closePanel() else openPanel() end
        playToggleSound()
    end
end)

print("[7/20] GUI Utama + Tombol W + Panel + Tab Bar OK")-- =========================================================
-- Section 8 : Komponen UI
-- =========================================================

function sec(title, icon, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local deco = Instance.new("Frame")
    deco.Size = UDim2.new(0, 3, 0, 14)
    deco.Position = UDim2.new(0, 2, 0.5, -7)
    deco.BackgroundColor3 = C.CYAN
    deco.BorderSizePixel = 0
    deco.Parent = f
    rnd(deco, 2)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -12, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = (icon or "•") .. " " .. string.upper(title)
    l.TextColor3 = C.CYAN
    l.TextSize = 9
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

function tog(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    local fStrk = strk(f, DIAMOND_BLUE, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -55, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local t = Instance.new("Frame")
    t.Size = UDim2.fromOffset(30, 15)
    t.Position = UDim2.new(1, -42, 0.5, -7.5)
    t.BorderSizePixel = 0
    t.Parent = f
    rnd(t, 8)

    local k = Instance.new("Frame")
    k.Size = UDim2.fromOffset(11, 11)
    k.BorderSizePixel = 0
    k.Parent = t
    rnd(k, 6)

    _G.ToggleStates = _G.ToggleStates or {}
    local saved = _G.ToggleStates[name]
    local state
    if saved ~= nil then state = saved else state = def end
    _G.ToggleStates[name] = state

    t.BackgroundColor3 = state and C.CYAN or C.PANEL2
    k.Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5)
    k.BackgroundColor3 = state and Color3.fromRGB(20, 50, 120) or C.DIM

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        state = not state
        _G.ToggleStates[name] = state
        TweenService:Create(k, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5),
            BackgroundColor3 = state and Color3.fromRGB(20, 50, 120) or C.DIM
        }):Play()
        TweenService:Create(t, TweenInfo.new(0.2), {
            BackgroundColor3 = state and C.CYAN or C.PANEL2
        }):Play()
        fStrk.Color = state and DIAMOND_LIGHT or DIAMOND_BLUE
        playToggleSound()
        if cb then pcall(cb, state) end
    end)
end

function sl(name, min, max, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 36)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, DIAMOND_BLUE, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -60, 0, 14)
    l.Position = UDim2.new(0, 10, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.SliderStates = _G.SliderStates or {}
    local curVal = _G.SliderStates[name]
    if curVal == nil then curVal = def end
    _G.SliderStates[name] = curVal

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 50, 0, 14)
    v.Position = UDim2.new(1, -56, 0, 4)
    v.BackgroundTransparency = 1
    v.Text = tostring(curVal)
    v.TextColor3 = C.CYAN
    v.TextSize = 10
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local bg2 = Instance.new("Frame")
    bg2.Size = UDim2.new(1, -20, 0, 5)
    bg2.Position = UDim2.new(0, 10, 1, -10)
    bg2.BackgroundColor3 = Color3.fromRGB(10, 25, 60)
    bg2.BorderSizePixel = 0
    bg2.Parent = f
    rnd(bg2, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((curVal - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.CYAN
    fill.BorderSizePixel = 0
    fill.Parent = bg2
    rnd(fill, 3)

    local kn = Instance.new("Frame")
    kn.Size = UDim2.fromOffset(12, 12)
    kn.Position = UDim2.new((curVal - min) / (max - min), -6, 0.5, -6)
    kn.BackgroundColor3 = DIAMOND_LIGHT
    kn.BorderSizePixel = 0
    kn.ZIndex = 2
    kn.Parent = bg2
    rnd(kn, 6)
    strk(kn, DIAMOND_BLUE, 1.5)

    local drag = false
    local function upd(input)
        local pos = math.clamp((input.Position.X - bg2.AbsolutePosition.X) / bg2.AbsoluteSize.X, 0, 1)
        local raw = min + (max - min) * pos
        local val
        if (max - min) <= 2 then
            val = math.floor(raw * 100 + 0.5) / 100
        else
            val = math.floor(raw + 0.5)
        end
        _G.SliderStates[name] = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        kn.Position = UDim2.new(pos, -6, 0.5, -6)
        v.Text = tostring(val)
        if cb then pcall(cb, val) end
    end

    bg2.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = true
            upd(input)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if drag and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            upd(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

function cpk(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, DIAMOND_BLUE, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.fromOffset(30, 16)
    cB.Position = UDim2.new(1, -38, 0.5, -8)
    cB.BackgroundColor3 = def
    cB.Text = ""
    cB.BorderSizePixel = 0
    cB.Parent = f
    rnd(cB, 4)
    strk(cB, DIAMOND_BLUE, 1.5)

    local presets = {
        Color3.fromRGB(255, 210, 80),
        Color3.fromRGB(255, 230, 120),
        Color3.fromRGB(255, 180, 60),
        Color3.fromRGB(255, 70, 100),
        Color3.fromRGB(80, 255, 150),
        Color3.fromRGB(74, 255, 181),
        Color3.fromRGB(80, 240, 255),
        Color3.fromRGB(255, 80, 200),
        Color3.fromRGB(255, 255, 255),
    }
    local idx = 1

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #presets then idx = 1 end
        cB.BackgroundColor3 = presets[idx]
        if cb then pcall(cb, presets[idx]) end
    end)
end

function btn(name, cb, parent)
    parent = parent or cs
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 28)
    b.BackgroundColor3 = C.PANEL
    b.BackgroundTransparency = 0.4
    b.Text = name
    b.TextColor3 = C.TXT
    b.TextSize = 10
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = parent
    rnd(b, 6)
    strk(b, DIAMOND_BLUE, 1, 0.4)

    b.MouseButton1Click:Connect(function()
        playToggleSound()
        if cb then pcall(cb) end
    end)
end

function drp(name, options, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, DIAMOND_BLUE, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.DropdownStates = _G.DropdownStates or {}
    local savedIdx = _G.DropdownStates[name]
    local idx = savedIdx or 1
    if not savedIdx then
        for i, o in ipairs(options) do
            if o == def then idx = i end
        end
        _G.DropdownStates[name] = idx
    end
    local cur = options[idx]

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.5, -28, 1, 0)
    v.Position = UDim2.new(0.5, 0, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = tostring(cur) .. " ▾"
    v.TextColor3 = C.CYAN
    v.TextSize = 9
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        cur = options[idx]
        _G.DropdownStates[name] = idx
        v.Text = tostring(cur) .. " ▾"
        if cb then pcall(cb, cur) end
    end)

    if cb and savedIdx then
        task.defer(function() pcall(cb, cur) end)
    end
end

function tpBtn(name, icon, color, callback, parent)
    parent = parent or cs
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 42)
    b.BackgroundColor3 = C.PANEL
    b.BackgroundTransparency = 0.3
    b.Text = ""
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.ClipsDescendants = true
    b.Parent = parent
    rnd(b, 10)

    local fStrk = strk(b, color or C.CYAN, 1.5, 0.4)

    local bgGrad = Instance.new("UIGradient")
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.PANEL),
        ColorSequenceKeypoint.new(1, C.BG2),
    })
    bgGrad.Rotation = 90
    bgGrad.Parent = b

    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 4, 1, -10)
    accentBar.Position = UDim2.new(0, 6, 0, 5)
    accentBar.BackgroundColor3 = color or C.CYAN
    accentBar.BorderSizePixel = 0
    accentBar.Parent = b
    rnd(accentBar, 2)

    local iconBox = Instance.new("Frame")
    iconBox.Size = UDim2.fromOffset(28, 28)
    iconBox.Position = UDim2.new(0, 16, 0.5, -14)
    iconBox.BackgroundColor3 = color or C.CYAN
    iconBox.BackgroundTransparency = 0.15
    iconBox.BorderSizePixel = 0
    iconBox.Parent = b
    rnd(iconBox, 7)

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(1, 0, 1, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon or "→"
    iconLbl.TextColor3 = Color3.fromRGB(15, 30, 60)
    iconLbl.TextSize = 15
    iconLbl.Font = Enum.Font.GothamBlack
    iconLbl.Parent = iconBox

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -80, 1, 0)
    label.Position = UDim2.new(0, 52, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = C.TXT
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 28, 1, 0)
    arrow.Position = UDim2.new(1, -32, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "→"
    arrow.TextColor3 = color or C.CYAN
    arrow.TextSize = 16
    arrow.Font = Enum.Font.GothamBlack
    arrow.Parent = b

    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = color or C.CYAN,
            BackgroundTransparency = 0.5,
        }):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), {
            Position = UDim2.new(1, -24, 0, 0),
        }):Play()
    end)

    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = C.PANEL,
            BackgroundTransparency = 0.3,
        }):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), {
            Position = UDim2.new(1, -32, 0, 0),
        }):Play()
    end)

    b.MouseButton1Click:Connect(function()
        playToggleSound()
        if callback then pcall(callback) end
        TweenService:Create(b, TweenInfo.new(0.1), {
            BackgroundColor3 = color or C.CYAN,
            BackgroundTransparency = 0.2,
        }):Play()
        task.wait(0.15)
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = C.PANEL,
            BackgroundTransparency = 0.3,
        }):Play()
    end)
end

activeTab = nil
tabButtons = {}

function makeTab(name, icon, order, leftCb, rightCb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(90, 32)
    b.BackgroundColor3 = C.BG
    b.BackgroundTransparency = 1
    b.Text = ""
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.AutoButtonColor = false
    b.Parent = tabScroll
    rnd(b, 7)

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 22, 1, 0)
    ico.Position = UDim2.new(0, 10, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = C.DIM
    ico.TextSize = 13
    ico.Font = Enum.Font.GothamBold
    ico.TextXAlignment = Enum.TextXAlignment.Left
    ico.Parent = b

    local lblT = Instance.new("TextLabel")
    lblT.Size = UDim2.new(1, -34, 1, 0)
    lblT.Position = UDim2.new(0, 30, 0, 0)
    lblT.BackgroundTransparency = 1
    lblT.Text = string.upper(name)
    lblT.TextColor3 = C.DIM
    lblT.TextSize = 8
    lblT.Font = Enum.Font.GothamBold
    lblT.TextXAlignment = Enum.TextXAlignment.Left
    lblT.Parent = b

    table.insert(tabButtons, {btn = b, name = name, leftCb = leftCb, rightCb = rightCb})

    b.MouseButton1Click:Connect(function()
        if activeTab == b then return end
        if activeTab then
            TweenService:Create(activeTab, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            for _, c in pairs(activeTab:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = C.DIM}):Play()
                end
            end
        end
        activeTab = b
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.5, BackgroundColor3 = C.CYAN}):Play()
        for _, c in pairs(b:GetChildren()) do
            if c:IsA("TextLabel") then
                TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(20, 50, 120)}):Play()
            end
        end
        for _, c in pairs(leftScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        for _, c in pairs(rightScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        if leftCb then pcall(leftCb) end
        if rightCb then pcall(rightCb) end
    end)

    return b
end

_G.Roooor_sec = sec
_G.Roooor_tog = tog
_G.Roooor_sl = sl
_G.Roooor_cpk = cpk
_G.Roooor_btn = btn
_G.Roooor_drp = drp
_G.Roooor_tpBtn = tpBtn
_G.Roooor_makeTab = makeTab

print("[8/20] Komponen UI OK")-- =========================================================
-- Section 9 : Tab Survivor + Killer + Teleport + Auto Parry UI
-- =========================================================

-- =========================================================
-- HITBOX ESP + SPOOF ATTACK (dari One W)
-- =========================================================
_G.HitboxEsp = _G.HitboxEsp or {
    Enabled = false, Size = 50,
    ShowSurvivor = true, ShowKiller = true,
    ColorSurvivor = Color3.fromRGB(80, 240, 255),
    ColorKiller = Color3.fromRGB(255, 70, 100),
    Transparency = 0.85, ShowWireframe = true,
}

_G.SpoofAttack = _G.SpoofAttack or {
    Enabled = false, SpoofDistance = 3,
    OnlyWhenClose = false, MaxRealDistance = 50,
    AttackSpam = false, AttackDelay = 0.15,
}

local HitboxEspObjects = {}

local function CreateHitboxEsp(char, color)
    if not char then return end
    if HitboxEspObjects[char] then
        local d = HitboxEspObjects[char]
        if d.sphere then d.sphere.Color = color end
        if d.wire then d.wire.Color = color end
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local sphere = Instance.new("Part")
    sphere.Name = "HitboxEsp"
    sphere.Shape = Enum.PartType.Ball
    sphere.Size = Vector3.new(1,1,1) * _G.HitboxEsp.Size
    sphere.Material = Enum.Material.ForceField
    sphere.Color = color
    sphere.Transparency = _G.HitboxEsp.Transparency
    sphere.CanCollide = false
    sphere.CanQuery = false
    sphere.CanTouch = false
    sphere.Anchored = true
    sphere.Parent = workspace

    local wire = nil
    if _G.HitboxEsp.ShowWireframe then
        wire = Instance.new("Part")
        wire.Name = "HitboxWire"
        wire.Shape = Enum.PartType.Ball
        wire.Size = Vector3.new(1,1,1) * _G.HitboxEsp.Size
        wire.Material = Enum.Material.Neon
        wire.Color = color
        wire.Transparency = 0.7
        wire.CanCollide = false
        wire.CanQuery = false
        wire.CanTouch = false
        wire.Anchored = true
        wire.Parent = workspace
    end

    HitboxEspObjects[char] = { sphere = sphere, wire = wire, color = color }

    char.AncestryChanged:Connect(function(_, parent)
        if not parent then
            local d = HitboxEspObjects[char]
            if d then
                if d.sphere then d.sphere:Destroy() end
                if d.wire then d.wire:Destroy() end
                HitboxEspObjects[char] = nil
            end
        end
    end)
end

local function RemoveHitboxEsp(char)
    local d = HitboxEspObjects[char]
    if d then
        if d.sphere then d.sphere:Destroy() end
        if d.wire then d.wire:Destroy() end
        HitboxEspObjects[char] = nil
    end
end

task.spawn(function()
    while task.wait(0.1) do
        local hitbox = _G.HitboxEsp
        if not hitbox.Enabled then
            for char, _ in pairs(HitboxEspObjects) do RemoveHitboxEsp(char) end
            continue
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local isSurv = p.Team and p.Team.Name == "Survivors"
                    local isKill = p.Team and p.Team.Name == "Killer"
                    if (isSurv and hitbox.ShowSurvivor) or (isKill and hitbox.ShowKiller) then
                        local color = isSurv and hitbox.ColorSurvivor or hitbox.ColorKiller
                        CreateHitboxEsp(p.Character, color)
                    else
                        RemoveHitboxEsp(p.Character)
                    end
                else
                    RemoveHitboxEsp(p.Character)
                end
            end
        end
        for char, d in pairs(HitboxEspObjects) do
            if char and char.Parent then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if d.sphere then
                        d.sphere.Size = Vector3.new(1,1,1) * hitbox.Size
                        d.sphere.CFrame = hrp.CFrame
                        d.sphere.Transparency = hitbox.Transparency
                    end
                    if d.wire then
                        d.wire.Size = Vector3.new(1,1,1) * hitbox.Size
                        d.wire.CFrame = hrp.CFrame
                    end
                end
            end
        end
    end
end)

-- SPOOF ATTACK
local SpoofHooked = false
local OriginalNamecall = nil

local function GetClosestSurvivorForSpoof()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, math.huge end
    local closest, shortest = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team and p.Team.Name == "Survivors" then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - myRoot.Position).Magnitude
                if dist < shortest then shortest = dist; closest = hrp end
            end
        end
    end
    return closest, shortest
end

local function EnableSpoofHook()
    if SpoofHooked then return end
    if not hookmetamethod or not getrawmetatable then return end
    SpoofHooked = true
    local mt = getrawmetatable(game)
    if not mt then SpoofHooked = false; return end
    OriginalNamecall = mt.__namecall
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and _G.SpoofAttack.Enabled then
            local name = self.Name
            if name == "BasicAttack" or name == "Attack" or name == "Slash"
                or name == "HitEvent" or name == "AttackEvent" then
                local target, dist = GetClosestSurvivorForSpoof()
                if target then
                    local spoof = _G.SpoofAttack
                    if not spoof.OnlyWhenClose or dist <= spoof.MaxRealDistance then
                        local args = {...}
                        local spoofedPos = target.Position + Vector3.new(0, 0, spoof.SpoofDistance)
                        pcall(function()
                            if type(args[1]) == "Vector3" then
                                args[1] = spoofedPos
                            elseif type(args[1]) == "CFrame" then
                                args[1] = CFrame.new(spoofedPos)
                            else
                                table.insert(args, 1, spoofedPos)
                            end
                        end)
                        return oldNamecall(self, table.unpack(args))
                    end
                end
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end

local function DisableSpoofHook()
    if not SpoofHooked then return end
    SpoofHooked = false
    if not getrawmetatable then return end
    local mt = getrawmetatable(game)
    if not mt or not OriginalNamecall then return end
    setreadonly(mt, false)
    mt.__namecall = OriginalNamecall
    setreadonly(mt, true)
end

task.spawn(function()
    while task.wait(1) do
        if _G.SpoofAttack.Enabled then
            if not SpoofHooked then pcall(EnableSpoofHook) end
        else
            if SpoofHooked then pcall(DisableSpoofHook) end
        end
    end
end)

-- =========================================================
-- TAB SURVIVOR
-- =========================================================
makeTab("Survivor", "🏃", 1, function()
    -- ===== AUTO PARRY ALF v1 =====
    sec("Auto Parry v1 (ALF)", "🛡️")
    tog("Enable Auto Parry v1", false, function(s)
        ALF.PARRY_Enabled = s
        if s then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    task.spawn(function()
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local anim = hum:FindFirstChildOfClass("Animator")
                            if anim then
                                anim.AnimationPlayed:Connect(function(track)
                                    if not ALF.PARRY_Enabled then return end
                                    if not APALF_IsEquippedDagger() then return end
                                    local at = APALF_GetAnimType(track)
                                    if at then
                                        APALF_State.ActiveAttackers[p] = {
                                            char = p.Character, track = track, type = at, registeredAt = os.clock()
                                        }
                                    end
                                end)
                            end
                        end
                    end)
                end
            end
        else
            APALF_State.ActiveAttackers = {}
            if APALF_DestroyCircle then pcall(APALF_DestroyCircle) end
        end
    end)
    tog("Aggressive Mode", false, function(s) ALF.PARRY_Aggressive = s end)
    tog("Silent Parry", false, function(s) ALF.PARRY_SilentParry = s end)
    tog("Show Parry Circle", false, function(s)
        ALF.PARRY_ShowCircle = s
        if not s and _G.Roooor_APALF_DestroyCircle then
            pcall(_G.Roooor_APALF_DestroyCircle)
        end
    end)
    sl("Parry Distance", 5, 40, 10, function(v) ALF.PARRY_Distance = v end)
    btn("Reset Parry State", function()
        APALF_ClearCooldown()
        APALF_State.ActiveAttackers = {}
        _G.ToggleStates["Enable Auto Parry v1"] = false
    end)

    -- ===== AUTO PARRY WISNU v2 =====
    sec("Auto Parry v2 (Wisnu)", "⚡")
    tog("Enable Auto Parry v2", false, function(s)
        ALF.Wisnu_AutoParry = s
        if not s then
            if Wisnu_State.Adornment then Wisnu_State.Adornment:Destroy(); Wisnu_State.Adornment = nil end
        end
    end)
    tog("Aggressive Mode", false, function(s) ALF.Wisnu_ParryAggressive = s end)
    tog("Safety Parry", false, function(s) ALF.Wisnu_ParrySafety = s end)
    tog("Show Range Circle", true, function(s) ALF.Wisnu_ParryCircle = s end)
    sl("Wisnu Parry Distance", 4, 25, 6, function(v) ALF.Wisnu_ParryDistance = v end)
    sl("Face Sensitivity", -1, 1, 0.7, function(v) ALF.Wisnu_ParryFace = v end)
    drp("Ignore Skills", {"None", "Hidden S1", "Abyssal S1"}, "None", function(v)
        if v == "None" then
            ALF.Wisnu_IgnoredSkills = {}
        else
            ALF.Wisnu_IgnoredSkills = { [v] = true }
        end
    end)

    -- ===== AUTO SKILL CHECK =====
    sec("Auto Skill Check", "⚡")
    tog("Enable Auto Skill Check", false, function(s)
        SkillCheck.Enabled = s
        if s then
            task.spawn(function()
                task.wait(0.1)
                if startSkillCheck then startSkillCheck() end
            end)
        end
    end)
    drp("Mode", {"Perfect", "Instant"}, "Perfect", function(v)
        SkillCheck.Mode = v
    end)
    btn("Reset Counter", function()
        SkillCheck.Success = 0
        SkillCheck.Total = 0
    end)

    -- ===== AUTO WIGGLE =====
    sec("Auto Wiggle", "🔓")
    tog("Enable Auto Wiggle", false, function(s)
        AutoParry.Wiggle = s
    end)
    sl("Wiggle Spam", 1, 20, 5, function(v)
        AutoParry.WiggleSpam = v
    end)

    -- ===== AUTO FLEE =====
    sec("Auto Flee", "🏃‍♂️")
    tog("Enable Auto Flee", false, function(s)
        AutoFlee.Enabled = s
    end)
    sl("Detect Distance", 10, 150, 50, function(v)
        AutoFlee.DetectDistance = v
    end)
    sl("Cooldown", 0.1, 5, 0.5, function(v)
        AutoFlee.Cooldown = v
    end)

    -- ===== FAST VAULT =====
    sec("Fast Vault", "⚡")
    tog("Enable Fast Vault", false, function(s)
        FastVault.Enabled = s
        if s and LP.Character then hookVault(LP.Character) end
    end)
    sl("Animation Speed", 1, 5, 1.2, function(v)
        FastVault.Speed = v
    end)

    -- ===== SUPPORT =====
    sec("Support", "💊")
    tog("Instant Interact", false, function(s) S.InstantInteract = s end)

    -- ===== TELEPORT =====
    sec("Teleport", "🌀")
    btn("TP Finish Line", function() teleportToFinishLine() end)
end, function()
    -- ===== TELEPORT MENU (KANAN) =====
    sec("Teleport Menu", "🌀", rightScroll)

    local TP = _G.Teleport or { OffsetY = 5, FrontDistance = 4, Mode = "Random", Notify = true }
    _G.Teleport = TP

    local function TP_GetPos(obj)
        if not obj then return nil end
        if obj:IsA("BasePart") then return obj.Position end
        if obj:IsA("Model") then
            local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if pp then return pp.Position end
        end
        return nil
    end

    local function TP_DoTeleport(targetObj, targetPos, targetName)
        local root = getRoot()
        if not root then return false end
        local offset = TP.OffsetY or 5
        local fd = TP.FrontDistance or 4
        local finalCF

        if targetObj then
            local bp = nil
            if targetObj:IsA("BasePart") then bp = targetObj
            elseif targetObj:IsA("Model") then bp = targetObj.PrimaryPart or targetObj:FindFirstChildWhichIsA("BasePart") end
            if bp then
                local frontOffset = bp.CFrame.LookVector * fd
                local tpPos = bp.Position + frontOffset + Vector3.new(0, offset, 0)
                finalCF = CFrame.new(tpPos, bp.Position)
            else
                finalCF = CFrame.new(targetPos + Vector3.new(0, offset, 0), targetPos)
            end
        else
            finalCF = CFrame.new(targetPos + Vector3.new(0, offset, 0), targetPos)
        end

        pcall(function()
            root.CFrame = finalCF
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end)

        if TP.Notify then
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Teleport",
                    Text = "Ke " .. (targetName or "target"),
                    Duration = 1
                })
            end)
        end
    end

    local function TP_Pick(targets)
        if not targets or #targets == 0 then return nil end
        local root = getRoot()
        local myPos = root and root.Position or Vector3.new(0, 0, 0)
        local mode = TP.Mode or "Random"
        if mode == "Random" then return targets[math.random(1, #targets)]
        elseif mode == "Nearest" then
            local b, bd = nil, math.huge
            for _, t in ipairs(targets) do
                local d = (t.pos - myPos).Magnitude
                if d < bd then bd = d; b = t end
            end
            return b
        elseif mode == "Farthest" then
            local b, bd = nil, 0
            for _, t in ipairs(targets) do
                local d = (t.pos - myPos).Magnitude
                if d > bd then bd = d; b = t end
            end
            return b
        end
        return targets[1]
    end

    local function TP_FindByNames(names)
        local r = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            for _, n in ipairs(names) do
                if obj.Name == n then
                    local p = TP_GetPos(obj)
                    if p then table.insert(r, {pos=p, name=n, obj=obj}) end
                    break
                end
            end
        end
        return r
    end

    local function TP_FindGates()
        local r = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            local n = string.lower(obj.Name)
            if n == "gate" or n == "exitgate" or n == "gateexit"
            or n == "escape" or n == "escapegate"
            or n == "fininshline" or n == "finishline"
            or string.find(n, "^gate%d") then
                local p = TP_GetPos(obj)
                if p then table.insert(r, {pos=p, name=obj.Name, obj=obj}) end
            end
        end
        return r
    end

    local function TP_FindHooks()
        local r = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "HookPoint" and obj:IsA("BasePart") then
                table.insert(r, {pos=obj.Position, name="Hook", obj=obj})
            end
        end
        return r
    end

    local function TP_FindSCPs()
        local r = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            local n = string.lower(obj.Name)
            if string.find(n, "scp") then
                local p = TP_GetPos(obj)
                if p then table.insert(r, {pos=p, name=obj.Name, obj=obj}) end
            end
        end
        return r
    end

    local function TP_FindPlayers(teamName)
        local r = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == teamName then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    table.insert(r, {pos=hrp.Position, name=p.Name, obj=p.Character})
                end
            end
        end
        return r
    end

    tpBtn("Generator", "⚙", Color3.fromRGB(255, 170, 0), function()
        local p = TP_Pick(TP_FindByNames({"Generator"}))
        if p then TP_DoTeleport(p.obj, p.pos, "Generator") end
    end, rightScroll)

    tpBtn("Pallet", "▬", Color3.fromRGB(74, 255, 181), function()
        local p = TP_Pick(TP_FindByNames({"Pallet", "Palletwrong"}))
        if p then TP_DoTeleport(p.obj, p.pos, "Pallet") end
    end, rightScroll)

    tpBtn("Gate / Exit", "⛩", Color3.fromRGB(255, 220, 80), function()
        local p = TP_Pick(TP_FindGates())
        if p then TP_DoTeleport(p.obj, p.pos, "Gate") end
    end, rightScroll)

    tpBtn("Window", "▢", Color3.fromRGB(80, 240, 255), function()
        local p = TP_Pick(TP_FindByNames({"Window"}))
        if p then TP_DoTeleport(p.obj, p.pos, "Window") end
    end, rightScroll)

    tpBtn("Hook Point", "⤴", Color3.fromRGB(255, 130, 60), function()
        local p = TP_Pick(TP_FindHooks())
        if p then TP_DoTeleport(p.obj, p.pos, "Hook") end
    end, rightScroll)

    tpBtn("SCP", "☠", Color3.fromRGB(180, 100, 255), function()
        local p = TP_Pick(TP_FindSCPs())
        if p then TP_DoTeleport(p.obj, p.pos, "SCP") end
    end, rightScroll)

    tpBtn("Survivor", "☺", Color3.fromRGB(80, 255, 150), function()
        local p = TP_Pick(TP_FindPlayers("Survivors"))
        if p then TP_DoTeleport(p.obj, p.pos, "Survivor: " .. p.name) end
    end, rightScroll)

    tpBtn("Killer", "⚔", Color3.fromRGB(255, 70, 100), function()
        local p = TP_Pick(TP_FindPlayers("Killer"))
        if p then TP_DoTeleport(p.obj, p.pos, "Killer: " .. p.name) end
    end, rightScroll)

    tpBtn("Random", "★", Color3.fromRGB(255, 200, 50), function()
        local all = {}
        for _, t in ipairs(TP_FindByNames({"Generator"})) do table.insert(all, t) end
        for _, t in ipairs(TP_FindByNames({"Pallet", "Palletwrong"})) do table.insert(all, t) end
        for _, t in ipairs(TP_FindGates()) do table.insert(all, t) end
        for _, t in ipairs(TP_FindByNames({"Window"})) do table.insert(all, t) end
        for _, t in ipairs(TP_FindHooks()) do table.insert(all, t) end
        local p = all[math.random(1, #all)]
        if p then TP_DoTeleport(p.obj, p.pos, "Random: " .. p.name) end
    end, rightScroll)

    sec("TP Settings", "⚙️", rightScroll)

    drp("TP Mode", {"Random", "Nearest", "Farthest"}, "Random", function(v)
        TP.Mode = v
    end, rightScroll)

    sl("TP Offset Y", 0, 20, 5, function(v)
        TP.OffsetY = v
    end, rightScroll)

    sl("TP Front Distance", 1, 15, 4, function(v)
        TP.FrontDistance = v
    end, rightScroll)

    tog("TP Notify", true, function(s)
        TP.Notify = s
    end, rightScroll)
end)

-- =========================================================
-- TAB KILLER
-- =========================================================
makeTab("Killer", "🔪", 2, function()
    sec("Auto Attack", "⚔️")
    tog("Killer Auto Attack", false, function(s) S.Killer_AutoAtk = s end)
    sl("Attack Delay", 0.1, 1, 0.35, function(v) S.Killer_AtkDelay = v end)

    sec("Hitbox ESP", "📦")
    tog("Enable Hitbox ESP", false, function(s) _G.HitboxEsp.Enabled = s end)
    sl("Hitbox Size", 10, 400, 50, function(v) _G.HitboxEsp.Size = v end)
    sl("Hitbox Transparency", 0.1, 1, 0.85, function(v) _G.HitboxEsp.Transparency = v end)
    tog("Show Survivor Hitbox", true, function(s) _G.HitboxEsp.ShowSurvivor = s end)
    tog("Show Killer Hitbox", true, function(s) _G.HitboxEsp.ShowKiller = s end)
    tog("Show Wireframe", true, function(s) _G.HitboxEsp.ShowWireframe = s end)

    sec("Spoof Attack", "⚡")
    tog("Enable Spoof Attack", false, function(s) _G.SpoofAttack.Enabled = s end)
    sl("Spoof Distance", 0, 10, 3, function(v) _G.SpoofAttack.SpoofDistance = v end)
    tog("Only When Close", false, function(s) _G.SpoofAttack.OnlyWhenClose = s end)
    sl("Max Real Distance", 10, 200, 50, function(v) _G.SpoofAttack.MaxRealDistance = v end)
    tog("Attack Spam (Auto Attack)", false, function(s) _G.SpoofAttack.AttackSpam = s end)
    sl("Attack Delay", 0.05, 0.5, 0.15, function(v) _G.SpoofAttack.AttackDelay = v end)

    sec("Kill All", "💀")
    tog("Killer Kill All", false, function(s) S.Killer_KillAll = s end)

    sec("Auto Carry + Hook", "🎒")
    tog("Auto Carry", false, function(s) S.AutoCarry = s end)
    tog("Auto Hook", false, function(s) S.AutoHook = s end)
    sl("Carry Range", 10, 200, 60, function(v) S.CarryRange = v end)
end, function()
    sec("Masked Power", "🎭", rightScroll)
    drp("Select Power", {"Cobra", "Richter", "Brandon", "Rabbit", "Alex"}, "Cobra", function(v)
        S.MaskedPower = v
    end, rightScroll)
    btn("Activate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
        if Event then Event:FireServer(S.MaskedPower) end
    end, rightScroll)
    btn("Deactivate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
        if Event then Event:FireServer() end
    end, rightScroll)
end)

print("[9/20] Tab Survivor + Killer + Teleport + Auto Parry UI OK")-- =========================================================
-- Section 10 : Tab ESP + Fire + Musik
-- =========================================================

-- =========================================================
-- TAB ESP
-- =========================================================
makeTab("ESP", "👁️", 3, function()
    sec("Player ESP", "🟢")
    tog("ESP Survivor", true, function(s) ESP.Survivor = s end)
    cpk("Survivor Color", TeamColors.Survivor, function(c) TeamColors.Survivor = c end)
    tog("ESP Killer", true, function(s) ESP.Killer = s end)
    cpk("Killer Color", TeamColors.Killer, function(c) TeamColors.Killer = c end)

    sec("Object ESP", "⚡")
    tog("ESP Generator", true, function(s) ESP.Generator = s end)
    cpk("Gen Color", GeneratorColor, function(c) GeneratorColor = c end)
    tog("ESP Pallet", false, function(s) ESP.Pallet = s end)
    cpk("Pallet Color", PalletColor, function(c) PalletColor = c end)
    tog("ESP Window", false, function(s) ESP.Window = s end)
    cpk("Window Color", WindowColor, function(c) WindowColor = c end)
    tog("ESP SCP", false, function(s) ESP.SCP = s end)
    cpk("SCP Color", SCPColor, function(c) SCPColor = c end)

    sec("ESP Distance", "📏")
    sl("ESP Radius", 10, 1000, 1000, function(v) ESP.Distance = v end)
end, function()
    sec("Generator Mode", "📊", rightScroll)
    drp("Generator Mode", {"Classic", "Bar"}, "Bar", function(v)
        S.ESPGenMode = v
        for gen in pairs(Cached.Generators) do
            local a = gen:FindFirstChild("GenESP")
            if a then a:Destroy() end
            local b = gen:FindFirstChild("GenESPBar")
            if b then b:Destroy() end
        end
    end, rightScroll)
    sl("Bar Width", 40, 200, 64, function(v) S.ESPGenBarSize = v end, rightScroll)
    sl("Bar Height", 8, 40, 8, function(v) S.ESPGenBarHeight = v end, rightScroll)
    sl("Text Size", 6, 30, 6, function(v) S.ESPGenBarTextSize = v end, rightScroll)

    sec("Status ESP", "🟢", rightScroll)
    tog("Enable Status ESP", false, function(s) ESPStatus.Enabled = s end, rightScroll)
    tog("Show Name", true, function(s) ESPStatus.ShowName = s end, rightScroll)
    tog("Show Distance", true, function(s) ESPStatus.ShowDistance = s end, rightScroll)
    tog("Show Health", true, function(s) ESPStatus.ShowHealth = s end, rightScroll)
    sl("Status Radius", 20, 1000, 1000, function(v) ESPStatus.Radius = v end, rightScroll)

    sec("Nama Mode", "✨", rightScroll)
    drp("Name Mode", {"Text", "Galaxy"}, "Galaxy", function(v)
        S.ESPNameMode = v
    end, rightScroll)
    sl("Name Size", 8, 30, 8, function(v)
        S.ESPNameSize = v
    end, rightScroll)
end)

-- =========================================================
-- TAB FIRE
-- =========================================================
makeTab("Fire", "🔥", 4, function()
    sec("Fire Control", "⚙️")
    tog("Enable Fire", false, function(s)
        S.FireOn = s
        applyFire()
    end)
    sl("Fire Size", 1, 15, 5, function(v)
        S.FireSize = v
        applyFire()
    end)
end, function()
    sec("Fire Effect (60)", "🔥", rightScroll)
    for i, fireName in ipairs(FireList) do
        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 24)
        btn2.BackgroundColor3 = C.BG
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = ""
        btn2.AutoButtonColor = false
        btn2.LayoutOrder = i + 100
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, DIAMOND_BLUE, 1, 0.6)

        local btnLbl = Instance.new("TextLabel")
        btnLbl.Size = UDim2.new(1, -10, 1, 0)
        btnLbl.Position = UDim2.new(0, 8, 0, 0)
        btnLbl.BackgroundTransparency = 1
        btnLbl.Text = fireName
        btnLbl.TextColor3 = C.TXT
        btnLbl.TextSize = 9
        btnLbl.Font = Enum.Font.GothamMedium
        btnLbl.TextXAlignment = Enum.TextXAlignment.Left
        btnLbl.Parent = btn2

        if S.FireType == fireName then
            btn2.BackgroundColor3 = C.CYAN
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.fromRGB(20, 50, 120)
        end

        btn2.MouseButton1Click:Connect(function()
            S.FireType = fireName
            applyFire()
            for _, c in pairs(rightScroll:GetChildren()) do
                if c:IsA("TextButton") and c.LayoutOrder > 100 and c.LayoutOrder < 200 then
                    c.BackgroundColor3 = C.BG
                    c.BackgroundTransparency = 0.4
                    local l = c:FindFirstChildOfClass("TextLabel")
                    if l then l.TextColor3 = C.TXT end
                end
            end
            btn2.BackgroundColor3 = C.CYAN
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.fromRGB(20, 50, 120)
            playToggleSound()
        end)
    end
end)

-- =========================================================
-- TAB MUSIK
-- =========================================================
makeTab("Musik", "🎵", 5, function()
    sec("Music Player", "🎵")

    sl("Volume", 0, 1, 0.5, function(v)
        if Bombax.Music then Bombax.Music.Volume = v end
        Bombax.Volume = v
    end)

    sl("Pitch", 0.5, 2, 1, function(v)
        if Bombax.Music then Bombax.Music.Pitch = v end
        Bombax.Pitch = v
    end)

    tog("Show Standalone GUI", true, function(s)
        if _G.Roooor_BombaxGui then
            _G.Roooor_BombaxGui.Enabled = s
        end
    end)

    sec("Quick Controls", "🎮")
    btn("Play / Next", function()
        if Bombax.PutarRandom then Bombax.PutarRandom() end
    end)
    btn("Stop", function()
        if Bombax.Stop then Bombax.Stop() end
    end)

    sec("Teleport GUI", "📍")
    btn("Reset GUI ke Pojok Kiri", function()
        if _G.Roooor_BombaxGui then
            local frame = _G.Roooor_BombaxGui:FindFirstChild("MainFrame")
            if frame then
                TweenService:Create(frame, TweenInfo.new(0.3), {
                    Position = UDim2.new(0, 20, 0, 100)
                }):Play()
            end
        end
    end)
end, function()
    sec("Playlist (" .. #Bombax.DaftarLagu .. " lagu)", "🎵", rightScroll)

    for i, lagu in ipairs(Bombax.DaftarLagu) do
        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 26)
        btn2.BackgroundColor3 = C.BG
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = ""
        btn2.AutoButtonColor = false
        btn2.LayoutOrder = i
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, DIAMOND_BLUE, 1, 0.6)

        local btnLbl = Instance.new("TextLabel")
        btnLbl.Size = UDim2.new(1, -10, 1, 0)
        btnLbl.Position = UDim2.new(0, 8, 0, 0)
        btnLbl.BackgroundTransparency = 1
        btnLbl.Text = i .. ". " .. lagu.judul
        btnLbl.TextColor3 = C.TXT
        btnLbl.TextSize = 9
        btnLbl.Font = Enum.Font.GothamMedium
        btnLbl.TextXAlignment = Enum.TextXAlignment.Left
        btnLbl.Parent = btn2

        btn2.MouseButton1Click:Connect(function()
            if Bombax.Music then
                Bombax.Music.SoundId = "rbxassetid://" .. lagu.id
                Bombax.Music:Play()
            end
            playToggleSound()
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Now Playing",
                    Text = lagu.judul,
                    Duration = 3
                })
            end)
        end)
    end
end)

print("[10/20] Tab ESP + Fire + Musik OK")-- =========================================================
-- Section 11 : Tab Misc + Visual + Grafik Ultra
-- =========================================================

-- =========================================================
-- TAB MISC
-- =========================================================
makeTab("Misc", "⚙️", 6, function()
    sec("Movement", "🏃")
    tog("Walk Speed", false, function(s) S.WalkSpeed = s end)
    sl("Walk Speed Value", 16, 100, 16, function(v) S.WalkSpeedVal = v end)
    tog("Speed Hack", false, function(s) S.SpeedHack = s end)
    sl("Speed Hack Value", 20, 200, 40, function(v) S.SpeedHackVal = v end)
    tog("No Clip", false, function(s) S.NoClip = s end)
    tog("No Clip Camera", false, function(s) S.NoClipCamera = s end)

    sec("FOV", "🎥")
    btn("FOV 70", function()
        S.FOV = 70; S.FOVEnabled = true; applyFOV()
    end)
    btn("FOV 90", function()
        S.FOV = 90; S.FOVEnabled = true; applyFOV()
    end)
    btn("FOV 120", function()
        S.FOV = 120; S.FOVEnabled = true; applyFOV()
    end)

    sec("Utility", "🛠️")
    tog("Anti-AFK", false, function(s)
        S.AntiAFK = s
        applyAntiAFK(s)
    end)
end, function()
    sec("FPS Counter", "📊", rightScroll)
    tog("Show FPS Counter", true, function(s) S.ShowFPS = s end, rightScroll)
    tog("Show Ping Counter", true, function(s) S.ShowPing = s end, rightScroll)

    sec("Notify", "🔔", rightScroll)
    tog("Kill Feed", false, function(s) S.KillFeed = s end, rightScroll)
    tog("Stun Notify", false, function(s) S.StunNotify = s end, rightScroll)

    sec("Server", "🌐", rightScroll)
    btn("Rejoin Server", function() rejoinServer() end, rightScroll)
end)

-- =========================================================
-- TAB VISUAL
-- =========================================================
makeTab("Visual", "✨", 7, function()
    sec("Fullbright & No Fog", "💡")
    tog("Fullbright", false, function(s)
        S.Fullbright = s
        applyFullbright(s)
    end)
    sl("Brightness Level", 0, 500, 200, function(v)
        S.FullbrightVal = v
        if S.Fullbright then applyFullbright(true) end
    end)
    sl("Clock Time", 0, 24, 14, function(v)
        S.ClockTime = v
        pcall(function() Lighting.ClockTime = v end)
    end)
    sl("Custom Brightness", 0, 500, 200, function(v)
        S.CustomBrightness = v
        pcall(function() Lighting.Brightness = v / 100 end)
    end)
    tog("No Fog", false, function(s)
        S.NoFog = s
        applyNoFog(s)
    end)
    tog("Kill VD Fog", true, function(s)
        S.KillFog = s
        applyKillFog(s)
    end)

    sec("HD Sky", "🔷")
    tog("HD Sky (Clean)", false, function(s)
        S.HDSky = s
        applyHDSky(s)
    end)

    sec("HD Visual", "🌟")
    tog("HD Texture", false, function(s) S.HDTexture = s; applyHDTexture(s) end)
    tog("HD Reflection", false, function(s) S.HDReflection = s; applyHDReflection(s) end)
    tog("HD Bloom", false, function(s) S.HDBloom = s; applyHDBloom(s) end)
    tog("HD Shadow", false, function(s) S.HDShadow = s; applyHDShadow(s) end)
    tog("HD Water", false, function(s) S.HDWater = s; applyHDWater(s) end)
    tog("HD Sun Rays", false, function(s) S.HDSunRays = s; applyHDSunRays(s) end)
    tog("HD Depth of Field", false, function(s) S.HDDepthField = s; applyHDDepthField(s) end)
    tog("HD Anti-Aliasing", false, function(s) S.HDAntiAliasing = s; applyHDAntiAliasing(s) end)

    sec("Lighting", "💡")
    tog("Ultra HD", false, function(s) S.UltraHD = s; applyUltraHD() end)
    tog("Contrast Boost", false, function(s) S.Contrast = s; applyContrast() end)
    sl("Contrast", 0, 1, 0.3, function(v) S.ContrastVal = v; applyContrast() end)
    sl("Saturation", 0, 1, 0.2, function(v) S.SaturationVal = v; applyContrast() end)

    sec("Character", "🎭")
    tog("Headless", true, function(s)
        S.Headless = s
        applyHeadless(s)
    end)
    tog("Enable Korblox", true, function(s)
        S.Korblox = s
        applyKorblox(s, "Pencil", S.KorbloxYOffset, S.KorbloxScale)
    end)
    sl("Korblox Y", -2, 2, 0.80, function(v)
        S.KorbloxYOffset = v
        if S.Korblox then applyKorblox(true, "Pencil", v, S.KorbloxScale) end
    end)
    sl("Korblox Scale", 0.3, 3, 1, function(v)
        S.KorbloxScale = v
        if S.Korblox then applyKorblox(true, "Pencil", S.KorbloxYOffset, v) end
    end)
    tog("8-Bit Crown", false, function(s)
        S.EightBitOn = s
        apply8Bit(s, "Royal Crown", S.EightBitSize, S.EightBitHeight)
    end)
    sl("Crown Size", 0.3, 3, 1.24, function(v)
        S.EightBitSize = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", v, S.EightBitHeight) end
    end)
    sl("Crown Height", -1, 4, 0.88, function(v)
        S.EightBitHeight = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", S.EightBitSize, v) end
    end)
end, function()
    sec("Sky Preset", "🌌", rightScroll)
    drp("Sky", SkyList, "Default", function(v)
        S.SkyId = v
        applySky(v)
    end, rightScroll)

    sec("Camera", "🎥", rightScroll)
    tog("Zoom Out", false, function(s) S.ZoomOut = s; applyZoomOut(s, S.ZoomOutValue) end, rightScroll)
    sl("Max Zoom Distance", 100, 1000, 500, function(v)
        S.ZoomOutValue = v
        if S.ZoomOut then applyZoomOut(true, v) end
    end, rightScroll)

    sec("Crosshair", "🎯", rightScroll)
    tog("Enable Crosshair", false, function(s)
        S.Crosshair = s
        applyCrosshair(s, S.CrosshairColor, S.CrosshairSize)
    end, rightScroll)
    cpk("Crosshair Color", S.CrosshairColor, function(c)
        S.CrosshairColor = c
        if S.Crosshair then applyCrosshair(true, c, S.CrosshairSize) end
    end, rightScroll)
    drp("Crosshair Style", {"Plus","Dot","Circle","Cross","X-Cross","T-Shape","Chevron","Arrow","Brackets","Diamond"}, "Plus", function(v)
        S.CrosshairStyle = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    sl("Crosshair Size", 2, 30, 8, function(v)
        S.CrosshairSize = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, v) end
    end, rightScroll)
    sl("Crosshair Thickness", 1, 8, 2, function(v)
        S.CrosshairThickness = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    sl("Crosshair Gap", 0, 15, 4, function(v)
        S.CrosshairGap = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    sl("Crosshair Pos X", -200, 200, 0, function(v)
        S.CrosshairOffsetX = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    sl("Crosshair Pos Y", -200, 200, 0, function(v)
        S.CrosshairOffsetY = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)
    tog("Show Outline", true, function(s)
        S.CrosshairShowOutline = s
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end, rightScroll)

    sec("Character Effects", "✨", rightScroll)
    tog("Fire Trail", false, function(s)
        S.Trail = s
        applyTrail(s, S.TrailColor)
    end, rightScroll)
    cpk("Trail Color", S.TrailColor, function(c)
        S.TrailColor = c
        if S.Trail then applyTrail(true, c) end
    end, rightScroll)
    tog("Aura Fire", false, function(s)
        S.Aura = s
        applyAura(s, S.AuraColor)
    end, rightScroll)
    cpk("Aura Color", S.AuraColor, function(c)
        S.AuraColor = c
        if S.Aura then applyAura(true, c) end
    end, rightScroll)
    tog("Kill Effect", false, function(s) S.KillEffect = s end, rightScroll)

    sec("FPS Boost", "🚀", rightScroll)
    tog("No Screen Effects", false, function(s)
        S.NoScreenEffects = s
        applyNoScreenEffects()
    end, rightScroll)
    tog("Low Graphics", false, function(s)
        S.LowGraphics = s
        applyLowGraphics()
    end, rightScroll)
    tog("Clean Sky", false, function(s)
        S.CleanSky = s
        applyCleanSky()
    end, rightScroll)

    sec("Danger Zone", "⚠️", rightScroll)
    btn("UNLOAD", function()
        pcall(function()
            if gui then gui:Destroy() end
            if killFeedGui then killFeedGui:Destroy() end
            if crosshairGui then crosshairGui:Destroy() end
            if fpsPingGui then fpsPingGui:Destroy() end
            if mwBtnGui then mwBtnGui:Destroy() end
            if AimbotLaserGui then AimbotLaserGui:Destroy() end
            if _G.Roooor_BombaxGui then _G.Roooor_BombaxGui:Destroy() end
            clear8Bit()
            clearKorblox()
            AP_ClearCircle()
            SharpReset()
        end)
    end, rightScroll)
end)

-- =========================================================
-- TAB GRAFIK ULTRA
-- =========================================================
makeTab("Grafik Ultra", "🎬", 8, function()
    sec("Soft Cinematic", "🎬")
    tog("Soft Cinematic", false, function(s)
        if s then
            GraphicEnableSoftCinematic()
        else
            GraphicDisableSoftCinematic()
        end
    end)
    tog("Full Bright", false, function(s)
        GraphicState.FullBright = s
    end)
    tog("No Fog", false, function(s)
        GraphicState.NoFog = s
    end)
    tog("Clean Sky", false, function(s)
        GraphicState.CleanSky = s
    end)
end, function()
    sec("SharpGraph Preset", "⚡", rightScroll)
    btn("ANTI LAG 10", function() SharpApplyAntiLag10() end, rightScroll)
    btn("TAJAM MAX", function() SharpApplyTajamMax() end, rightScroll)
    btn("BALANCE", function() SharpApplyBalance() end, rightScroll)
    btn("HD SHARP", function() SharpApplyHDSharp() end, rightScroll)
    btn("ULTRA HD 10", function() SharpApplyUltraHD10() end, rightScroll)

    sec("Soft Cinematic Preset", "🎬", rightScroll)
    for _, presetName in ipairs(GraphicPresetOrder) do
        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 28)
        btn2.BackgroundColor3 = C.PANEL
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = "🎬  " .. presetName
        btn2.TextColor3 = C.TXT
        btn2.TextSize = 10
        btn2.Font = Enum.Font.GothamMedium
        btn2.TextXAlignment = Enum.TextXAlignment.Left
        btn2.AutoButtonColor = false
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, DIAMOND_BLUE, 1, 0.4)

        local pad2 = Instance.new("UIPadding")
        pad2.PaddingLeft = UDim.new(0, 10)
        pad2.Parent = btn2

        if GraphicState.SelectedPreset == presetName then
            btn2.BackgroundColor3 = C.CYAN
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(20, 50, 120)
        end

        btn2.MouseButton1Click:Connect(function()
            GraphicSelectPreset(presetName)
            for _, c in pairs(rightScroll:GetChildren()) do
                if c:IsA("TextButton") and c:GetAttribute("IsPreset") then
                    c.BackgroundColor3 = C.PANEL
                    c.BackgroundTransparency = 0.4
                    c.TextColor3 = C.TXT
                end
            end
            btn2.BackgroundColor3 = C.CYAN
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(20, 50, 120)
            playToggleSound()
        end)
        btn2:SetAttribute("IsPreset", true)
    end

    sec("Reset", "🔄", rightScroll)
    btn("Reset All Graphics", function()
        GraphicReset()
        SharpReset()
    end, rightScroll)
end)

print("[11/20] Tab Misc + Visual + Grafik Ultra OK")-- =========================================================
-- Section 12 : Tab Aimbot + Moonwalk
-- =========================================================

-- =========================================================
-- TAB AIMBOT
-- =========================================================
makeTab("Aimbot", "🎯", 9, function()
    sec("Aimbot Killer", "🗡️")
    tog("Enable Aimbot Killer", false, function(s)
        Aimlock.Enabled = s
        if s then
            Aimlock_HookAttackButtons()
            Aimlock_StartLoop()
        else
            Aimlock.Holding = false
            Aimlock_StopLoop()
        end
    end)
    sl("Killer Radius", 5, 100, 80, function(v)
        Aimlock.Radius = v
    end)
    drp("Killer Aim Part", {"HumanoidRootPart", "Head", "UpperTorso"}, "HumanoidRootPart", function(v)
        Aimlock.AimPart = v
    end)

    sec("Aimbot Senter", "🔦")
    tog("Enable Aimbot Senter", false, function(s)
        AimbotSenter.Enabled = s
        if not s then
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end
    end)
    drp("Senter Lock Part", {"Head", "HumanoidRootPart", "UpperTorso"}, "Head", function(v)
        AimbotSenter.LockPart = v
    end)
    tog("Show ESP Laser", true, function(s)
        AimbotSenter.ShowLaser = s
    end)
    cpk("Laser Color", DIAMOND_BLUE, function(c)
        AimbotSenter.LaserColor = c
    end)
end, function()
    sec("Info", "ℹ️", rightScroll)
    local infoLbl = Instance.new("TextLabel")
    infoLbl.Size = UDim2.new(1, -4, 0, 80)
    infoLbl.BackgroundTransparency = 1
    infoLbl.Text = "Aimbot Killer: HOLD attack = lock ke Survivor\n\nAimbot Senter: HOLD senter = lock ke Killer\n\nLepas tombol = kamera bebas"
    infoLbl.TextColor3 = C.DIM
    infoLbl.TextSize = 9
    infoLbl.Font = Enum.Font.Gotham
    infoLbl.TextXAlignment = Enum.TextXAlignment.Left
    infoLbl.TextYAlignment = Enum.TextYAlignment.Top
    infoLbl.TextWrapped = true
    infoLbl.Parent = rightScroll
end)

-- =========================================================
-- TAB MOONWALK
-- =========================================================
makeTab("Moonwalk", "🕺", 10, function()
    sec("Moonwalk", "🕺")
    tog("Enable Moonwalk", false, function(s)
        if _G.Roooor_setMoonwalk then
            _G.Roooor_setMoonwalk(s)
        else
            Moonwalk.Enabled = s
        end
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Lock Moonwalk", false, function(s)
        Moonwalk.Locked = s
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Show MW Button", true, function(s)
        Moonwalk.ShowButton = s
        if mwBtnGui then mwBtnGui.Enabled = s end
    end)
    btn("Reset Posisi Tombol MW", function()
        if mwBtn then mwBtn.Position = UDim2.new(0, 20, 1, -100) end
        if mwLockBtn then mwLockBtn.Position = UDim2.new(0, 20, 1, -128) end
    end)
end, function()
    sec("Moonwalk Settings", "⚙️", rightScroll)
    sl("Spam Speed", 1, 50, 30, function(v) Moonwalk.SpamSpeed = v end, rightScroll)
    sl("Intensity", 1, 50, 35, function(v) Moonwalk.Intensity = v end, rightScroll)
    sl("Slow Speed", 5, 20, 13, function(v) Moonwalk.SlowSpeed = v end, rightScroll)
    tog("Use Slow Speed", true, function(s) Moonwalk.UseSlow = s end, rightScroll)
end)

print("[12/20] Tab Aimbot + Moonwalk OK")-- =========================================================
-- Section 13 : Loop Fitur + Stun Indicator + Camera Fix
-- =========================================================

-- =========================================================
-- MOONWALK BUTTON
-- =========================================================
function mwIsDowned()
    local char = LP.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    return hum.Health <= 0 or hum.Health < 2
end

function mwResetSpeed()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

function setMoonwalk(state)
    if Moonwalk.Locked and state ~= Moonwalk.Enabled then
        return false
    end
    Moonwalk.Enabled = state
    if not state then mwResetSpeed() end
    return true
end

_G.Roooor_setMoonwalk = setMoonwalk

if PG:FindFirstChild("MW_BottomBtn") then
    PG.MW_BottomBtn:Destroy()
end

mwBtnGui = Instance.new("ScreenGui")
mwBtnGui.Name = "MW_BottomBtn"
mwBtnGui.ResetOnSpawn = false
mwBtnGui.IgnoreGuiInset = true
mwBtnGui.Parent = PG

mwBtn = Instance.new("TextButton")
mwBtn.Size = UDim2.fromOffset(60, 60)
mwBtn.Position = UDim2.new(0, 20, 1, -100)
mwBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
mwBtn.Text = "MW"
mwBtn.TextColor3 = Color3.new(1, 1, 1)
mwBtn.TextSize = 16
mwBtn.Font = Enum.Font.GothamBlack
mwBtn.AutoButtonColor = false
mwBtn.Active = true
mwBtn.Draggable = true
mwBtn.Parent = mwBtnGui
rnd(mwBtn, 999)
local mwBtnStroke = strk(mwBtn, DIAMOND_BLUE, 2, 0.5)

mwLockBtn = Instance.new("TextButton")
mwLockBtn.Size = UDim2.fromOffset(60, 22)
mwLockBtn.Position = UDim2.new(0, 20, 1, -128)
mwLockBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 130)
mwLockBtn.Text = "UNLOCK"
mwLockBtn.TextColor3 = Color3.new(1, 1, 1)
mwLockBtn.TextSize = 10
mwLockBtn.Font = Enum.Font.GothamBold
mwLockBtn.AutoButtonColor = false
mwLockBtn.Parent = mwBtnGui
rnd(mwLockBtn, 999)
local mwLockStroke = strk(mwLockBtn, DIAMOND_BLUE, 1.5, 0.5)

function mwBtnUpdateUI()
    if Moonwalk.Enabled then
        mwBtn.Text = "MW ON"
        mwBtnStroke.Color = DIAMOND_LIGHT
        mwBtn.BackgroundColor3 = DIAMOND_MID
    else
        mwBtn.Text = "MW"
        mwBtnStroke.Color = DIAMOND_BLUE
        mwBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
    end
    if Moonwalk.Locked then
        mwLockBtn.Text = "LOCKED"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        mwLockBtn.Text = "UNLOCK"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 130)
    end
end

mwBtn.MouseButton1Click:Connect(function()
    if Moonwalk.Locked then
        mwBtn.Text = "X"
        task.delay(0.8, mwBtnUpdateUI)
        return
    end
    setMoonwalk(not Moonwalk.Enabled)
    mwBtnUpdateUI()
end)

mwLockBtn.MouseButton1Click:Connect(function()
    Moonwalk.Locked = not Moonwalk.Locked
    mwBtnUpdateUI()
end)

mwBtnUpdateUI()
_G.Roooor_mwBtnUpdateUI = mwBtnUpdateUI

RunService.RenderStepped:Connect(function()
    if Moonwalk.Enabled and not AP_ParryActive and not mwIsDowned() then
        local char = LP.Character
        if char and char.Parent then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
            if humanoid and hrp and cam then
                if Moonwalk.UseSlow and humanoid.WalkSpeed ~= Moonwalk.SlowSpeed then
                    humanoid.WalkSpeed = Moonwalk.SlowSpeed
                end
                local look = cam.CFrame.LookVector
                local flatLook = Vector3.new(look.X, 0, look.Z)
                if flatLook.Magnitude > 0 then
                    flatLook = flatLook.Unit
                    local baseCF = CFrame.new(hrp.Position, hrp.Position + flatLook)
                    local angle = math.sin(tick() * Moonwalk.SpamSpeed) * Moonwalk.Intensity
                    hrp.CFrame = baseCF * CFrame.Angles(0, math.rad(angle), 0)
                    humanoid:Move(Vector3.new(0, 0, 1), true)
                end
            end
        end
    end
end)

-- =========================================================
-- SKILL CHECK
-- =========================================================
function pressSpace()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

TouchID = 8822
ActionPath = "Survivor-mob.Controls.action.check"
SkillHeartbeat = nil
busy = false

function GetActionTarget()
    local current = PG
    for segment in string.gmatch(ActionPath, "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function TriggerMobileButton()
    local b = GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s, i = b.AbsolutePosition, b.AbsoluteSize, GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function()
            VirtualInputManager:SendTouchEvent(TouchID, 0, cx, cy)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(TouchID, 2, cx, cy)
        end)
    end
end

function startSkillCheck()
    if SkillHeartbeat then SkillHeartbeat:Disconnect() end
    SkillHeartbeat = RunService.RenderStepped:Connect(function()
        if not SkillCheck.Enabled or busy then return end
        local prompt = PG:FindFirstChild("SkillCheckPromptGui")
        if not prompt then return end
        local check = prompt:FindFirstChild("Check")
        if not check or not check.Visible then return end
        local line = check:FindFirstChild("Line")
        local goal = check:FindFirstChild("Goal")
        if not line or not goal then return end
        local lr = line.Rotation % 360
        local gr = goal.Rotation % 360

        if SkillCheck.Mode == "Instant" then
            local targetRot = (gr + 109) % 360
            pcall(function() line.Rotation = targetRot end)
            busy = true
            task.spawn(function()
                if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                SkillCheck.Success += 1
                SkillCheck.Total += 1
                task.wait(0.05)
                busy = false
            end)
            return
        end

        if SkillCheck.Mode == "Perfect" then
            local startRange = (gr + 102) % 360
            local endRange   = (gr + 116) % 360
            local success = (startRange > endRange and (lr >= startRange or lr <= endRange)) or (lr >= startRange and lr <= endRange)
            if success then
                busy = true
                task.spawn(function()
                    if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                    SkillCheck.Success += 1
                    SkillCheck.Total += 1
                    task.wait(0.05)
                    busy = false
                end)
            end
            return
        end
    end)
end

-- =========================================================
-- AUTO WIGGLE
-- =========================================================
task.spawn(function()
    while task.wait(1) do
        if not AutoParry.Wiggle then continue end
        local char = LP.Character
        if not char then continue end
        local carried = (char:FindFirstChild("IsCarried") and char.IsCarried.Value)
            or (char:FindFirstChild("IsCarrying") and char.IsCarrying.Value)
        if not carried then continue end
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then continue end
        local carry = remotes:FindFirstChild("Carry")
        if not carry then continue end
        local event = carry:FindFirstChild("SelfUnHookEvent")
        if not event then continue end
        for i = 1, (AutoParry.WiggleSpam or 5) do
            pcall(function() event:FireServer() end)
        end
    end
end)

-- =========================================================
-- AUTO FLEE
-- =========================================================
function GetNearestKillerForFlee()
    local root = getRoot()
    if not root then return nil, math.huge end
    local closest, shortest = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Team and plr.Team.Name == "Killer" and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = hrp
                end
            end
        end
    end
    return closest, shortest
end

task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end
        local killerRoot, distance = GetNearestKillerForFlee()
        if killerRoot and distance <= AutoFlee.DetectDistance
           and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = nil
            local farthest = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > farthest then
                        farthest = d
                        point = obj
                    end
                end
            end
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- =========================================================
-- INSTANT INTERACT
-- =========================================================
task.spawn(function()
    while task.wait(0.3) do
        if S.InstantInteract and LP.Character then
            local myRoot = getRoot()
            if myRoot then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local parent = obj.Parent
                        local pos
                        if parent:IsA("BasePart") then pos = parent.Position
                        elseif parent:IsA("Model") then pos = parent:GetPivot().Position end
                        if pos and (pos - myRoot.Position).Magnitude <= 12 then
                            pcall(function()
                                obj:InputHoldBegin()
                                task.wait(0.05)
                                obj:InputHoldEnd()
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- SPEED HACK
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= S.SpeedHackVal then
                hum.WalkSpeed = S.SpeedHackVal
            end
        end
    end
end)

-- =========================================================
-- WALK SPEED
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if S.WalkSpeed and not S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local target = S.WalkSpeedVal
                if hum.WalkSpeed ~= target then
                    hum.WalkSpeed = target
                end
            end
        end
    end
end)

-- =========================================================
-- ANTI-AFK
-- =========================================================
task.spawn(function()
    while task.wait(120) do
        if S.AntiAFK then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- =========================================================
-- KILL FEED
-- =========================================================
killFeedGui = Instance.new("ScreenGui")
killFeedGui.Name = "OneWKillFeed"
killFeedGui.ResetOnSpawn = false
killFeedGui.IgnoreGuiInset = true
killFeedGui.Parent = PG

local killFeedFrame = Instance.new("Frame")
killFeedFrame.Size = UDim2.new(0, 250, 0, 200)
killFeedFrame.Position = UDim2.new(1, -260, 0, 50)
killFeedFrame.BackgroundTransparency = 1
killFeedFrame.Parent = killFeedGui

local killFeedLayout = Instance.new("UIListLayout")
killFeedLayout.Padding = UDim.new(0, 4)
killFeedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
killFeedLayout.Parent = killFeedFrame

function addKillFeed(killerName, survivorName)
    if not S.KillFeed then return end
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 28)
    entry.BackgroundColor3 = Color3.fromRGB(20, 50, 120)
    entry.BackgroundTransparency = 0.2
    entry.BorderSizePixel = 0
    entry.Parent = killFeedFrame
    rnd(entry, 6)
    strk(entry, DIAMOND_BLUE, 1, 0.5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = killerName .. " > " .. survivorName
    lbl.TextColor3 = DIAMOND_LIGHT
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = entry

    task.spawn(function()
        task.wait(4)
        TweenService:Create(entry, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.6)
        entry:Destroy()
    end)
end

task.spawn(function()
    local lastHealth = {}
    while task.wait(0.5) do
        if not S.KillFeed then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local prevHP = lastHealth[p] or hum.Health
                    if prevHP > 0 and hum.Health <= 0 then
                        local killerName = "???"
                        if p:GetAttribute("LastAttacker") then
                            killerName = p:GetAttribute("LastAttacker")
                        end
                        addKillFeed(killerName, p.Name)
                    end
                    lastHealth[p] = hum.Health
                end
            end
        end
    end
end)

-- =========================================================
-- STUN INDICATOR
-- =========================================================
local function CreateStunBillboard(char)
    local head = char:FindFirstChild("Head")
    if not head then return nil end
    local old = head:FindFirstChild("OneWStunBillboard")
    if old then old:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OneWStunBillboard"
    billboard.Size = UDim2.new(0, 120, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 4.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = head
    billboard.Parent = head

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = billboard

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, 0, 0, 16)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "⚡ STUNNED ⚡"
    titleLbl.TextColor3 = DIAMOND_LIGHT
    titleLbl.TextStrokeTransparency = 0
    titleLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    titleLbl.TextSize = 14
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.Parent = container

    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.Size = UDim2.new(1, 0, 0, 10)
    barBg.Position = UDim2.new(0, 0, 0, 20)
    barBg.BackgroundColor3 = Color3.fromRGB(10, 25, 60)
    barBg.BorderSizePixel = 0
    barBg.Parent = container
    rnd(barBg, 999)

    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = DIAMOND_BLUE
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    rnd(barFill, 999)

    local timerLbl = Instance.new("TextLabel")
    timerLbl.Name = "TimerLbl"
    timerLbl.Size = UDim2.new(1, 0, 0, 14)
    timerLbl.Position = UDim2.new(0, 0, 0, 32)
    timerLbl.BackgroundTransparency = 1
    timerLbl.Text = "0.0s"
    timerLbl.TextColor3 = DIAMOND_LIGHT
    timerLbl.TextSize = 11
    timerLbl.Font = Enum.Font.GothamBold
    timerLbl.Parent = container

    return billboard
end

local function PlayStunSound(char)
    local head = char:FindFirstChild("Head")
    if not head then return end
    local oldSound = head:FindFirstChild("OneWStunSound")
    if oldSound then oldSound:Destroy() end

    local sound = Instance.new("Sound")
    sound.Name = "OneWStunSound"
    sound.SoundId = STUN_SOUND_ID
    sound.Volume = 1.5
    sound.RollOffMaxDistance = 100
    sound.RollOffMinDistance = 5
    sound.Parent = head
    sound:Play()
    task.delay(6, function()
        if sound and sound.Parent then sound:Destroy() end
    end)
end

local function IsKillerStunned(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return false end
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        local anim = track.Animation
        if anim and anim.AnimationId then
            local id = anim.AnimationId:match("%d+")
            if id == STUN_ANIM_ID then return true end
        end
    end
    return false
end

local function StartStun(char)
    if StunIndicator.ActiveStuns[char] then return end
    local billboard = CreateStunBillboard(char)
    if not billboard then return end
    PlayStunSound(char)
    StunIndicator.ActiveStuns[char] = {
        billboard = billboard,
        startTime = tick(),
        duration = STUN_DURATION,
    }
end

function EndStun(char)
    local data = StunIndicator.ActiveStuns[char]
    if not data then return end
    if data.billboard and data.billboard.Parent then
        data.billboard:Destroy()
    end
    StunIndicator.ActiveStuns[char] = nil
end

task.spawn(function()
    while task.wait(0.1) do
        if not StunIndicator.Enabled then
            for char, _ in pairs(StunIndicator.ActiveStuns) do EndStun(char) end
            continue
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local char = p.Character
                if IsKillerStunned(char) then
                    if not StunIndicator.ActiveStuns[char] then
                        StartStun(char)
                    end
                    local data = StunIndicator.ActiveStuns[char]
                    if data and data.billboard and data.billboard.Parent then
                        local elapsed = tick() - data.startTime
                        local remaining = math.max(0, data.duration - elapsed)
                        local progress = remaining / data.duration
                        local container = data.billboard:FindFirstChild("Container")
                        if container then
                            local barBg = container:FindFirstChild("BarBg")
                            if barBg then
                                local barFill = barBg:FindFirstChild("BarFill")
                                local timerLbl = container:FindFirstChild("TimerLbl")
                                if barFill then barFill.Size = UDim2.new(progress, 0, 1, 0) end
                                if timerLbl then timerLbl.Text = string.format("%.1fs", remaining) end
                            end
                        end
                        if remaining <= 0 then EndStun(char) end
                    end
                else
                    if StunIndicator.ActiveStuns[char] then EndStun(char) end
                end
            end
        end
    end
end)

-- =========================================================
-- MAIN ESP LOOP
-- =========================================================
local lastESPUpdate = 0
RunService.Heartbeat:Connect(function()
    local root = getRoot()
    if not root then return end
    local now = tick()
    if now - lastESPUpdate >= 0.2 then
        lastESPUpdate = now
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = (hrp.Position - root.Position).Magnitude
                        if distance <= ESP.Distance then
                            if ESP.Survivor and p.Team and p.Team.Name == "Survivors" then
                                createESP(char, TeamColors.Survivor)
                            elseif ESP.Killer and p.Team and p.Team.Name == "Killer" then
                                createESP(char, TeamColors.Killer)
                            else
                                removeESP(char)
                            end
                        else
                            removeESP(char)
                        end
                    end
                    createStatusESP(p, char, root)
                else
                    removeESP(char)
                end
            end
        end
        if ESP.Generator then
            for gen in pairs(Cached.Generators) do
                UpdateGenerator(gen)
            end
        end
        for obj in pairs(Cached.Windows) do UpdateMapESP(obj, root) end
        for obj in pairs(Cached.Pallets) do UpdateMapESP(obj, root) end
        UpdateSCPEsp(root)
        if S.NoScreenEffects then applyNoScreenEffects() end
        if S.LowGraphics then applyLowGraphics() end
        if S.CleanSky then applyCleanSky() end
    end
end)

-- =========================================================
-- KILL EFFECT LOOP
-- =========================================================
task.spawn(function()
    while task.wait(2) do
        if S.KillEffect then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health <= 0 then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and not p.Character:GetAttribute("OneWKillEffect") then
                            p.Character:SetAttribute("OneWKillEffect", true)
                            spawnKillEffect(hrp.Position)
                        end
                    else
                        if p.Character:GetAttribute("OneWKillEffect") then
                            p.Character:SetAttribute("OneWKillEffect", false)
                        end
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- NO CLIP
-- =========================================================
task.spawn(function()
    while task.wait(0.15) do
        if S.NoClip and LP.Character then
            for _, v in ipairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- =========================================================
-- NO CLIP CAMERA
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        local cam = workspace.CurrentCamera
        if cam then
            cam.CanCollide = not S.NoClipCamera
        end
    end
end)

-- =========================================================
-- CAMERA FIX
-- =========================================================
AP_LastCamFix = 0

task.spawn(function()
    while task.wait(0.03) do
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not cam or not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end
        if AimbotSenter.Enabled and AimbotSenter.HoldingSenter then continue end
        if Aimlock.Enabled and Aimlock.Holding then continue end
        if GuiService.SelectedObject then continue end

        local needFix = false
        if cam.CameraType ~= Enum.CameraType.Custom then needFix = true end
        if cam.CameraSubject ~= hum then needFix = true end

        local state = hum:GetState()
        if state == Enum.HumanoidStateType.FallingDown
            or state == Enum.HumanoidStateType.Ragdoll
            or state == Enum.HumanoidStateType.PlatformStanding
            or state == Enum.HumanoidStateType.Physics then
            needFix = true
        end

        if char:GetAttribute("Downed") == true
            or char:GetAttribute("IsDown") == true
            or char:GetAttribute("Knocked") == true then
            needFix = true
        end

        if needFix then
            local now = tick()
            if now - AP_LastCamFix > 0.05 then
                AP_LastCamFix = now
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.CameraMode = Enum.CameraMode.Classic
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                end)
            end
        end
    end
end)

-- =========================================================
-- KEYBIND V & K
-- =========================================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.V then
        if Moonwalk.Locked then return end
        setMoonwalk(not Moonwalk.Enabled)
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.K then
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if cam and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                    GuiService.SelectedObject = nil
                end)
            end
        end
    end
end)

-- =========================================================
-- ANTI-ILANG
-- =========================================================
local function forceAllGuiResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        pcall(forceAllGuiResetOnSpawnFalse)
    end
end)

-- =========================================================
-- KILL FOG AUTO
-- =========================================================
task.spawn(function()
    while task.wait(0.5) do
        if S.KillFog then
            if Lighting.FogEnd < 100000 then
                Lighting.FogEnd = 1000000
                Lighting.FogStart = 1000000
            end
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") and v.Density > 0 then
                    v.Density = 0
                    v.Haze = 0
                    v.Glare = 0
                end
            end
        end
    end
end)

print("[13/20] Loop Fitur + Stun Indicator + Camera Fix + Kill Fog Auto OK")-- =========================================================
-- Section 15 : Auto-ON + Print Final
-- =========================================================

task.spawn(function()
    task.wait(2)

    ESP.Survivor = true
    _G.ToggleStates["ESP Survivor"] = true

    ESP.Killer = true
    _G.ToggleStates["ESP Killer"] = true

    ESP.Generator = true
    _G.ToggleStates["ESP Generator"] = true

    S.ESPGenMode = "Bar"
    _G.DropdownStates["Generator Mode"] = 2

    S.ESPGenBarSize = 64
    _G.SliderStates["Bar Width"] = 64

    S.ESPGenBarHeight = 8
    _G.SliderStates["Bar Height"] = 8

    S.ESPGenBarTextSize = 6
    _G.SliderStates["Text Size"] = 6

    S.ESPNameMode = "Galaxy"
    _G.DropdownStates["Name Mode"] = 2

    S.ESPNameSize = 8
    _G.SliderStates["Name Size"] = 8

    S.Korblox = true
    _G.ToggleStates["Enable Korblox"] = true
    task.wait(0.3)
    pcall(function() applyKorblox(true, "Pencil", 0.80, 1) end)

    S.Headless = true
    _G.ToggleStates["Headless"] = true
    task.wait(0.3)
    pcall(function() applyHeadless(true) end)

    StunIndicator.Enabled = true
    _G.ToggleStates["Enable Stun Sound"] = true

    S.ShowFPS = true
    S.ShowPing = true
    _G.ToggleStates["Show FPS Counter"] = true
    _G.ToggleStates["Show Ping Counter"] = true

    S.KillFog = true
    _G.ToggleStates["Kill VD Fog"] = true
    pcall(function() applyKillFog(true) end)

    print("[AUTO-ON] ESP Survivor/Killer/Generator: ON")
    print("[AUTO-ON] Korblox + Headless: ON")
    print("[AUTO-ON] Stun Indicator: ON")
    print("[AUTO-ON] FPS + Ping: ON")
    print("[AUTO-ON] Kill Fog: ON")
end)

task.spawn(function()
    task.wait(2.5)
    pcall(function()
        local banner = Instance.new("ScreenGui")
        banner.Name = "OneWBanner"
        banner.ResetOnSpawn = false
        banner.IgnoreGuiInset = true
        banner.DisplayOrder = 999998
        banner.Parent = PG

        local bg2 = Instance.new("Frame")
        bg2.Size = UDim2.new(0, 340, 0, 64)
        bg2.Position = UDim2.new(0.5, -170, 0, -80)
        bg2.BackgroundColor3 = C.BG
        bg2.BackgroundTransparency = 0.05
        bg2.BorderSizePixel = 0
        bg2.Parent = banner
        rnd(bg2, 12)
        strk(bg2, DIAMOND_BLUE, 2, 0.2)

        local grad = Instance.new("UIGradient")
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 50, 120)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 160, 240)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 50, 120)),
        })
        grad.Rotation = 45
        grad.Parent = bg2

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 26)
        title.Position = UDim2.new(0, 0, 0, 10)
        title.BackgroundTransparency = 1
        title.Text = "ONE W + ALF LOADED"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 16
        title.Font = Enum.Font.GothamBlack
        title.TextStrokeTransparency = 0.5
        title.TextStrokeColor3 = Color3.fromRGB(20, 60, 120)
        title.Parent = bg2

        local sub = Instance.new("TextLabel")
        sub.Size = UDim2.new(1, 0, 0, 18)
        sub.Position = UDim2.new(0, 0, 0, 36)
        sub.BackgroundTransparency = 1
        sub.Text = "60 Fire • 18 Sky • 32 Lagu • Crosshair 10 Style • Auto Parry ALF + Wisnu"
        sub.TextColor3 = Color3.fromRGB(180, 230, 255)
        sub.TextSize = 9
        sub.Font = Enum.Font.GothamBold
        sub.Parent = bg2

        TweenService:Create(bg2, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
            Position = UDim2.new(0.5, -170, 0, 20)
        }):Play()

        task.wait(3.5)
        TweenService:Create(bg2, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, -170, 0, -80)
        }):Play()
        task.wait(0.6)
        banner:Destroy()
    end)
end)

task.delay(4, function()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "ONE W + ALF",
            Text = "60 Fire • 32 Lagu • Crosshair 10 Style • Auto Parry ALF + Wisnu\nRightShift = Buka Menu",
            Duration = 5
        })
    end)
end)

task.wait(0.5)

print("")
print("==========================================")
print("  ONE W + ALFZXZZZ MEGA HUB")
print("  SEMUA 20 SECTION LOADED")
print("==========================================")
print("  Keybind:")
print("    RightShift = Buka Menu")
print("    V = Moonwalk")
print("    K = Unlock Camera")
print("------------------------------------------")
print("  10 TAB UTAMA:")
print("    1. Survivor   (Auto Parry ALF v1 + Wisnu v2)")
print("    2. Killer     (Hitbox + Spoof)")
print("    3. ESP")
print("    4. Fire       (60 efek)")
print("    5. Musik      (32 lagu)")
print("    6. Misc")
print("    7. Visual     (Crosshair 10 Style)")
print("    8. Grafik Ultra")
print("    9. Aimbot")
print("   10. Moonwalk")
print("------------------------------------------")
print("  FITUR ALF YANG DIMASUKIN:")
print("    - Auto Parry ALF v1 (Original)")
print("    - Wisnu Auto Parry v2")
print("    - (Lanjut Section 16-20)")
print("==========================================")
print("")
print("ALL SECTIONS 1-15 COMPLETE!")
print("Lanjut Section 16-20 untuk fitur ALF lainnya")-- =========================================================
-- Section 16 : Killer+ (18 fitur ALF)
-- =========================================================

-- =========================================================
-- KILLER: BYPASS HIDDEN LEAP
-- =========================================================
getgenv().Bypass_HiddenLeapBypassThread = nil

function BYPASS_StartHiddenCooldownBypass()
    if getgenv().Bypass_HiddenLeapBypassThread then return end
    if not debug or not debug.getupvalues or not getgc then return end
    getgenv().Bypass_HiddenLeapBypassThread = task.spawn(function()
        local leapFunction, m2Function
        local function scanGC()
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local info
                        pcall(function() info = debug.getinfo(v) end)
                        if info then
                            if info.name == "tryActivate" then leapFunction = v
                            elseif info.name == "playM2Animation" then m2Function = v end
                        end
                    end
                    if leapFunction and m2Function then break end
                end
            end)
        end
        scanGC()
        local lastScan = os.clock()
        while task.wait(0.1) do
            if not ALF.KILLER_BypassLeap then break end
            if not (leapFunction and m2Function) then
                if os.clock() - lastScan >= 2 then lastScan = os.clock(); scanGC() end
            end
            if leapFunction then
                pcall(function()
                    for i, val in pairs(debug.getupvalues(leapFunction)) do
                        if type(val) == "boolean" and val == true then
                            debug.setupvalue(leapFunction, i, false)
                        end
                    end
                end)
            end
            if m2Function then
                pcall(function()
                    for i, val in pairs(debug.getupvalues(m2Function)) do
                        if type(val) == "boolean" and val == true then
                            debug.setupvalue(m2Function, i, false)
                        end
                    end
                end)
            end
        end
        getgenv().Bypass_HiddenLeapBypassThread = nil
    end)
end

function BYPASS_StopHiddenCooldownBypass() end

function BYPASS_SetHiddenLeap(v)
    ALF.KILLER_BypassLeap = v and true or false
    if ALF.KILLER_BypassLeap then BYPASS_StartHiddenCooldownBypass()
    else BYPASS_StopHiddenCooldownBypass() end
end

-- =========================================================
-- KILLER: MYERS INFINITE GRAB
-- =========================================================
MyersGrabData = { Enabled = false, HotkeyCode = Enum.KeyCode.H }

function getMyersTarget()
    local char = LP.Character
    if not char then return nil end
    local myHRP = char:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    local candidates = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                table.insert(candidates, {
                    player = player, dist = (hrp.Position - myHRP.Position).Magnitude, health = hum.Health
                })
            end
        end
    end
    table.sort(candidates, function(a, b) return a.dist < b.dist end)
    for _, c in ipairs(candidates) do return c.player end
    return nil
end

function doMyersGrab()
    if not MyersGrabData.Enabled then return end
    local target = getMyersTarget()
    if not target or not target.Character then return end
    pcall(function()
        ReplicatedStorage.Remotes.Killers.Stalker.grab:FireServer(target.Character)
    end)
end

function setMyersGrab(v)
    MyersGrabData.Enabled = v and true or false
    ALF.KILLER_InfGrab = MyersGrabData.Enabled
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
        doMyersGrab()
    end
end)

-- =========================================================
-- KILLER: SLASHER BYPASS (LakeMist + Pursuit)
-- =========================================================
getgenv().MAWWW_SlasherCooldownBypassThread = nil

function MAWWW_StartSlasherCooldownBypass()
    if getgenv().MAWWW_SlasherCooldownBypassThread then return end
    pcall(function()
        local b = true
        local mt = debug.getmetatable(b)
        if not mt then mt = {}; debug.setmetatable(b, mt) end
        if setreadonly then setreadonly(mt, false) end
        mt.__div = function() return 0 end
        mt.__mul = function() return 0 end
        mt.__add = function() return 0 end
        mt.__sub = function() return 0 end
        if setreadonly then setreadonly(mt, true) end
    end)
    if not getgc then return end
    getgenv().MAWWW_SlasherCooldownBypassThread = task.spawn(function()
        local toggleFunc = nil
        local pursuitHandler = nil
        local function scanGCForSlasher()
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local consts = debug.getconstants(v)
                        local hasOffset, hasLinear, hasAction, hasTweenInfo = false, false, false, false
                        local hasPursuit, hasWalkSpeed = false, false
                        for _, c in pairs(consts) do
                            if c == "Offset" then hasOffset = true end
                            if c == "Linear" then hasLinear = true end
                            if c == "action" then hasAction = true end
                            if c == "TweenInfo" then hasTweenInfo = true end
                            if c == "Pursuit" then hasPursuit = true end
                            if c == "WalkSpeed" then hasWalkSpeed = true end
                        end
                        if hasOffset and hasLinear and hasAction and hasTweenInfo and not hasPursuit then toggleFunc = v end
                        if hasPursuit and hasTweenInfo and hasAction and hasWalkSpeed then pursuitHandler = v end
                    end
                    if toggleFunc and pursuitHandler then break end
                end
            end)
        end
        scanGCForSlasher()
        local lastScan = os.clock()
        while task.wait(0.1) do
            if not ALF.KILLER_InfLakeMist and not ALF.KILLER_InfPursuit then break end
            if not (toggleFunc and pursuitHandler) then
                if os.clock() - lastScan >= 2 then scanGCForSlasher(); lastScan = os.clock() end
            end
            if toggleFunc and ALF.KILLER_InfLakeMist then
                pcall(function()
                    debug.setupvalue(toggleFunc, 6, false)
                    debug.setupvalue(toggleFunc, 10, false)
                end)
            end
            if pursuitHandler and ALF.KILLER_InfPursuit then
                pcall(function()
                    debug.setupvalue(pursuitHandler, 5, false)
                    debug.setupvalue(pursuitHandler, 6, false)
                end)
            end
        end
        getgenv().MAWWW_SlasherCooldownBypassThread = nil
    end)
end

function MAWWW_StopSlasherCooldownBypass()
    pcall(function()
        local jason = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Killers")
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Jason")
        if jason then
            if not ALF.KILLER_InfLakeMist then
                local lm = jason:FindFirstChild("LakeMist")
                if lm then lm:FireServer(false) end
            end
            if not ALF.KILLER_InfPursuit then
                local ps = jason:FindFirstChild("Pursuit")
                if ps then ps:FireServer(false) end
            end
        end
    end)
end

function MAWWW_SetLakeMist(v)
    ALF.KILLER_InfLakeMist = v and true or false
    if ALF.KILLER_InfLakeMist or ALF.KILLER_InfPursuit then MAWWW_StartSlasherCooldownBypass()
    else MAWWW_StopSlasherCooldownBypass() end
end

function MAWWW_SetPursuit(v)
    ALF.KILLER_InfPursuit = v and true or false
    if ALF.KILLER_InfLakeMist or ALF.KILLER_InfPursuit then MAWWW_StartSlasherCooldownBypass()
    else MAWWW_StopSlasherCooldownBypass() end
end

-- =========================================================
-- KILLER: ABYSS BYPASS COOLDOWN
-- =========================================================
getgenv().MAWWW_AbyssCooldownBypassConnection = nil
getgenv().MAWWW_CorruptHandlerFunc = nil

function MAWWW_StartAbyssCooldownBypass()
    if not getgenv().MAWWW_CorruptHandlerFunc and getgc then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "function" and islclosure(v) then
                    local constants = debug.getconstants(v)
                    if table.find(constants, "corrupt") and table.find(constants, "Immobile") then
                        getgenv().MAWWW_CorruptHandlerFunc = v
                        break
                    end
                end
            end
        end)
    end
    if not getgenv().MAWWW_CorruptHandlerFunc then return end
    if getgenv().MAWWW_AbyssCooldownBypassConnection then
        getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
    end
    getgenv().MAWWW_AbyssCooldownBypassConnection = RunService.Heartbeat:Connect(function()
        if not ALF.KILLER_BypassCooldown then return end
        if getgenv().MAWWW_CorruptHandlerFunc then
            local upvalues = debug.getupvalues(getgenv().MAWWW_CorruptHandlerFunc)
            for idx, val in pairs(upvalues) do
                if type(val) == "boolean" and val == false then
                    debug.setupvalue(getgenv().MAWWW_CorruptHandlerFunc, idx, true)
                end
            end
        end
    end)
end

function MAWWW_StopAbyssCooldownBypass()
    if getgenv().MAWWW_AbyssCooldownBypassConnection then
        getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
        getgenv().MAWWW_AbyssCooldownBypassConnection = nil
    end
end

function MAWWW_SetAbyssBypass(v)
    ALF.KILLER_BypassCooldown = v and true or false
    if ALF.KILLER_BypassCooldown then MAWWW_StartAbyssCooldownBypass()
    else MAWWW_StopAbyssCooldownBypass() end
end

-- =========================================================
-- KILLER: JEFF INFINITE FRENZY
-- =========================================================
getgenv().MAWWW_JeffCooldownBypassThread = nil

function MAWWW_StartJeffCooldownBypass()
    if getgenv().MAWWW_JeffCooldownBypassThread then return end
    getgenv().MAWWW_JeffCooldownBypassThread = task.spawn(function()
        while task.wait() do
            if not ALF.KILLER_InfFrenzy then break end
            pcall(function()
                local char = LP.Character
                if char and char:GetAttribute("Frenzy") ~= true then
                    char:SetAttribute("Frenzy", true)
                end
            end)
        end
        getgenv().MAWWW_JeffCooldownBypassThread = nil
    end)
end

function MAWWW_StopJeffCooldownBypass()
    pcall(function()
        local char = LP.Character
        if char and char:GetAttribute("Frenzy") == true then
            char:SetAttribute("Frenzy", false)
            local killer = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Killers")
                and ReplicatedStorage.Remotes.Killers:FindFirstChild("Killer")
            if killer then
                local deact = killer:FindFirstChild("Deactivatefromclient")
                if deact then deact:FireServer() end
            end
        end
    end)
end

function MAWWW_SetJeffFrenzy(v)
    ALF.KILLER_InfFrenzy = v and true or false
    if ALF.KILLER_InfFrenzy then MAWWW_StartJeffCooldownBypass()
    else MAWWW_StopJeffCooldownBypass() end
end

-- =========================================================
-- KILLER: ANTI BLIND
-- =========================================================
function SetupAntiBlind()
    pcall(function()
        local r  = ReplicatedStorage:FindFirstChild("Remotes")
        local i  = r and r:FindFirstChild("Items")
        local fl = i and i:FindFirstChild("Flashlight")
        local gb = fl and fl:FindFirstChild("GotBlinded")
        if not (gb and gb:IsA("RemoteEvent")) then return end
        if not getrawmetatable or not setreadonly or not hookmetamethod then return end

        local ok, mt = pcall(function() return getrawmetatable(game) end)
        if ok and mt then
            pcall(function()
                setreadonly(mt, false)
                local old = mt.__namecall
                mt.__namecall = newcclosure(function(self, ...)
                    if not checkcaller() and getgenv().Roooor_ALF and getgenv().Roooor_ALF.KILLER_AntiBlind and self == gb then
                        local method = getnamecallmethod()
                        if method == "FireServer" then
                            return nil
                        end
                    end
                    return old(self, ...)
                end)
                setreadonly(mt, true)
            end)
        end
    end)
end

pcall(SetupAntiBlind)

-- =========================================================
-- KILLER: DESTROY PALLET
-- =========================================================
getgenv().MAWWW_IsBreakingPallet = false

function MAWWW_DestroyAllPallets()
    if not ALF.KILLER_DestroyPallets then return end
    if getgenv().MAWWW_IsBreakingPallet then return end

    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then return end

    local stunned = char:GetAttribute("IsStunned") or char:GetAttribute("isStunned")
    local immobile = char:GetAttribute("Immobile") or char:GetAttribute("immobile")
    local carrying = char:GetAttribute("IsCarrying") or char:GetAttribute("isCarrying")
    local ci = char:FindFirstChild("CheckInterractable")
    local action = ci and (ci:GetAttribute("action") or ci:GetAttribute("Action"))
    if stunned or immobile or carrying or action then return end

    local pts = CollectionService:GetTagged("PalletPointSlide")
    local nearest, minDist = nil, 6
    for _, p in ipairs(pts) do
        if p:IsA("BasePart") and not CollectionService:HasTag(p, "doing action") then
            local d = (p.Position - root.Position).Magnitude
            if d < minDist then minDist = d; nearest = p end
        end
    end
    if not nearest then return end

    getgenv().MAWWW_IsBreakingPallet = true
    task.spawn(function()
        pcall(function()
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local pFold = r and r:FindFirstChild("Pallet")
            local j = pFold and pFold:FindFirstChild("Jason")
            if j then
                local dg = j:FindFirstChild("Destroy-Global")
                local commit = j:FindFirstChild("PalletBreakCommit")
                if dg and dg:IsA("RemoteEvent") then dg:FireServer(nearest) end
                if commit and commit:IsA("RemoteEvent") then commit:FireServer(nearest) end
            end
        end)
        task.wait(0.2)
        local start = os.clock()
        while char and char.Parent and (char:GetAttribute("Immobile") or char:GetAttribute("immobile")) do
            if os.clock() - start > 3 then break end
            task.wait(0.1)
        end
        getgenv().MAWWW_IsBreakingPallet = false
    end)
end

-- =========================================================
-- KILLER: INFINITE LUNGE
-- =========================================================
VD_OriginalLungeBoost = nil

function VD_UpdateInfiniteLunge()
    local char = LP.Character
    if not char then return end

    if ALF.KILLER_InfLunge then
        if char:GetAttribute("lungeboost") ~= 999999 then
            VD_OriginalLungeBoost = char:GetAttribute("lungeboost") or 1
            char:SetAttribute("lungeboost", 999999)
        end
    else
        if VD_OriginalLungeBoost then
            char:SetAttribute("lungeboost", VD_OriginalLungeBoost)
            VD_OriginalLungeBoost = nil
        end
    end
end

LP.CharacterRemoving:Connect(function()
    VD_OriginalLungeBoost = nil
end)

-- =========================================================
-- KILLER: AUTO HOOK
-- =========================================================
local IsAutoHooking = false

local function GetMapCacheHooks()
    local hooks = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return hooks end
    for _, obj in ipairs(map:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Hook" then
            local hp = obj:FindFirstChild("HookPoint")
                or obj:FindFirstChild("HookHitbox")
                or obj:FindFirstChildWhichIsA("BasePart", true)
            if hp then table.insert(hooks, { model = obj, part = hp }) end
        end
    end
    return hooks
end

local function IsPlayerOnHook(character, hooks)
    local tr = character:FindFirstChild("HumanoidRootPart")
    if not tr then return false end
    for _, h in ipairs(hooks) do
        if (h.part.Position - tr.Position).Magnitude < 6 then return true end
    end
    return false
end

local function IsPlayerCarried(character)
    return character:GetAttribute("IsCarried") == true
end

local function FindDownedSurvivor(hooks)
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, nil end
    local closest, closestDist, closestChar = nil, math.huge, nil
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == LP or not pl.Character then continue end
        if not (pl.Team and pl.Team.Name == "Survivors") then continue end
        local tr = pl.Character:FindFirstChild("HumanoidRootPart")
        local h = pl.Character:FindFirstChildOfClass("Humanoid")
        if not tr or not h then continue end
        local pct = h.MaxHealth > 0 and (h.Health / h.MaxHealth) or 0
        if pct > 0.25 or pct <= 0 then continue end
        if IsPlayerOnHook(pl.Character, hooks) then continue end
        if IsPlayerCarried(pl.Character) then continue end
        local d = (tr.Position - myRoot.Position).Magnitude
        if d < closestDist then
            closestDist = d
            closest = tr
            closestChar = pl.Character
        end
    end
    return closest, closestChar
end

local function FindNearestHook(targetPos, hooks)
    local closest, closestDist = nil, math.huge
    for _, h in ipairs(hooks) do
        local d = (h.part.Position - targetPos).Magnitude
        if d < closestDist then closestDist = d; closest = h end
    end
    return closest
end

local function DoAutoHook()
    if not ALF.KILLER_AutoHook then return end
    if IsAutoHooking then return end
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local hooks = GetMapCacheHooks()
    if #hooks == 0 then return end
    local targetRoot, targetChar = FindDownedSurvivor(hooks)
    if not targetRoot then return end
    local nearestHook = FindNearestHook(targetRoot.Position, hooks)
    if not nearestHook then return end

    IsAutoHooking = true
    task.spawn(function()
        local CarryEvent, HookEvent, HookCommit
        pcall(function()
            local carryFolder = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Carry")
            CarryEvent = carryFolder:FindFirstChild("CarrySurvivorEvent")
            HookEvent  = carryFolder:FindFirstChild("HookEvent")
            HookCommit = carryFolder:FindFirstChild("HookCommit")
        end)
        pcall(function()
            root.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0), targetRoot.Position)
        end)
        task.wait(0.2)
        pcall(function() if CarryEvent then CarryEvent:FireServer(targetChar) end end)
        task.wait(0.5)
        local r2 = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not r2 then IsAutoHooking = false; return end
        pcall(function()
            r2.CFrame = CFrame.new(nearestHook.part.Position + Vector3.new(0, 3, 0))
        end)
        task.wait(0.3)
        pcall(function()
            local hookPoint = nearestHook.model:FindFirstChild("HookPoint")
                or nearestHook.model:FindFirstChild("HookHitbox")
                or nearestHook.part
            if HookEvent then HookEvent:FireServer(hookPoint) end
            if HookCommit then HookCommit:FireServer(hookPoint) end
        end)
        task.wait(1)
        IsAutoHooking = false
    end)
end

function KA_StartAutoHook()
    if _G.Roooor_AutoHookThread then return end
    _G.Roooor_AutoHookThread = task.spawn(function()
        while ALF.KILLER_AutoHook do
            pcall(DoAutoHook)
            task.wait(1)
        end
        _G.Roooor_AutoHookThread = nil
    end)
end

function KA_StopAutoHook()
    if _G.Roooor_AutoHookThread then
        pcall(function() task.cancel(_G.Roooor_AutoHookThread) end)
        _G.Roooor_AutoHookThread = nil
    end
end

function KA_SetAutoHook(v)
    ALF.KILLER_AutoHook = v and true or false
    if ALF.KILLER_AutoHook then KA_StartAutoHook() else KA_StopAutoHook() end
end

-- =========================================================
-- KILLER: ABILITIES (AutoStalk, AutoKillAll, DropPallet, BlockVault)
-- =========================================================
KillerAbilities = {
    AutoStalk = ALF.KA_AutoStalk,
    AutoStalkRange = ALF.KA_AutoStalkRange,
    AutoKillAll = ALF.KA_AutoKillAll,
    DropAllPallet = ALF.KA_DropAllPallet,
    BlockAllVault = ALF.KA_BlockAllVault,
}
KA = KillerAbilities

function KA_GetClosestSurvivor(range, minHealth)
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closest, shortest = nil, (range or math.huge)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Team and plr.Team.Name == "Survivors" then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > (minHealth or 30) then
                local d = (hrp.Position - root.Position).Magnitude
                if d <= shortest then shortest = d; closest = plr end
            end
        end
    end
    return closest
end

local AutoStalkConnection = nil

function KA_StartAutoStalk()
    if AutoStalkConnection then return end
    AutoStalkConnection = RunService.Heartbeat:Connect(function()
        if not KA.AutoStalk then return end
        local target = KA_GetClosestSurvivor(KA.AutoStalkRange, 30)
        if not target or not target.Character then return end
        local stalkEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Stalker", true)
            and ReplicatedStorage.Remotes.Killers.Stalker:FindFirstChild("StartStalking")
        if stalkEvent then pcall(function() stalkEvent:FireServer(target) end) end
    end)
end

function KA_StopAutoStalk()
    if AutoStalkConnection then
        pcall(function() AutoStalkConnection:Disconnect() end)
        AutoStalkConnection = nil
    end
end

function KA_SetAutoStalk(v)
    KA.AutoStalk = v and true or false
    ALF.KA_AutoStalk = KA.AutoStalk
    if KA.AutoStalk then KA_StartAutoStalk() else KA_StopAutoStalk() end
end

local KillAllTarget = nil

function KA_UpdateKillAll()
    if not KA.AutoKillAll then KillAllTarget = nil; return end
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local tChar = KillAllTarget and KillAllTarget.Character
    if not KillAllTarget or not tChar or not tChar.Parent
        or not tChar:FindFirstChild("Humanoid") or tChar.Humanoid.Health <= 35 then
        KillAllTarget = KA_GetClosestSurvivor(math.huge, 30)
        tChar = KillAllTarget and KillAllTarget.Character
    end
    if KillAllTarget and tChar then
        local targetHRP = tChar:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            local velocity  = targetHRP.AssemblyLinearVelocity
            local predict   = velocity * 0.15
            local targetPos = targetHRP.Position + predict
            local behind    = targetHRP.CFrame.LookVector * -3
            root.CFrame = CFrame.new(targetPos + behind, targetPos)
        end
        pcall(function()
            local attacks = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
            local basic = attacks and attacks:FindFirstChild("BasicAttack")
            if basic then basic:FireServer(false) end
        end)
    end
end

function KA_SetAutoKillAll(v)
    KA.AutoKillAll = v and true or false
    ALF.KA_AutoKillAll = KA.AutoKillAll
    if not KA.AutoKillAll then KillAllTarget = nil end
end

local lastDropAllPallet = 0

function KA_DropAllPallets()
    if not KA.DropAllPallet then return end
    local now = tick()
    if now - lastDropAllPallet < 2 then return end
    lastDropAllPallet = now
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local palletFold = remotes and remotes:FindFirstChild("Pallet")
        local dropEvent = palletFold and palletFold:FindFirstChild("PalletDropEvent")
        if not dropEvent then return end
        local map = workspace:FindFirstChild("Map")
        if not map then return end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
                local target = obj:FindFirstChild("PalletPointSlide") or obj:FindFirstChild("PalletPoint")
                if target then pcall(function() dropEvent:FireServer(target) end) end
            end
        end
    end)
end

function KA_SetDropAllPallet(v)
    KA.DropAllPallet = v and true or false
    ALF.KA_DropAllPallet = KA.DropAllPallet
end

local lastBlockVault = 0

function KA_BlockAllVaults()
    if not KA.BlockAllVault then return end
    local VaultEvent = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Window")
        and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultEvent")
    if not VaultEvent then return end
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    for _, trigger in ipairs(map:GetDescendants()) do
        if trigger.Name == "VaultTrigger" then
            pcall(function() VaultEvent:FireServer(trigger, true) end)
        end
    end
end

function KA_SetBlockAllVault(v)
    KA.BlockAllVault = v and true or false
    ALF.KA_BlockAllVault = KA.BlockAllVault
end

task.spawn(function()
    while true do
        task.wait(0.12)
        if KA.AutoKillAll then pcall(KA_UpdateKillAll) end
        if KA.DropAllPallet then pcall(KA_DropAllPallets) end
        if KA.BlockAllVault then pcall(KA_BlockAllVaults) end
        if ALF.KILLER_DestroyPallets then pcall(MAWWW_DestroyAllPallets) end
        pcall(VD_UpdateInfiniteLunge)
    end
end)

LP.CharacterAdded:Connect(function()
    task.wait(1)
    if KA.AutoStalk then pcall(KA_StartAutoStalk) end
end)

-- =========================================================
-- KILLER: UNLOCK SKILL WHILE CARRYING
-- =========================================================
W424_CarryConfig = { Enabled = false, Hooked = false }
CarryCfg = W424_CarryConfig

local function SetupCarryHook()
    if CarryCfg.Hooked then return end
    if typeof(getrawmetatable) ~= "function" then return end
    pcall(function()
        local mt = getrawmetatable(game)
        if setreadonly then setreadonly(mt, false) end
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if CarryCfg.Enabled and method == "GetAttribute" and not checkcaller() then
                if args[1] == "IsCarrying" then return false end
            end
            return oldNamecall(self, ...)
        end)
        if setreadonly then setreadonly(mt, true) end
        CarryCfg.Hooked = true
    end)
end

_G.Roooor_SetupCarryHook = SetupCarryHook

-- =========================================================
-- KILLER PERKS DISPLAY (dari ALF)
-- =========================================================
local PerkDisplayState = { Gui = nil, Thread = nil, Enabled = false, Minimized = false }

local function GetKillerPlayer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Team and p.Team.Name == "Killer" then return p end
    end
    return nil
end

local function FormatPerkName(name)
    name = tostring(name or "")
    local clean = name:gsub("_", " "):gsub("-", " ")
    clean = clean:gsub("(%l)(%u)", "%1 %2")
    clean = clean:gsub("(%a)(%d)", "%1 %2")
    clean = clean:gsub("(%d)(%a)", "%1 %2")
    clean = clean:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return clean ~= "" and clean or "Unknown Perk"
end

local function ParsePerkName(name)
    name = tostring(name or "")
    local perkName, level = name:match("^(.+)%s+(%d+)$")
    if not perkName then return nil end
    perkName = perkName:gsub("^%s+", ""):gsub("%s+$", "")
    if perkName == "" then return nil end
    local lower = perkName:lower()
    local excluded = {
        head=true, torso=true, humanoid=true,
        ["left arm"]=true, ["right arm"]=true,
        ["left leg"]=true, ["right leg"]=true,
        ["humanoidrootpart"]=true,
    }
    if excluded[lower] then return nil end
    return perkName, level
end

local function ReadPerksFromChar(char)
    if not char then return {} end
    local result, seen = {}, {}
    local function addPerk(rawName, displayName, level)
        if not rawName then return end
        rawName = tostring(rawName)
        if rawName == "" or rawName == "nil" then return end
        if rawName:lower():find("template") then return end
        if seen[rawName] then return end
        seen[rawName] = true
        table.insert(result, {
            Raw = rawName,
            Name = displayName and tostring(displayName) or FormatPerkName(rawName),
            Level = level and tostring(level) or nil,
        })
    end

    local function scanAttrs(inst)
        if not inst.GetAttributes then return end
        local attrs = inst:GetAttributes()
        for k, v in pairs(attrs) do
            local lk = tostring(k):lower()
            if lk:find("perk") then
                if type(v) == "string" then addPerk(v)
                elseif v == true then addPerk(k)
                elseif type(v) == "number" and lk:find("level") then
                    local bn = tostring(k):gsub("[Ll]evel",""):gsub("[Pp]erk","")
                    if bn ~= "" then addPerk(bn, nil, v) end
                end
            end
        end
    end

    scanAttrs(char)
    for _, child in ipairs(char:GetChildren()) do
        local pn, lv = ParsePerkName(child.Name)
        if pn then addPerk(child.Name, pn, lv) end
    end
    for _, inst in ipairs(char:GetDescendants()) do
        scanAttrs(inst)
        local lower = inst.Name:lower()
        if lower == "perks" or lower == "killerperks"
            or lower:find("perkfolder") or lower:find("perklist") then
            for _, child in ipairs(inst:GetChildren()) do
                if child:IsA("StringValue") then addPerk(child.Value)
                elseif child:IsA("IntValue") or child:IsA("NumberValue") then addPerk(child.Name, nil, child.Value)
                elseif child:IsA("BoolValue") and child.Value then addPerk(child.Name) end
            end
        elseif lower:find("perk") then
            if inst:IsA("StringValue") then addPerk(inst.Value)
            elseif inst:IsA("BoolValue") and inst.Value then addPerk(inst.Name) end
        end
    end
    table.sort(result, function(a, b) return tostring(a.Name) < tostring(b.Name) end)
    return result
end

local function BuildPerkGui()
    if PerkDisplayState.Gui then pcall(function() PerkDisplayState.Gui:Destroy() end) end
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "GlutoKillerPerksDisplay"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 60
    gui.Parent = pg

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 200, 0, 28)
    frame.Position = UDim2.new(0.02, 0, 0.42, 0)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.2
    stroke.Transparency = 0.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local topBar = Instance.new("Frame", frame)
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 3)
    topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topBar.BorderSizePixel = 0
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

    local header = Instance.new("Frame", frame)
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 22)
    header.Position = UDim2.new(0, 0, 0, 3)
    header.BackgroundTransparency = 1
    header.Active = true

    local title = Instance.new("TextLabel", header)
    title.Name = "Title"
    title.Size = UDim2.new(1, -26, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "KILLER PERKS"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local killerName = Instance.new("TextLabel", header)
    killerName.Name = "KillerName"
    killerName.AnchorPoint = Vector2.new(1, 0.5)
    killerName.Size = UDim2.new(0, 80, 1, 0)
    killerName.Position = UDim2.new(1, -26, 0.5, 0)
    killerName.BackgroundTransparency = 1
    killerName.Font = Enum.Font.GothamBold
    killerName.Text = "???"
    killerName.TextColor3 = Color3.fromRGB(220, 220, 220)
    killerName.TextSize = 9
    killerName.TextXAlignment = Enum.TextXAlignment.Right
    killerName.TextTruncate = Enum.TextTruncate.AtEnd
    killerName.Parent = header

    local minBtn = Instance.new("TextButton", header)
    minBtn.Name = "MinBtn"
    minBtn.AnchorPoint = Vector2.new(1, 0.5)
    minBtn.Size = UDim2.new(0, 20, 0, 20)
    minBtn.Position = UDim2.new(1, -3, 0.5, 0)
    minBtn.BackgroundTransparency = 1
    minBtn.Text = "−"
    minBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 13
    minBtn.AutoButtonColor = false
    minBtn.Parent = header

    local divider = Instance.new("Frame", frame)
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, -12, 0, 1)
    divider.Position = UDim2.new(0, 6, 0, 25)
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.BackgroundTransparency = 0.7
    divider.BorderSizePixel = 0

    local body = Instance.new("Frame", frame)
    body.Name = "Body"
    body.Size = UDim2.new(1, -12, 0, 0)
    body.Position = UDim2.new(0, 6, 0, 28)
    body.AutomaticSize = Enum.AutomaticSize.Y
    body.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", body)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 3)

    local function setMinimized(state)
        PerkDisplayState.Minimized = state
        if state then
            frame.Size = UDim2.new(0, 200, 0, 28)
            divider.Visible = false
            body.Visible = false
            minBtn.Text = "+"
        else
            frame.Size = UDim2.new(0, 200, 0, 28)
            divider.Visible = true
            body.Visible = true
            minBtn.Text = "−"
        end
    end
    minBtn.MouseButton1Click:Connect(function() setMinimized(not PerkDisplayState.Minimized) end)
    setMinimized(false)

    local dragging, dragStart, startPos = false, nil, nil
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    PerkDisplayState.Gui = gui
end

local function UpdatePerkDisplay()
    local gui = PerkDisplayState.Gui
    if not gui then return end
    local frame = gui:FindFirstChild("MainFrame")
    if not frame then return end
    local header = frame:FindFirstChild("Header")
    local body = frame:FindFirstChild("Body")
    local divider = frame:FindFirstChild("Divider")
    if not header or not body then return end

    local killer = GetKillerPlayer()
    local killerName = killer and (killer.DisplayName or killer.Name) or "???"
    local hName = header:FindFirstChild("KillerName")
    if hName then hName.Text = killerName end

    for _, child in ipairs(body:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end

    local perks = {}
    if killer and killer.Character then
        perks = ReadPerksFromChar(killer.Character)
    end

    local count = math.min(#perks, 6)
    if count == 0 then
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 14)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamMedium
        lbl.Text = "Waiting for perk data..."
        lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        lbl.TextSize = 9
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = body
    else
        for i = 1, count do
            local p = perks[i]
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 14)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamMedium
            local lvlText = p.Level and (" (Lv " .. tostring(p.Level) .. ")") or ""
            lbl.Text = "• " .. p.Name .. lvlText
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.TextSize = 10
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = body
        end
    end

    if PerkDisplayState.Minimized then
        if divider then divider.Visible = false end
        body.Visible = false
        frame.Size = UDim2.new(0, 200, 0, 28)
    else
        if divider then divider.Visible = true end
        body.Visible = true
        local bodyH = body.AbsoluteSize.Y
        frame.Size = UDim2.new(0, 200, 0, 28 + bodyH + 6)
    end
end

local function StopPerkDisplay()
    PerkDisplayState.Enabled = false
    if PerkDisplayState.Thread then
        pcall(function() task.cancel(PerkDisplayState.Thread) end)
        PerkDisplayState.Thread = nil
    end
    if PerkDisplayState.Gui then
        pcall(function() PerkDisplayState.Gui:Destroy() end)
        PerkDisplayState.Gui = nil
    end
end

local function StartPerkDisplay()
    if PerkDisplayState.Enabled then return end
    PerkDisplayState.Enabled = true
    BuildPerkGui()
    task.spawn(function()
        task.wait(0.05)
        UpdatePerkDisplay()
    end)
    PerkDisplayState.Thread = task.spawn(function()
        while PerkDisplayState.Enabled do
            pcall(UpdatePerkDisplay)
            task.wait(1)
        end
    end)
end

function KillerPerksDisplay_SetEnabled(v)
    ALF.KillerPerksDisplay = v and true or false
    if ALF.KillerPerksDisplay then StartPerkDisplay() else StopPerkDisplay() end
end

-- =========================================================
-- MASKED TONY (Tambah power ke-6)
-- =========================================================
local MaskedPowersFull = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"}

function Masked_ActivatePower(power)
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
    if ev then
        pcall(function() ev:FireServer(power or "Cobra") end)
    end
end

function Masked_DeactivatePower()
    local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
    if ev then
        pcall(function() ev:FireServer() end)
    end
end

print("[16/20] Killer+ (18 fitur ALF) OK")-- =========================================================
-- Section 17 : Survivor+ (20 fitur ALF)
-- =========================================================

-- =========================================================
-- SURVIVOR: AUTO CROUCH DODGE
-- =========================================================
function ALF_IsDowned(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local state = char:GetAttribute("State")
    return state == "Downed" or state == "Dead"
end

function ALF_TriggerCrouch()
    local startT = tick()
    task.spawn(function()
        local char = LP.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        pcall(function() char:SetAttribute("Crouching", true) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
        pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then
                        if firesignal then firesignal(crouchBtn.MouseButton1Click) end
                    end
                end
            end
        end)
        while tick() - startT < 1.2 do
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            task.wait(0.1)
        end
        pcall(function() char:SetAttribute("Crouching", false) end)
        pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
        if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
        pcall(function()
            local survMob = LP:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
            if survMob then
                local controls = survMob:FindFirstChild("Controls")
                if controls then
                    local crouchBtn = controls:FindFirstChild("crouch")
                    if crouchBtn then
                        if firesignal then firesignal(crouchBtn.MouseButton1Click) end
                    end
                end
            end
        end)
    end)
end

_G.Roooor_ALF_TriggerCrouch = ALF_TriggerCrouch

-- =========================================================
-- SURVIVOR: SELF HEAL
-- =========================================================
function doSelfHealTrue()
    local c = LP.Character
    if not c then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() hr:FireServer(hp, true) end)
end

function doSelfHealFalse()
    local c = LP.Character
    if not c then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    local hp = c:FindFirstChild("HumanoidRootPart")
    if not hp then return end
    pcall(function() hr:FireServer(hp, false) end)
end

function doOthersHealTrue(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() hr:FireServer(hrp, true) end)
end

function doOthersHealFalse(tp)
    if not tp or not tp.Character then return end
    local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local hr = ReplicatedStorage.Remotes.Healing.HealEvent
    pcall(function() hr:FireServer(hrp, false) end)
end

SelfHeal_BlockedAnimId = "95836365038528"
SelfHeal_AnimMonitor = { Conn = nil, CharHook = nil }

function SelfHeal_StartAnimBlock()
    if SelfHeal_AnimMonitor.Conn then return end
    SelfHeal_AnimMonitor.Conn = RunService.Heartbeat:Connect(function()
        if not ALF.InstantHealSelf then return end
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator")
        if not anim then return end
        local ok2, tracks = pcall(function() return anim:GetPlayingAnimationTracks() end)
        if not ok2 then return end
        for _, track in ipairs(tracks) do
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            if numId == SelfHeal_BlockedAnimId then
                pcall(function() track:Stop(0) end)
            end
        end
    end)
    local function hookChar(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
        if not anim then return end
        anim.AnimationPlayed:Connect(function(track)
            if not ALF.InstantHealSelf then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            if numId == SelfHeal_BlockedAnimId then
                pcall(function() track:Stop(0) end)
            end
        end)
    end
    hookChar(LP.Character)
    SelfHeal_AnimMonitor.CharHook = LP.CharacterAdded:Connect(function(c)
        task.wait(0.3); hookChar(c)
    end)
end

function SelfHeal_StopAnimBlock()
    if SelfHeal_AnimMonitor.Conn then
        pcall(function() SelfHeal_AnimMonitor.Conn:Disconnect() end)
        SelfHeal_AnimMonitor.Conn = nil
    end
    if SelfHeal_AnimMonitor.CharHook then
        pcall(function() SelfHeal_AnimMonitor.CharHook:Disconnect() end)
        SelfHeal_AnimMonitor.CharHook = nil
    end
end

function setInstantHealSelf(v)
    ALF.InstantHealSelf = v
    if v then
        SelfHeal_StartAnimBlock()
    else
        SelfHeal_StopAnimBlock()
    end
    if v then
        local ha = false
        if _G.Roooor_InstantHealConnection then _G.Roooor_InstantHealConnection:Disconnect() end
        _G.Roooor_InstantHealConnection = RunService.Heartbeat:Connect(function()
            if not ALF.InstantHealSelf then return end
            local c = LP.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not h then return end
            if h.Health >= h.MaxHealth * 0.9 then
                if ha then ha = false; doSelfHealFalse() end
                return
            end
            if ha then
                local ci = c:FindFirstChild("CheckInterractable")
                if ci and not ci:GetAttribute("isHealing") then ha = false end
            end
            if not ha then ha = true; doSelfHealTrue() end
        end)
    else
        if _G.Roooor_InstantHealConnection then
            _G.Roooor_InstantHealConnection:Disconnect()
            _G.Roooor_InstantHealConnection = nil
        end
        pcall(doSelfHealFalse)
    end
end

function setAutoHealAll(v)
    ALF.AutoHealAll = v
    if v then
        local ah = {}
        if _G.Roooor_AutoHealAllConnection then _G.Roooor_AutoHealAllConnection:Disconnect() end
        _G.Roooor_AutoHealAllConnection = RunService.Heartbeat:Connect(function()
            if not ALF.AutoHealAll then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hu = p.Character:FindFirstChildOfClass("Humanoid")
                    if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 and hrp then
                        if ah[p] then
                            local c = LP.Character
                            local ci = c and c:FindFirstChild("CheckInterractable")
                            if ci and not ci:GetAttribute("isHealing") then ah[p] = nil end
                        end
                        if not ah[p] then ah[p] = true; doOthersHealTrue(p) end
                    else
                        if ah[p] then ah[p] = nil; doOthersHealFalse(p) end
                    end
                else
                    if ah[p] then ah[p] = nil; pcall(function() doOthersHealFalse(p) end) end
                end
            end
        end)
    else
        if _G.Roooor_AutoHealAllConnection then
            _G.Roooor_AutoHealAllConnection:Disconnect()
            _G.Roooor_AutoHealAllConnection = nil
        end
    end
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if ALF.InstantHealSelf then setInstantHealSelf(true) end
    if ALF.AutoHealAll then setAutoHealAll(true) end
end)

-- =========================================================
-- SURVIVOR: FAKE PERKS
-- =========================================================
FP = {
    ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
    FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
}

local function FP_Char() return LP.Character end
local function FP_Hum() local c = FP_Char(); return c and c:FindFirstChildOfClass("Humanoid") end
local function FP_GetTotal()
    local t = 0
    for _,b in pairs(FP.ActiveBuffs) do if tick() < b.endTime then t = t + b.amt end end
    return t
end
local function FP_Apply()
    local c = FP_Char()
    local tb = FP_GetTotal()
    local h = FP_Hum()
    if c then
        if tb > 0 then c:SetAttribute("speedboost", 1+(tb/14)) else c:SetAttribute("speedboost", 1) end
    end
    if h and tb > 0 then h.WalkSpeed = 16 + tb end
end

PerkGUI = {
    Gui = nil, Container = nil, Layout = nil, Cards = {},
    PerkInfo = {
        Flowstate        = { Icon = "✦", Label = "FLOWSTATE" },
        QuickRecovery    = { Icon = "✚", Label = "QUICK RECOV" },
        PerfectLanding   = { Icon = "▼", Label = "PERFECT LAND" },
        AdrenalineRush   = { Icon = "♥", Label = "ADRENALINE" },
    }
}

local function PerkGUI_Create()
    if PerkGUI.Gui then return end
    local parent = LP:FindFirstChild("PlayerGui")
    if not parent then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "GlutoPerkGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 50
    gui.Parent = parent
    PerkGUI.Gui = gui
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.AnchorPoint = Vector2.new(1, 0)
    container.Position = UDim2.new(1, -12, 0, 100)
    container.Size = UDim2.new(0, 180, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Parent = gui
    PerkGUI.Container = container
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.Parent = container
    PerkGUI.Layout = layout
end

local function PerkGUI_AddCard(name)
    if PerkGUI.Cards[name] then return end
    if not PerkGUI.Gui then PerkGUI_Create() end
    if not PerkGUI.Gui then return end
    local info = PerkGUI.PerkInfo[name] or { Icon = "★", Label = string.upper(name) }
    local card = Instance.new("Frame")
    card.Name = "Card_" .. name
    card.Size = UDim2.new(0, 180, 0, 38)
    card.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    card.BackgroundTransparency = 1
    card.BorderSizePixel = 0
    card.ZIndex = 1
    card.LayoutOrder = #PerkGUI.Cards + 1
    card.Parent = PerkGUI.Container
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
    local grad = Instance.new("UIGradient")
    grad.Rotation = 135
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 10)),
    })
    grad.Parent = card
    local stroke = Instance.new("UIStroke", card)
    stroke.Name = "Stroke"
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.2
    stroke.Transparency = 0.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "IconHolder"
    iconHolder.Size = UDim2.fromOffset(26, 26)
    iconHolder.Position = UDim2.new(0, 6, 0.5, -13)
    iconHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    iconHolder.BorderSizePixel = 0
    iconHolder.ZIndex = 3
    iconHolder.Parent = card
    Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)

    local iconTxt = Instance.new("TextLabel")
    iconTxt.Name = "Icon"
    iconTxt.Size = UDim2.fromScale(1, 1)
    iconTxt.BackgroundTransparency = 1
    iconTxt.Font = Enum.Font.GothamBlack
    iconTxt.Text = info.Icon
    iconTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconTxt.TextScaled = true
    iconTxt.ZIndex = 4
    iconTxt.Parent = iconHolder

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Name = "Name"
    nameLbl.Size = UDim2.new(1, -46, 0, 12)
    nameLbl.Position = UDim2.new(0, 38, 0, 5)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.Text = info.Label
    nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLbl.TextSize = 10
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 3
    nameLbl.Parent = card

    local timeLbl = Instance.new("TextLabel")
    timeLbl.Name = "Time"
    timeLbl.AnchorPoint = Vector2.new(1, 0)
    timeLbl.Size = UDim2.fromOffset(34, 12)
    timeLbl.Position = UDim2.new(1, -6, 0, 5)
    timeLbl.BackgroundTransparency = 1
    timeLbl.Font = Enum.Font.GothamBold
    timeLbl.Text = "3.0s"
    timeLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    timeLbl.TextSize = 9
    timeLbl.TextXAlignment = Enum.TextXAlignment.Right
    timeLbl.ZIndex = 3
    timeLbl.Parent = card

    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.AnchorPoint = Vector2.new(0.5, 1)
    barBg.Size = UDim2.new(1, -12, 0, 3)
    barBg.Position = UDim2.new(0.5, 0, 1, -5)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
    barBg.BorderSizePixel = 0
    barBg.ZIndex = 4
    barBg.Parent = card
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 5
    barFill.Parent = barBg
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

    PerkGUI.Cards[name] = {
        Card = card, BarFill = barFill, Stroke = stroke,
        TimeLbl = timeLbl, IconTxt = iconTxt,
    }
    card.Position = UDim2.new(0.4, 0, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 0.05,
    }):Play()
end

local function PerkGUI_RemoveCard(name)
    local data = PerkGUI.Cards[name]
    if not data then return end
    PerkGUI.Cards[name] = nil
    local card = data.Card
    if not card or not card.Parent then return end
    TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.4, 0, 0, 0),
        BackgroundTransparency = 1,
    }):Play()
    task.delay(0.28, function()
        if card and card.Parent then card:Destroy() end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.05)
        for name in pairs(FP.ActiveBuffs) do
            if not PerkGUI.Cards[name] then PerkGUI_AddCard(name) end
        end
        for name, data in pairs(PerkGUI.Cards) do
            if not FP.ActiveBuffs[name] then
                PerkGUI_RemoveCard(name)
            else
                local b = FP.ActiveBuffs[name]
                if b and data.BarFill then
                    local remain = math.max(0, b.endTime - tick())
                    local dur = b.duration or 3
                    local ratio = math.clamp(remain / dur, 0, 1)
                    data.BarFill.Size = UDim2.new(ratio, 0, 1, 0)
                    data.BarFill.BackgroundColor3 = Color3.fromRGB(160, 160, 170):Lerp(Color3.fromRGB(255, 255, 255), ratio)
                    if data.TimeLbl then data.TimeLbl.Text = string.format("%.1fs", remain) end
                end
            end
        end
    end
end)

local function FP_EnsureHB()
    if FP.HB then return end
    FP.HB = RunService.Heartbeat:Connect(function()
        local exp = {}
        for n,b in pairs(FP.ActiveBuffs) do if tick() >= b.endTime then table.insert(exp,n) end end
        for _,n in ipairs(exp) do FP.ActiveBuffs[n]=nil end
        if #exp > 0 and FP_GetTotal()<=0 then FP.LastBuffEnd = tick() end
        FP_Apply()
        if FP_GetTotal()<=0 and next(FP.ActiveBuffs)==nil then
            if FP.HB then FP.HB:Disconnect(); FP.HB=nil end
            local c = FP_Char()
            if c then c:SetAttribute("speedboost",1) end
        end
    end)
end

local function FP_TryBuff(name, amt, dur)
    if FP.ActiveBuffs[name] then return end
    if tick()-FP.LastBuffEnd < FP.CooldownTime and next(FP.ActiveBuffs)==nil then return end
    FP.ActiveBuffs[name] = {amt=amt, endTime=tick()+dur, duration=dur, startTime=tick()}
    FP_Apply(); FP_EnsureHB()
end

local function FP_Clean(name)
    if FP.Conns[name] then
        for _,c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end
        FP.Conns[name] = nil
    end
end

local function FP_Reg(name, conn)
    if not FP.Conns[name] then FP.Conns[name] = {} end
    table.insert(FP.Conns[name], conn)
end

function FP_SetupFlowstate(val)
    FP.FlowstateOn = val
    local c = FP_Char()
    if c then c:SetAttribute("Flowstate", val) end
    if val then
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local w = r and r:FindFirstChild("Window")
        local p = r and r:FindFirstChild("Pallet")
        local function onV()
            if not FP.FlowstateOn then return end
            task.delay(0.5, function() if FP.FlowstateOn then FP_TryBuff("Flowstate",5,3) end end)
        end
        if w then
            local vb = w:FindFirstChild("Vaultbindable")
            if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(onV)) end
        end
        if p then
            local sb = p:FindFirstChild("Slidebindable")
            if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(onV)) end
        end
        local function hookChar(cc)
            if not cc then return end
            local cn = cc:GetAttributeChangedSignal("__VaultFireCount"):Connect(function()
                if FP.FlowstateOn then onV() end
            end)
            FP_Reg("Flowstate", cn)
        end
        hookChar(LP.Character)
        FP_Reg("Flowstate", LP.CharacterAdded:Connect(function(cc)
            if FP.FlowstateOn then cc:SetAttribute("Flowstate", true); hookChar(cc) end
        end))
    else
        FP_Clean("Flowstate")
        FP.ActiveBuffs["Flowstate"] = nil
        local c2 = FP_Char()
        if c2 then c2:SetAttribute("Flowstate", false) end
    end
end

function FP_SetupQuickRecovery(val)
    FP.QuickRecOn = val
    if val then
        local function onH() if not FP.QuickRecOn then return end FP_TryBuff("QuickRecovery", 6, 3) end
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local hf = r and r:FindFirstChild("Healing")
        if hf then
            local hd = hf:FindFirstChild("Healdone")
            if hd and hd:IsA("BindableEvent") then FP_Reg("QuickRecovery", hd.Event:Connect(onH)) end
        end
        local function hookH(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if h then
                local lh = h.Health
                local cn = h.HealthChanged:Connect(function(nh)
                    if not FP.QuickRecOn then return end
                    if nh > lh and (nh >= h.MaxHealth or (nh - lh) >= 15) then onH() end
                    lh = nh
                end)
                FP_Reg("QuickRecovery", cn)
            end
        end
        hookH(LP.Character)
        FP_Reg("QuickRecovery", LP.CharacterAdded:Connect(hookH))
    else
        FP_Clean("QuickRecovery")
        FP.ActiveBuffs["QuickRecovery"] = nil
    end
end

function FP_SetupPerfectLanding(val)
    FP.PerfLandOn = val
    if val then
        local function hookF(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local wf, fs = false, 0
            local cn = h.StateChanged:Connect(function(_, n)
                if not FP.PerfLandOn then return end
                if n == Enum.HumanoidStateType.Freefall then wf = true; fs = tick() end
                if wf and (n == Enum.HumanoidStateType.Landed or n == Enum.HumanoidStateType.Running) then
                    local ft = tick() - fs
                    wf = false
                    if ft >= 0.25 then FP_TryBuff("PerfectLanding", 8, 3) end
                end
            end)
            FP_Reg("PerfectLanding", cn)
        end
        hookF(LP.Character)
        FP_Reg("PerfectLanding", LP.CharacterAdded:Connect(hookF))
    else
        FP_Clean("PerfectLanding")
        FP.ActiveBuffs["PerfectLanding"] = nil
    end
end

function FP_SetupAdrenalineRush(val)
    FP.AdrenalineOn = val
    if val then
        local function hookD(cc)
            if not cc then return end
            local h = cc:FindFirstChildOfClass("Humanoid")
            if not h then return end
            local lh = h.Health
            local cn = h.HealthChanged:Connect(function(nh)
                if not FP.AdrenalineOn then return end
                if nh < lh and nh <= 50 and nh > 0 then FP_TryBuff("AdrenalineRush", 4, 5) end
                lh = nh
            end)
            FP_Reg("AdrenalineRush", cn)
        end
        hookD(LP.Character)
        FP_Reg("AdrenalineRush", LP.CharacterAdded:Connect(hookD))
    else
        FP_Clean("AdrenalineRush")
        FP.ActiveBuffs["AdrenalineRush"] = nil
    end
end

-- =========================================================
-- SURVIVOR: FAKE PARRY V2
-- =========================================================
FakeParryTrack = nil
FakeParryLast = 0
FakeParryButtonGui = nil
FakeParryButton = nil

FakeParryAnims = {
    ["Enten"]       = "rbxassetid://127096285501517",
    ["Stopwatch"]   = "rbxassetid://81793464499285",
    ["Fih"]         = "rbxassetid://123307242865945",
    ["BloodShield"] = "rbxassetid://75939529748815",
}

local function FakeParry_Stop()
    if FakeParryTrack then
        pcall(function() FakeParryTrack:Stop(0.05) end)
        FakeParryTrack = nil
    end
end

local function FakeParry_Play()
    if not ALF.SURV_FakeParry then return end
    local now = tick()
    if now - FakeParryLast < (tonumber(ALF.SURV_FakeParryCooldown) or 0.4) then return end
    FakeParryLast = now

    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end

    FakeParry_Stop()

    local animId = FakeParryAnims[ALF.SURV_FakeParryAnim] or FakeParryAnims["Enten"]
    pcall(function()
        local anim = Instance.new("Animation")
        anim.AnimationId = animId
        local track = animator:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action4
        track.Looped = false
        track:Play(0.1)
        FakeParryTrack = track
        task.delay(2, function()
            if FakeParryTrack == track then FakeParry_Stop() end
        end)
    end)
end

function FakeParry_Trigger() FakeParry_Play() end

local function FakeParry_CreateButton()
    if FakeParryButtonGui then return end
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return end

    local sg = Instance.new("ScreenGui")
    sg.Name = "GlutoFakeParryBtn"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 100
    sg.Parent = pg

    local btn = Instance.new("TextButton")
    btn.Name = "FakeParryBtn"
    btn.Size = UDim2.fromOffset(64, 64)
    btn.Position = UDim2.new(0.82, 0, 0.62, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
    btn.BackgroundTransparency = 0.15
    btn.Text = "FAKE\nPARRY"
    btn.TextColor3 = Color3.fromRGB(220, 180, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = true
    btn.ZIndex = 10
    btn.Parent = sg
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(200, 120, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.2

    local lockBtn = Instance.new("TextButton")
    lockBtn.Name = "LockDrag"
    lockBtn.Size = UDim2.new(0, 22, 0, 22)
    lockBtn.Position = UDim2.new(1, -5, 0, -5)
    lockBtn.AnchorPoint = Vector2.new(1, 0)
    lockBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    lockBtn.BackgroundTransparency = 0.3
    lockBtn.Text = ALF.SURV_FakeParryLocked and "X" or "L"
    lockBtn.TextSize = 10
    lockBtn.Font = Enum.Font.GothamBold
    lockBtn.TextColor3 = Color3.new(1, 1, 1)
    lockBtn.ZIndex = 11
    lockBtn.Parent = btn
    Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)

    lockBtn.MouseButton1Click:Connect(function()
        ALF.SURV_FakeParryLocked = not ALF.SURV_FakeParryLocked
        lockBtn.Text = ALF.SURV_FakeParryLocked and "X" or "L"
        lockBtn.BackgroundColor3 = ALF.SURV_FakeParryLocked and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
    end)

    local dragging, dragStart, startPos = false, nil, nil
    local moved = false
    btn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if ALF.SURV_FakeParryLocked then return end
            dragging = true
            moved = false
            dragStart = inp.Position
            startPos = btn.Position
        end
    end)
    btn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if dragging and moved then
            elseif not moved then
                FakeParry_Play()
            end
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if not dragging or ALF.SURV_FakeParryLocked then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - dragStart
            if math.abs(d.X) + math.abs(d.Y) > 6 then moved = true end
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)

    FakeParryButtonGui = sg
    FakeParryButton = btn
end

local function FakeParry_RemoveButton()
    if FakeParryButtonGui then
        pcall(function() FakeParryButtonGui:Destroy() end)
        FakeParryButtonGui = nil
        FakeParryButton = nil
    end
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local keyName = ALF.SURV_FakeParryKey or "V"
    local kc = Enum.KeyCode[keyName]
    if kc and input.KeyCode == kc then
        FakeParry_Play()
    end
end)

function FakeParry_SetEnabled(v)
    ALF.SURV_FakeParry = v and true or false
    if not v then FakeParry_Stop() end
    if v and UIS.TouchEnabled and ALF.SURV_FakeParryShowBtn then
        FakeParry_CreateButton()
    end
end

function FakeParry_SetAnim(name)
    if name and FakeParryAnims[name] then
        ALF.SURV_FakeParryAnim = name
    else
        ALF.SURV_FakeParryAnim = "Enten"
    end
end

function FakeParry_SetShowButton(v)
    ALF.SURV_FakeParryShowBtn = v and true or false
    if v then FakeParry_CreateButton() else FakeParry_RemoveButton() end
end

function FakeParry_SetKeybind(keyName)
    local ok, kc = pcall(function() return Enum.KeyCode[tostring(keyName):upper()] end)
    if ok and kc then
        ALF.SURV_FakeParryKey = kc.Name
        return true
    end
    return false
end

-- =========================================================
-- SURVIVOR: SWIFT VAULT + PALLET REFLEX + SELF UNHOOK
-- =========================================================
ALF.SURV_AutoVault = ALF.SURV_AutoVault or false
ALF.SURV_FastVault = ALF.SURV_FastVault or false
ALF.SURF_VaultSpeed = ALF.SURF_VaultSpeed or 13
ALF.SURV_AutoPallet = ALF.SURV_AutoPallet or false
ALF.SURV_AutoPalletDist = ALF.SURV_AutoPalletDist or 20

local _vaultedWindows = {}
local _lastVaultScan = 0
local _lastPalletDrop = 0
local _usedPallets = {}

local function SwiftVault_BuildWindowGroups()
    local groups = {}
    local map = Workspace:FindFirstChild("Map")
    if not map then return groups end
    local seen = {}
    local function addPart(part)
        if not part or seen[part] then return end
        seen[part] = true
        local rootWindow = part.Parent
        if part.Name == "VaultPoint" and part.Parent and part.Parent.Name == "VaultTrigger" then
            rootWindow = part.Parent.Parent
        elseif part.Name == "VaultTrigger" then
            rootWindow = part.Parent
        end
        if rootWindow then
            groups[rootWindow] = groups[rootWindow] or {}
            local exists = false
            for _, p in ipairs(groups[rootWindow]) do
                if p == part then exists = true; break end
            end
            if not exists then table.insert(groups[rootWindow], part) end
        end
    end
    for _, obj in ipairs(map:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "VaultTrigger" or obj.Name == "VaultPoint") then
            addPart(obj)
        end
    end
    return groups
end

local function SwiftVault_GetVTPosition(vt)
    if not vt then return nil end
    if vt:IsA("BasePart") then return vt.Position end
    if vt:IsA("Model") then
        if vt.PrimaryPart then return vt.PrimaryPart.Position end
        local bp = vt:FindFirstChildWhichIsA("BasePart", true)
        if bp then return bp.Position end
    end
    return nil
end

RunService.Heartbeat:Connect(function()
    if ALF.SURV_FastVault then
        pcall(function()
            local char = LP.Character
            if char then char:SetAttribute("vaultspeed", (ALF.SURF_VaultSpeed or 13) / 10) end
        end)
    end
end)

RunService.Heartbeat:Connect(function()
    if not ALF.SURV_AutoVault then return end
    if tick() - _lastVaultScan < 0.15 then return end
    _lastVaultScan = tick()
    pcall(function()
        local char   = LP.Character
        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
        local hum    = char and char:FindFirstChildOfClass("Humanoid")
        if not myRoot or not hum or hum.Health <= 0 then return end
        local vel = myRoot.AssemblyLinearVelocity
        if vel.Magnitude < 1 then return end
        local remotes   = ReplicatedStorage:FindFirstChild("Remotes")
        local winFolder = remotes and remotes:FindFirstChild("Window")
        local vaultEv   = winFolder and winFolder:FindFirstChild("VaultCommit")
        if not vaultEv then return end
        local windowGroups = SwiftVault_BuildWindowGroups()
        for rootWindow, parts in pairs(windowGroups) do
            local allVTs = {}
            for _, child in ipairs(rootWindow:GetChildren()) do
                if child.Name == "VaultTrigger" then table.insert(allVTs, child) end
            end
            if #allVTs == 0 then continue end
            local nearestVT, nearestVTDist = nil, math.huge
            for _, vt in ipairs(allVTs) do
                local pos = SwiftVault_GetVTPosition(vt)
                if pos then
                    local d = (myRoot.Position - pos).Magnitude
                    if d < nearestVTDist then nearestVTDist = d; nearestVT = vt end
                end
            end
            if not nearestVT or nearestVTDist > 6.0 then continue end
            local lastUsed = _vaultedWindows[rootWindow] or 0
            if tick() - lastUsed < 3.0 then continue end
            local finalTarget = nearestVT
            local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
            local winFold  = remotes2 and remotes2:FindFirstChild("Window")
            if winFold and finalTarget then
                local vaultEvent     = winFold:FindFirstChild("VaultEvent")
                local vaultBindable  = winFold:FindFirstChild("Vaultbindable")
                local fastvault      = winFold:FindFirstChild("fastvault")
                local vaultComplete1 = winFold:FindFirstChild("VaultCompleteEventpart1")
                local vaultComplete  = winFold:FindFirstChild("VaultCompleteEvent")
                if vaultEvent    then pcall(function() vaultEvent:FireServer(finalTarget, true) end) end
                if vaultBindable then pcall(function() vaultBindable:Fire(finalTarget, true) end) end
                if fastvault     then pcall(function() fastvault:FireServer(LP) end) end
                if vaultComplete1 then pcall(function() vaultComplete1:FireServer() end) end
                if vaultComplete  then pcall(function() vaultComplete:FireServer(finalTarget, false) end) end
            end
            _vaultedWindows[rootWindow] = tick()
            break
        end
    end)
end)

LP.CharacterAdded:Connect(function()
    task.wait(0.5); _vaultedWindows = {}
end)

-- Pallet Reflex
local function Pallet_GetKillerRoot()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Team and plr.Team.Name == "Killer" and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then return hrp end
        end
    end
    return nil
end

local function Pallet_GetAllPallets()
    local list = {}
    local map = Workspace:FindFirstChild("Map")
    if not map then return list end
    for _, obj in ipairs(map:GetDescendants()) do
        if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
            table.insert(list, obj)
        end
    end
    return list
end

local function Pallet_IsDropped(palletModel)
    if not palletModel or not palletModel.Parent then return true end
    if _usedPallets[palletModel] then return true end
    local ok, destroyed = pcall(function() return palletModel:GetAttribute("Destroyed") end)
    if ok and destroyed == true then return true end
    local ok2, broken = pcall(function() return palletModel:GetAttribute("Broken") end)
    if ok2 and broken == true then return true end
    if not palletModel:FindFirstChildWhichIsA("BasePart", true) then return true end
    return false
end

local function Pallet_GetPointSlide(model)
    local slide = model:FindFirstChild("PalletPointSlide")
    if slide then return slide end
    for _, child in ipairs(model:GetDescendants()) do
        if child.Name == "PalletPointSlide" then return child end
    end
    return model:FindFirstChild("PalletPoint")
end

local _lastPalletScan = 0
RunService.Heartbeat:Connect(function()
    if not ALF.SURV_AutoPallet then return end
    local now = tick()
    if now - _lastPalletScan < 0.2 then return end
    _lastPalletScan = now
    if now - _lastPalletDrop < 2.5 then return end
    pcall(function()
        local char   = LP.Character
        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
        local hum    = char and char:FindFirstChildOfClass("Humanoid")
        if not myRoot or not hum or hum.Health <= 0 then return end
        local killerRoot = Pallet_GetKillerRoot()
        if not killerRoot then return end
        if (myRoot.Position - killerRoot.Position).Magnitude > (ALF.SURV_AutoPalletDist or 20) then return end
        local remotes    = ReplicatedStorage:FindFirstChild("Remotes")
        local palletFold = remotes and remotes:FindFirstChild("Pallet")
        local dropEvent  = palletFold and palletFold:FindFirstChild("PalletDropEvent")
        if not dropEvent then return end
        local bestPallet, bestDist = nil, 8
        for _, pal in ipairs(Pallet_GetAllPallets()) do
            if not Pallet_IsDropped(pal) then
                local refPart = pal:FindFirstChild("PalletPoint")
                    or pal:FindFirstChild("PalletPointSlide")
                    or pal:FindFirstChildWhichIsA("BasePart", true)
                if refPart then
                    local d = (myRoot.Position - refPart.Position).Magnitude
                    if d < bestDist then bestDist = d; bestPallet = pal end
                end
            end
        end
        if bestPallet then
            local fireTarget = Pallet_GetPointSlide(bestPallet)
            if fireTarget then
                pcall(function() dropEvent:FireServer(fireTarget) end)
                _usedPallets[bestPallet] = true
                _lastPalletDrop = tick()
            end
        end
    end)
end)

LP.CharacterAdded:Connect(function()
    task.wait(0.5); _usedPallets = {}
end)

-- =========================================================
-- SURVIVOR: GOD MODE + AUTO RUN + UNLIMITED VAULT
-- =========================================================
ALF.GodMode = false
ALF.AutoRunPC = false
ALF.AutoRunMobile = false

task.spawn(function()
    while task.wait(0.1) do
        if ALF.GodMode then
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    if hum.Health < hum.MaxHealth and hum.Health > 0 then
                        hum.Health = hum.MaxHealth
                    end
                end)
            end
        end
    end
end)

-- Auto Run PC
task.spawn(function()
    while task.wait(0.1) do
        if ALF.AutoRunPC then
            pcall(function()
                if VirtualInputManager then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LP:GetMouse())
                end
            end)
        else
            pcall(function()
                if VirtualInputManager then
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LP:GetMouse())
                end
            end)
        end
    end
end)

-- Auto Run Mobile
local function GetMobileSprintButton()
    local pg = LP:FindFirstChild("PlayerGui"); if not pg then return nil end
    local mob = pg:FindFirstChild("Survivor-mob"); if not mob then return nil end
    local controls = mob:FindFirstChild("Controls"); if not controls then return nil end
    local sprint = controls:FindFirstChild("sprint"); if not sprint then return nil end
    if sprint:IsA("GuiButton") then return sprint end
    local icon = sprint:FindFirstChild("icon")
    if icon and icon:IsA("GuiButton") then return icon end
    return nil
end

task.spawn(function()
    while task.wait(0.12) do
        if ALF.AutoRunMobile then
            local btn = GetMobileSprintButton()
            if btn and firesignal then
                pcall(function() firesignal(btn.MouseButton1Click) end)
            end
        end
    end
end)

-- Unlimited Vault + Anti Slow Vault
ALF.UnlimitedVault = false
ALF.AntiSlowVault = false

task.spawn(function()
    while task.wait(1) do
        if ALF.UnlimitedVault then
            for _, v in ipairs(CollectionService:GetTagged("Blocked")) do
                CollectionService:RemoveTag(v, "Blocked")
            end
        end
        if ALF.AntiSlowVault then
            for _, v in ipairs(CollectionService:GetTagged("SlowVault")) do
                CollectionService:RemoveTag(v, "SlowVault")
            end
        end
    end
end)

-- =========================================================
-- SURVIVOR: EMOTE + FAKE KORLESS
-- =========================================================
EmoteSystem = {
    Enabled = false, CurrentTrack = nil, CurrentSound = nil,
    SelectedEmote = "Friday Night",
    Options = {
        "Friday Night", "WarCry", "24 Hour Cinderella", "Applause",
        "Arm Swing", "Backflip", "California Girls", "Christmas Spirit",
        "Floating Rest", "Ghoul", "Griddy", "Kyoufuu", "OnePlays", "Vulnerable",
    },
    Data = {
        ["Friday Night"]        = { Anim = "rbxassetid://83229063951016",  Sound = "rbxassetid://85355610204255" },
        ["WarCry"]              = { Anim = "rbxassetid://82600868380136",  Sound = "rbxassetid://120101930689931" },
        ["24 Hour Cinderella"]  = { Anim = "rbxassetid://137195203725366", Sound = "rbxassetid://121099446613414" },
        ["Applause"]            = { Anim = "rbxassetid://96328361165090",  Sound = "rbxassetid://115490787020749" },
        ["Arm Swing"]           = { Anim = "rbxassetid://80552139463944",  Sound = "rbxassetid://74216458932348" },
        ["Backflip"]            = { Anim = "rbxassetid://74705617908505",  Sound = nil },
        ["California Girls"]    = { Anim = "rbxassetid://123552803041504", Sound = "rbxassetid://87899327891544" },
        ["Christmas Spirit"]    = { Anim = "rbxassetid://137859761110514", Sound = nil },
        ["Floating Rest"]       = { Anim = "rbxassetid://114593021219597", Sound = nil },
        ["Ghoul"]               = { Anim = "rbxassetid://130415594909401", Sound = "rbxassetid://123004139176580" },
        ["Griddy"]              = { Anim = "rbxassetid://75586690784894",  Sound = nil },
        ["Kyoufuu"]             = { Anim = "rbxassetid://137322894494527", Sound = "rbxassetid://129064643026442" },
        ["OnePlays"]            = { Anim = "rbxassetid://140625405103474", Sound = "rbxassetid://94749073728335" },
        ["Vulnerable"]          = { Anim = "rbxassetid://121773684313913", Sound = "rbxassetid://135265751184744" },
    },
}

local function EmoteSystem_Stop()
    if EmoteSystem.CurrentTrack then pcall(function() EmoteSystem.CurrentTrack:Stop() end); EmoteSystem.CurrentTrack = nil end
    if EmoteSystem.CurrentSound then pcall(function() EmoteSystem.CurrentSound:Destroy() end); EmoteSystem.CurrentSound = nil end
end

local function EmoteSystem_Play()
    EmoteSystem_Stop()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    local data = EmoteSystem.Data[EmoteSystem.SelectedEmote]
    if not data then return end
    if data.Anim then
        local anim = Instance.new("Animation")
        anim.AnimationId = data.Anim
        local track = hum:LoadAnimation(anim)
        track.Looped = true
        track.Priority = Enum.AnimationPriority.Action
        track:Play()
        EmoteSystem.CurrentTrack = track
    end
    if data.Sound then
        local snd = Instance.new("Sound")
        snd.SoundId = data.Sound
        snd.Looped = true
        snd.Volume = 2
        snd.Parent = hrp
        snd:Play()
        EmoteSystem.CurrentSound = snd
    end
end

function EmoteSystem_SetEnabled(v)
    EmoteSystem.Enabled = v and true or false
    if EmoteSystem.Enabled then EmoteSystem_Play() else EmoteSystem_Stop() end
end

function EmoteSystem_SelectEmote(name)
    if EmoteSystem.Data[name] then
        EmoteSystem.SelectedEmote = name
        if EmoteSystem.Enabled then EmoteSystem_Play() end
    end
end

LP.CharacterRemoving:Connect(function() EmoteSystem_Stop() end)
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if EmoteSystem.Enabled then EmoteSystem_Play() end
end)

-- =========================================================
-- SURVIVOR: BYPASS GENERATOR + MANUAL/AUTO GEN
-- =========================================================
GenBypass = {
    Enabled = false, Button = nil, UI = nil, Cache = {}, CacheTimer = 0,
    Processed = {}, HotkeyCode = Enum.KeyCode.B, TriggerRange = 8
}

local function GB_GetAllGeneratorsCached()
    local now = tick()
    if now - GenBypass.CacheTimer < 5 then return GenBypass.Cache end
    GenBypass.Cache = {}; GenBypass.CacheTimer = now
    local mf = Workspace:FindFirstChild("Map")
    if not mf then return GenBypass.Cache end
    pcall(function()
        for _, v in pairs(mf:GetDescendants()) do
            if not v:IsA("Model") then continue end
            if v.Name ~= "Generator" then continue end
            local real = v:GetAttribute("RepairProgress") ~= nil
                      or v:GetAttribute("kickcount") ~= nil
                      or v:GetAttribute("ProgressRepair") ~= nil
            if real then table.insert(GenBypass.Cache, v) end
        end
    end)
    return GenBypass.Cache
end

local function GB_GetPoints(m)
    local pts = {}
    if m then
        for _, o in ipairs(m:GetChildren()) do
            if o:IsA("BasePart") and string.find(o.Name, "GeneratorPoint") then
                table.insert(pts, o)
            end
        end
    end
    return pts
end

local function GB_GetNearestPoint()
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local best, bd = nil, math.huge
    for _, g in pairs(GB_GetAllGeneratorsCached()) do
        for _, p in pairs(GB_GetPoints(g)) do
            local d = (hrp.Position - p.Position).Magnitude
            if d < bd then bd = d; best = p end
        end
    end
    return best, bd
end

local function GB_WaitRepairing(pt, t)
    local s = tick()
    while tick() - s < (t or 1) do
        if pt:GetAttribute("IsRepairing") == true then return true end
        task.wait(0.05)
    end
    return false
end

local function GB_DoRepair(tp)
    local gm = tp.Parent
    if GenBypass.Processed[gm] then return end
    GenBypass.Processed[gm] = true
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if not hrp then GenBypass.Processed[gm] = nil; return end
    local re = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Generator")
        and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
    local og = hrp.CFrame
    pcall(function()
        for _, p in pairs(GB_GetPoints(gm)) do
            if p ~= tp and p.Parent then
                hrp.Anchored = true
                hrp.CFrame = p.CFrame
                task.wait(0.15)
                pcall(function() if re then re:FireServer(p, true) end end)
                if not GB_WaitRepairing(p, 0.8) then
                    pcall(function() if re then re:FireServer(p, false) end end)
                    task.wait(0.1)
                    hrp.CFrame = p.CFrame
                    task.wait(0.15)
                    pcall(function() if re then re:FireServer(p, true) end end)
                    GB_WaitRepairing(p, 0.5)
                end
                hrp.Anchored = false
                task.wait(0.05)
            end
        end
    end)
    pcall(function()
        if hrp and hrp.Parent then hrp.Anchored = false; hrp.CFrame = og end
    end)
    task.wait(0.1)
    pcall(function() if re then re:FireServer(tp, false) end end)
end

function setGenBypass(v)
    GenBypass.Enabled = v and true or false
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == GenBypass.HotkeyCode and GenBypass.Enabled then
        local bp, bd = GB_GetNearestPoint()
        if not bp or bd > GenBypass.TriggerRange then return end
        if GenBypass.Processed[bp.Parent] then return end
        GB_DoRepair(bp)
    end
end)

-- Manual Gen + Auto Gen
ALF.ManualGen = ALF.ManualGen or false
ALF.AutoGen = ALF.AutoGen or false

local REPAIR_ANIM_ID = "rbxassetid://92960319113695"
local RepairAnimTrack = nil

local function GetNearestKillerDist()
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, math.huge end
    local best, dist = nil, math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LP and pl.Team and pl.Team.Name == "Killer" and pl.Character then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - myRoot.Position).Magnitude
                if d < dist then dist = d; best = hrp end
            end
        end
    end
    return best, dist
end

local function PlayRepairAnim()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local animator = hum and hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    if RepairAnimTrack and RepairAnimTrack.IsPlaying then return end
    pcall(function()
        local anim = Instance.new("Animation")
        anim.AnimationId = REPAIR_ANIM_ID
        RepairAnimTrack = animator:LoadAnimation(anim)
        RepairAnimTrack.Priority = Enum.AnimationPriority.Action
        RepairAnimTrack:Play()
    end)
end

local function StopRepairAnim()
    if RepairAnimTrack and RepairAnimTrack.IsPlaying then
        pcall(function() RepairAnimTrack:Stop() end)
    end
    RepairAnimTrack = nil
end

local ManualThread, AutoThread = nil, nil
local ManualPoint, AutoPoint = nil, nil
local LastFire = 0

local function StopRepair(point)
    StopRepairAnim()
    local re = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Generator")
        and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
    if point and re then
        pcall(function() re:FireServer(point, false) end)
    end
end

local function GetNearestGenPointInReach()
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local bestPt, bestDist = nil, 5.5
    for _, gen in ipairs(GB_GetAllGeneratorsCached()) do
        for _, pt in ipairs(GB_GetPoints(gen)) do
            if pt and pt.Parent then
                local d = (myRoot.Position - pt.Position).Magnitude
                if d < bestDist then
                    bestDist = d
                    bestPt = pt
                end
            end
        end
    end
    return bestPt
end

task.spawn(function()
    while task.wait(0.1) do
        if ALF.ManualGen then
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            if myRoot and hum and hum.Health > 0 then
                local _, kd = GetNearestKillerDist()
                if kd <= ALF.KillerEscapeDist then
                    if ManualPoint then StopRepair(ManualPoint); ManualPoint = nil end
                else
                    local pt = GetNearestGenPointInReach()
                    if pt then
                        ManualPoint = pt
                        local now = tick()
                        if now - LastFire >= 0.5 then
                            local re = ReplicatedStorage:FindFirstChild("Remotes")
                                and ReplicatedStorage.Remotes:FindFirstChild("Generator")
                                and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
                            pcall(function() if re then re:FireServer(pt, true) end end)
                            PlayRepairAnim()
                            LastFire = now
                        end
                    else
                        if ManualPoint then StopRepair(ManualPoint); ManualPoint = nil end
                    end
                end
            end
        end
    end
end)

print("[17/20] Survivor+ (20 fitur ALF) OK")-- =========================================================
-- Section 18 : Combat+ (15 fitur ALF)
-- =========================================================

-- =========================================================
-- SILENT AIM (TOF)
-- =========================================================
ToFState = {
    Connection = nil, LaserBeam = nil, TargetGui = nil,
    InputBegan = nil, InputEnded = nil, TouchInput = nil,
    IsAiming = false, SavedUIPos = UDim2.new(0.5, -100, 0, 110),
    SCPCache = {}, SCPCacheTimer = 0
}

ToFKeyCodes = {
    None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R,
    T=Enum.KeyCode.T, F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H,
    J=Enum.KeyCode.J, K=Enum.KeyCode.K, L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z
}

local function ToF_IsDowned(c)
    if not c then return true end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return true end
    local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health<=0 then return true end
    if c:GetAttribute("Knocked")==true then return true end
    if c:GetAttribute("IsHooked")==true then return true end
    if c:GetAttribute("IsCarried")==true then return true end
    return false
end

local function ToF_IsBlocked()
    if ALF.TOF_BlockKnocked == false then return false end
    local c = LP.Character
    if not c then return true end
    return ToF_IsDowned(c)
end

local function ToF_GetEvent()
    local r = ReplicatedStorage:FindFirstChild("Remotes")
    local i = r and r:FindFirstChild("Items")
    local t = i and i:FindFirstChild("Twist of Fate")
    local f = t and t:FindFirstChild("Fire")
    if f and f:IsA("RemoteEvent") then return f end
    return nil
end

local function ToF_GetGun()
    local c = LP.Character
    if not c then return nil end
    local b = c:FindFirstChild("Twist of Fate", true)
    if not b then return nil end
    local ra = b:FindFirstChild("Right Arm")
    if ra then
        local g = ra:FindFirstChild("gun"); if g then return g end
        local e = ra:FindFirstChild("EmperorGun"); if e then return e end
    end
    return b
end

local function ToF_IsVisible(op, tp, tc)
    local d = tp - op; local dist = d.Magnitude
    if dist < 0.1 then return true end
    local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude
    local ex = {}
    local lc = LP.Character
    if lc then table.insert(ex, lc) end
    if tc and tc ~= lc then table.insert(ex, tc) end
    if ToFState.LaserBeam then table.insert(ex, ToFState.LaserBeam) end
    rp.FilterDescendantsInstances = ex
    return workspace:Raycast(op, d.Unit * dist, rp) == nil
end

local function ToF_GetSCPs()
    if tick() - ToFState.SCPCacheTimer < 0.5 then return ToFState.SCPCache end
    local nt = {}
    local mf = workspace:FindFirstChild("Map")
    if mf then
        for _, c in pairs(mf:GetDescendants()) do
            if c:IsA("Model") then
                local a = c:GetAttributes()
                if c:GetAttribute("CorpseCreated0492") or next(a) ~= nil then
                    local r = c:FindFirstChild("HumanoidRootPart")
                    if r then table.insert(nt, r) end
                end
            end
        end
    end
    ToFState.SCPCache = nt; ToFState.SCPCacheTimer = tick()
    return nt
end

local function ToF_GetTarget()
    local g = ToF_GetGun(); local c = LP.Character
    if not (g and c) then return nil,nil,nil,nil end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil,nil,nil,nil end
    local mp = hrp.Position
    local op
    if c:GetAttribute("IsCarried") then
        op = hrp.Position + (hrp.CFrame.LookVector * 2)
    else
        pcall(function()
            op = g:IsA("BasePart") and g.Position
                or (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position)
        end)
        op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
    end
    local function predict(t, tc)
        local tp = t.Position
        if ALF.TOF_WallCheck and not ToF_IsVisible(op, tp, tc) then return nil,nil,nil,nil end
        local tv = Vector3.new(0,0,0)
        local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
        if rp then tv = rp.Velocity end
        local dr = tp - op; local d = dr.Magnitude
        if d < 0.1 then return nil,nil,nil,nil end
        if d < 5 then return dr.Unit, g, op, tp end
        local tt = d/400
        local pp = tp + (tv*tt)
        for _=1,2 do
            local nd = (pp-op).Magnitude
            tt = nd/400
            pp = tp + (tv*tt)
        end
        local fd = pp - op
        if fd.Magnitude < 0.1 then return nil,nil,nil,nil end
        return fd.Unit, g, op, pp
    end
    local mode = ALF.TOF_TargetMode or "Killer"
    if mode=="Killer" then
        local bt, bc, bs = nil, nil, math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Team and p.Team.Name == "Killer" and p.Character then
                local t = p.Character:FindFirstChild("Torso")
                    or p.Character:FindFirstChild("UpperTorso")
                    or p.Character:FindFirstChild("HumanoidRootPart")
                if t then
                    local d = (mp-t.Position).Magnitude
                    if d < bs then bs=d; bt=t; bc=p.Character end
                end
            end
        end
        if not bt then return nil,nil,nil,nil end
        return predict(bt, bc)
    elseif mode=="Survivors" then
        local bt, bc, bd = nil, nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Team and p.Team.Name == "Survivors" and p.Character then
                local t = p.Character:FindFirstChild("Torso")
                    or p.Character:FindFirstChild("UpperTorso")
                    or p.Character:FindFirstChild("HumanoidRootPart")
                if t then
                    local dt = t.Position - cam.CFrame.Position
                    if dt.Magnitude>0.1 then
                        local dot = cl:Dot(dt.Unit)
                        if dot>0.5 and dot>bd then bd=dot; bt=t; bc=p.Character end
                    end
                end
            end
        end
        if not bt then return nil,nil,nil,nil end
        return predict(bt, bc)
    elseif mode=="Zombie" then
        local bp, bd = nil, -math.huge
        local cam = workspace.CurrentCamera
        local cl = cam.CFrame.LookVector
        for _,r in ipairs(ToF_GetSCPs()) do
            if r and r.Parent then
                local dt = r.Position - cam.CFrame.Position
                if dt.Magnitude>0.1 then
                    local dot = cl:Dot(dt.Unit)
                    if dot>0.5 and dot>bd then bd=dot; bp=r end
                end
            end
        end
        if not bp then return nil,nil,nil,nil end
        return predict(bp, bp.Parent)
    end
    return nil,nil,nil,nil
end

local function ToF_UpdateLaser(op, tp)
    if not ToFState.LaserBeam then
        local l = Instance.new("Part")
        l.Name="ToFLaser"
        l.Anchored=true
        l.CanCollide=false
        l.CanTouch=false
        l.CastShadow=false
        l.Material=Enum.Material.Neon
        l.Color=Color3.fromRGB(255,255,255)
        l.Parent=workspace
        ToFState.LaserBeam = l
    end
    local d = (tp-op).Magnitude
    ToFState.LaserBeam.Size = Vector3.new(0.05,0.05,d)
    ToFState.LaserBeam.CFrame = CFrame.new((op+tp)/2, tp)
    ToFState.LaserBeam.Transparency = 0
end

local function ToF_ClearLaser()
    if ToFState.LaserBeam then
        pcall(function() ToFState.LaserBeam:Destroy() end)
        ToFState.LaserBeam=nil
    end
end

local function ToF_GetMobileBtn()
    local pg = LP:FindFirstChild("PlayerGui")
    local sm = pg and pg:FindFirstChild("Survivor-mob")
    local ct = sm and sm:FindFirstChild("Controls")
    local gm = ct and ct:FindFirstChild("Gui-mob")
    if not gm then return nil end
    for _,n in ipairs({"attack","Attack","shoot","Shoot","fire","Fire"}) do
        local b = gm:FindFirstChild(n,true)
        if b and b:IsA("GuiObject") then return b end
    end
    for _,o in ipairs(gm:GetDescendants()) do
        if o:IsA("GuiButton") and o.Visible then return o end
    end
    return gm:IsA("GuiObject") and gm or nil
end

local function ToF_IsTouchShoot(input)
    local sb = ToF_GetMobileBtn()
    if not (sb and sb.Visible) then return false end
    local p = input.Position
    local ap = sb.AbsolutePosition
    local az = sb.AbsoluteSize
    return p.X>=ap.X and p.X<=ap.X+az.X and p.Y>=ap.Y and p.Y<=ap.Y+az.Y
end

local function ToF_Shoot()
    if not ALF.TOF_SilentAim then return end
    if ToF_IsBlocked() then return end
    local td, g, op, tp = ToF_GetTarget()
    if not (td and g and tp and op) then return end
    local e = ToF_GetEvent()
    if not e then return end
    local fd = tp - op
    if fd.Magnitude < 0.1 then return end
    pcall(function() e:FireServer(g, fd.Unit) end)
end

local function ToF_StartConn()
    if ToFState.Connection then return end
    ToFState.Connection = RunService.Heartbeat:Connect(function()
        if ToF_IsBlocked() then
            ToFState.IsAiming = false
            if ToFState.TouchInput then ToFState.TouchInput = nil end
            if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
            return
        end
        if not ALF.TOF_SilentAim or not ToFState.IsAiming then
            if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
            return
        end
        local _, _, op, tp = ToF_GetTarget()
        if op and tp then
            pcall(function()
                local c = LP.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                if hrp and not c:GetAttribute("IsCarried") then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.X, hrp.Position.Y, tp.Z))
                end
            end)
            if ALF.TOF_Laser then ToF_UpdateLaser(op, tp)
            elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
        elseif ToFState.LaserBeam then
            ToFState.LaserBeam.Transparency = 1
        end
    end)
end

local function ToF_StopConn()
    if ToFState.Connection then
        pcall(function() ToFState.Connection:Disconnect() end)
        ToFState.Connection = nil
    end
    ToFState.IsAiming = false
    ToF_ClearLaser()
end

local SetToFSilentAim

local function ToF_EnsureInputs()
    if not ToFState.InputBegan then
        ToFState.InputBegan = UIS.InputBegan:Connect(function(inp, gp)
            if gp then return end
            local k = ToFKeyCodes[ALF.TOF_Key or "None"]
            if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then
                SetToFSilentAim(not ALF.TOF_SilentAim)
                return
            end
            if not ALF.TOF_SilentAim then return end
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or (inp.UserInputType == Enum.UserInputType.Touch and ToF_IsTouchShoot(inp)) then
                if ToF_IsBlocked() then ToFState.IsAiming = false; return end
                ToFState.IsAiming = true
                if inp.UserInputType == Enum.UserInputType.Touch then ToFState.TouchInput = inp end
                return
            end
        end)
    end
    if not ToFState.InputEnded then
        ToFState.InputEnded = UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
                or (inp.UserInputType == Enum.UserInputType.Touch and inp == ToFState.TouchInput) then
                local wa = ToFState.IsAiming
                ToFState.IsAiming = false
                if inp == ToFState.TouchInput then ToFState.TouchInput = nil end
                if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                if wa then
                    if ToF_IsBlocked() then return end
                    ToF_Shoot()
                end
            end
        end)
    end
end

SetToFSilentAim = function(en)
    ALF.TOF_SilentAim = en and true or false
    ToF_EnsureInputs()
    if ALF.TOF_SilentAim then ToF_StartConn()
    else ToF_StopConn() end
end

function ToF_SetTargetMode(mode)
    if mode ~= "Killer" and mode ~= "Survivors" and mode ~= "Zombie" then return end
    ALF.TOF_TargetMode = mode
end

ToF_EnsureInputs()

-- =========================================================
-- AIM LOCK HIDDEN / ATTACK / GUN
-- =========================================================
AttackAim = {
    Enabled = false, Holding = false, Strength = 1,
    Predict = true, PredictStrength = 0.12, FOV = 250,
    VisibilityCheck = true, AimPart = "HumanoidRootPart",
}
GunAim = {
    Enabled = false, Holding = false, TargetMode = "Killer",
    Strength = 1, Predict = true, PredictStrength = 0.12,
    FOV = 250, VisibilityCheck = true,
    AimPart = "HumanoidRootPart", Target = nil,
}

local AttackAimConnection = nil
local GunAimConnection = nil

local function AL_IsVisible(part)
    local cam = Workspace.CurrentCamera
    if not cam then return true end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = { LP.Character }
    local origin = cam.CFrame.Position
    local dir = part.Position - origin
    local result = Workspace:Raycast(origin, dir, rp)
    if not result then return true end
    return result.Instance:IsDescendantOf(part.Parent)
end

local function AL_GetAttackTarget()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    local closest, shortest = nil, AttackAim.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) and p.Character then
            local hrp = p.Character:FindFirstChild(AttackAim.AimPart)
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                if visible then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < shortest then
                        if AttackAim.VisibilityCheck and not AL_IsVisible(hrp) then continue end
                        shortest = dist
                        closest = hrp
                    end
                end
            end
        end
    end
    return closest
end

function AttackAim_Start()
    if AttackAimConnection then return end
    AttackAimConnection = RunService.RenderStepped:Connect(function()
        if not AttackAim.Enabled then return end
        if not AttackAim.Holding then return end
        local target = AL_GetAttackTarget()
        if not target then return end
        local cam = Workspace.CurrentCamera
        local pos = target.Position
        if AttackAim.Predict then
            pos = pos + (target.AssemblyLinearVelocity * AttackAim.PredictStrength)
        end
        cam.CFrame = CFrame.new(cam.CFrame.Position, pos)
    end)
end

local function GA_GetGunTarget()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    local closest, shortest = nil, GunAim.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team then
            local valid = false
            if GunAim.TargetMode == "Killer" and string.find(string.lower(p.Team.Name), "killer", 1, true) then valid = true
            elseif GunAim.TargetMode == "Survivor" and string.find(string.lower(p.Team.Name), "survivor", 1, true) then valid = true end
            if valid then
                local hrp = p.Character:FindFirstChild(GunAim.AimPart)
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                    if visible then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist < shortest then
                            if GunAim.VisibilityCheck and not AL_IsVisible(hrp) then continue end
                            shortest = dist
                            closest = hrp
                        end
                    end
                end
            end
        end
    end
    return closest
end

function GunAim_Start()
    if GunAimConnection then return end
    GunAimConnection = RunService.RenderStepped:Connect(function()
        if not GunAim.Enabled or not GunAim.Holding then
            GunAim.Target = nil; return
        end
        local target = GA_GetGunTarget()
        if not target then return end
        GunAim.Target = target
        local pos = target.Position
        if GunAim.Predict then
            pos = pos + (target.AssemblyLinearVelocity * GunAim.PredictStrength)
        end
        local cam = Workspace.CurrentCamera
        cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), GunAim.Strength)
    end)
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if AttackAim.Enabled then AttackAim.Holding = true end
        if GunAim.Enabled then GunAim.Holding = true end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        AttackAim.Holding = false
        GunAim.Holding = false
    end
end)

-- =========================================================
-- SPEAR AIMBOT
-- =========================================================
ALF.SPEAR_Aimbot = ALF.SPEAR_Aimbot or false
ALF.SPEAR_Gravity = ALF.SPEAR_Gravity or 50
ALF.SPEAR_Speed = ALF.SPEAR_Speed or 100

SpearBtnData = {
    UI = nil, Button = nil, Active = true, DragLocked = false,
    Dragging = false, DragStart = nil, DragStartPos = nil,
    ManualTarget = nil, TargetIndex = 0,
    TargetLabel = nil, LeftArrow = nil, RightArrow = nil,
}

local function SpearAimbotCalc(targetPos)
    if not ALF.SPEAR_Aimbot then return nil end
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local startPos = root.Position + Vector3.new(0, 2, 0)
    local distance = (targetPos - startPos).Magnitude
    local gravity  = ALF.SPEAR_Gravity or 50
    local speed    = ALF.SPEAR_Speed or 100
    local time     = distance / speed
    local drop     = 0.5 * gravity * time * time
    return targetPos + Vector3.new(0, drop, 0)
end

local function Spear_GetTargetList()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local list = {}
    if not root then return list end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Team and player.Team.Name == "Survivors" and player.Character then
            local tr = player.Character:FindFirstChild("HumanoidRootPart")
            local th = player.Character:FindFirstChildOfClass("Humanoid")
            if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                local dist = (tr.Position - root.Position).Magnitude
                table.insert(list, { Player = player, Dist = dist })
            end
        end
    end
    table.sort(list, function(a, b) return a.Dist < b.Dist end)
    local players = {}
    for _, v in ipairs(list) do table.insert(players, v.Player) end
    return players
end

local function Spear_CycleTarget(direction)
    local list = Spear_GetTargetList()
    if #list == 0 then
        SpearBtnData.ManualTarget = nil
        SpearBtnData.TargetIndex = 0
        return
    end
    local curIdx = nil
    if SpearBtnData.ManualTarget then
        for i, p in ipairs(list) do
            if p == SpearBtnData.ManualTarget then curIdx = i; break end
        end
    end
    local nextIdx
    if curIdx then
        nextIdx = curIdx + direction
        if nextIdx > #list then nextIdx = 1 end
        if nextIdx < 1 then nextIdx = #list end
    else
        nextIdx = 1
    end
    SpearBtnData.TargetIndex  = nextIdx
    SpearBtnData.ManualTarget = list[nextIdx]
    if SpearBtnData.TargetLabel then
        SpearBtnData.TargetLabel.Text = SpearBtnData.ManualTarget.Name
    end
end

local function Spear_UpdateAim()
    if not ALF.SPEAR_Aimbot then return end
    if SpearBtnData and not SpearBtnData.Active then return end
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local target = nil
    if SpearBtnData.ManualTarget then
        local p = SpearBtnData.ManualTarget
        local valid = p.Parent and p.Team and p.Team.Name == "Survivors" and p.Character
        if valid then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            local th = p.Character:FindFirstChildOfClass("Humanoid")
            valid = tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25
        end
        if valid then target = p
        else SpearBtnData.ManualTarget = nil end
    end
    if not target then
        local closest, closestDist = nil, math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and player.Team and player.Team.Name == "Survivors" and player.Character then
                local tr = player.Character:FindFirstChild("HumanoidRootPart")
                local th = player.Character:FindFirstChildOfClass("Humanoid")
                if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                    local dist = (tr.Position - root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = player
                    end
                end
            end
        end
        target = closest
    end
    if target and target.Character then
        local tr = target.Character:FindFirstChild("HumanoidRootPart")
        if tr then
            local aimPos = SpearAimbotCalc(tr.Position)
            if aimPos then
                local cam = Workspace.CurrentCamera
                if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, aimPos) end
            end
        end
    end
end

function SpearAimbot_SetEnabled(v)
    ALF.SPEAR_Aimbot = v and true or false
end

function SpearAimbot_SetGravity(v) ALF.SPEAR_Gravity = tonumber(v) or 50 end
function SpearAimbot_SetSpeed(v) ALF.SPEAR_Speed = tonumber(v) or 100 end

RunService.RenderStepped:Connect(function()
    pcall(Spear_UpdateAim)
end)

-- =========================================================
-- DASH LOCK + LOCK POV
-- =========================================================
ALF.DashLockEnabled = ALF.DashLockEnabled or false
ALF.DashLockDuration = ALF.DashLockDuration or 1.5
ALF.DashLockSmoothness = ALF.DashLockSmoothness or 0.3
ALF.FreezeDuringDashLock = ALF.FreezeDuringDashLock or false
ALF._DashLockActive = false
ALF._DashLockTarget = nil
ALF._DashLockConnection = nil

local DashAnimationId = "rbxassetid://98163597193511"

local function DashLock_Update()
    if not ALF.DashLockEnabled or not ALF._DashLockActive then return end
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then ALF._DashLockTarget = nil; return end
    local target, targetDist = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Team and player.Team.Name == "Survivors" then
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                if root and hum and hum.Health > 0 then
                    local dist = (myRoot.Position - root.Position).Magnitude
                    if dist < targetDist then targetDist = dist; target = root end
                end
            end
        end
    end
    if not target then ALF._DashLockTarget = nil; return end
    ALF._DashLockTarget = target
    local cam = Workspace.CurrentCamera
    if cam then
        local smooth = ALF.DashLockSmoothness or 0.3
        cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), smooth)
    end
    if ALF.FreezeDuringDashLock then
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= 0 then hum.WalkSpeed = 0 end
    end
end

local function DashLock_SetActive(active)
    active = active and true or false
    if active == ALF._DashLockActive then return end
    ALF._DashLockActive = active
    if active then
        if not ALF._DashLockConnection then
            ALF._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
        end
    else
        if ALF._DashLockConnection then
            pcall(function() ALF._DashLockConnection:Disconnect() end)
            ALF._DashLockConnection = nil
        end
        ALF._DashLockTarget = nil
        if ALF.FreezeDuringDashLock then
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
        end
    end
end

local function DashLock_HookCharacter(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
    if not anim then return end
    anim.AnimationPlayed:Connect(function(track)
        if not ALF.DashLockEnabled then return end
        local aid = track.Animation and track.Animation.AnimationId or ""
        if aid == DashAnimationId then
            DashLock_SetActive(true)
            task.delay(ALF.DashLockDuration or 1.5, function()
                DashLock_SetActive(false)
            end)
        end
    end)
end

if LP.Character then DashLock_HookCharacter(LP.Character) end
LP.CharacterAdded:Connect(function(c)
    task.wait(0.5); DashLock_HookCharacter(c)
end)

function DashLock_SetEnabled(v)
    ALF.DashLockEnabled = v and true or false
    if not v then DashLock_SetActive(false) end
end

-- Lock POV
LockPOV = { Enabled = false, LockedFOV = 80, OriginalFOV = nil, Connection = nil }

local function LockPOV_Update()
    if not LockPOV.Enabled then return end
    local cam = Workspace.CurrentCamera
    if not cam then return end
    if math.abs(cam.FieldOfView - LockPOV.LockedFOV) > 0.1 then
        cam.FieldOfView = LockPOV.LockedFOV
    end
end

function LockPOV_SetEnabled(en)
    LockPOV.Enabled = en and true or false
    if LockPOV.Enabled then
        local cam = Workspace.CurrentCamera
        if cam then
            LockPOV.OriginalFOV = cam.FieldOfView
            if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
            cam.FieldOfView = LockPOV.LockedFOV
            LockPOV.Connection = RunService.RenderStepped:Connect(LockPOV_Update)
        end
    else
        if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
        local cam = Workspace.CurrentCamera
        if cam and LockPOV.OriginalFOV then cam.FieldOfView = LockPOV.OriginalFOV end
    end
end

print("[18/20] Combat+ (15 fitur ALF) OK")-- =========================================================
-- Section 19 : ESP+ + Misc+ (16 fitur ALF)
-- =========================================================

-- =========================================================
-- STATUS ESP ADVANCED (dari ALF)
-- =========================================================
ALF.StatusESP_Advanced = ALF.StatusESP_Advanced or false
ALF.StatusESP_ShowAvatar = ALF.StatusESP_ShowAvatar ~= false
ALF.StatusESP_ShowAction = ALF.StatusESP_ShowAction ~= false
ALF.StatusESP_AutoScale = ALF.StatusESP_AutoScale ~= false
ALF.StatusESP_Radius = ALF.StatusESP_Radius or 500

StatusESPAdvanced = {}
CachedSCPAdvanced = {}

local function AdvancedCacheObject(obj)
    if not obj then return end
    local ln = string.lower(obj.Name)
    if string.find(ln, "scp", 1, true) then CachedSCPAdvanced[obj] = true end
end

for _, obj in ipairs(workspace:GetDescendants()) do AdvancedCacheObject(obj) end
workspace.DescendantAdded:Connect(AdvancedCacheObject)
workspace.DescendantRemoving:Connect(function(obj)
    CachedSCPAdvanced[obj] = nil
    if StatusESPAdvanced[obj] then
        pcall(function() StatusESPAdvanced[obj]:Destroy() end)
        StatusESPAdvanced[obj] = nil
    end
end)

local function StatusESP_GetAction(char, hum)
    if not char or not hum then return "IDLE", Color3.fromRGB(150, 150, 150) end
    if hum.Health <= 0 then return "DEAD", Color3.fromRGB(200, 60, 60) end
    if char:GetAttribute("IsHooked") or char:GetAttribute("isHooked") or char:GetAttribute("Hooked") then
        return "HOOKED", Color3.fromRGB(255, 60, 60)
    end
    if char:GetAttribute("IsCarried") or char:GetAttribute("isCarried") or char:GetAttribute("Carried") then
        return "CARRIED", Color3.fromRGB(255, 100, 100)
    end
    local state = char:GetAttribute("State")
    if state == "Downed" or char:GetAttribute("Knocked") == true
       or char:GetAttribute("IsDown") == true or char:GetAttribute("Downed") == true then
        return "DOWNED", Color3.fromRGB(255, 130, 60)
    end
    local ci = char:FindFirstChild("CheckInterractable")
    if ci then
        if ci:GetAttribute("isRepairing") then return "REPAIR", Color3.fromRGB(255, 220, 60) end
        if ci:GetAttribute("isHealing") then return "HEAL", Color3.fromRGB(80, 220, 120) end
        if ci:GetAttribute("isVaulting") then return "VAULT", Color3.fromRGB(120, 200, 255) end
        if ci:GetAttribute("isSliding") then return "SLIDE", Color3.fromRGB(150, 180, 255) end
        if ci:GetAttribute("isDroppingPallet") then return "PALLET", Color3.fromRGB(255, 165, 60) end
        if ci:GetAttribute("isUnhooking") then return "UNHOOK", Color3.fromRGB(180, 120, 255) end
        if ci:GetAttribute("isExiting") then return "EXIT", Color3.fromRGB(80, 255, 180) end
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local vel = root.AssemblyLinearVelocity
        local speed = Vector3.new(vel.X, 0, vel.Z).Magnitude
        if speed > 20 then return "SPRINT", Color3.fromRGB(120, 255, 200) end
        if speed > 2 then return "MOVE", Color3.fromRGB(200, 200, 220) end
    end
    return "IDLE", Color3.fromRGB(150, 150, 150)
end

local function CreateStatusESPAdvanced(plr, char, root)
    if not ALF.StatusESP_Advanced then
        if StatusESPAdvanced[char] then
            pcall(function() StatusESPAdvanced[char]:Destroy() end)
            StatusESPAdvanced[char] = nil
        end
        return
    end
    if not root then return end
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local isDown = hum.Health <= 0 or hum.Health < 2
        or char:GetAttribute("Downed") == true
        or char:GetAttribute("IsDown") == true
        or char:GetAttribute("Knocked") == true

    local dist = (head.Position - root.Position).Magnitude
    if dist > (ALF.StatusESP_Radius or 500) then
        if StatusESPAdvanced[char] then
            pcall(function() StatusESPAdvanced[char]:Destroy() end)
            StatusESPAdvanced[char] = nil
        end
        return
    end

    local accentColor = Color3.fromRGB(255, 255, 255)
    if plr.Team then
        if plr.Team.Name == "Killer" then accentColor = TeamColors.Killer
        elseif plr.Team.Name == "Survivors" then accentColor = TeamColors.Survivor end
    end
    if isDown then accentColor = Color3.fromRGB(255, 60, 60) end

    local hpPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
    local hpColor
    if hpPct > 0.6 then hpColor = Color3.fromRGB(80, 220, 120)
    elseif hpPct > 0.3 then hpColor = Color3.fromRGB(255, 200, 60)
    else hpColor = Color3.fromRGB(255, 80, 80) end

    local actionText, actionColor = StatusESP_GetAction(char, hum)

    local bb = StatusESPAdvanced[char]
    if not bb or not bb.Parent then
        bb = Instance.new("BillboardGui")
        bb.Name = "GlutoStatusESPAdvanced"
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.Adornee = head
        bb.StudsOffset = Vector3.new(0, 2.5, 0)
        bb.Size = UDim2.fromOffset(260, 40)
        bb.Parent = char

        local scaleObj = Instance.new("UIScale")
        scaleObj.Name = "DistScale"
        scaleObj.Scale = 1
        scaleObj.Parent = bb

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Name = "NameLbl"
        nameLbl.BackgroundTransparency = 1
        nameLbl.Size = UDim2.new(1, 0, 0, 16)
        nameLbl.Position = UDim2.new(0, 0, 0, 0)
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextSize = 13
        nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLbl.TextStrokeTransparency = 0.2
        nameLbl.TextXAlignment = Enum.TextXAlignment.Center
        nameLbl.TextYAlignment = Enum.TextYAlignment.Center
        nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
        nameLbl.Parent = bb

        local pill = Instance.new("Frame")
        pill.Name = "Pill"
        pill.AnchorPoint = Vector2.new(0.5, 0)
        pill.Position = UDim2.new(0.5, 0, 0, 18)
        pill.Size = UDim2.fromOffset(120, 22)
        pill.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
        pill.BackgroundTransparency = 0.15
        pill.BorderSizePixel = 0
        pill.Parent = bb
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

        local pillStroke = Instance.new("UIStroke", pill)
        pillStroke.Name = "PillStroke"
        pillStroke.Color = accentColor
        pillStroke.Thickness = 1
        pillStroke.Transparency = 0.5
        pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local layout = Instance.new("UIListLayout", pill)
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local pad = Instance.new("UIPadding", pill)
        pad.PaddingLeft = UDim.new(0, 6)
        pad.PaddingRight = UDim.new(0, 8)

        local avatarHolder = Instance.new("Frame")
        avatarHolder.Name = "AvatarHolder"
        avatarHolder.Size = UDim2.fromOffset(18, 18)
        avatarHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
        avatarHolder.BorderSizePixel = 0
        avatarHolder.LayoutOrder = 1
        avatarHolder.ClipsDescendants = true
        avatarHolder.Parent = pill
        Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0)

        local avatarStroke = Instance.new("UIStroke", avatarHolder)
        avatarStroke.Name = "AvatarStroke"
        avatarStroke.Color = accentColor
        avatarStroke.Thickness = 1.2
        avatarStroke.Transparency = 0.3
        avatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local avatarImg = Instance.new("ImageLabel")
        avatarImg.Name = "AvatarImg"
        avatarImg.Size = UDim2.fromScale(1, 1)
        avatarImg.BackgroundTransparency = 1
        avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
        avatarImg.Parent = avatarHolder

        local dot = Instance.new("Frame")
        dot.Name = "Dot"
        dot.Size = UDim2.fromOffset(7, 7)
        dot.BackgroundColor3 = accentColor
        dot.BorderSizePixel = 0
        dot.LayoutOrder = 1
        dot.Visible = false
        dot.Parent = pill
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        local distLbl = Instance.new("TextLabel")
        distLbl.Name = "DistLbl"
        distLbl.BackgroundTransparency = 1
        distLbl.Size = UDim2.fromOffset(32, 14)
        distLbl.Font = Enum.Font.GothamBold
        distLbl.TextSize = 11
        distLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
        distLbl.Text = "0m"
        distLbl.LayoutOrder = 2
        distLbl.Parent = pill

        local actionLbl = Instance.new("TextLabel")
        actionLbl.Name = "ActionLbl"
        actionLbl.BackgroundTransparency = 1
        actionLbl.Size = UDim2.fromOffset(50, 14)
        actionLbl.Font = Enum.Font.GothamBold
        actionLbl.TextSize = 10
        actionLbl.TextColor3 = actionColor
        actionLbl.Text = "IDLE"
        actionLbl.LayoutOrder = 3
        actionLbl.Parent = pill

        local hpBarBg = Instance.new("Frame")
        hpBarBg.Name = "HPBarBg"
        hpBarBg.Size = UDim2.fromOffset(38, 4)
        hpBarBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        hpBarBg.BorderSizePixel = 0
        hpBarBg.LayoutOrder = 4
        hpBarBg.Parent = pill
        Instance.new("UICorner", hpBarBg).CornerRadius = UDim.new(1, 0)

        local hpBarFill = Instance.new("Frame")
        hpBarFill.Name = "HPBarFill"
        hpBarFill.Size = UDim2.new(1, 0, 1, 0)
        hpBarFill.BackgroundColor3 = hpColor
        hpBarFill.BorderSizePixel = 0
        hpBarFill.Parent = hpBarBg
        Instance.new("UICorner", hpBarFill).CornerRadius = UDim.new(1, 0)

        local downPill = Instance.new("Frame")
        downPill.Name = "DownPill"
        downPill.Size = UDim2.fromOffset(36, 14)
        downPill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        downPill.BackgroundTransparency = 0.1
        downPill.BorderSizePixel = 0
        downPill.Visible = false
        downPill.LayoutOrder = 5
        downPill.Parent = pill
        Instance.new("UICorner", downPill).CornerRadius = UDim.new(1, 0)

        local downLbl = Instance.new("TextLabel")
        downLbl.Name = "DownLbl"
        downLbl.Size = UDim2.new(1, 0, 1, 0)
        downLbl.BackgroundTransparency = 1
        downLbl.Font = Enum.Font.GothamBold
        downLbl.TextSize = 9
        downLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        downLbl.Text = "DOWN"
        downLbl.Parent = downPill

        StatusESPAdvanced[char] = bb
    end

    local nameLbl = bb:FindFirstChild("NameLbl")
    local pill = bb:FindFirstChild("Pill")
    if not pill then return end
    local pillStroke = pill:FindFirstChild("PillStroke")
    local avatarHolder = pill:FindFirstChild("AvatarHolder")
    local avatarStroke = avatarHolder and avatarHolder:FindFirstChild("AvatarStroke")
    local dot = pill:FindFirstChild("Dot")
    local distLbl = pill:FindFirstChild("DistLbl")
    local actionLbl = pill:FindFirstChild("ActionLbl")
    local hpBarBg = pill:FindFirstChild("HPBarBg")
    local hpBarFill = hpBarBg and hpBarBg:FindFirstChild("HPBarFill")
    local downPill = pill:FindFirstChild("DownPill")
    local distScale = bb:FindFirstChild("DistScale")

    if pillStroke then
        pillStroke.Color = accentColor
        pillStroke.Transparency = isDown and 0.2 or 0.5
    end
    if avatarHolder then
        avatarHolder.Visible = ALF.StatusESP_ShowAvatar == true
        if avatarStroke then avatarStroke.Color = accentColor end
    end
    if dot then
        dot.Visible = (ALF.StatusESP_ShowAvatar ~= true)
        dot.BackgroundColor3 = accentColor
    end
    if nameLbl then
        nameLbl.Text = plr.Name
        nameLbl.TextColor3 = isDown and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
    end
    if distLbl then
        distLbl.Text = string.format("%.0fm", dist)
    end
    if actionLbl then
        actionLbl.Text = actionText
        actionLbl.TextColor3 = actionColor
        actionLbl.Visible = ALF.StatusESP_ShowAction == true
    end
    if hpBarBg and hpBarFill then
        hpBarFill.Size = UDim2.new(hpPct, 0, 1, 0)
        hpBarFill.BackgroundColor3 = hpColor
    end
    if downPill then downPill.Visible = isDown end

    local totalW = 14
    local count = 0
    if ALF.StatusESP_ShowAvatar then totalW = totalW + 18; count = count + 1
    else totalW = totalW + 7; count = count + 1 end
    totalW = totalW + 32; count = count + 1
    if ALF.StatusESP_ShowAction then totalW = totalW + 50; count = count + 1 end
    totalW = totalW + 38; count = count + 1
    if isDown then totalW = totalW + 36; count = count + 1 end
    totalW = totalW + math.max(count - 1, 0) * 5
    if totalW < 50 then totalW = 50 end
    if totalW > 240 then totalW = 240 end
    pill.Size = UDim2.fromOffset(totalW, 22)
    pill.Visible = true
    bb.Size = UDim2.fromOffset(260, 40)

    if distScale and ALF.StatusESP_AutoScale then
        local scaleVal = 1 - (dist - 50) / 500
        scaleVal = math.clamp(scaleVal, 0.5, 1.05)
        distScale.Scale = scaleVal
    end
end

RunService.RenderStepped:Connect(function()
    if not ALF.StatusESP_Advanced then return end
    local root = getRoot()
    if not root then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                CreateStatusESPAdvanced(p, p.Character, root)
            else
                if StatusESPAdvanced[p.Character] then
                    pcall(function() StatusESPAdvanced[p.Character]:Destroy() end)
                    StatusESPAdvanced[p.Character] = nil
                end
            end
        end
    end
end)

-- =========================================================
-- NO FALL DAMAGE
-- =========================================================
FallHookInstalled = false

local function InstallNoFallHook()
    if FallHookInstalled then return end
    FallHookInstalled = true
    task.spawn(function()
        pcall(function()
            local mt = getrawmetatable and getrawmetatable(game)
            if not mt then return end
            local oldNamecall = mt.__namecall
            if setreadonly then setreadonly(mt, false) end
            mt.__namecall = newcclosure(function(self, ...)
                if not checkcaller() and getgenv().Roooor_ALF and getgenv().Roooor_ALF.NoFallDamage then
                    local method = getnamecallmethod()
                    if method == "FireServer" then
                        local ok, name = pcall(function() return self.Name end)
                        if ok and name == "Fall" then
                            local par = self.Parent
                            if par and par.Name == "Mechanics" then
                                return nil
                            end
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            if setreadonly then setreadonly(mt, true) end
        end)
    end)
end

InstallNoFallHook()

-- =========================================================
-- NEXT MAP PREDICTION
-- =========================================================
MapPredictState = { Gui = nil, Thread = nil, Enabled = false, LastMap = "Unknown" }

local function DetectMapName(map)
    if not map then return nil end
    if map:FindFirstChild("random shakes") or map:FindFirstChild("SCP-173 Room") or map:FindFirstChild("SCP-205 Room") then
        return "Site 68"
    elseif map:FindFirstChild("HooksMeat") then
        return "BLOODBATH! Club"
    elseif map:FindFirstChild("Gate") and map.Gate:FindFirstChild("vfx") then
        return "Firelink Shrine"
    elseif map:FindFirstChild("Bldg_Addon_RooftopUnit_A") or map:FindFirstChild("Rooftop") then
        return "Mercy Hospital Rooftop"
    elseif map:FindFirstChild("White Armored Car") then
        return "Mount Massive Asylum"
    elseif map:FindFirstChild("Dumbster") then
        return "The Bay Harbor"
    elseif map:FindFirstChild("water pump") then
        return "Valdelobos Village"
    elseif map:FindFirstChild("LargeBoulder01") then
        return "Woodview Cabin"
    end
    return nil
end

local function BuildMapGui()
    if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end) end
    local pg = LP:FindFirstChild("PlayerGui")
    if not pg then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "GlutoMapPredict"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 50
    gui.Parent = pg

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 210, 0, 54)
    frame.Position = UDim2.new(0.5, -105, 0, 110)
    frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 15)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "NEXT MAP PREDICTION"
    title.TextColor3 = Color3.fromRGB(150, 180, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 10
    title.Parent = frame

    local mapName = Instance.new("TextLabel")
    mapName.Name = "MapName"
    mapName.Size = UDim2.new(1, -12, 0, 18)
    mapName.Position = UDim2.new(0, 6, 0, 21)
    mapName.BackgroundTransparency = 1
    mapName.Text = "Scanning..."
    mapName.TextColor3 = Color3.fromRGB(255, 255, 255)
    mapName.Font = Enum.Font.GothamBold
    mapName.TextSize = 13
    mapName.TextXAlignment = Enum.TextXAlignment.Center
    mapName.Parent = frame

    local status = Instance.new("TextLabel")
    status.Name = "StatusLabel"
    status.Size = UDim2.new(1, -12, 0, 12)
    status.Position = UDim2.new(0, 6, 0, 38)
    status.BackgroundTransparency = 1
    status.Text = "Status: Waiting"
    status.TextColor3 = Color3.fromRGB(150, 150, 150)
    status.Font = Enum.Font.GothamMedium
    status.TextSize = 9
    status.TextXAlignment = Enum.TextXAlignment.Center
    status.Parent = frame

    local dragging, dragStart, startPos = false, nil, nil
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    MapPredictState.Gui = gui
end

local function StopMapPredict()
    MapPredictState.Enabled = false
    if MapPredictState.Thread then
        pcall(function() task.cancel(MapPredictState.Thread) end)
        MapPredictState.Thread = nil
    end
    if MapPredictState.Gui then
        pcall(function() MapPredictState.Gui:Destroy() end)
        MapPredictState.Gui = nil
    end
end

local function StartMapPredict()
    if MapPredictState.Enabled then return end
    MapPredictState.Enabled = true
    BuildMapGui()
    MapPredictState.Thread = task.spawn(function()
        local lastDetected, lastExisted = nil, false
        while MapPredictState.Enabled do
            local map = workspace:FindFirstChild("Map")
            local mapExists = map ~= nil
            local detected = mapExists and DetectMapName(map) or nil
            local gui = MapPredictState.Gui
            local frame = gui and gui:FindFirstChild("MainFrame")
            local nameLabel = frame and frame:FindFirstChild("MapName")
            local statusLabel = frame and frame:FindFirstChild("StatusLabel")
            if nameLabel and statusLabel then
                if lastExisted and not mapExists then
                    nameLabel.Text = lastDetected or "Unknown"
                    statusLabel.Text = "Status: Loading next map..."
                    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
                elseif mapExists then
                    lastDetected = detected or "Unknown"
                    nameLabel.Text = detected or "Unknown"
                    statusLabel.Text = "Status: In-Game"
                    statusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
                else
                    nameLabel.Text = "Waiting..."
                    statusLabel.Text = "Status: Lobby"
                    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
                end
            end
            lastExisted = mapExists
            task.wait(0.5)
        end
    end)
end

function NextMapPredict_SetEnabled(v)
    ALF.NextMapPredict = v and true or false
    if ALF.NextMapPredict then StartMapPredict() else StopMapPredict() end
end

-- =========================================================
-- STUN SOUND PICKER (12 suara dari ALF)
-- =========================================================
STUN_SOUND_PICKER_ENABLED = ALF.StunSoundEnabled or false
STUN_SOUND_SELECTED = ALF.StunSoundSelected or "Default"
STUN_SOUND_VOLUME = ALF.StunSoundVolume or 1.5
STUN_SOUND_RANGE = ALF.StunSoundRange or 500

local function StunSound_GetActiveSoundId()
    return StunSounds[STUN_SOUND_SELECTED] or StunSounds["Default"]
end

local function StunSound_Play(char)
    if not STUN_SOUND_PICKER_ENABLED then return end
    pcall(function()
        local head = char and char:FindFirstChild("Head")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local attachTo = head or hrp
        if not attachTo then return end
        local snd = Instance.new("Sound")
        snd.Name = "GlutoStunSound"
        snd.SoundId = "rbxassetid://" .. tostring(StunSound_GetActiveSoundId())
        snd.Volume = STUN_SOUND_VOLUME
        snd.PlaybackSpeed = 1
        snd.RollOffMaxDistance = STUN_SOUND_RANGE
        snd.RollOffMinDistance = 10
        snd.RollOffMode = Enum.RollOffMode.InverseTapered
        snd.Parent = attachTo
        snd:Play()
        snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
        task.delay(5, function()
            pcall(function() if snd and snd.Parent then snd:Destroy() end end)
        end)
    end)
end

function StunSound_TestSound()
    pcall(function()
        local snd = Instance.new("Sound")
        snd.SoundId = "rbxassetid://" .. tostring(StunSound_GetActiveSoundId())
        snd.Volume = STUN_SOUND_VOLUME
        snd.Parent = SoundService
        snd:Play()
        snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
        task.delay(5, function()
            pcall(function() if snd and snd.Parent then snd:Destroy() end end)
        end)
    end)
end

function StunSound_SetEnabled(v)
    ALF.StunSoundEnabled = v and true or false
    STUN_SOUND_PICKER_ENABLED = ALF.StunSoundEnabled
end

function StunSound_SetSelected(name)
    ALF.StunSoundSelected = name
    STUN_SOUND_SELECTED = name
end

function StunSound_SetVolume(v)
    ALF.StunSoundVolume = tonumber(v) or 1.5
    STUN_SOUND_VOLUME = ALF.StunSoundVolume
end

function StunSound_SetRange(v)
    ALF.StunSoundRange = tonumber(v) or 500
    STUN_SOUND_RANGE = ALF.StunSoundRange
end

-- Override PlayStunSound (dari Section 13) biar pakai picker
local OriginalPlayStunSound = PlayStunSound
function PlayStunSound(char)
    if STUN_SOUND_PICKER_ENABLED then
        StunSound_Play(char)
    else
        OriginalPlayStunSound(char)
    end
end

-- =========================================================
-- SPEED BOOST
-- =========================================================
SpeedBoostConnection = nil

local function ShouldDisableSpeedBoost()
    local char = LP.Character
    if not char then return true end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local animator = hum:FindFirstChildOfClass("Animator")
        if animator then
            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                local anim = track.Animation
                if anim and anim.AnimationId then
                    if anim.AnimationId == "rbxassetid://127096285501517" then return true end
                    if anim.AnimationId == "rbxassetid://112166042383605" then return true end
                    if anim.AnimationId == "http://www.roblox.com/asset/?id=126965695851149" then return true end
                    if anim.AnimationId == "http://www.roblox.com/asset/?id=135084204086504" then return true end
                    if anim.AnimationId == "rbxassetid://123047897844134" then return true end
                    local id = anim.AnimationId:match("%d+")
                    if id and KillerAnims["rbxassetid://" .. id] then return true end
                end
            end
        end
        if hum.Health <= 0 or hum.Health < 2
            or char:GetAttribute("Downed") == true
            or char:GetAttribute("IsDown") == true
            or char:GetAttribute("Knocked") == true then
            return true
        end
    end
    return false
end

function SpeedBoost_SetEnabled(v)
    ALF.SpeedBoostEnabled = v and true or false
    if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
    if not ALF.SpeedBoostEnabled then
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then pcall(function() hum.WalkSpeed = 16 end) end
        return
    end
    SpeedBoostConnection = RunService.Heartbeat:Connect(function()
        if not ALF.SpeedBoostEnabled then return end
        if ShouldDisableSpeedBoost() then return end
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= ALF.SpeedBoostValue then
            pcall(function() hum.WalkSpeed = ALF.SpeedBoostValue end)
        end
    end)
end

function SpeedBoost_SetValue(v)
    ALF.SpeedBoostValue = tonumber(v) or 30
end

LP.CharacterAdded:Connect(function()
    task.wait(0.8)
    if ALF.SpeedBoostEnabled then SpeedBoost_SetEnabled(true) end
end)

-- =========================================================
-- CURSOR FEATURE
-- =========================================================
CursorThread = nil
CursorSavedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }

function Cursor_SetEnabled(v)
    ALF.CursorEnabled = v and true or false
    if v then
        CursorSavedOriginal.MouseIconEnabled = UIS.MouseIconEnabled
        CursorSavedOriginal.MouseBehavior = UIS.MouseBehavior
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        CursorSavedOriginal.AutoRotate = hum and hum.AutoRotate or true

        pcall(function()
            UIS.MouseIconEnabled = true
            UIS.MouseBehavior = Enum.MouseBehavior.Default
        end)
        if hum then pcall(function() hum.AutoRotate = false end) end

        if CursorThread then pcall(function() task.cancel(CursorThread) end) end
        CursorThread = task.spawn(function()
            while ALF.CursorEnabled do
                pcall(function()
                    UIS.MouseIconEnabled = true
                    UIS.MouseBehavior = Enum.MouseBehavior.Default
                end)
                local c = LP.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.AutoRotate then h.AutoRotate = false end
                task.wait(0.1)
            end
        end)
    else
        ALF.CursorEnabled = false
        if CursorThread then
            pcall(function() task.cancel(CursorThread) end)
            CursorThread = nil
        end
        pcall(function()
            UIS.MouseIconEnabled = CursorSavedOriginal.MouseIconEnabled or false
            UIS.MouseBehavior = CursorSavedOriginal.MouseBehavior or Enum.MouseBehavior.LockCenter
        end)
        local c = LP.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then pcall(function() h.AutoRotate = CursorSavedOriginal.AutoRotate or true end) end
    end
end

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        Cursor_SetEnabled(not ALF.CursorEnabled)
    end
end)

LP.CharacterAdded:Connect(function()
    task.wait(1)
    if ALF.CursorEnabled then Cursor_SetEnabled(true) end
end)

-- =========================================================
-- CAMERA DBD (Smooth Follow + POV Lock)
-- =========================================================
CameraBindName = "Gluto_CameraDBD_Smooth"
CameraDBD_PreviousPosition = nil
CameraDBD_PreviousRotation = nil
CameraDBD_OriginalPOV = 70

pcall(function() RunService:UnbindFromRenderStep(CameraBindName) end)

RunService:BindToRenderStep(
    CameraBindName,
    Enum.RenderPriority.Camera.Value + 1,
    function(DeltaTime)
        local Camera = workspace.CurrentCamera
        if not Camera then return end
        if Camera.CameraType ~= Enum.CameraType.Custom
           and Camera.CameraType ~= Enum.CameraType.Follow then
            CameraDBD_PreviousPosition = nil
            CameraDBD_PreviousRotation = nil
            return
        end
        if ALF.CamDBD_SmoothEnabled then
            local CurrentCFrame   = Camera.CFrame
            local CurrentPosition = CurrentCFrame.Position
            local CurrentRotation = CurrentCFrame.Rotation
            if not CameraDBD_PreviousPosition or not CameraDBD_PreviousRotation then
                CameraDBD_PreviousPosition = CurrentPosition
                CameraDBD_PreviousRotation = CurrentRotation
            else
                local smoothSpeed = tonumber(ALF.CamDBD_SmoothSpeed) or 5
                local posAlpha = 1 - math.exp(-smoothSpeed * DeltaTime)
                CameraDBD_PreviousPosition = CameraDBD_PreviousPosition:Lerp(CurrentPosition, posAlpha)
                local rotAlpha = 1 - math.exp(-(smoothSpeed * 1.90) * DeltaTime)
                CameraDBD_PreviousRotation = CameraDBD_PreviousRotation:Lerp(CurrentRotation, rotAlpha)
                Camera.CFrame = CFrame.new(CameraDBD_PreviousPosition) * CameraDBD_PreviousRotation
            end
        else
            CameraDBD_PreviousPosition = nil
            CameraDBD_PreviousRotation = nil
        end
        if ALF.CamDBD_POVEnabled then
            local povSpeed = tonumber(ALF.CamDBD_POVSmooth) or 9
            local alpha = 1 - math.exp(-povSpeed * DeltaTime)
            local target = tonumber(ALF.CamDBD_TargetPOV) or 85
            Camera.FieldOfView = Camera.FieldOfView + (target - Camera.FieldOfView) * alpha
        end
    end
)

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    CameraDBD_PreviousPosition = nil
    CameraDBD_PreviousRotation = nil
end)

function CamDBD_SetSmooth(v)
    ALF.CamDBD_SmoothEnabled = v and true or false
    if not v then
        CameraDBD_PreviousPosition = nil
        CameraDBD_PreviousRotation = nil
    else
        local cam = workspace.CurrentCamera
        if cam then
            CameraDBD_PreviousPosition = cam.CFrame.Position
            CameraDBD_PreviousRotation = cam.CFrame.Rotation
        end
    end
end

function CamDBD_SetSmoothSpeed(v) ALF.CamDBD_SmoothSpeed = tonumber(v) or 5 end

function CamDBD_SetPOVLock(v)
    ALF.CamDBD_POVEnabled = v and true or false
    if not v then
        local cam = workspace.CurrentCamera
        if cam then cam.FieldOfView = CameraDBD_OriginalPOV end
    else
        local cam = workspace.CurrentCamera
        if cam then CameraDBD_OriginalPOV = cam.FieldOfView end
    end
end

function CamDBD_SetTargetPOV(v) ALF.CamDBD_TargetPOV = tonumber(v) or 85 end
function CamDBD_SetPOVSmooth(v) ALF.CamDBD_POVSmooth = tonumber(v) or 9 end

-- =========================================================
-- SPECTATOR COUNTER
-- =========================================================
SpecEnabled = false
SpecGui = nil
SpecLabel = nil
SpecThread = nil

local function Spec_CreateUI()
    if SpecGui then SpecGui:Destroy(); SpecGui = nil end
    SpecGui = Instance.new("ScreenGui")
    SpecGui.Name = "GlutoSpectatorCounter"
    SpecGui.ResetOnSpawn = false
    SpecGui.IgnoreGuiInset = true
    local ok = pcall(function() SpecGui.Parent = game:GetService("CoreGui") end)
    if not ok then SpecGui.Parent = PG end

    local mainFrame = Instance.new("Frame", SpecGui)
    mainFrame.Name = "MainBox"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
    mainFrame.Size = UDim2.new(0, 145, 0, 52)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel", mainFrame)
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 18)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = "Spectators"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 10

    local body = Instance.new("Frame", mainFrame)
    body.Name = "Body"
    body.Size = UDim2.new(1, 0, 1, -25)
    body.Position = UDim2.new(0, 0, 0, 25)
    body.BackgroundTransparency = 1

    SpecLabel = Instance.new("TextLabel", body)
    SpecLabel.Name = "CountLabel"
    SpecLabel.Size = UDim2.new(1, 0, 1, 0)
    SpecLabel.BackgroundTransparency = 1
    SpecLabel.Font = Enum.Font.GothamMedium
    SpecLabel.Text = "No spectators"
    SpecLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    SpecLabel.TextSize = 10

    local dragging, dragStart, startPos = false, nil, nil
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = mainFrame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function Spec_Update()
    if not SpecEnabled or not SpecLabel then return end
    local count = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Team and p.Team.Name == "Spectator" then count = count + 1 end
    end
    if count == 0 then
        SpecLabel.Text = "No spectators"
        SpecLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    else
        SpecLabel.Text = count .. " spectators"
        SpecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

function SpectatorCounter_SetEnabled(state)
    SpecEnabled = state
    if SpecThread then task.cancel(SpecThread); SpecThread = nil end
    if state then
        Spec_CreateUI()
        Spec_Update()
        SpecThread = task.spawn(function()
            while SpecEnabled do Spec_Update(); task.wait(1.2) end
        end)
    else
        if SpecGui then SpecGui:Destroy(); SpecGui = nil; SpecLabel = nil end
    end
end

-- =========================================================
-- HEADER TITLE
-- =========================================================
HeaderEnabled = false
HeaderText = "ONE W"
HeaderState = { Billboard = nil, TextLabel = nil, ShineLabel = nil, ShineGradient = nil, SizeConnection = nil }
BASE_WIDTH = 140
BASE_HEIGHT = 32
BASE_DISTANCE = 12
MIN_SCALE = 0.6
MAX_SCALE = 1.4

local function Header_Create()
    if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
    local character = LP.Character or LP.CharacterAdded:Wait()
    if not character:FindFirstChild("Head") then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "GlutoHeaderBillboard"
    billboard.Adornee = character.Head
    billboard.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
    billboard.StudsOffset = Vector3.new(0, 1.5, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = character
    HeaderState.Billboard = billboard

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "BaseText"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = HeaderText
    textLabel.ZIndex = 1
    textLabel.Parent = billboard
    HeaderState.TextLabel = textLabel

    local shineLabel = Instance.new("TextLabel")
    shineLabel.Name = "ShineText"
    shineLabel.Size = UDim2.new(1, 0, 1, 0)
    shineLabel.BackgroundTransparency = 1
    shineLabel.TextScaled = true
    shineLabel.Font = Enum.Font.GothamBold
    shineLabel.TextStrokeTransparency = 1
    shineLabel.Text = HeaderText
    shineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    shineLabel.ZIndex = 2
    shineLabel.Parent = billboard
    HeaderState.ShineLabel = shineLabel

    local shineGradient = Instance.new("UIGradient")
    shineGradient.Name = "ShineGradient"
    shineGradient.Rotation = 20
    shineGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.30, 1),
        NumberSequenceKeypoint.new(0.42, 0), NumberSequenceKeypoint.new(0.58, 0),
        NumberSequenceKeypoint.new(0.70, 1), NumberSequenceKeypoint.new(1.00, 1),
    })
    shineGradient.Offset = Vector2.new(-1, 0)
    shineGradient.Parent = shineLabel
    HeaderState.ShineGradient = shineGradient

    if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect() end
    HeaderState.SizeConnection = RunService.RenderStepped:Connect(function()
        if not billboard or not billboard.Parent then
            if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect() end
            return
        end
        local head = character:FindFirstChild("Head")
        if not head then return end
        local dist = (workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
        local scaleFactor = math.clamp(BASE_DISTANCE / dist, MIN_SCALE, MAX_SCALE)
        billboard.Size = UDim2.new(0, BASE_WIDTH * scaleFactor, 0, BASE_HEIGHT * scaleFactor)
    end)

    task.spawn(function()
        while shineLabel and shineLabel.Parent and shineGradient and shineGradient.Parent do
            shineGradient.Offset = Vector2.new(-1, 0)
            local tween = TweenService:Create(shineGradient,
                TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                { Offset = Vector2.new(1, 0) })
            tween:Play()
            tween.Completed:Wait()
            task.wait(2)
        end
    end)
end

local function Header_UpdateText(text)
    HeaderText = text or "ONE W"
    if HeaderState.TextLabel then HeaderState.TextLabel.Text = HeaderText end
    if HeaderState.ShineLabel then HeaderState.ShineLabel.Text = HeaderText end
end

local function Header_Toggle(enabled)
    if enabled then
        Header_Create()
    else
        if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect(); HeaderState.SizeConnection = nil end
        if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
        HeaderState.Billboard = nil
        HeaderState.TextLabel = nil
        HeaderState.ShineLabel = nil
        HeaderState.ShineGradient = nil
    end
end

function Header_SetEnabled(v)
    HeaderEnabled = v
    Header_Toggle(v)
end

function Header_SetText(text)
    Header_UpdateText(text)
end

LP.CharacterAdded:Connect(function()
    task.wait(1)
    if HeaderEnabled then Header_Toggle(true) end
end)

-- =========================================================
-- PLAYER UTILITY
-- =========================================================
PU = {
    SpeedEnabled = false, SpeedValue = 16,
    SkipEndScreen = false, ShiftLock = false, NoCutscene = false,
    HideSurvivorIcon = false, ShowPingFPS = false, HideName = false,
    UnlimitedZoom = false, Noclip = false,
    _Connections = {}, _FPS = { frames = 0, last = tick(), value = 0, ping = 0 },
    _origIcons = {}, _pingGui = nil, _shiftLockWasActive = false,
}

table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
    if not PU.SpeedEnabled then return end
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.WalkSpeed ~= PU.SpeedValue then hum.WalkSpeed = PU.SpeedValue end
end))

table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    local char = LP.Character
    if not char then return end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local cam  = workspace.CurrentCamera
    if not (hum and root and cam) then return end
    if PU.ShiftLock then
        hum.AutoRotate = false
        PU._shiftLockWasActive = true
        local look = cam.CFrame.LookVector
        local flat = Vector3.new(look.X, 0, look.Z)
        if flat.Magnitude > 0.001 then
            root.CFrame = CFrame.new(root.Position, root.Position + flat.Unit)
        end
    elseif PU._shiftLockWasActive then
        hum.AutoRotate = true
        PU._shiftLockWasActive = false
    end
end))

table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
    if not PU.UnlimitedZoom then return end
    if LP.CameraMaxZoomDistance ~= math.huge then LP.CameraMaxZoomDistance = math.huge end
    if LP.CameraMinZoomDistance ~= 0 then LP.CameraMinZoomDistance = 0 end
end))

PU._origCanCollide = {}

table.insert(PU._Connections, RunService.Stepped:Connect(function()
    if not PU.Noclip then return end
    local char = LP.Character
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            if PU._origCanCollide[d] == nil then PU._origCanCollide[d] = d.CanCollide end
            d.CanCollide = false
        end
    end
end))

LP.CharacterRemoving:Connect(function(char)
    if char == LP.Character then PU._origCanCollide = {} end
end)

print("[19/20] ESP+ + Misc+ (16 fitur ALF) OK")-- =========================================================
-- Section 20 : UI Update (Tab Killer+ / Survivor+ / Combat+ / Misc+)
-- =========================================================

-- =========================================================
-- TAB KILLER+ (18 fitur ALF)
-- =========================================================
makeTab("Killer+", "🗡️", 11, function()
    sec("Bypass No Cooldown", "⚡")
    tog("Hidden - Leap Bypass", false, function(v)
        BYPASS_SetHiddenLeap(v)
    end)
    tog("Myers - Infinite Grab", false, function(v)
        setMyersGrab(v)
    end)
    tog("Slasher - Infinite LakeMist", false, function(v)
        MAWWW_SetLakeMist(v)
    end)
    tog("Slasher - Infinite Pursuit", false, function(v)
        MAWWW_SetPursuit(v)
    end)
    tog("Abyss - Bypass Cooldown", false, function(v)
        MAWWW_SetAbyssBypass(v)
    end)
    tog("Jeff - Infinite Frenzy", false, function(v)
        MAWWW_SetJeffFrenzy(v)
    end)

    sec("Killer Utility", "🛠️")
    tog("Anti Blind", false, function(v)
        ALF.KILLER_AntiBlind = v
        if v then pcall(SetupAntiBlind) end
    end)
    tog("Destroy Pallets", false, function(v)
        ALF.KILLER_DestroyPallets = v
    end)
    tog("Infinite Lunge", false, function(v)
        ALF.KILLER_InfLunge = v
    end)
    tog("Auto Hook", false, function(v)
        KA_SetAutoHook(v)
    end)

    sec("Killer Abilities", "💀")
    tog("Auto Stalk (Myers)", false, function(v)
        KA_SetAutoStalk(v)
    end)
    sl("Auto Stalk Range", 20, 500, 150, function(v)
        KA.AutoStalkRange = v
        ALF.KA_AutoStalkRange = v
    end)
    tog("Auto Kill All", false, function(v)
        KA_SetAutoKillAll(v)
    end)
    tog("Drop All Pallet", false, function(v)
        KA_SetDropAllPallet(v)
    end)
    tog("Block All Vault", false, function(v)
        KA_SetBlockAllVault(v)
    end)

    sec("Special Killer", "🎭")
    tog("Unlock Skill While Carrying", false, function(v)
        CarryCfg.Enabled = v
        if v then SetupCarryHook() end
    end)
    tog("Killer Perks Display", false, function(v)
        KillerPerksDisplay_SetEnabled(v)
    end)
end, function()
    sec("Masked Power (6)", "🎭", rightScroll)
    drp("Select Power", {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"}, "Cobra", function(v)
        ALF.MaskedPower = v
    end, rightScroll)
    btn("Activate Power", function()
        Masked_ActivatePower(ALF.MaskedPower or "Cobra")
    end, rightScroll)
    btn("Deactivate Power", function()
        Masked_DeactivatePower()
    end, rightScroll)
end)

-- =========================================================
-- TAB SURVIVOR+ (20 fitur ALF)
-- =========================================================
makeTab("Survivor+", "🏃", 12, function()
    sec("Auto Crouch Dodge", "🛡️")
    tog("Enable Auto Crouch Dodge", false, function(v)
        ALF.AutoCrouch = v
    end)

    sec("Self Heal", "💊")
    tog("Self Heal Instant", false, function(v)
        setInstantHealSelf(v)
    end)
    tog("Auto Heal All", false, function(v)
        setAutoHealAll(v)
    end)

    sec("Fake Perks", "✨")
    tog("Flowstate", false, function(v) FP_SetupFlowstate(v) end)
    tog("Quick Recovery", false, function(v) FP_SetupQuickRecovery(v) end)
    tog("Perfect Landing", false, function(v) FP_SetupPerfectLanding(v) end)
    tog("Adrenaline Rush", false, function(v) FP_SetupAdrenalineRush(v) end)
    sl("Perk Cooldown", 0, 30, 5, function(v) FP.CooldownTime = v end)
    btn("Clear All Buffs", function()
        for k in pairs(FP.ActiveBuffs) do FP.ActiveBuffs[k] = nil end
        local c = LP.Character
        if c then c:SetAttribute("speedboost", 1) end
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end)

    sec("Fake Parry V2", "🛡️")
    tog("Enable Fake Parry", false, function(v)
        FakeParry_SetEnabled(v)
    end)
    drp("Animation", {"Enten", "Stopwatch", "Fih", "BloodShield"}, "Enten", function(v)
        FakeParry_SetAnim(v)
    end)
    sl("Cooldown", 0, 3, 0.4, function(v)
        ALF.SURV_FakeParryCooldown = v
    end)
    tog("Show Floating Button", false, function(v)
        FakeParry_SetShowButton(v)
    end)
    btn("Test Fake Parry", function()
        FakeParry_Trigger()
    end)

    sec("Swift Vault", "⚡")
    tog("Swift Vault (Auto Vault)", false, function(v)
        ALF.SURV_AutoVault = v
    end)
    tog("Swift Vault V2 (Custom Speed)", false, function(v)
        ALF.SURV_FastVault = v
    end)
    sl("Vault Speed", 10, 20, 13, function(v)
        ALF.SURF_VaultSpeed = v
    end)

    sec("Pallet Reflex", "▬")
    tog("Enable Pallet Reflex", false, function(v)
        ALF.SURV_AutoPallet = v
    end)
    sl("Trigger Distance", 5, 50, 20, function(v)
        ALF.SURV_AutoPalletDist = v
    end)

    sec("God Mode", "🛡️")
    tog("God Mode (Auto Heal)", false, function(v)
        ALF.GodMode = v
    end)

    sec("Auto Run", "🏃")
    tog("Auto Run [PC]", false, function(v)
        ALF.AutoRunPC = v
    end)
    tog("Auto Run [Mobile]", false, function(v)
        ALF.AutoRunMobile = v
    end)

    sec("Bypass Vault", "🔓")
    tog("Unlimited Vault", false, function(v)
        ALF.UnlimitedVault = v
    end)
    tog("Anti Slow Vault", false, function(v)
        ALF.AntiSlowVault = v
    end)

    sec("Emote System", "💃")
    tog("Enable Emote", false, function(v)
        EmoteSystem_SetEnabled(v)
    end)
    drp("Select Emote", EmoteSystem.Options, "Friday Night", function(v)
        EmoteSystem_SelectEmote(v)
    end)
    btn("Stop Emote", function()
        EmoteSystem_Stop()
        EmoteSystem.Enabled = false
    end)
end, function()
    sec("Bypass Generator", "⚙️", rightScroll)
    tog("Enable Bypass Generator", false, function(v)
        setGenBypass(v)
    end)
    sl("Trigger Range", 3, 20, 8, function(v)
        GenBypass.TriggerRange = v
    end)
    btn("Force Repair Nearest", function()
        local bp, bd = GB_GetNearestPoint()
        if bp and bd <= GenBypass.TriggerRange then
            GB_DoRepair(bp)
        end
    end, rightScroll)

    sec("Manual/Auto Gen", "🔧", rightScroll)
    tog("Manual Generator", false, function(v)
        ALF.ManualGen = v
    end)
    tog("Auto Generator", false, function(v)
        ALF.AutoGen = v
    end)
    sl("Killer Escape Distance", 10, 80, 30, function(v)
        ALF.KillerEscapeDist = v
    end, rightScroll)
end)

-- =========================================================
-- TAB COMBAT+ (15 fitur ALF)
-- =========================================================
makeTab("Combat+", "🎯", 13, function()
    sec("Silent Aim (TOF)", "🎯")
    tog("Enable Silent Aim", false, function(v)
        SetToFSilentAim(v)
    end)
    drp("Target Mode", {"Killer", "Survivors", "Zombie"}, "Killer", function(v)
        ToF_SetTargetMode(v)
    end)
    tog("Show Laser", true, function(v) ALF.TOF_Laser = v end)
    tog("Wall Check", true, function(v) ALF.TOF_WallCheck = v end)
    tog("Block Knocked", true, function(v) ALF.TOF_BlockKnocked = v end)

    sec("Aim Lock", "🔒")
    tog("Aim Lock Attack", false, function(v)
        AttackAim.Enabled = v
        if v then AttackAim_Start() end
    end)
    sl("Attack FOV", 50, 1000, 250, function(v) AttackAim.FOV = v end)
    sl("Attack Smoothness", 0.1, 1, 1, function(v) AttackAim.Strength = v end)
    sl("Attack Prediction", 0, 1, 0.12, function(v) AttackAim.PredictStrength = v end)

    tog("Aim Lock Gun", false, function(v)
        GunAim.Enabled = v
        if v then GunAim_Start() end
    end)
    drp("Gun Target", {"Killer", "Survivor"}, "Killer", function(v)
        GunAim.TargetMode = v
    end)
    sl("Gun FOV", 50, 1000, 250, function(v) GunAim.FOV = v end)

    sec("Spear Aimbot", "🗡️")
    tog("Enable Spear Aimbot", false, function(v)
        SpearAimbot_SetEnabled(v)
    end)
    sl("Spear Gravity", 10, 200, 50, function(v)
        SpearAimbot_SetGravity(v)
    end)
    sl("Spear Speed", 50, 300, 100, function(v)
        SpearAimbot_SetSpeed(v)
    end)
end, function()
    sec("Dash Lock", "⚡", rightScroll)
    tog("Enable Dash Lock", false, function(v)
        DashLock_SetEnabled(v)
    end)
    sl("Lock Duration", 0.5, 5, 1.5, function(v) ALF.DashLockDuration = v end, rightScroll)
    sl("Smoothness", 0.05, 1, 0.3, function(v) ALF.DashLockSmoothness = v end, rightScroll)
    tog("Freeze During Lock", false, function(v)
        ALF.FreezeDuringDashLock = v
        if not v then
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
        end
    end, rightScroll)

    sec("Lock POV", "🎥", rightScroll)
    tog("Enable Lock POV", false, function(v)
        LockPOV_SetEnabled(v)
    end, rightScroll)
    sl("Locked FOV", 40, 120, 80, function(v)
        LockPOV.LockedFOV = v
        if LockPOV.Enabled then
            local cam = workspace.CurrentCamera
            if cam then cam.FieldOfView = v end
        end
    end, rightScroll)
end)

-- =========================================================
-- TAB MISC+ (16 fitur ALF)
-- =========================================================
makeTab("Misc+", "🛠️", 14, function()
    sec("Status ESP Advanced", "👁️")
    tog("Enable Status ESP Advanced", false, function(v)
        ALF.StatusESP_Advanced = v
    end)
    tog("Show Avatar", true, function(v) ALF.StatusESP_ShowAvatar = v end)
    tog("Show Action State", true, function(v) ALF.StatusESP_ShowAction = v end)
    tog("Auto Scale", true, function(v) ALF.StatusESP_AutoScale = v end)
    sl("Status ESP Radius", 20, 1000, 500, function(v)
        ALF.StatusESP_Radius = v
    end)

    sec("No Fall Damage", "🛡️")
    tog("Enable No Fall Damage", false, function(v)
        ALF.NoFallDamage = v
    end)

    sec("Next Map Prediction", "🗺️")
    tog("Enable Map Prediction", false, function(v)
        NextMapPredict_SetEnabled(v)
    end)

    sec("Stun Sound Picker", "🔔")
    tog("Enable Stun Sound", false, function(v)
        StunSound_SetEnabled(v)
    end)
    drp("Select Sound",
        {"Default", "Clash Royale", "Blash", "Coin", "Kururin Kuru", "Spongebob",
         "Fahhhh", "Cave", "Aughhh", "Samsung", "iPhone", "Siren"},
        "Default",
        function(v)
            StunSound_SetSelected(v)
        end)
    btn("Preview Sound", function()
        StunSound_TestSound()
    end)
    sl("Sound Volume", 0, 5, 1.5, function(v)
        StunSound_SetVolume(v)
    end)
    sl("Sound Range", 50, 2000, 500, function(v)
        StunSound_SetRange(v)
    end)

    sec("Speed Boost", "🚀")
    tog("Enable Speed Boost", false, function(v)
        SpeedBoost_SetEnabled(v)
    end)
    sl("Speed Value", 16, 100, 30, function(v)
        SpeedBoost_SetValue(v)
    end)

    sec("Cursor Feature", "🖱️")
    tog("Enable Cursor Unlock (Alt)", false, function(v)
        Cursor_SetEnabled(v)
    end)

    sec("Camera DBD", "🎥")
    tog("DBD Camera (Smooth Follow)", false, function(v)
        CamDBD_SetSmooth(v)
    end)
    sl("Camera Smoothness", 1, 30, 4, function(v) CamDBD_SetSmoothSpeed(v) end)
    tog("POV Lock", false, function(v)
        CamDBD_SetPOVLock(v)
    end)
    sl("POV Value", 60, 120, 85, function(v) CamDBD_SetTargetPOV(v) end)
    sl("POV Smoothness", 3, 20, 9, function(v) CamDBD_SetPOVSmooth(v) end)

    sec("Spectator Counter", "👥")
    tog("Enable Spectator Counter", false, function(v)
        SpectatorCounter_SetEnabled(v)
    end)

    sec("Header Title", "📛")
    tog("Enable Header Title", false, function(v)
        Header_SetEnabled(v)
    end)
end, function()
    sec("Header Custom", "📛", rightScroll)
    local headerInput = Instance.new("TextBox")
    headerInput.Size = UDim2.new(1, -4, 0, 28)
    headerInput.BackgroundColor3 = C.PANEL
    headerInput.BackgroundTransparency = 0.4
    headerInput.Text = "ONE W"
    headerInput.PlaceholderText = "Tulis nama di atas kepala..."
    headerInput.TextColor3 = C.TXT
    headerInput.TextSize = 10
    headerInput.Font = Enum.Font.GothamMedium
    headerInput.BorderSizePixel = 0
    headerInput.Parent = rightScroll
    rnd(headerInput, 6)
    strk(headerInput, DIAMOND_BLUE, 1, 0.4)
    headerInput.FocusLost:Connect(function()
        Header_SetText(headerInput.Text)
    end)

    sec("Danger", "⚠️", rightScroll)
    btn("Full Unload Hub", function()
        if _G.Roooor_Unload then
            pcall(_G.Roooor_Unload)
        end
    end, rightScroll)
end)

-- =========================================================
-- FIX: AP_ParryActive → APALF_Cooldown.WaitingForResult
-- =========================================================
_G.Roooor_AP_ParryActive_Fix = function()
    return APALF_Cooldown.WaitingForResult
end

-- =========================================================
-- FINAL PRINT
-- =========================================================
print("")
print("==========================================")
print("  ONE W + ALFZXZZZ MEGA HUB")
print("  SEMUA 20 SECTION LOADED")
print("==========================================")
print("  Keybind:")
print("    RightShift = Buka Menu")
print("    V = Moonwalk / Fake Parry")
print("    K = Unlock Camera")
print("    G = Invisible (kalau aktif)")
print("    Q = Toggle Silent Aim")
print("    H = Myers Grab")
print("    B = Bypass Generator")
print("    Alt = Cursor Unlock")
print("------------------------------------------")
print("  14 TAB TERSEDIA:")
print("    1. Survivor   (Auto Parry ALF v1 + Wisnu v2)")
print("    2. Killer")
print("    3. ESP")
print("    4. Fire       (60 efek)")
print("    5. Musik      (32 lagu)")
print("    6. Misc")
print("    7. Visual     (Crosshair 10 Style)")
print("    8. Grafik Ultra")
print("    9. Aimbot")
print("   10. Moonwalk")
print("   11. Killer+    (18 fitur ALF)")
print("   12. Survivor+  (20 fitur ALF)")
print("   13. Combat+    (15 fitur ALF)")
print("   14. Misc+      (16 fitur ALF)")
print("------------------------------------------")
print("  FITUR ALF YANG DIMASUKIN (69):")
print("    - Auto Parry ALF v1 (Original)")
print("    - Wisnu Auto Parry v2")
print("    - Killer Bypass (6 tipe)")
print("    - Self Heal + Auto Heal All")
print("    - Fake Perks (4 buff)")
print("    - Fake Parry V2 (4 anim)")
print("    - Silent Aim (TOF)")
print("    - Aim Lock (Attack + Gun)")
print("    - Spear Aimbot")
print("    - Status ESP Advanced")
print("    - Stun Sound Picker (12 suara)")
print("    - Camera DBD")
print("    - Speed Boost")
print("    - Cursor Feature")
print("    - DLL.")
print("==========================================")
print("")
print("ALL SECTIONS COMPLETE!")
print("Klik tombol W atau RightShift buat buka menu")
