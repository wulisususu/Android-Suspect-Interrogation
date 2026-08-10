.class public Lanet/channel/monitor/f;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field a:Z

.field protected b:J

.field private final c:D

.field private d:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/high16 v0, 0x4044000000000000L    # 40.0

    iput-wide v0, p0, Lanet/channel/monitor/f;->c:D

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/monitor/f;->a:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/monitor/f;->d:Z

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public a(D)Z
    .locals 2

    const-wide/high16 v0, 0x4044000000000000L    # 40.0

    cmpg-double p1, p1, v0

    if-gez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method protected final b()Z
    .locals 6

    iget-boolean v0, p0, Lanet/channel/monitor/f;->d:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 45
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lanet/channel/monitor/f;->b:J

    sub-long/2addr v2, v4

    invoke-virtual {p0}, Lanet/channel/monitor/f;->a()I

    move-result v0

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v4, v0

    cmp-long v0, v2, v4

    if-lez v0, :cond_0

    iput-boolean v1, p0, Lanet/channel/monitor/f;->d:Z

    return v1

    :cond_0
    const/4 v0, 0x1

    return v0

    :cond_1
    return v1
.end method
