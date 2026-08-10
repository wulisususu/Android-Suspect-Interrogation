.class final enum Lcom/aliyun/emas/apm/concurrent/i$c;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/concurrent/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "c"
.end annotation


# static fields
.field public static final enum a:Lcom/aliyun/emas/apm/concurrent/i$c;

.field public static final enum b:Lcom/aliyun/emas/apm/concurrent/i$c;

.field public static final enum c:Lcom/aliyun/emas/apm/concurrent/i$c;

.field public static final enum d:Lcom/aliyun/emas/apm/concurrent/i$c;

.field private static final synthetic e:[Lcom/aliyun/emas/apm/concurrent/i$c;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i$c;

    const-string v1, "IDLE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/i$c;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i$c;

    const-string v1, "QUEUING"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/i$c;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->b:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 5
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i$c;

    const-string v1, "QUEUED"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/i$c;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 6
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i$c;

    const-string v1, "RUNNING"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/i$c;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->d:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/i$c;->a()[Lcom/aliyun/emas/apm/concurrent/i$c;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->e:[Lcom/aliyun/emas/apm/concurrent/i$c;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method private static synthetic a()[Lcom/aliyun/emas/apm/concurrent/i$c;
    .locals 4

    sget-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    sget-object v1, Lcom/aliyun/emas/apm/concurrent/i$c;->b:Lcom/aliyun/emas/apm/concurrent/i$c;

    sget-object v2, Lcom/aliyun/emas/apm/concurrent/i$c;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->d:Lcom/aliyun/emas/apm/concurrent/i$c;

    filled-new-array {v0, v1, v2, v3}, [Lcom/aliyun/emas/apm/concurrent/i$c;

    move-result-object v0

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/aliyun/emas/apm/concurrent/i$c;
    .locals 1

    const-class v0, Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 1
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/aliyun/emas/apm/concurrent/i$c;

    return-object p0
.end method

.method public static values()[Lcom/aliyun/emas/apm/concurrent/i$c;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->e:[Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 1
    invoke-virtual {v0}, [Lcom/aliyun/emas/apm/concurrent/i$c;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/aliyun/emas/apm/concurrent/i$c;

    return-object v0
.end method
