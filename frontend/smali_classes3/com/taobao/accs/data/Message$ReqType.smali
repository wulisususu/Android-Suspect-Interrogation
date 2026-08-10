.class public final enum Lcom/taobao/accs/data/Message$ReqType;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/data/Message;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ReqType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/accs/data/Message$ReqType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/accs/data/Message$ReqType;

.field public static final enum ACK:Lcom/taobao/accs/data/Message$ReqType;

.field public static final enum DATA:Lcom/taobao/accs/data/Message$ReqType;

.field public static final enum REQ:Lcom/taobao/accs/data/Message$ReqType;

.field public static final enum RES:Lcom/taobao/accs/data/Message$ReqType;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 80
    new-instance v0, Lcom/taobao/accs/data/Message$ReqType;

    const-string v1, "DATA"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/accs/data/Message$ReqType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/taobao/accs/data/Message$ReqType;->DATA:Lcom/taobao/accs/data/Message$ReqType;

    new-instance v1, Lcom/taobao/accs/data/Message$ReqType;

    const-string v2, "ACK"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/taobao/accs/data/Message$ReqType;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/taobao/accs/data/Message$ReqType;->ACK:Lcom/taobao/accs/data/Message$ReqType;

    new-instance v2, Lcom/taobao/accs/data/Message$ReqType;

    const-string v3, "REQ"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/taobao/accs/data/Message$ReqType;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/taobao/accs/data/Message$ReqType;->REQ:Lcom/taobao/accs/data/Message$ReqType;

    new-instance v3, Lcom/taobao/accs/data/Message$ReqType;

    const-string v4, "RES"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/taobao/accs/data/Message$ReqType;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;

    filled-new-array {v0, v1, v2, v3}, [Lcom/taobao/accs/data/Message$ReqType;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/data/Message$ReqType;->$VALUES:[Lcom/taobao/accs/data/Message$ReqType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 79
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(I)Lcom/taobao/accs/data/Message$ReqType;
    .locals 1

    if-eqz p0, :cond_3

    const/4 v0, 0x1

    if-eq p0, v0, :cond_2

    const/4 v0, 0x2

    if-eq p0, v0, :cond_1

    const/4 v0, 0x3

    if-eq p0, v0, :cond_0

    sget-object p0, Lcom/taobao/accs/data/Message$ReqType;->DATA:Lcom/taobao/accs/data/Message$ReqType;

    return-object p0

    :cond_0
    sget-object p0, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;

    return-object p0

    :cond_1
    sget-object p0, Lcom/taobao/accs/data/Message$ReqType;->REQ:Lcom/taobao/accs/data/Message$ReqType;

    return-object p0

    :cond_2
    sget-object p0, Lcom/taobao/accs/data/Message$ReqType;->ACK:Lcom/taobao/accs/data/Message$ReqType;

    return-object p0

    :cond_3
    sget-object p0, Lcom/taobao/accs/data/Message$ReqType;->DATA:Lcom/taobao/accs/data/Message$ReqType;

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/accs/data/Message$ReqType;
    .locals 1

    const-class v0, Lcom/taobao/accs/data/Message$ReqType;

    .line 79
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/accs/data/Message$ReqType;

    return-object p0
.end method

.method public static values()[Lcom/taobao/accs/data/Message$ReqType;
    .locals 1

    sget-object v0, Lcom/taobao/accs/data/Message$ReqType;->$VALUES:[Lcom/taobao/accs/data/Message$ReqType;

    .line 79
    invoke-virtual {v0}, [Lcom/taobao/accs/data/Message$ReqType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/accs/data/Message$ReqType;

    return-object v0
.end method
