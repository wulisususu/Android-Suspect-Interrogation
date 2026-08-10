.class public final enum Lanet/channel/entity/ConnType$TypeLevel;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/entity/ConnType;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "TypeLevel"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lanet/channel/entity/ConnType$TypeLevel;",
        ">;"
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lanet/channel/entity/ConnType$TypeLevel;

.field public static final enum HTTP:Lanet/channel/entity/ConnType$TypeLevel;

.field public static final enum SPDY:Lanet/channel/entity/ConnType$TypeLevel;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 22
    new-instance v0, Lanet/channel/entity/ConnType$TypeLevel;

    const-string v1, "SPDY"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lanet/channel/entity/ConnType$TypeLevel;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    .line 23
    new-instance v1, Lanet/channel/entity/ConnType$TypeLevel;

    const-string v2, "HTTP"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lanet/channel/entity/ConnType$TypeLevel;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lanet/channel/entity/ConnType$TypeLevel;->HTTP:Lanet/channel/entity/ConnType$TypeLevel;

    filled-new-array {v0, v1}, [Lanet/channel/entity/ConnType$TypeLevel;

    move-result-object v0

    sput-object v0, Lanet/channel/entity/ConnType$TypeLevel;->$VALUES:[Lanet/channel/entity/ConnType$TypeLevel;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 21
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lanet/channel/entity/ConnType$TypeLevel;
    .locals 1

    const-class v0, Lanet/channel/entity/ConnType$TypeLevel;

    .line 20
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lanet/channel/entity/ConnType$TypeLevel;

    return-object p0
.end method

.method public static values()[Lanet/channel/entity/ConnType$TypeLevel;
    .locals 1

    sget-object v0, Lanet/channel/entity/ConnType$TypeLevel;->$VALUES:[Lanet/channel/entity/ConnType$TypeLevel;

    .line 20
    invoke-virtual {v0}, [Lanet/channel/entity/ConnType$TypeLevel;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lanet/channel/entity/ConnType$TypeLevel;

    return-object v0
.end method
