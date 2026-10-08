-- =========================================================
-- ONE W
-- PART 1/8 : SECTION 1 - CONFIG + LOADING + STATE
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
welcomeTitle.Text = "ONE W"
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

AutoParry = _G.Roooor_AutoParry or {
    Enabled = false, ParryDistance = 15,
    FaceSensitivity = 0.7, RequireFacing = true,
    Cooldown = 0.2, ParryLockTime = 0.3,
    Wiggle = false, WiggleSpam = 5,
}
_G.Roooor_AutoParry = AutoParry

AP_ESPCircle = {
    Enabled = false,
    ColorNormal = Color3.fromRGB(0, 255, 100),
    ColorDanger = Color3.fromRGB(255, 50, 50),
    Thickness = 0.4, Segments = 36, YOffset = -2.5,
}

AimbotSenter = _G.Roooor_AimbotSenter or {
    Enabled = false, LockPart = "Head",
    ShowLaser = true, LaserColor = Color3.fromRGB(255, 210, 80),
    CurrentTarget = nil, HoldingSenter = false,
}
_G.Roooor_AimbotSenter = AimbotSenter

Aimlock = _G.Roooor_Aimlock or {
    Enabled = false, Radius = 80, TargetTeam = "Survivors",
    AimPart = "HumanoidRootPart", Holding = false, CurrentTarget = nil,
}
_G.Roooor_Aimlock = Aimlock

SkillCheck = _G.Roooor_SkillCheck or {
    Enabled = false, Mode = "Perfect", Success = 0, Total = 0,
}
_G.Roooor_SkillCheck = SkillCheck

Moonwalk = _G.Roooor_Moonwalk or {
    Enabled = false, Locked = false, SpamSpeed = 30,
    Intensity = 35, SlowSpeed = 13, UseSlow = true, ShowButton = true,
}
_G.Roooor_Moonwalk = Moonwalk

FastVault = _G.Roooor_FastVault or {
    Enabled = false, Speed = 1.2,
    ReplaceMap = {
        ["rbxassetid://83873880822918"] = "rbxassetid://136962284480779",
    },
}
_G.Roooor_FastVault = FastVault

AutoFlee = _G.Roooor_AutoFlee or {
    Enabled = false, DetectDistance = 50, Cooldown = 0.1, LastFlee = 0,
}
_G.Roooor_AutoFlee = AutoFlee

GodMode = _G.Roooor_GodMode or { Enabled = false }
_G.Roooor_GodMode = GodMode

StunIndicator = _G.Roooor_StunIndicator or {
    Enabled = true,
    ActiveStuns = {},
}
_G.Roooor_StunIndicator = StunIndicator

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

