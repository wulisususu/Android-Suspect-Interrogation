.class Lanet/channel/strategy/ConnHistoryItem;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field a:B

.field b:J

.field c:J


# direct methods
.method constructor <init>()V
    .locals 2

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lanet/channel/strategy/ConnHistoryItem;->a:B

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/strategy/ConnHistoryItem;->b:J

    iput-wide v0, p0, Lanet/channel/strategy/ConnHistoryItem;->c:J

    return-void
.end method


# virtual methods
.method a()I
    .locals 3

    iget-byte v0, p0, Lanet/channel/strategy/ConnHistoryItem;->a:B

    and-int/lit16 v0, v0, 0xff

    const/4 v1, 0x0

    :goto_0
    if-lez v0, :cond_0

    and-int/lit8 v2, v0, 0x1

    add-int/2addr v1, v2

    shr-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return v1
.end method

.method a(Z)V
    .locals 6

    .line 21
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    if-eqz p1, :cond_0

    iget-wide v2, p0, Lanet/channel/strategy/ConnHistoryItem;->b:J

    goto :goto_0

    :cond_0
    iget-wide v2, p0, Lanet/channel/strategy/ConnHistoryItem;->c:J

    :goto_0
    sub-long v2, v0, v2

    const-wide/16 v4, 0x2710

    cmp-long v2, v2, v4

    if-lez v2, :cond_2

    iget-byte v2, p0, Lanet/channel/strategy/ConnHistoryItem;->a:B

    shl-int/lit8 v2, v2, 0x1

    xor-int/lit8 v3, p1, 0x1

    or-int/2addr v2, v3

    int-to-byte v2, v2

    iput-byte v2, p0, Lanet/channel/strategy/ConnHistoryItem;->a:B

    if-eqz p1, :cond_1

    iput-wide v0, p0, Lanet/channel/strategy/ConnHistoryItem;->b:J

    goto :goto_1

    :cond_1
    iput-wide v0, p0, Lanet/channel/strategy/ConnHistoryItem;->c:J

    :cond_2
    :goto_1
    return-void
.end method

.method b()Z
    .locals 2

    iget-byte v0, p0, Lanet/channel/strategy/ConnHistoryItem;->a:B

    const/4 v1, 0x1

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method c()Z
    .locals 5

    .line 47
    invoke-virtual {p0}, Lanet/channel/strategy/ConnHistoryItem;->a()I

    move-result v0

    const/4 v1, 0x3

    const/4 v2, 0x0

    if-ge v0, v1, :cond_0

    return v2

    .line 51
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v3, p0, Lanet/channel/strategy/ConnHistoryItem;->c:J

    sub-long/2addr v0, v3

    const-wide/32 v3, 0x493e0

    cmp-long v0, v0, v3

    if-gtz v0, :cond_1

    const/4 v2, 0x1

    :cond_1
    return v2
.end method

.method d()Z
    .locals 5

    iget-wide v0, p0, Lanet/channel/strategy/ConnHistoryItem;->b:J

    iget-wide v2, p0, Lanet/channel/strategy/ConnHistoryItem;->c:J

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    goto :goto_0

    :cond_0
    move-wide v0, v2

    :goto_0
    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-eqz v2, :cond_1

    .line 56
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long/2addr v2, v0

    const-wide/32 v0, 0x5265c00

    cmp-long v0, v2, v0

    if-lez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    return v0
.end method
