.class public final enum Lcom/taobao/tao/log/godeye/api/a/d;
.super Ljava/lang/Enum;
.source "TraceProgress.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/tao/log/godeye/api/a/d;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lcom/taobao/tao/log/godeye/api/a/d;

.field private static final synthetic a:[Lcom/taobao/tao/log/godeye/api/a/d;

.field public static final enum b:Lcom/taobao/tao/log/godeye/api/a/d;

.field public static final enum c:Lcom/taobao/tao/log/godeye/api/a/d;

.field public static final enum d:Lcom/taobao/tao/log/godeye/api/a/d;

.field public static final enum e:Lcom/taobao/tao/log/godeye/api/a/d;

.field public static final enum f:Lcom/taobao/tao/log/godeye/api/a/d;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 8
    new-instance v0, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v1, "NOT_STARTED"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/taobao/tao/log/godeye/api/a/d;->a:Lcom/taobao/tao/log/godeye/api/a/d;

    new-instance v1, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v2, "EXCEPTION_ON_TRY_TIME_OUT"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/taobao/tao/log/godeye/api/a/d;->b:Lcom/taobao/tao/log/godeye/api/a/d;

    new-instance v2, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v3, "RUNNING"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/taobao/tao/log/godeye/api/a/d;->c:Lcom/taobao/tao/log/godeye/api/a/d;

    new-instance v3, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v4, "COMPLETE"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/taobao/tao/log/godeye/api/a/d;->d:Lcom/taobao/tao/log/godeye/api/a/d;

    new-instance v4, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v5, "EXCEPTION_ON_UPLOAD"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/taobao/tao/log/godeye/api/a/d;->e:Lcom/taobao/tao/log/godeye/api/a/d;

    new-instance v5, Lcom/taobao/tao/log/godeye/api/a/d;

    const-string v6, "UPLOADED"

    const/4 v7, 0x5

    invoke-direct {v5, v6, v7}, Lcom/taobao/tao/log/godeye/api/a/d;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/taobao/tao/log/godeye/api/a/d;->f:Lcom/taobao/tao/log/godeye/api/a/d;

    filled-new-array/range {v0 .. v5}, [Lcom/taobao/tao/log/godeye/api/a/d;

    move-result-object v0

    sput-object v0, Lcom/taobao/tao/log/godeye/api/a/d;->a:[Lcom/taobao/tao/log/godeye/api/a/d;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 6
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/tao/log/godeye/api/a/d;
    .locals 1

    const-class v0, Lcom/taobao/tao/log/godeye/api/a/d;

    .line 6
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/tao/log/godeye/api/a/d;

    return-object p0
.end method

.method public static values()[Lcom/taobao/tao/log/godeye/api/a/d;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/godeye/api/a/d;->a:[Lcom/taobao/tao/log/godeye/api/a/d;

    .line 6
    invoke-virtual {v0}, [Lcom/taobao/tao/log/godeye/api/a/d;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/tao/log/godeye/api/a/d;

    return-object v0
.end method
