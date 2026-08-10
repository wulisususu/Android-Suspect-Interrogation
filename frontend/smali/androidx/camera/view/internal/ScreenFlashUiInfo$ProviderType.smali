.class public final enum Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
.super Ljava/lang/Enum;
.source "ScreenFlashUiInfo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/view/internal/ScreenFlashUiInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ProviderType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

.field public static final enum PREVIEW_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

.field public static final enum SCREEN_FLASH_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;


# direct methods
.method private static synthetic $values()[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
    .locals 2

    sget-object v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->PREVIEW_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    sget-object v1, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->SCREEN_FLASH_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    filled-new-array {v0, v1}, [Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 40
    new-instance v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    const-string v1, "PREVIEW_VIEW"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->PREVIEW_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    .line 41
    new-instance v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    const-string v1, "SCREEN_FLASH_VIEW"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->SCREEN_FLASH_VIEW:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    .line 39
    invoke-static {}, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->$values()[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    move-result-object v0

    sput-object v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->$VALUES:[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 39
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    const-class v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    .line 39
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    return-object p0
.end method

.method public static values()[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
    .locals 1

    sget-object v0, Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->$VALUES:[Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    .line 39
    invoke-virtual {v0}, [Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    return-object v0
.end method