print("✅ [1/15] Loading + Config + State Loaded (32 lagu)")-- =========================================================
-- SECTION 2 : FIRE + SKY + KILLERANIMS + SKIPANIMS + GRAFIK
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
    ["Soft"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.075, Ambient = Color3.fromRGB(42,45,52), OutdoorAmbient = Color3.fromRGB(130,138,155), AtmosphereDensity = 0.055, AtmosphereHaze = 0.025, AtmosphereGlare = 0.08, BloomIntensity = 0.12, BloomSize = 20, BloomThreshold = 0.96, Contrast = 0.18, Saturation = 0.08, ColorBrightness = 0.01, SunRaysIntensity = 0.06, SunRaysSpread = 0.75, DOFNear = 0.01, DOFFar = 0.02, DOFFocus = 45, DOFRadius = 40 },
    ["Cinematic"] = { Brightness = 2.10, Exposure = 0.05, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(32,35,42), OutdoorAmbient = Color3.fromRGB(125,132,150), AtmosphereDensity = 0.075, AtmosphereHaze = 0.045, AtmosphereGlare = 0.12, BloomIntensity = 0.18, BloomSize = 24, BloomThreshold = 0.92, Contrast = 0.24, Saturation = 0.10, ColorBrightness = 0.015, SunRaysIntensity = 0.085, SunRaysSpread = 0.72, DOFNear = 0.025, DOFFar = 0.045, DOFFocus = 45, DOFRadius = 35 },
    ["Ultra Cinematic"] = { Brightness = 2.15, Exposure = 0.07, ShadowSoftness = 0.045, Ambient = Color3.fromRGB(30,32,40), OutdoorAmbient = Color3.fromRGB(135,142,160), AtmosphereDensity = 0.065, AtmosphereHaze = 0.035, AtmosphereGlare = 0.14, BloomIntensity = 0.22, BloomSize = 27, BloomThreshold = 0.89, Contrast = 0.27, Saturation = 0.13, ColorBrightness = 0.02, SunRaysIntensity = 0.10, SunRaysSpread = 0.70, DOFNear = 0.02, DOFFar = 0.04, DOFFocus = 44, DOFRadius = 34 },
    ["Golden Hour"] = { Brightness = 2.20, Exposure = 0.08, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(58,48,38), OutdoorAmbient = Color3.fromRGB(155,135,105), AtmosphereDensity = 0.07, AtmosphereHaze = 0.055, AtmosphereGlare = 0.16, BloomIntensity = 0.20, BloomSize = 26, BloomThreshold = 0.91, Contrast = 0.20, Saturation = 0.16, ColorBrightness = 0.025, SunRaysIntensity = 0.12, SunRaysSpread = 0.76, DOFNear = 0.015, DOFFar = 0.035, DOFFocus = 45, DOFRadius = 38 },
    ["Night Cinema"] = { Brightness = 1.65, Exposure = -0.02, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(20,25,38), OutdoorAmbient = Color3.fromRGB(65,78,110), AtmosphereDensity = 0.085, AtmosphereHaze = 0.065, AtmosphereGlare = 0.06, BloomIntensity = 0.15, BloomSize = 24, BloomThreshold = 0.86, Contrast = 0.30, Saturation = 0.08, ColorBrightness = -0.01, SunRaysIntensity = 0.04, SunRaysSpread = 0.70, DOFNear = 0.025, DOFFar = 0.05, DOFFocus = 48, DOFRadius = 32 },
}

GraphicPresetOrder = {
    "Soft","Cinematic","Ultra Cinematic","Golden Hour","Night Cinema",
}

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
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        ClockTime = Lighting.ClockTime,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
    },
    CreatedEffects = {},
}

print("✅ [2/15] Fire + Sky + KillerAnims + SkipAnims + Grafik Presets Loaded")-- =========================================================
-- SECTION 3 : BOMBAX MUSIC PLAYER
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

