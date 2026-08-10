.class final enum Landroidx/camera/core/CameraX$InternalInitState;
.super Ljava/lang/Enum;
.source "CameraX.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/CameraX;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "InternalInitState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Landroidx/camera/core/CameraX$InternalInitState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Landroidx/camera/core/CameraX$InternalInitState;

.field public static final enum INITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;

.field public static final enum INITIALIZING:Landroidx/camera/core/CameraX$InternalInitState;

.field public static final enum INITIALIZING_ERROR:Landroidx/camera/core/CameraX$InternalInitState;

.field public static final enum SHUTDOWN:Landroidx/camera/core/CameraX$InternalInitState;

.field public static final enum UNINITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;


# direct methods
.method private static synthetic $values()[Landroidx/camera/core/CameraX$InternalInitState;
    .locals 5

    sget-object v0, Landroidx/camera/core/CameraX$InternalInitState;->UNINITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;

    sget-object v1, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZING:Landroidx/camera/core/CameraX$InternalInitState;

    sget-object v2, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZING_ERROR:Landroidx/camera/core/CameraX$InternalInitState;

    sget-object v3, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;

    sget-object v4, Landroidx/camera/core/CameraX$InternalInitState;->SHUTDOWN:Landroidx/camera/core/CameraX$InternalInitState;

    filled-new-array {v0, v1, v2, v3, v4}, [Landroidx/camera/core/CameraX$InternalInitState;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 573
    new-instance v0, Landroidx/camera/core/CameraX$InternalInitState;

    const-string v1, "UNINITIALIZED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroidx/camera/core/CameraX$InternalInitState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->UNINITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;

    .line 576
    new-instance v0, Landroidx/camera/core/CameraX$InternalInitState;

    const-string v1, "INITIALIZING"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Landroidx/camera/core/CameraX$InternalInitState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZING:Landroidx/camera/core/CameraX$InternalInitState;

    .line 579
    new-instance v0, Landroidx/camera/core/CameraX$InternalInitState;

    const-string v1, "INITIALIZING_ERROR"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Landroidx/camera/core/CameraX$InternalInitState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZING_ERROR:Landroidx/camera/core/CameraX$InternalInitState;

    .line 582
    new-instance v0, Landroidx/camera/core/CameraX$InternalInitState;

    const-string v1, "INITIALIZED"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Landroidx/camera/core/CameraX$InternalInitState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->INITIALIZED:Landroidx/camera/core/CameraX$InternalInitState;

    .line 589
    new-instance v0, Landroidx/camera/core/CameraX$InternalInitState;

    const-string v1, "SHUTDOWN"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Landroidx/camera/core/CameraX$InternalInitState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->SHUTDOWN:Landroidx/camera/core/CameraX$InternalInitState;

    .line 571
    invoke-static {}, Landroidx/camera/core/CameraX$InternalInitState;->$values()[Landroidx/camera/core/CameraX$InternalInitState;

    move-result-object v0

    sput-object v0, Landroidx/camera/core/CameraX$InternalInitState;->$VALUES:[Landroidx/camera/core/CameraX$InternalInitState;

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

    .line 571
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Landroidx/camera/core/CameraX$InternalInitState;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    const-class v0, Landroidx/camera/core/CameraX$InternalInitState;

    .line 571
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Landroidx/camera/core/CameraX$InternalInitState;

    return-object p0
.end method

.method public static values()[Landroidx/camera/core/CameraX$InternalInitState;
    .locals 1

    sget-object v0, Landroidx/camera/core/CameraX$InternalInitState;->$VALUES:[Landroidx/camera/core/CameraX$InternalInitState;

    .line 571
    invoke-virtual {v0}, [Landroidx/camera/core/CameraX$InternalInitState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroidx/camera/core/CameraX$InternalInitState;

    return-object v0
.end method
