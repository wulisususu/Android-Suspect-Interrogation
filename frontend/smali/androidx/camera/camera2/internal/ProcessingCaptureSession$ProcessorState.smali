.class final enum Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;
.super Ljava/lang/Enum;
.source "ProcessingCaptureSession.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/camera2/internal/ProcessingCaptureSession;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "ProcessorState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

.field public static final enum DE_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

.field public static final enum ON_CAPTURE_SESSION_ENDED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

.field public static final enum ON_CAPTURE_SESSION_STARTED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

.field public static final enum SESSION_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

.field public static final enum UNINITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;


# direct methods
.method private static synthetic $values()[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;
    .locals 5

    sget-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->UNINITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    sget-object v1, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->SESSION_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    sget-object v2, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->ON_CAPTURE_SESSION_STARTED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    sget-object v3, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->ON_CAPTURE_SESSION_ENDED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    sget-object v4, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->DE_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    filled-new-array {v0, v1, v2, v3, v4}, [Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 112
    new-instance v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    const-string v1, "UNINITIALIZED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->UNINITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 113
    new-instance v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    const-string v1, "SESSION_INITIALIZED"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->SESSION_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 114
    new-instance v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    const-string v1, "ON_CAPTURE_SESSION_STARTED"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->ON_CAPTURE_SESSION_STARTED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 115
    new-instance v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    const-string v1, "ON_CAPTURE_SESSION_ENDED"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->ON_CAPTURE_SESSION_ENDED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 116
    new-instance v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    const-string v1, "DE_INITIALIZED"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->DE_INITIALIZED:Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 111
    invoke-static {}, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->$values()[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    move-result-object v0

    sput-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->$VALUES:[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

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

    .line 111
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            null
        }
    .end annotation

    const-class v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 111
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    return-object p0
.end method

.method public static values()[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;
    .locals 1

    sget-object v0, Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->$VALUES:[Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    .line 111
    invoke-virtual {v0}, [Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroidx/camera/camera2/internal/ProcessingCaptureSession$ProcessorState;

    return-object v0
.end method