print("✅ [3/15] BOMBAX Music Player Loaded - " .. #Bombax.DaftarLagu .. " lagu")-- =========================================================
-- SECTION 4 : FUNGSI UTAMA + HD SKY + FPS/PING + GRAFIK
-- PATCH: applyCrosshair 10 style + applyFullbright max 500 + Kill Fog
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

print("✅ [4/15] Fungsi Utama + HD Sky + FPS/Ping + Grafik + Crosshair 10 Style + Kill Fog Loaded")-- =========================================================
-- SECTION 5 : ESP + AUTO PARRY (23 ID) + PARRY CIRCLE
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
-- AUTO PARRY (23 ID)
-- =========================================================
AP_parryCount = 0
AP_LastParry = 0
AP_ParryActive = false
AP_HookedKillers = _G.AP_HookedKillers or {}
_G.AP_HookedKillers = AP_HookedKillers

function AP_FindParryButton()
    local current = PG
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    if current and current:IsA("GuiObject") and current.Visible then
        return current
    end
    return nil
end

function AP_PressRightClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
end

function AP_PressParryButton()
    if UIS.TouchEnabled then
        local btn = AP_FindParryButton()
        if btn and btn:IsA("GuiObject") then
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            VirtualInputManager:SendTouchEvent(8823, 0, x, y)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(8823, 2, x, y)
        end
    else
        AP_PressRightClick()
    end
end

function AP_IsFacingTarget(killerChar)
    if not AutoParry.RequireFacing then return true end
    if AutoParry.FaceSensitivity <= -1 then return true end
    local myChar = LP.Character
    if not myChar then return false end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local enemyRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not enemyRoot then return false end
    local enemyForward = enemyRoot.CFrame.LookVector
    local directionToMe = (myRoot.Position - enemyRoot.Position).Unit
    local dot = enemyForward:Dot(directionToMe)
    return dot >= AutoParry.FaceSensitivity
end

function AP_IsInRange(killerChar)
    local myRoot = getRoot()
    if not myRoot or not killerChar then return false end
    local enemyRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not enemyRoot then return false end
    return (enemyRoot.Position - myRoot.Position).Magnitude <= AutoParry.ParryDistance
end

function AP_DoParry()
    local now = tick()
    if AP_ParryActive then return end
    if now - AP_LastParry < AutoParry.Cooldown then return end
    AP_LastParry = now
    AP_ParryActive = true

    if Moonwalk and Moonwalk.Enabled then
        Moonwalk.Enabled = false
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end

    AP_PressParryButton()
    AP_parryCount = AP_parryCount + 1

    task.delay(AutoParry.ParryLockTime, function()
        AP_ParryActive = false
    end)
end

function AP_HookKiller(char)
    if AP_HookedKillers[char] then return end
    AP_HookedKillers[char] = true

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        if not AutoParry.Enabled then return end
        if AP_ParryActive then return end

        local anim = track.Animation
        if not anim or not anim.AnimationId then return end
        local id = anim.AnimationId:match("%d+")
        if not id then return end

        if SkipAnims and SkipAnims[id] then return end

        local fullId = "rbxassetid://" .. id
        if not KillerAnims[fullId] then return end

        if not AP_IsInRange(char) then return end
        if not AP_IsFacingTarget(char) then return end

        AP_DoParry()
    end)
end

task.spawn(function()
    while task.wait(0.8) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    AP_HookKiller(p.Character)
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if AutoParry.Enabled and p.Team and p.Team.Name == "Killer" then
            AP_HookKiller(c)
        end
    end)
end)

-- ============ PARRY CIRCLE ============
AP_parryCirclePart = nil
AP_parryCircleAttachments = {}
AP_parryCircleBeams = {}

function AP_ClearCircle()
    if AP_parryCirclePart then
        AP_parryCirclePart:Destroy()
        AP_parryCirclePart = nil
    end
    AP_parryCircleAttachments = {}
    AP_parryCircleBeams = {}
end

function AP_CreateCircle()
    AP_ClearCircle()
    AP_parryCirclePart = Instance.new("Part")
    AP_parryCirclePart.Name = "AP_ParryRingBeam"
    AP_parryCirclePart.Anchored = true
    AP_parryCirclePart.CanCollide = false
    AP_parryCirclePart.CanQuery = false
    AP_parryCirclePart.CanTouch = false
    AP_parryCirclePart.Transparency = 1
    AP_parryCirclePart.Size = Vector3.new(1, 0.1, 1)
    AP_parryCirclePart.Parent = workspace

    local segments = AP_ESPCircle.Segments
    for i = 1, segments do
        local angle = (i / segments) * math.pi * 2
        local att = Instance.new("Attachment")
        att.Position = Vector3.new(math.cos(angle), 0, math.sin(angle))
        att.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleAttachments, att)
    end
    for i = 1, segments do
        local attA = AP_parryCircleAttachments[i]
        local attB = AP_parryCircleAttachments[(i % segments) + 1]
        local beam = Instance.new("Beam")
        beam.Attachment0 = attA
        beam.Attachment1 = attB
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.FaceCamera = true
        beam.LightEmission = 1
        beam.LightInfluence = 0
        beam.Segments = 1
        beam.Transparency = NumberSequence.new(0)
        beam.Color = ColorSequence.new(AP_ESPCircle.ColorNormal)
        beam.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleBeams, beam)
    end
end

