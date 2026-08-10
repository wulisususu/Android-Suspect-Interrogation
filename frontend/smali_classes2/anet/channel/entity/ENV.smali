.class public final enum Lanet/channel/entity/ENV;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lanet/channel/entity/ENV;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lanet/channel/entity/ENV;

.field public static final enum ONLINE:Lanet/channel/entity/ENV;

.field public static final enum PREPARE:Lanet/channel/entity/ENV;

.field public static final enum TEST:Lanet/channel/entity/ENV;


# instance fields
.field private envMode:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 8
    new-instance v0, Lanet/channel/entity/ENV;

    const-string v1, "ONLINE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lanet/channel/entity/ENV;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lanet/channel/entity/ENV;->ONLINE:Lanet/channel/entity/ENV;

    new-instance v1, Lanet/channel/entity/ENV;

    const-string v2, "PREPARE"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3, v3}, Lanet/channel/entity/ENV;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lanet/channel/entity/ENV;->PREPARE:Lanet/channel/entity/ENV;

    new-instance v2, Lanet/channel/entity/ENV;

    const-string v3, "TEST"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4, v4}, Lanet/channel/entity/ENV;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lanet/channel/entity/ENV;->TEST:Lanet/channel/entity/ENV;

    filled-new-array {v0, v1, v2}, [Lanet/channel/entity/ENV;

    move-result-object v0

    sput-object v0, Lanet/channel/entity/ENV;->$VALUES:[Lanet/channel/entity/ENV;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 28
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lanet/channel/entity/ENV;->envMode:I

    return-void
.end method

.method public static valueOf(I)Lanet/channel/entity/ENV;
    .locals 1

    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    const/4 v0, 0x2

    if-eq p0, v0, :cond_0

    sget-object p0, Lanet/channel/entity/ENV;->ONLINE:Lanet/channel/entity/ENV;

    return-object p0

    :cond_0
    sget-object p0, Lanet/channel/entity/ENV;->TEST:Lanet/channel/entity/ENV;

    return-object p0

    :cond_1
    sget-object p0, Lanet/channel/entity/ENV;->PREPARE:Lanet/channel/entity/ENV;

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lanet/channel/entity/ENV;
    .locals 1

    const-class v0, Lanet/channel/entity/ENV;

    .line 7
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lanet/channel/entity/ENV;

    return-object p0
.end method

.method public static values()[Lanet/channel/entity/ENV;
    .locals 1

    sget-object v0, Lanet/channel/entity/ENV;->$VALUES:[Lanet/channel/entity/ENV;

    .line 7
    invoke-virtual {v0}, [Lanet/channel/entity/ENV;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lanet/channel/entity/ENV;

    return-object v0
.end method


# virtual methods
.method public getEnvMode()I
    .locals 1

    iget v0, p0, Lanet/channel/entity/ENV;->envMode:I

    return v0
.end method

.method public setEnvMode(I)V
    .locals 0

    iput p1, p0, Lanet/channel/entity/ENV;->envMode:I

    return-void
.end method
