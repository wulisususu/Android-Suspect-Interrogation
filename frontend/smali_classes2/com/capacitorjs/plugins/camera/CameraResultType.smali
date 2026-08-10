.class public final enum Lcom/capacitorjs/plugins/camera/CameraResultType;
.super Ljava/lang/Enum;
.source "CameraResultType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/capacitorjs/plugins/camera/CameraResultType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/capacitorjs/plugins/camera/CameraResultType;

.field public static final enum BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

.field public static final enum DATAURL:Lcom/capacitorjs/plugins/camera/CameraResultType;

.field public static final enum URI:Lcom/capacitorjs/plugins/camera/CameraResultType;


# instance fields
.field private type:Ljava/lang/String;


# direct methods
.method private static synthetic $values()[Lcom/capacitorjs/plugins/camera/CameraResultType;
    .locals 3

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

    sget-object v1, Lcom/capacitorjs/plugins/camera/CameraResultType;->URI:Lcom/capacitorjs/plugins/camera/CameraResultType;

    sget-object v2, Lcom/capacitorjs/plugins/camera/CameraResultType;->DATAURL:Lcom/capacitorjs/plugins/camera/CameraResultType;

    filled-new-array {v0, v1, v2}, [Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 4
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraResultType;

    const/4 v1, 0x0

    const-string v2, "base64"

    const-string v3, "BASE64"

    invoke-direct {v0, v3, v1, v2}, Lcom/capacitorjs/plugins/camera/CameraResultType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->BASE64:Lcom/capacitorjs/plugins/camera/CameraResultType;

    .line 5
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraResultType;

    const/4 v1, 0x1

    const-string v2, "uri"

    const-string v3, "URI"

    invoke-direct {v0, v3, v1, v2}, Lcom/capacitorjs/plugins/camera/CameraResultType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->URI:Lcom/capacitorjs/plugins/camera/CameraResultType;

    .line 6
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraResultType;

    const/4 v1, 0x2

    const-string v2, "dataUrl"

    const-string v3, "DATAURL"

    invoke-direct {v0, v3, v1, v2}, Lcom/capacitorjs/plugins/camera/CameraResultType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->DATAURL:Lcom/capacitorjs/plugins/camera/CameraResultType;

    .line 3
    invoke-static {}, Lcom/capacitorjs/plugins/camera/CameraResultType;->$values()[Lcom/capacitorjs/plugins/camera/CameraResultType;

    move-result-object v0

    sput-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->$VALUES:[Lcom/capacitorjs/plugins/camera/CameraResultType;

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

    iput-object p3, p0, Lcom/capacitorjs/plugins/camera/CameraResultType;->type:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/capacitorjs/plugins/camera/CameraResultType;
    .locals 1

    const-class v0, Lcom/capacitorjs/plugins/camera/CameraResultType;

    .line 3
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/capacitorjs/plugins/camera/CameraResultType;

    return-object p0
.end method

.method public static values()[Lcom/capacitorjs/plugins/camera/CameraResultType;
    .locals 1

    sget-object v0, Lcom/capacitorjs/plugins/camera/CameraResultType;->$VALUES:[Lcom/capacitorjs/plugins/camera/CameraResultType;

    .line 3
    invoke-virtual {v0}, [Lcom/capacitorjs/plugins/camera/CameraResultType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/capacitorjs/plugins/camera/CameraResultType;

    return-object v0
.end method


# virtual methods
.method public getType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraResultType;->type:Ljava/lang/String;

    return-object v0
.end method