function AP_UpdateCircle()
    local root = getRoot()
    if not AP_ESPCircle.Enabled or not root then
        if AP_parryCirclePart then AP_ClearCircle() end
        return
    end
    if not AP_parryCirclePart or not AP_parryCirclePart.Parent then
        AP_CreateCircle()
    end
    local radius = AutoParry.ParryDistance
    local myPos = root.Position
    local yOffset = AP_ESPCircle.YOffset
    local killerInside = false
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
            local eRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if eRoot then
                local dist = (eRoot.Position - myPos).Magnitude
                if dist <= radius then
                    killerInside = true
                    break
                end
            end
        end
    end
    local ringColor = killerInside and AP_ESPCircle.ColorDanger or AP_ESPCircle.ColorNormal
    AP_parryCirclePart.Position = Vector3.new(myPos.X, myPos.Y + yOffset, myPos.Z)
    for i, att in ipairs(AP_parryCircleAttachments) do
        local angle = (i / AP_ESPCircle.Segments) * math.pi * 2
        att.Position = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
    end
    for _, beam in ipairs(AP_parryCircleBeams) do
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.Color = ColorSequence.new(ringColor)
        beam.Transparency = NumberSequence.new(0)
    end
end

RunService.RenderStepped:Connect(function()
    if AutoParry.Enabled and AP_ESPCircle.Enabled then
        pcall(AP_UpdateCircle)
    end
end)

print("✅ [5/15] ESP + Auto Parry (23 ID) + Parry Circle Loaded")-- =========================================================
-- SECTION 6 : AIMBOT SENTER + AIMBOT KILLER + FAST VAULT
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

AimbotSenter.HoldingSenter = false
AimbotSenter.CurrentTarget = nil
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

-- INSTANT LOCK KE HEAD
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

-- ============ AIMBOT KILLER (AIMLOCK) ============
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

-- ============ FAST VAULT ============
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

print("✅ [6/15] Aimbot Senter (Instant Head Lock) + Aimbot Killer + Fast Vault Loaded")-- =========================================================
-- SECTION 7/15 : GUI UTAMA + TOMBOL W + PANEL + TAB BAR
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
hTitle.Text = "ONE W"
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

print("✅ [7/15] GUI + Tombol W + Panel + Tab Bar Loaded")

-- =========================================================
-- SECTION 8/15 : KOMPONEN UI
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

print("✅ [8/15] Komponen UI Loaded")

-- =========================================================
-- SECTION 9/15 : TAB SURVIVOR + KILLER + HITBOX + TELEPORT
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

task.spawn(function()
    while task.wait(0.05) do
        local spoof = _G.SpoofAttack
        if not spoof.Enabled or not spoof.AttackSpam then continue end
        local target = GetClosestSurvivorForSpoof()
        if target then
            pcall(function()
                local r = ReplicatedStorage:FindFirstChild("Remotes")
                if r then
                    local a = r:FindFirstChild("Attacks")
                    if a then
                        local atk = a:FindFirstChild("BasicAttack")
                        if atk then atk:FireServer(false) end
                    end
                end
            end)
        end
        task.wait(spoof.AttackDelay or 0.15)
    end
end)

