.class public Lcom/taobao/accs/data/a;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final SPLIT_DATA_INDEX:I = 0x11

.field public static final SPLIT_DATA_MD5:I = 0x12

.field public static final SPLIT_DATA_NUMS:I = 0x10

.field public static final SPLIT_TIME_OUT:I = 0xf

.field private static final a:[C


# instance fields
.field private final b:Ljava/lang/String;

.field private final c:I

.field private final d:Ljava/lang/String;

.field private e:J

.field private volatile f:I

.field private g:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private final h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "[B>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x10

    new-array v0, v0, [C

    fill-array-data v0, :array_0

    sput-object v0, Lcom/taobao/accs/data/a;->a:[C

    return-void

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method public constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 2

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/accs/data/a;->f:I

    .line 43
    new-instance v0, Ljava/util/TreeMap;

    new-instance v1, Lcom/taobao/accs/data/b;

    invoke-direct {v1, p0}, Lcom/taobao/accs/data/b;-><init>(Lcom/taobao/accs/data/a;)V

    invoke-direct {v0, v1}, Ljava/util/TreeMap;-><init>(Ljava/util/Comparator;)V

    iput-object v0, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    iput-object p1, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    iput p2, p0, Lcom/taobao/accs/data/a;->c:I

    iput-object p3, p0, Lcom/taobao/accs/data/a;->d:Ljava/lang/String;

    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/data/a;)I
    .locals 0

    .line 22
    iget p0, p0, Lcom/taobao/accs/data/a;->f:I

    return p0
.end method

.method static synthetic a(Lcom/taobao/accs/data/a;I)I
    .locals 0

    .line 22
    iput p1, p0, Lcom/taobao/accs/data/a;->f:I

    return p1
.end method

.method private static a([B)[C
    .locals 8

    .line 146
    array-length v0, p0

    shl-int/lit8 v1, v0, 0x1

    .line 147
    new-array v1, v1, [C

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v2, v0, :cond_0

    add-int/lit8 v4, v3, 0x1

    sget-object v5, Lcom/taobao/accs/data/a;->a:[C

    .line 150
    aget-byte v6, p0, v2

    and-int/lit16 v7, v6, 0xf0

    ushr-int/lit8 v7, v7, 0x4

    aget-char v7, v5, v7

    aput-char v7, v1, v3

    add-int/lit8 v3, v3, 0x2

    and-int/lit8 v6, v6, 0xf

    .line 151
    aget-char v5, v5, v6

    aput-char v5, v1, v4

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method static synthetic b(Lcom/taobao/accs/data/a;)Ljava/lang/String;
    .locals 0

    .line 22
    iget-object p0, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lcom/taobao/accs/data/a;)Ljava/util/Map;
    .locals 0

    .line 22
    iget-object p0, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    return-object p0
.end method


# virtual methods
.method public a(J)V
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const-wide/16 p1, 0x7530

    .line 60
    :cond_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/data/c;

    invoke-direct {v1, p0}, Lcom/taobao/accs/data/c;-><init>(Lcom/taobao/accs/data/a;)V

    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, p1, p2, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/data/a;->g:Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method

.method public a(II[B)[B
    .locals 12

    .line 77
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "AssembleMessage"

    const-string v1, "putBurst"

    const-string v2, "dataId"

    iget-object v3, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    const-string v4, "index"

    .line 78
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget v0, p0, Lcom/taobao/accs/data/a;->c:I

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eq p2, v0, :cond_1

    const-string p1, "AssembleMessage"

    const-string p2, "putBurst fail as burstNums not match"

    new-array p3, v2, [Ljava/lang/Object;

    .line 81
    invoke-static {p1, p2, p3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v1

    :cond_1
    if-ltz p1, :cond_c

    if-lt p1, p2, :cond_2

    goto/16 :goto_3

    .line 88
    :cond_2
    monitor-enter p0

    :try_start_0
    iget p2, p0, Lcom/taobao/accs/data/a;->f:I

    const/4 v0, 0x1

    const/4 v3, 0x2

    if-nez p2, :cond_a

    iget-object p2, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 90
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {p2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    if-eqz p2, :cond_3

    const-string p1, "AssembleMessage"

    const-string p2, "putBurst fail as exist old"

    new-array p3, v2, [Ljava/lang/Object;

    .line 91
    invoke-static {p1, p2, p3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 92
    monitor-exit p0

    return-object v1

    :cond_3
    iget-object p2, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 94
    invoke-interface {p2}, Ljava/util/Map;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_4

    .line 95
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/taobao/accs/data/a;->e:J

    :cond_4
    iget-object p2, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 97
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {p2, p1, p3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 98
    invoke-interface {p1}, Ljava/util/Map;->size()I

    move-result p1

    iget p2, p0, Lcom/taobao/accs/data/a;->c:I

    if-ne p1, p2, :cond_b

    iget-object p1, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 100
    invoke-interface {p1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    move-object p2, v1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, [B

    if-nez p2, :cond_5

    move-object p2, p3

    goto :goto_0

    .line 104
    :cond_5
    array-length v4, p2

    array-length v5, p3

    add-int/2addr v4, v5

    new-array v4, v4, [B

    .line 105
    array-length v5, p2

    invoke-static {p2, v2, v4, v2, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 106
    array-length p2, p2

    array-length v5, p3

    invoke-static {p3, v2, v4, p2, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move-object p2, v4

    goto :goto_0

    :cond_6
    iget-object p1, p0, Lcom/taobao/accs/data/a;->d:Ljava/lang/String;

    .line 111
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    const/4 p3, 0x5

    const/4 v4, 0x4

    const/4 v5, 0x6

    const/4 v6, 0x3

    if-nez p1, :cond_7

    .line 112
    new-instance p1, Ljava/lang/String;

    invoke-static {p2}, Lcom/taobao/accs/utl/d;->a([B)[B

    move-result-object v7

    invoke-static {v7}, Lcom/taobao/accs/data/a;->a([B)[C

    move-result-object v7

    invoke-direct {p1, v7}, Ljava/lang/String;-><init>([C)V

    iget-object v7, p0, Lcom/taobao/accs/data/a;->d:Ljava/lang/String;

    .line 113
    invoke-virtual {v7, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_7

    const-string p2, "AssembleMessage"

    const-string v7, "putBurst fail"

    new-array v8, v5, [Ljava/lang/Object;

    const-string v9, "dataId"

    aput-object v9, v8, v2

    iget-object v9, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    aput-object v9, v8, v0

    const-string v9, "dataMd5"

    aput-object v9, v8, v3

    iget-object v9, p0, Lcom/taobao/accs/data/a;->d:Ljava/lang/String;

    aput-object v9, v8, v6

    const-string v9, "finalDataMd5"

    aput-object v9, v8, v4

    aput-object p1, v8, p3

    .line 115
    invoke-static {p2, v7, v8}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iput v6, p0, Lcom/taobao/accs/data/a;->f:I

    goto :goto_1

    :cond_7
    move-object v1, p2

    :goto_1
    if-eqz v1, :cond_8

    .line 122
    array-length p1, v1

    int-to-long p1, p1

    .line 123
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    iget-wide v9, p0, Lcom/taobao/accs/data/a;->e:J

    sub-long/2addr v7, v9

    iput v3, p0, Lcom/taobao/accs/data/a;->f:I

    const-string v9, "AssembleMessage"

    const-string v10, "putBurst completed"

    new-array v5, v5, [Ljava/lang/Object;

    const-string v11, "dataId"

    aput-object v11, v5, v2

    iget-object v11, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    aput-object v11, v5, v0

    const-string v0, "length"

    aput-object v0, v5, v3

    .line 125
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    aput-object v0, v5, v6

    const-string v0, "cost"

    aput-object v0, v5, v4

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    aput-object v0, v5, p3

    invoke-static {v9, v10, v5}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    :cond_8
    const-wide/16 p1, 0x0

    move-wide v7, p1

    .line 127
    :goto_2
    new-instance p3, Lcom/taobao/accs/ut/monitor/AssembleMonitor;

    iget-object v0, p0, Lcom/taobao/accs/data/a;->b:Ljava/lang/String;

    iget v3, p0, Lcom/taobao/accs/data/a;->f:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-direct {p3, v0, v3}, Lcom/taobao/accs/ut/monitor/AssembleMonitor;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 128
    iput-wide p1, p3, Lcom/taobao/accs/ut/monitor/AssembleMonitor;->assembleLength:J

    .line 129
    iput-wide v7, p3, Lcom/taobao/accs/ut/monitor/AssembleMonitor;->assembleTimes:J

    .line 130
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    invoke-interface {p1, p3}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    iget-object p1, p0, Lcom/taobao/accs/data/a;->h:Ljava/util/Map;

    .line 132
    invoke-interface {p1}, Ljava/util/Map;->clear()V

    iget-object p1, p0, Lcom/taobao/accs/data/a;->g:Ljava/util/concurrent/ScheduledFuture;

    if-eqz p1, :cond_9

    .line 134
    invoke-interface {p1, v2}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    .line 136
    :cond_9
    monitor-exit p0

    return-object v1

    :cond_a
    const-string p1, "AssembleMessage"

    const-string p2, "putBurst fail"

    new-array p3, v3, [Ljava/lang/Object;

    const-string v3, "status"

    aput-object v3, p3, v2

    iget v2, p0, Lcom/taobao/accs/data/a;->f:I

    .line 139
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, p3, v0

    invoke-static {p1, p2, p3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    :cond_b
    monitor-exit p0

    return-object v1

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_c
    :goto_3
    const-string p1, "AssembleMessage"

    const-string p2, "putBurst fail as burstIndex invalid"

    new-array p3, v2, [Ljava/lang/Object;

    .line 85
    invoke-static {p1, p2, p3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v1
.end method
