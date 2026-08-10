.class public Lcom/taobao/monitor/impl/data/r/a;
.super Ljava/lang/Object;
.source "TrafficTracker.java"


# static fields
.field private static a:I = -0x1

.field private static a:Z

.field private static a:[J


# direct methods
.method static constructor <clinit>()V
    .locals 7

    const/4 v0, 0x2

    new-array v0, v0, [J

    sput-object v0, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    .line 4
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v0

    sput v0, Lcom/taobao/monitor/impl/data/r/a;->a:I

    sget-object v1, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    .line 5
    invoke-static {v0}, Landroid/net/TrafficStats;->getUidRxBytes(I)J

    move-result-wide v2

    const/4 v0, 0x0

    aput-wide v2, v1, v0

    sget-object v1, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    sget v2, Lcom/taobao/monitor/impl/data/r/a;->a:I

    .line 6
    invoke-static {v2}, Landroid/net/TrafficStats;->getUidTxBytes(I)J

    move-result-wide v2

    const/4 v4, 0x1

    aput-wide v2, v1, v4

    sget-object v1, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    .line 7
    aget-wide v2, v1, v0

    const-wide/16 v5, 0x0

    cmp-long v2, v2, v5

    if-ltz v2, :cond_0

    aget-wide v2, v1, v4

    cmp-long v1, v2, v5

    if-ltz v1, :cond_0

    move v0, v4

    :cond_0
    sput-boolean v0, Lcom/taobao/monitor/impl/data/r/a;->a:Z

    return-void
.end method

.method public static a()[J
    .locals 4

    sget-boolean v0, Lcom/taobao/monitor/impl/data/r/a;->a:Z

    if-eqz v0, :cond_0

    sget v0, Lcom/taobao/monitor/impl/data/r/a;->a:I

    if-lez v0, :cond_0

    sget-object v1, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    .line 2
    invoke-static {v0}, Landroid/net/TrafficStats;->getUidRxBytes(I)J

    move-result-wide v2

    const/4 v0, 0x0

    aput-wide v2, v1, v0

    sget-object v0, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    sget v1, Lcom/taobao/monitor/impl/data/r/a;->a:I

    .line 3
    invoke-static {v1}, Landroid/net/TrafficStats;->getUidTxBytes(I)J

    move-result-wide v1

    const/4 v3, 0x1

    aput-wide v1, v0, v3

    sget-object v0, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    return-object v0

    :cond_0
    sget-object v0, Lcom/taobao/monitor/impl/data/r/a;->a:[J

    return-object v0
.end method