makeTab("Survivor", "🏃", 1, function()
    sec("Auto Parry", "🛡️")
    tog("Enable Auto Parry", false, function(s)
        AutoParry.Enabled = s
        if s then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    task.spawn(function() AP_HookKiller(p.Character) end)
                end
            end
        end
    end)
    sl("Parry Radius", 5, 40, 13, function(v)
        AutoParry.ParryDistance = v
        if AP_ESPCircle then AP_ESPCircle.Radius = v end
    end)
    sl("Face Sensitivity", -1, 1, -1, function(v)
        AutoParry.FaceSensitivity = v
    end)
    tog("Require Facing", true, function(s)
        AutoParry.RequireFacing = s
    end)
    sl("Cooldown", 0.05, 0.5, 0.2, function(v)
        AutoParry.Cooldown = v
    end)
    sl("Parry Lock", 0.1, 0.6, 0.3, function(v)
        AutoParry.ParryLockTime = v
    end)
    btn("Reset Parry Counter", function()
        AP_parryCount = 0
    end)

    sec("ESP Circle Parry", "⭕")
    tog("Show Circle", false, function(s)
        if AP_ESPCircle then
            AP_ESPCircle.Enabled = s
            if s then
                if AP_CreateCircle then pcall(AP_CreateCircle) end
            else
                if AP_ClearCircle then pcall(AP_ClearCircle) end
            end
        end
    end)
    sl("Circle Thickness", 0.01, 0.5, 0.08, function(v)
        if AP_ESPCircle then
            AP_ESPCircle.Thickness = v
            if AP_ClearCircle then pcall(AP_ClearCircle) end
            if AP_ESPCircle.Enabled and AP_CreateCircle then pcall(AP_CreateCircle) end
        end
    end)
    sl("Circle Y Offset", -10, 5, -2.5, function(v)
        if AP_ESPCircle then AP_ESPCircle.YOffset = v end
    end)
    sl("Circle Segments", 16, 80, 36, function(v)
        if AP_ESPCircle then
            AP_ESPCircle.Segments = v
            if AP_ClearCircle then pcall(AP_ClearCircle) end
            if AP_ESPCircle.Enabled and AP_CreateCircle then pcall(AP_CreateCircle) end
        end
    end)
    cpk("Circle Safe Color", Color3.fromRGB(0, 255, 100), function(c)
        if AP_ESPCircle then AP_ESPCircle.ColorNormal = c end
    end)
    cpk("Circle Danger Color", Color3.fromRGB(255, 50, 50), function(c)
        if AP_ESPCircle then AP_ESPCircle.ColorDanger = c end
    end)

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

    sec("Auto Wiggle", "🔓")
    tog("Enable Auto Wiggle", false, function(s)
        AutoParry.Wiggle = s
    end)
    sl("Wiggle Spam", 1, 20, 5, function(v)
        AutoParry.WiggleSpam = v
    end)

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

    sec("Fast Vault", "⚡")
    tog("Enable Fast Vault", false, function(s)
        FastVault.Enabled = s
        if s and LP.Character then hookVault(LP.Character) end
    end)
    sl("Animation Speed", 1, 5, 1.2, function(v)
        FastVault.Speed = v
    end)

    sec("Auto Escape", "🚪")
    tog("Enable Auto Escape", false, function(s) S.AutoEscapeGate = s end)
    tog("Killer Deket", true, function(s) S.AutoEscapeUseKillerCheck = s end)
    tog("Generator Cukup", true, function(s) S.AutoEscapeUseGenCheck = s end)
    sl("Killer Range", 10, 150, 50, function(v) S.AutoEscapeRange = v end)

    sec("Support", "💊")
    tog("Instant Interact", false, function(s) S.InstantInteract = s end)

    sec("Teleport", "🌀")
    btn("TP Finish Line", function() teleportToFinishLine() end)
end, function()
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

-- =========================================================
-- SECTION 10/15 : TAB ESP + FIRE + MUSIK
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

-- =========================================================
-- SECTION 11/15 : TAB MISC + VISUAL + GRAFIK ULTRA
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
    btn("FOV 70", function() S.FOV = 70; S.FOVEnabled = true; applyFOV() end)
    btn("FOV 90", function() S.FOV = 90; S.FOVEnabled = true; applyFOV() end)
    btn("FOV 120", function() S.FOV = 120; S.FOVEnabled = true; applyFOV() end)

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

makeTab("Grafik Ultra", "🎬", 8, function()
    sec("Soft Cinematic", "🎬")
    tog("Soft Cinematic", false, function(s)
        if s then
            GraphicEnableSoftCinematic()
        else
            GraphicDisableSoftCinematic()
        end
    end)
    tog("Full Bright", false, function(s) GraphicState.FullBright = s end)
    tog("No Fog", false, function(s) GraphicState.NoFog = s end)
    tog("Clean Sky", false, function(s) GraphicState.CleanSky = s end)
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
    sl("Killer Radius", 5, 100, 80, function(v) Aimlock.Radius = v end)
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
    tog("Show ESP Laser", true, function(s) AimbotSenter.ShowLaser = s end)
    cpk("Laser Color", DIAMOND_BLUE, function(c) AimbotSenter.LaserColor = c end)
end, function()
    sec("Info", "ℹ️", rightScroll)
    local infoLbl = Instance.new("TextLabel")
    infoLbl.Size = UDim2.new(1, -4, 0, 80)
    infoLbl.BackgroundTransparency = 1
    infoLbl.Text = "Aimbot Killer: HOLD attack = lock ke Survivor\n\nAimbot Senter: HOLD senter = lock ke Killer (Instant Head)\n\nLepas tombol = kamera bebas"
    infoLbl.TextColor3 = C.DIM
    infoLbl.TextSize = 9
    infoLbl.Font = Enum.Font.Gotham
    infoLbl.TextXAlignment = Enum.TextXAlignment.Left
    infoLbl.TextYAlignment = Enum.TextYAlignment.Top
    infoLbl.TextWrapped = true
    infoLbl.Parent = rightScroll
end)

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

print("✅ [9-12/15] Semua Tab Loaded")-- =========================================================
-- SECTION 13/15 : LOOP FITUR AKTIF + STUN INDICATOR + CAMERA FIX
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

-- ============ SKILL CHECK ============
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

-- ============ AUTO WIGGLE ============
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

-- ============ AUTO FLEE ============
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

-- ============ INSTANT INTERACT ============
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

-- ============ SPEED HACK ============
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

-- ============ WALK SPEED ============
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

-- ============ ANTI-AFK ============
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

-- ============ KILL FEED ============
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

-- ============ STUN INDICATOR + SOUND ============
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

-- ============ MAIN ESP LOOP ============
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

-- ============ KILL EFFECT LOOP ============
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

-- ============ NO CLIP ============
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

-- ============ NO CLIP CAMERA ============
task.spawn(function()
    while task.wait(0.2) do
        local cam = workspace.CurrentCamera
        if cam then
            cam.CanCollide = not S.NoClipCamera
        end
    end
end)

-- ============ CAMERA FIX ============
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

-- ============ KEYBIND V & K ============
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

-- ============ ANTI-ILANG ============
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

-- ============ KILL FOG AUTO ============
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

print("✅ [13/15] Loop Fitur + Stun Indicator + Camera Fix + Kill Fog Auto Loaded")

-- =========================================================
-- SECTION 14/15 : ANTI-ILANG + RECOVERY + AUTO REAPPLY
-- =========================================================

task.delay(3, function()
    pcall(function()
        local oldLoading = PG:FindFirstChild("OneWLoading")
        if oldLoading then oldLoading:Destroy() end
    end)
end)

function RecreateAllGUI()
    local coreGui = game:GetService("CoreGui")

    if not gui or not gui.Parent then
        local existing = PG:FindFirstChild("OneWHub")
            or (coreGui and coreGui:FindFirstChild("OneWHub"))
        if existing then
            gui = existing
            _G.Roooor_Gui = gui
            gui.ResetOnSpawn = false
            gui.Enabled = true
        end
    end

    if not fpsPingGui or not fpsPingGui.Parent then
        local existing = PG:FindFirstChild("OneWFPSPing")
        if existing then
            fpsPingGui = existing
            fpsPingGui.ResetOnSpawn = false
        else
            pcall(createFPSPingGui)
        end
    end

    if not mwBtnGui or not mwBtnGui.Parent then
        local existing = PG:FindFirstChild("MW_BottomBtn")
        if existing then
            mwBtnGui = existing
            mwBtnGui.ResetOnSpawn = false
        end
    end

    if not killFeedGui or not killFeedGui.Parent then
        local existing = PG:FindFirstChild("OneWKillFeed")
        if existing then
            killFeedGui = existing
            killFeedGui.ResetOnSpawn = false
        end
    end

    if not _G.Roooor_BombaxGui or not _G.Roooor_BombaxGui.Parent then
        local existing = PG:FindFirstChild("BombaxGUI")
        if existing then
            _G.Roooor_BombaxGui = existing
            existing.ResetOnSpawn = false
        end
    end

    if not AimbotLaserGui or not AimbotLaserGui.Parent then
        local existing = PG:FindFirstChild("OneWAimbotLaser")
        if existing then
            AimbotLaserGui = existing
            AimbotLaserGui.ResetOnSpawn = false
        end
    end
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(RecreateAllGUI)
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    task.wait(0.3)
    pcall(RecreateAllGUI)
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1.5)

    if S.Headless then pcall(function() applyHeadless(true) end) end
    if S.Korblox then
        task.wait(0.3)
        pcall(function() applyKorblox(true, "Pencil", S.KorbloxYOffset, S.KorbloxScale) end)
    end
    if S.EightBitOn then
        task.wait(0.3)
        pcall(function() apply8Bit(true, "Royal Crown", S.EightBitSize, S.EightBitHeight) end)
    end
    if S.FireOn then
        task.wait(0.5)
        pcall(applyFire)
    end
    if S.Trail then
        task.wait(0.5)
        pcall(function() applyTrail(true, S.TrailColor) end)
    end
    if S.Aura then
        task.wait(0.5)
        pcall(function() applyAura(true, S.AuraColor) end)
    end
    if FastVault.Enabled then
        pcall(function() hookVault(char) end)
    end
    if S.KillFog then
        pcall(function() applyKillFog(true) end)
    end

    AimbotSenter.CurrentTarget = nil
    AimbotSenter.HoldingSenter = false
    Aimlock.CurrentTarget = nil
    Aimlock.Holding = false
