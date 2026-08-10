.class public final enum Lanetwork/channel/monitor/speed/NetworkSpeed;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lanetwork/channel/monitor/speed/NetworkSpeed;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lanetwork/channel/monitor/speed/NetworkSpeed;

.field public static final enum Fast:Lanetwork/channel/monitor/speed/NetworkSpeed;

.field public static final enum Slow:Lanetwork/channel/monitor/speed/NetworkSpeed;


# instance fields
.field private final code:I

.field private final desc:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 6
    new-instance v0, Lanetwork/channel/monitor/speed/NetworkSpeed;

    const-string v1, "Slow"

    const/4 v2, 0x0

    const-string/jumbo v3, "\u5f31\u7f51\u7edc"

    const/4 v4, 0x1

    invoke-direct {v0, v1, v2, v3, v4}, Lanetwork/channel/monitor/speed/NetworkSpeed;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v0, Lanetwork/channel/monitor/speed/NetworkSpeed;->Slow:Lanetwork/channel/monitor/speed/NetworkSpeed;

    .line 7
    new-instance v1, Lanetwork/channel/monitor/speed/NetworkSpeed;

    const-string/jumbo v2, "\u5f3a\u7f51\u7edc"

    const/4 v3, 0x5

    const-string v5, "Fast"

    invoke-direct {v1, v5, v4, v2, v3}, Lanetwork/channel/monitor/speed/NetworkSpeed;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    sput-object v1, Lanetwork/channel/monitor/speed/NetworkSpeed;->Fast:Lanetwork/channel/monitor/speed/NetworkSpeed;

    filled-new-array {v0, v1}, [Lanetwork/channel/monitor/speed/NetworkSpeed;

    move-result-object v0

    sput-object v0, Lanetwork/channel/monitor/speed/NetworkSpeed;->$VALUES:[Lanetwork/channel/monitor/speed/NetworkSpeed;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    .line 10
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->desc:Ljava/lang/String;

    iput p4, p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->code:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lanetwork/channel/monitor/speed/NetworkSpeed;
    .locals 1

    const-class v0, Lanetwork/channel/monitor/speed/NetworkSpeed;

    .line 4
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lanetwork/channel/monitor/speed/NetworkSpeed;

    return-object p0
.end method

.method public static valueOfCode(I)Lanetwork/channel/monitor/speed/NetworkSpeed;
    .locals 1

    const/4 v0, 0x1

    if-ne p0, v0, :cond_0

    sget-object p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->Slow:Lanetwork/channel/monitor/speed/NetworkSpeed;

    goto :goto_0

    :cond_0
    sget-object p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->Fast:Lanetwork/channel/monitor/speed/NetworkSpeed;

    :goto_0
    return-object p0
.end method

.method public static values()[Lanetwork/channel/monitor/speed/NetworkSpeed;
    .locals 1

    sget-object v0, Lanetwork/channel/monitor/speed/NetworkSpeed;->$VALUES:[Lanetwork/channel/monitor/speed/NetworkSpeed;

    .line 4
    invoke-virtual {v0}, [Lanetwork/channel/monitor/speed/NetworkSpeed;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lanetwork/channel/monitor/speed/NetworkSpeed;

    return-object v0
.end method


# virtual methods
.method public getCode()I
    .locals 1

    iget v0, p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->code:I

    return v0
.end method

.method public getDesc()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/monitor/speed/NetworkSpeed;->desc:Ljava/lang/String;

    return-object v0
.end method
