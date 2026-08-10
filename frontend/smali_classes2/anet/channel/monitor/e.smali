.class Lanet/channel/monitor/e;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field private a:J

.field private b:D

.field private c:D

.field private d:D

.field private e:D

.field private f:D

.field private g:D

.field private h:D

.field private i:D

.field private j:D

.field private k:D


# direct methods
.method constructor <init>()V
    .locals 2

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/monitor/e;->a:J

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/monitor/e;->i:D

    iput-wide v0, p0, Lanet/channel/monitor/e;->j:D

    iput-wide v0, p0, Lanet/channel/monitor/e;->k:D

    return-void
.end method


# virtual methods
.method public a(DD)D
    .locals 11

    div-double/2addr p1, p3

    const-wide/high16 p3, 0x4020000000000000L    # 8.0

    cmpg-double p3, p1, p3

    const-wide/16 v0, 0x0

    if-gez p3, :cond_1

    iget-wide p3, p0, Lanet/channel/monitor/e;->a:J

    cmp-long p3, p3, v0

    if-eqz p3, :cond_0

    iget-wide p1, p0, Lanet/channel/monitor/e;->k:D

    return-wide p1

    :cond_0
    iput-wide p1, p0, Lanet/channel/monitor/e;->k:D

    return-wide p1

    :cond_1
    iget-wide p3, p0, Lanet/channel/monitor/e;->a:J

    cmp-long v0, p3, v0

    if-nez v0, :cond_2

    iput-wide p1, p0, Lanet/channel/monitor/e;->i:D

    iput-wide p1, p0, Lanet/channel/monitor/e;->h:D

    const-wide p3, 0x3fb999999999999aL    # 0.1

    mul-double v0, p1, p3

    iput-wide v0, p0, Lanet/channel/monitor/e;->d:D

    const-wide v0, 0x3f947ae147ae147bL    # 0.02

    mul-double/2addr v0, p1

    iput-wide v0, p0, Lanet/channel/monitor/e;->c:D

    mul-double/2addr p3, p1

    mul-double/2addr p3, p1

    iput-wide p3, p0, Lanet/channel/monitor/e;->e:D

    goto/16 :goto_2

    :cond_2
    const-wide/16 v0, 0x1

    cmp-long p3, p3, v0

    if-nez p3, :cond_3

    iput-wide p1, p0, Lanet/channel/monitor/e;->j:D

    iput-wide p1, p0, Lanet/channel/monitor/e;->h:D

    goto/16 :goto_2

    :cond_3
    iget-wide p3, p0, Lanet/channel/monitor/e;->j:D

    sub-double v0, p1, p3

    iput-wide p3, p0, Lanet/channel/monitor/e;->i:D

    iput-wide p1, p0, Lanet/channel/monitor/e;->j:D

    const-wide p3, 0x3fee666666666666L    # 0.95

    div-double/2addr p1, p3

    iput-wide p1, p0, Lanet/channel/monitor/e;->b:D

    iget-wide v2, p0, Lanet/channel/monitor/e;->h:D

    mul-double/2addr v2, p3

    sub-double/2addr p1, v2

    iput-wide p1, p0, Lanet/channel/monitor/e;->g:D

    iget-wide p1, p0, Lanet/channel/monitor/e;->d:D

    .line 73
    invoke-static {p1, p2}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide p1

    iget-wide v2, p0, Lanet/channel/monitor/e;->g:D

    const-wide/high16 v4, 0x4010000000000000L    # 4.0

    mul-double/2addr v4, p1

    cmpl-double v4, v2, v4

    const/4 v5, 0x2

    const-wide/high16 v6, 0x3fe8000000000000L    # 0.75

    const/4 v8, 0x1

    if-ltz v4, :cond_4

    mul-double/2addr v2, v6

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    mul-double/2addr p1, v6

    add-double/2addr v2, p1

    iput-wide v2, p0, Lanet/channel/monitor/e;->g:D

    move p1, v8

    goto :goto_0

    :cond_4
    const-wide/high16 v9, -0x3ff0000000000000L    # -4.0

    mul-double/2addr v9, p1

    cmpg-double v4, v2, v9

    if-gtz v4, :cond_5

    const-wide/high16 v9, -0x4010000000000000L    # -1.0

    mul-double/2addr p1, v9

    mul-double/2addr v2, v6

    add-double/2addr p1, v2

    iput-wide p1, p0, Lanet/channel/monitor/e;->g:D

    move p1, v5

    goto :goto_0

    :cond_5
    const/4 p1, 0x0

    :goto_0
    const-wide v2, 0x3ff0cccccccccccdL    # 1.05

    iget-wide v6, p0, Lanet/channel/monitor/e;->d:D

    mul-double/2addr v6, v2

    iget-wide v2, p0, Lanet/channel/monitor/e;->g:D

    const-wide v9, 0x3f647ae147ae147bL    # 0.0025

    mul-double/2addr v9, v2

    mul-double/2addr v9, v2

    sub-double/2addr v6, v9

    .line 84
    invoke-static {v6, v7}, Ljava/lang/Math;->abs(D)D

    move-result-wide v2

    const-wide v6, 0x3fe999999999999aL    # 0.8

    iget-wide v9, p0, Lanet/channel/monitor/e;->d:D

    mul-double/2addr v9, v6

    invoke-static {v2, v3, v9, v10}, Ljava/lang/Math;->max(DD)D

    move-result-wide v2

    const-wide/high16 v6, 0x3ff4000000000000L    # 1.25

    iget-wide v9, p0, Lanet/channel/monitor/e;->d:D

    mul-double/2addr v9, v6

    .line 85
    invoke-static {v2, v3, v9, v10}, Ljava/lang/Math;->min(DD)D

    move-result-wide v2

    iput-wide v2, p0, Lanet/channel/monitor/e;->d:D

    iget-wide v6, p0, Lanet/channel/monitor/e;->e:D

    const-wide v9, 0x3fece147ae147ae1L    # 0.9025

    mul-double/2addr v9, v6

    add-double/2addr v9, v2

    div-double/2addr v6, v9

    iput-wide v6, p0, Lanet/channel/monitor/e;->f:D

    iget-wide v2, p0, Lanet/channel/monitor/e;->h:D

    const-wide v9, 0x3ff0d79435e50d79L    # 1.0526315789473684

    mul-double/2addr v9, v0

    add-double/2addr v2, v9

    iget-wide v0, p0, Lanet/channel/monitor/e;->g:D

    mul-double/2addr v6, v0

    add-double/2addr v2, v6

    iput-wide v2, p0, Lanet/channel/monitor/e;->h:D

    if-ne p1, v8, :cond_6

    iget-wide p1, p0, Lanet/channel/monitor/e;->b:D

    .line 91
    invoke-static {v2, v3, p1, p2}, Ljava/lang/Math;->min(DD)D

    move-result-wide p1

    iput-wide p1, p0, Lanet/channel/monitor/e;->h:D

    goto :goto_1

    :cond_6
    if-ne p1, v5, :cond_7

    iget-wide p1, p0, Lanet/channel/monitor/e;->b:D

    .line 93
    invoke-static {v2, v3, p1, p2}, Ljava/lang/Math;->max(DD)D

    move-result-wide p1

    iput-wide p1, p0, Lanet/channel/monitor/e;->h:D

    :cond_7
    :goto_1
    iget-wide p1, p0, Lanet/channel/monitor/e;->f:D

    mul-double/2addr p3, p1

    const-wide/high16 p1, 0x3ff0000000000000L    # 1.0

    sub-double/2addr p1, p3

    iget-wide p3, p0, Lanet/channel/monitor/e;->e:D

    iget-wide v0, p0, Lanet/channel/monitor/e;->c:D

    add-double/2addr p3, v0

    mul-double/2addr p1, p3

    iput-wide p1, p0, Lanet/channel/monitor/e;->e:D

    :goto_2
    iget-wide p1, p0, Lanet/channel/monitor/e;->h:D

    const-wide/16 p3, 0x0

    cmpg-double p3, p1, p3

    if-gez p3, :cond_8

    iget-wide p1, p0, Lanet/channel/monitor/e;->j:D

    const-wide p3, 0x3fe6666666666666L    # 0.7

    mul-double/2addr p1, p3

    iput-wide p1, p0, Lanet/channel/monitor/e;->k:D

    iput-wide p1, p0, Lanet/channel/monitor/e;->h:D

    goto :goto_3

    :cond_8
    iput-wide p1, p0, Lanet/channel/monitor/e;->k:D

    :goto_3
    iget-wide p1, p0, Lanet/channel/monitor/e;->k:D

    return-wide p1
.end method

.method public a()V
    .locals 2

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/monitor/e;->a:J

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/monitor/e;->k:D

    return-void
.end method