end)

task.spawn(function()
    while task.wait(8) do
        if S.SkyId and S.SkyId ~= "Default" then
            local currentSky = nil
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Sky") then
                    currentSky = v
                    break
                end
            end
            if not currentSky or not currentSky.Name:find("OneWSky_") then
                pcall(function() applySky(S.SkyId) end)
            end
        end
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            if head and not head:FindFirstChild("RoooorFire") then
                pcall(applyFire)
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if GraphicState.SoftCinematic and obj:IsA("BasePart") then
            if GraphicPartBackup[obj] == nil then
                GraphicPartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
    end)
end)

task.spawn(function()
    while task.wait(2) do
        if Bombax.Music and not Bombax.Music.Parent then
            Bombax.Music.Parent = SoundService
        end
        if not _G.Roooor_BombaxGui or not _G.Roooor_BombaxGui.Parent then
            local existing = PG:FindFirstChild("BombaxGUI")
            if existing then
                _G.Roooor_BombaxGui = existing
                existing.ResetOnSpawn = false
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if AutoParry.Enabled and p.Team and p.Team.Name == "Killer" then
            AP_HookKiller(c)
        end
    end)
end)

task.spawn(function()
    while task.wait(1) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    AP_HookKiller(p.Character)
                end
            end
        end
    end
end)

