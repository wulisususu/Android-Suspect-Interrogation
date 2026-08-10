.class Lanet/channel/monitor/d;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:J

.field final synthetic b:J

.field final synthetic c:J

.field final synthetic d:Lanet/channel/monitor/b;


# direct methods
.method constructor <init>(Lanet/channel/monitor/b;JJJ)V
    .locals 0

    iput-object p1, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    iput-wide p2, p0, Lanet/channel/monitor/d;->a:J

    iput-wide p4, p0, Lanet/channel/monitor/d;->b:J

    iput-wide p6, p0, Lanet/channel/monitor/d;->c:J

    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    .line 106
    sget v0, Lanet/channel/monitor/b;->a:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    sput v0, Lanet/channel/monitor/b;->a:I

    .line 107
    sget-wide v2, Lanet/channel/monitor/b;->e:J

    iget-wide v4, p0, Lanet/channel/monitor/d;->a:J

    add-long/2addr v2, v4

    sput-wide v2, Lanet/channel/monitor/b;->e:J

    .line 109
    sget v0, Lanet/channel/monitor/b;->a:I

    if-ne v0, v1, :cond_0

    iget-wide v2, p0, Lanet/channel/monitor/d;->b:J

    iget-wide v4, p0, Lanet/channel/monitor/d;->c:J

    sub-long/2addr v2, v4

    .line 110
    sput-wide v2, Lanet/channel/monitor/b;->d:J

    .line 113
    :cond_0
    sget v0, Lanet/channel/monitor/b;->a:I

    const/4 v2, 0x2

    const/4 v3, 0x3

    if-lt v0, v2, :cond_2

    sget v0, Lanet/channel/monitor/b;->a:I

    if-gt v0, v3, :cond_2

    iget-wide v4, p0, Lanet/channel/monitor/d;->c:J

    .line 115
    sget-wide v6, Lanet/channel/monitor/b;->c:J

    cmp-long v0, v4, v6

    if-ltz v0, :cond_1

    .line 116
    sget-wide v4, Lanet/channel/monitor/b;->d:J

    iget-wide v6, p0, Lanet/channel/monitor/d;->b:J

    iget-wide v8, p0, Lanet/channel/monitor/d;->c:J

    sub-long/2addr v6, v8

    add-long/2addr v4, v6

    sput-wide v4, Lanet/channel/monitor/b;->d:J

    goto :goto_0

    :cond_1
    iget-wide v4, p0, Lanet/channel/monitor/d;->c:J

    .line 119
    sget-wide v6, Lanet/channel/monitor/b;->c:J

    cmp-long v0, v4, v6

    if-gez v0, :cond_2

    iget-wide v4, p0, Lanet/channel/monitor/d;->b:J

    sget-wide v6, Lanet/channel/monitor/b;->c:J

    cmp-long v0, v4, v6

    if-ltz v0, :cond_2

    .line 120
    sget-wide v4, Lanet/channel/monitor/b;->d:J

    iget-wide v6, p0, Lanet/channel/monitor/d;->b:J

    iget-wide v8, p0, Lanet/channel/monitor/d;->c:J

    sub-long/2addr v6, v8

    add-long/2addr v4, v6

    sput-wide v4, Lanet/channel/monitor/b;->d:J

    .line 121
    sget-wide v4, Lanet/channel/monitor/b;->d:J

    sget-wide v6, Lanet/channel/monitor/b;->c:J

    iget-wide v8, p0, Lanet/channel/monitor/d;->c:J

    sub-long/2addr v6, v8

    sub-long/2addr v4, v6

    sput-wide v4, Lanet/channel/monitor/b;->d:J

    :cond_2
    :goto_0
    iget-wide v4, p0, Lanet/channel/monitor/d;->c:J

    .line 129
    sput-wide v4, Lanet/channel/monitor/b;->b:J

    iget-wide v4, p0, Lanet/channel/monitor/d;->b:J

    .line 130
    sput-wide v4, Lanet/channel/monitor/b;->c:J

    .line 132
    sget v0, Lanet/channel/monitor/b;->a:I

    if-ne v0, v3, :cond_a

    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 133
    invoke-static {v0}, Lanet/channel/monitor/b;->a(Lanet/channel/monitor/b;)Lanet/channel/monitor/e;

    move-result-object v0

    sget-wide v2, Lanet/channel/monitor/b;->e:J

    long-to-double v2, v2

    sget-wide v4, Lanet/channel/monitor/b;->d:J

    long-to-double v4, v4

    invoke-virtual {v0, v2, v3, v4, v5}, Lanet/channel/monitor/e;->a(DD)D

    move-result-wide v2

    double-to-long v2, v2

    long-to-double v2, v2

    sput-wide v2, Lanet/channel/monitor/b;->i:D

    .line 135
    sget-wide v2, Lanet/channel/monitor/b;->f:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    sput-wide v2, Lanet/channel/monitor/b;->f:J

    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 136
    invoke-static {v0}, Lanet/channel/monitor/b;->b(Lanet/channel/monitor/b;)I

    .line 139
    sget-wide v2, Lanet/channel/monitor/b;->f:J

    const-wide/16 v4, 0x1e

    cmp-long v0, v2, v4

    if-lez v0, :cond_3

    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 140
    invoke-static {v0}, Lanet/channel/monitor/b;->a(Lanet/channel/monitor/b;)Lanet/channel/monitor/e;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/monitor/e;->a()V

    const-wide/16 v2, 0x3

    .line 141
    sput-wide v2, Lanet/channel/monitor/b;->f:J

    .line 145
    :cond_3
    sget-wide v2, Lanet/channel/monitor/b;->i:D

    const-wide v4, 0x3fe5c28f5c28f5c3L    # 0.68

    mul-double/2addr v2, v4

    sget-wide v4, Lanet/channel/monitor/b;->h:D

    const-wide v6, 0x3fd147ae147ae148L    # 0.27

    mul-double/2addr v4, v6

    add-double/2addr v2, v4

    sget-wide v4, Lanet/channel/monitor/b;->g:D

    const-wide v6, 0x3fa999999999999aL    # 0.05

    mul-double/2addr v4, v6

    add-double/2addr v2, v4

    .line 147
    sget-wide v4, Lanet/channel/monitor/b;->h:D

    sput-wide v4, Lanet/channel/monitor/b;->g:D

    .line 148
    sget-wide v4, Lanet/channel/monitor/b;->i:D

    sput-wide v4, Lanet/channel/monitor/b;->h:D

    .line 151
    sget-wide v4, Lanet/channel/monitor/b;->i:D

    const-wide v6, 0x3fe4cccccccccccdL    # 0.65

    sget-wide v8, Lanet/channel/monitor/b;->g:D

    mul-double/2addr v8, v6

    cmpg-double v0, v4, v8

    if-ltz v0, :cond_4

    sget-wide v4, Lanet/channel/monitor/b;->i:D

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    sget-wide v8, Lanet/channel/monitor/b;->g:D

    mul-double/2addr v8, v6

    cmpl-double v0, v4, v8

    if-lez v0, :cond_5

    .line 152
    :cond_4
    sput-wide v2, Lanet/channel/monitor/b;->i:D

    .line 155
    :cond_5
    invoke-static {v1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    const/4 v2, 0x0

    const-string v3, "awcn.BandWidthSampler"

    if-eqz v0, :cond_6

    const-string v4, "mKalmanDataSize"

    .line 156
    sget-wide v5, Lanet/channel/monitor/b;->e:J

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    const-string v6, "mKalmanTimeUsed"

    sget-wide v7, Lanet/channel/monitor/b;->d:J

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    const-string v8, "speed"

    sget-wide v9, Lanet/channel/monitor/b;->i:D

    .line 157
    invoke-static {v9, v10}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v9

    const-string v10, "mSpeedKalmanCount"

    sget-wide v11, Lanet/channel/monitor/b;->f:J

    invoke-static {v11, v12}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v11

    filled-new-array/range {v4 .. v11}, [Ljava/lang/Object;

    move-result-object v0

    const-string v4, "NetworkSpeed"

    .line 156
    invoke-static {v3, v4, v2, v0}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_6
    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 162
    invoke-static {v0}, Lanet/channel/monitor/b;->c(Lanet/channel/monitor/b;)I

    move-result v0

    const/4 v4, 0x0

    const/4 v5, 0x5

    if-gt v0, v5, :cond_7

    sget-wide v6, Lanet/channel/monitor/b;->f:J

    const-wide/16 v8, 0x2

    cmp-long v0, v6, v8

    if-nez v0, :cond_9

    .line 163
    :cond_7
    invoke-static {}, Lanet/channel/monitor/a;->a()Lanet/channel/monitor/a;

    move-result-object v0

    sget-wide v6, Lanet/channel/monitor/b;->i:D

    invoke-virtual {v0, v6, v7}, Lanet/channel/monitor/a;->a(D)V

    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 164
    invoke-static {v0, v4}, Lanet/channel/monitor/b;->a(Lanet/channel/monitor/b;I)I

    iget-object v0, p0, Lanet/channel/monitor/d;->d:Lanet/channel/monitor/b;

    .line 165
    sget-wide v6, Lanet/channel/monitor/b;->i:D

    sget-wide v8, Lanet/channel/monitor/b;->j:D

    cmpg-double v6, v6, v8

    if-gez v6, :cond_8

    goto :goto_1

    :cond_8
    move v1, v5

    :goto_1
    invoke-static {v0, v1}, Lanet/channel/monitor/b;->b(Lanet/channel/monitor/b;I)I

    const-string v0, "Send Network quality notification."

    .line 166
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "NetworkSpeed notification!"

    invoke-static {v3, v1, v2, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_9
    const-wide/16 v0, 0x0

    .line 168
    sput-wide v0, Lanet/channel/monitor/b;->d:J

    .line 169
    sput-wide v0, Lanet/channel/monitor/b;->e:J

    .line 170
    sput v4, Lanet/channel/monitor/b;->a:I

    :cond_a
    return-void
.end method
