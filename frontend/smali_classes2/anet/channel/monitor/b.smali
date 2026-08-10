.class public Lanet/channel/monitor/b;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/monitor/b$a;
    }
.end annotation


# static fields
.field static a:I = 0x0

.field static b:J = 0x0L

.field static c:J = 0x0L

.field static d:J = 0x0L

.field static e:J = 0x0L

.field static f:J = 0x0L

.field static g:D = 0.0

.field static h:D = 0.0

.field static i:D = 0.0

.field static j:D = 40.0

.field private static volatile k:Z = false


# instance fields
.field private l:I

.field private m:I

.field private n:Lanet/channel/monitor/e;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x5

    iput v0, p0, Lanet/channel/monitor/b;->l:I

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/monitor/b;->m:I

    .line 32
    new-instance v0, Lanet/channel/monitor/e;

    invoke-direct {v0}, Lanet/channel/monitor/e;-><init>()V

    iput-object v0, p0, Lanet/channel/monitor/b;->n:Lanet/channel/monitor/e;

    .line 43
    new-instance v0, Lanet/channel/monitor/c;

    invoke-direct {v0, p0}, Lanet/channel/monitor/c;-><init>(Lanet/channel/monitor/b;)V

    invoke-static {v0}, Lanet/channel/status/NetworkStatusHelper;->addStatusChangeListener(Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;)V

    return-void
.end method

.method synthetic constructor <init>(Lanet/channel/monitor/c;)V
    .locals 0

    .line 10
    invoke-direct {p0}, Lanet/channel/monitor/b;-><init>()V

    return-void
.end method

.method static synthetic a(Lanet/channel/monitor/b;I)I
    .locals 0

    .line 10
    iput p1, p0, Lanet/channel/monitor/b;->m:I

    return p1
.end method

.method public static a()Lanet/channel/monitor/b;
    .locals 1

    .line 39
    sget-object v0, Lanet/channel/monitor/b$a;->a:Lanet/channel/monitor/b;

    return-object v0
.end method

.method static synthetic a(Lanet/channel/monitor/b;)Lanet/channel/monitor/e;
    .locals 0

    .line 10
    iget-object p0, p0, Lanet/channel/monitor/b;->n:Lanet/channel/monitor/e;

    return-object p0
.end method

.method static synthetic b(Lanet/channel/monitor/b;)I
    .locals 2

    .line 10
    iget v0, p0, Lanet/channel/monitor/b;->m:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lanet/channel/monitor/b;->m:I

    return v0
.end method

.method static synthetic b(Lanet/channel/monitor/b;I)I
    .locals 0

    .line 10
    iput p1, p0, Lanet/channel/monitor/b;->l:I

    return p1
.end method

.method static synthetic c(Lanet/channel/monitor/b;)I
    .locals 0

    .line 10
    iget p0, p0, Lanet/channel/monitor/b;->m:I

    return p0
.end method


# virtual methods
.method public a(JJJ)V
    .locals 9

    sget-boolean v0, Lanet/channel/monitor/b;->k:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    .line 91
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v1, "mRequestStartTime"

    .line 92
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "mRequestFinishedTime"

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const-string v5, "mRequestDataSize"

    .line 93
    invoke-static {p5, p6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.BandWidthSampler"

    const-string v2, "onDataReceived"

    const/4 v3, 0x0

    .line 92
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    const-wide/16 v0, 0xbb8

    cmp-long v0, p5, v0

    if-lez v0, :cond_3

    cmp-long v0, p1, p3

    if-ltz v0, :cond_2

    goto :goto_0

    .line 102
    :cond_2
    new-instance v0, Lanet/channel/monitor/d;

    move-object v1, v0

    move-object v2, p0

    move-wide v3, p5

    move-wide v5, p3

    move-wide v7, p1

    invoke-direct/range {v1 .. v8}, Lanet/channel/monitor/d;-><init>(Lanet/channel/monitor/b;JJJ)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    :cond_3
    :goto_0
    return-void
.end method

.method public b()I
    .locals 2

    .line 54
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v0

    sget-object v1, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G2:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    iget v0, p0, Lanet/channel/monitor/b;->l:I

    return v0
.end method

.method public c()D
    .locals 2

    sget-wide v0, Lanet/channel/monitor/b;->i:D

    return-wide v0
.end method

.method public declared-synchronized d()V
    .locals 7

    monitor-enter p0

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "awcn.BandWidthSampler"

    const-string v3, "[startNetworkMeter]"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "NetworkStatus"

    aput-object v5, v4, v1

    .line 69
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v4, v6

    invoke-static {v2, v3, v0, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v2

    sget-object v3, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G2:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-ne v2, v3, :cond_0

    sput-boolean v1, Lanet/channel/monitor/b;->k:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 72
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    sput-boolean v6, Lanet/channel/monitor/b;->k:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    move-exception v2

    :try_start_2
    const-string v3, "awcn.BandWidthSampler"

    const-string v4, "startNetworkMeter fail."

    new-array v1, v1, [Ljava/lang/Object;

    .line 77
    invoke-static {v3, v4, v0, v2, v1}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 79
    :goto_0
    monitor-exit p0

    return-void

    :goto_1
    monitor-exit p0

    throw v0
.end method

.method public e()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lanet/channel/monitor/b;->k:Z

    return-void
.end method