print("✅ [14/15] Anti-Ilang + Recovery + Auto Reapply Loaded")

-- =========================================================
-- SECTION 15/15 : AUTO-ON + BANNER + PRINT FINAL
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
        title.Text = "ONE W LOADED"
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
        sub.Text = "32 Lagu • Crosshair 10 Style • Kill Fog • Teleport"
        sub.TextColor3 = Color3.fromRGB(180, 230, 255)
        sub.TextSize = 10
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
            Title = "ONE W",
            Text = "32 Lagu • Crosshair 10 Style • Teleport • Kill Fog\nRightShift = Buka Menu",
            Duration = 5
        })
    end)
end)

task.wait(0.5)

print("")
print("==========================================")
print("  ONE W - FINAL")
print("  SEMUA 15 SECTION LOADED")
print("==========================================")
print("  Keybind:")
print("    RightShift = Buka Menu")
print("    V = Moonwalk")
print("    K = Unlock Camera")
print("------------------------------------------")
print("  10 TAB TERSEDIA:")
print("    1. Survivor  (Auto Parry + Teleport)")
print("    2. Killer    (Hitbox + Spoof)")
print("    3. ESP")
print("    4. Fire      (60 efek)")
print("    5. Musik     (32 lagu)")
print("    6. Misc")
print("    7. Visual    (Crosshair 10 Style)")
print("    8. Grafik Ultra")
print("    9. Aimbot")
print("   10. Moonwalk")
print("==========================================")
print("")
print("✅ [15/15] ALL SECTIONS COMPLETE!")
print("Klik tombol W atau RightShift buat buka menu")
