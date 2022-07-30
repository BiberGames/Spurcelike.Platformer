function Start()
    LoadSprites()
    CLGameObject.SetActive("DefaultCanvas", false)
    CLGameObject.SetActive("BLOOM", false)
    CLGameObject.SetActive("DebugScreen", false)
    Sky()
    CreateObject("Tree", -5, 9.54, 1)
    CreateObject("Grass 1", -2, 8.33, -1)
    CreateObject("Grass 2", -1, 8.3, -1)
    CreateObject("Grass 3", 0, 8.4, -1)
    CreateObject("Grass 4", 2, 8.32, -1)
    CreateObject("Grass 5", 4, 8, -1)
    Utils.DelayedLauncher("SpawnPlayer", 2)
end

function include()
    CLConsole.Log(CLIO.LoadFileRaw("Addons/Platformer/Code/Autorun.lua"))
    --local myModule = require(CLIO.GetStreamingAssetsPath() .. "/Addons/Platformer/Code/Autorun")

    local myModule = dofile(CLIO.GetStreamingAssetsPath() .. "/Addons/Platformer/Code/Autorun")
    myModule.Test("hallo!!!!!!!")
end

function CreateTestText()
    CLUI.CeateText("TestText1", 10, "MainCanvas", '<color="red"><align="center">This is a test!</align>', 0, "", "")
    CLTransform.Position("TestText1", 100, 0, 0, 0)
end

function CreateIsland()
    CLGameObject.CreateEmpty("Island")
    CLGameObject.AddComponent("Island", "2D.Sprite")
    CLGameObject.AddComponent("Island", "Physics.BoxCollider2D")
    CL2D.SetBoxColliderSize("Island", 14, 10)
    CL2D.SetColliderOffset("Island", -0.8, 3)
    CL2D.SetSprite("Island", 0)
    CLTransform.Position("Island", 0, 0, 0, 0)
end

function CreateFootball()
    CLGameObject.CreateEmpty("Football")
    CLGameObject.AddComponent("Football", "2D.Sprite")
    CLGameObject.AddComponent("Football", "Physics.CircleCollider2D")
    CLGameObject.AddComponent("Football", "Physics.Rigidbody2D")
    CL2D.SetCircleColliderSize("Football", 0.5)
    CL2D.SetColliderOffset("Football", 0, 0)
    CL2D.SetSprite("Football", 11)
    CLTransform.Position("Football", -3, 15, 0, 0)
end

function Sky()
    CLGameObject.CreateEmpty("Sky")
    CLTransform.Position("Sky", 0, 0, 100, 0)
    CLGameObject.AddComponent("Sky", "2D.Sprite")
end

function LoadSprites()
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Island.png", 0, 8, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Grass_01.png", 1, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Grass_02.png", 2, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Grass_03.png", 3, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Grass_04.png", 4, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/World/Tree_01.png", 5, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Sky.png", 6, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Player/Player_01.png", 7, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Player/Player_02.png", 8, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Player/Player_03.png", 9, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Player/Player_04.png", 10, 16, true)
    CL2D.LoadSprite("Addons/Platformer/Textures/Football.png", 11, 16, true)
end

function CreateObject(Name, X, Y, Z)
    CLGameObject.CreateEmpty(Name)
    CLTransform.Position(Name, X, Y, Z, 0)
    CLGameObject.AddComponent(Name, "2D.Sprite")
end

function SpawnPlayer()
    CL2D.SetCapsuleColliderSize("2DPlayer", 1, 1)
    CreateFootball()
    CreateIsland()
    CL2D.SetSprite("Sky", 6)
    CL2D.SetSprite("Tree", 5)
    CLTransform.Position("2DPlayer", 0, 10, 0, 0)
    CLCamera.SetSize("2DCamera", 5)
    CLGameObject.SetActive("LoadingBackground", false)
end

PlayerAnimationFrame = 7
PlayerTimer = 0
function PlayerAnimation()
    if CLTime.GetTime() > PlayerTimer then
        PlayerTimer = CLTime.GetTime() + 0.3
        PlayerAnimationFrame = PlayerAnimationFrame + 1

        if PlayerAnimationFrame == 11 then
            PlayerAnimationFrame = 7
        end

        CL2D.SetSprite("2DPlayer", PlayerAnimationFrame)
    end
end


GAnimationFrame = 4
GTimer = 0
function GrassAnimation(Names)
    if CLTime.GetTime() > GTimer then
        GTimer = CLTime.GetTime() + 0.3
        GAnimationFrame = GAnimationFrame + 1

        if GAnimationFrame == 5 then
            GAnimationFrame = 1
        end

        for i = 1, #Names do
            CL2D.SetSprite(Names[i], GAnimationFrame)
        end
    end
end

function Loop()
    GrassAnimation({"Grass 1", "Grass 2", "Grass 3", "Grass 4", "Grass 5"})
    PlayerAnimation()

    BallPosition = CLTransform.GetPosition("Football")
    if BallPosition[2] < 6 then
        CLTransform.Position("Football", -3, 15, 0, 0)
    end
end