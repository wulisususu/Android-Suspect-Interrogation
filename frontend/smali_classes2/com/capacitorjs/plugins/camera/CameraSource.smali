.class public final enum Lcom/capacitorjs/plugins/camera/CameraSource;
.super Ljava/lang/Enum;
.source "CameraSource.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/capacitorjs/plugins/camera/CameraSource;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/capacitorjs/plugins/camera/CameraSource;

.field public static final enum CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

.field public static final enum PHOTOS:Lcom/capacitorjs/plugins/camera/CameraSource;

.field public static final enum PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;


# instance fields
.field private source:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lcom/capacitorjs/plugins/camera/CameraSource;
    .locals 3

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;

    sget-object v1, Lcom/capacitorjs/plugins/camera/CameraSource;->CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

    sget-object v2, Lcom/capacitorjs/plugins/camera/CameraSource;->PHOTOS:Lcom/capacitorjs/plugins/camera/CameraSource;

    filled-new-array {v0, v1, v2}, [Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 4
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraSource;

    const-string v1, "PROMPT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1}, Lcom/capacitorjs/plugins/camera/CameraSource;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->PROMPT:Lcom/capacitorjs/plugins/camera/CameraSource;

    .line 5
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraSource;

    const-string v1, "CAMERA"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v1}, Lcom/capacitorjs/plugins/camera/CameraSource;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->CAMERA:Lcom/capacitorjs/plugins/camera/CameraSource;

    .line 6
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraSource;

    const-string v1, "PHOTOS"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v1}, Lcom/capacitorjs/plugins/camera/CameraSource;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->PHOTOS:Lcom/capacitorjs/plugins/camera/CameraSource;

    .line 3
    invoke-static {}, Lcom/capacitorjs/plugins/camera/CameraSource;->$values()[Lcom/capacitorjs/plugins/camera/CameraSource;

    move-result-object v0

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->$VALUES:[Lcom/capacitorjs/plugins/camera/CameraSource;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 10
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/capacitorjs/plugins/camera/CameraSource;->source:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraSource;
    .locals 1

    const-class v0, Lcom/capacitorjs/plugins/camera/CameraSource;

    .line 3
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/capacitorjs/plugins/camera/CameraSource;

    return-object p0
.end method

.method public static values()[Lcom/capacitorjs/plugins/camera/CameraSource;
    .locals 1

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraSource;->$VALUES:[Lcom/capacitorjs/plugins/camera/CameraSource;

    .line 3
    invoke-virtual {v0}, [Lcom/capacitorjs/plugins/camera/CameraSource;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/capacitorjs/plugins/camera/CameraSource;

    return-object v0
.end method


# virtual methods
.method public getSource()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraSource;->source:Ljava/lang/String;

    return-object v0
.end method
